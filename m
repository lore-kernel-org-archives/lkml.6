Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25042C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ACF208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ACF208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeJPN2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:28:05 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57184 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeJPN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:28:04 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 48C5B27FEE; Tue, 16 Oct 2018 01:39:21 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <089e72bf45ec4d58d3e33fe8e0dcb914fcb7753d.1539667885.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1539667885.git.fthain@telegraphics.com.au>
References: <cover.1539667885.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 1/6] zorro_esp: Limit DMA transfers to 65535 bytes
Date:   Tue, 16 Oct 2018 16:31:25 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core driver, esp_scsi, does not use the ESP_CONFIG2_FENAB bit, so
the chip's Transfer Counter register is only 16 bits wide (not 24).
A larger transfer cannot work and will theoretically result in a failed
command and a "DMA length is zero" error.

Fixes: 3109e5ae0311 ("scsi: zorro_esp: New driver for Amiga Zorro NCR53C9x boards")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
---
 drivers/scsi/zorro_esp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/zorro_esp.c b/drivers/scsi/zorro_esp.c
index bb70882e6b56..be79127db594 100644
--- a/drivers/scsi/zorro_esp.c
+++ b/drivers/scsi/zorro_esp.c
@@ -245,7 +245,7 @@ static int fastlane_esp_irq_pending(struct esp *esp)
 static u32 zorro_esp_dma_length_limit(struct esp *esp, u32 dma_addr,
 					u32 dma_len)
 {
-	return dma_len > 0xFFFFFF ? 0xFFFFFF : dma_len;
+	return dma_len > 0xFFFF ? 0xFFFF : dma_len;
 }
 
 static void zorro_esp_reset_dma(struct esp *esp)
@@ -484,7 +484,6 @@ static void zorro_esp_send_blz1230_dma_cmd(struct esp *esp, u32 addr,
 	scsi_esp_cmd(esp, ESP_CMD_DMA);
 	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
 	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
-	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
 
 	scsi_esp_cmd(esp, cmd);
 }
@@ -529,7 +528,6 @@ static void zorro_esp_send_blz1230II_dma_cmd(struct esp *esp, u32 addr,
 	scsi_esp_cmd(esp, ESP_CMD_DMA);
 	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
 	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
-	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
 
 	scsi_esp_cmd(esp, cmd);
 }
@@ -574,7 +572,6 @@ static void zorro_esp_send_blz2060_dma_cmd(struct esp *esp, u32 addr,
 	scsi_esp_cmd(esp, ESP_CMD_DMA);
 	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
 	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
-	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
 
 	scsi_esp_cmd(esp, cmd);
 }
@@ -599,7 +596,6 @@ static void zorro_esp_send_cyber_dma_cmd(struct esp *esp, u32 addr,
 
 	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
 	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
-	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
 
 	if (write) {
 		/* DMA receive */
@@ -649,7 +645,6 @@ static void zorro_esp_send_cyberII_dma_cmd(struct esp *esp, u32 addr,
 
 	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
 	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
-	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
 
 	if (write) {
 		/* DMA receive */
@@ -691,7 +686,6 @@ static void zorro_esp_send_fastlane_dma_cmd(struct esp *esp, u32 addr,
 
 	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
 	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
-	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
 
 	if (write) {
 		/* DMA receive */
-- 
2.18.1

