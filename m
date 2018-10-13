Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB04C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C15921470
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C15921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJMIrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:47:12 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47234 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeJMIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:46:53 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0E8EF29FCA; Fri, 12 Oct 2018 21:11:49 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <3a2534bff570653de6897afa081017e2a359747e.1539391876.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1539391876.git.fthain@telegraphics.com.au>
References: <cover.1539391876.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 6/6] esp_scsi: Optimize PIO loops
Date:   Sat, 13 Oct 2018 11:51:16 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid function calls in the inner PIO loops. On a Centris 660av this
improves throughput for sequential read transfers by about 40% and
sequential write by about 10%.

Unfortunately it is not possible to have method calls like esp_write8()
placed inline so this is always going to be slow (even with LTO).

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/esp_scsi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 646701fc22a4..9f0e68cd0e99 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2788,7 +2788,7 @@ static inline unsigned int esp_wait_for_fifo(struct esp *esp)
 		if (fbytes)
 			return fbytes;
 
-		udelay(2);
+		udelay(1);
 	} while (--i);
 
 	pr_err("FIFO is empty (sreg %02x)\n", esp_read8(ESP_STATUS));
@@ -2804,7 +2804,7 @@ static inline int esp_wait_for_intr(struct esp *esp)
 		if (esp->sreg & ESP_STAT_INTR)
 			return 0;
 
-		udelay(2);
+		udelay(1);
 	} while (--i);
 
 	pr_err("IRQ timeout (sreg %02x)\n", esp->sreg);
@@ -2831,7 +2831,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
 			if (!esp_wait_for_fifo(esp))
 				break;
 
-			*dst++ = esp_read8(ESP_FDATA);
+			*dst++ = readb(esp->fifo_reg);
 			--esp_count;
 
 			if (!esp_count)
@@ -2852,15 +2852,15 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
 			}
 
 			if (phase == ESP_MIP)
-				scsi_esp_cmd(esp, ESP_CMD_MOK);
+				esp_write8(ESP_CMD_MOK, ESP_CMD);
 
-			scsi_esp_cmd(esp, ESP_CMD_TI);
+			esp_write8(ESP_CMD_TI, ESP_CMD);
 		}
 	} else {
 		unsigned int n = ESP_FIFO_SIZE;
 		u8 *src = (u8 *)addr;
 
-		scsi_esp_cmd(esp, ESP_CMD_FLUSH);
+		esp_write8(ESP_CMD_FLUSH, ESP_CMD);
 
 		if (n > esp_count)
 			n = esp_count;
@@ -2894,7 +2894,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
 			src += n;
 			esp_count -= n;
 
-			scsi_esp_cmd(esp, ESP_CMD_TI);
+			esp_write8(ESP_CMD_TI, ESP_CMD);
 		}
 	}
 
-- 
2.16.4

