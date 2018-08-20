Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECB4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E73321534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E73321534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeHTMNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:13:39 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:8569 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeHTMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:13:39 -0400
X-IronPort-AV: E=Sophos;i="5.53,264,1531810800"; 
   d="scan'208";a="18003601"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Aug 2018 01:58:52 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Mon, 20 Aug 2018
 01:58:46 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <dgilbert@interlog.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 1/2] mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
Date:   Mon, 20 Aug 2018 10:54:44 +0200
Message-ID: <20180820085445.14632-2-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180820085445.14632-1-ludovic.desroches@microchip.com>
References: <20180820085445.14632-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion to sg_copy_{from,to}_buffer has been done in the wrong
way. sg_copy_to_buffer is a copy from an SG list to a linear buffer so
it can't replace memcpy(buf + offset, &value, remaining) where buf is
the virtual address of the SG. Same for sg_copy_to_buffer but in the
opposite way.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 5b4277814e3f ("mmc: atmel-mci: use sg_copy_{from,to}_buffer")
---
 drivers/mmc/host/atmel-mci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 5aa2c9404e92..be53044086c7 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1976,7 +1976,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 	do {
 		value = atmci_readl(host, ATMCI_RDR);
 		if (likely(offset + 4 <= sg->length)) {
-			sg_pcopy_to_buffer(sg, 1, &value, sizeof(u32), offset);
+			sg_pcopy_from_buffer(sg, 1, &value, sizeof(u32), offset);
 
 			offset += 4;
 			nbytes += 4;
@@ -1993,7 +1993,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 		} else {
 			unsigned int remaining = sg->length - offset;
 
-			sg_pcopy_to_buffer(sg, 1, &value, remaining, offset);
+			sg_pcopy_from_buffer(sg, 1, &value, remaining, offset);
 			nbytes += remaining;
 
 			flush_dcache_page(sg_page(sg));
@@ -2003,7 +2003,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 				goto done;
 
 			offset = 4 - remaining;
-			sg_pcopy_to_buffer(sg, 1, (u8 *)&value + remaining,
+			sg_pcopy_from_buffer(sg, 1, (u8 *)&value + remaining,
 					offset, 0);
 			nbytes += offset;
 		}
@@ -2042,7 +2042,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 
 	do {
 		if (likely(offset + 4 <= sg->length)) {
-			sg_pcopy_from_buffer(sg, 1, &value, sizeof(u32), offset);
+			sg_pcopy_to_buffer(sg, 1, &value, sizeof(u32), offset);
 			atmci_writel(host, ATMCI_TDR, value);
 
 			offset += 4;
@@ -2059,7 +2059,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 			unsigned int remaining = sg->length - offset;
 
 			value = 0;
-			sg_pcopy_from_buffer(sg, 1, &value, remaining, offset);
+			sg_pcopy_to_buffer(sg, 1, &value, remaining, offset);
 			nbytes += remaining;
 
 			host->sg = sg = sg_next(sg);
@@ -2070,7 +2070,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 			}
 
 			offset = 4 - remaining;
-			sg_pcopy_from_buffer(sg, 1, (u8 *)&value + remaining,
+			sg_pcopy_to_buffer(sg, 1, (u8 *)&value + remaining,
 					offset, 0);
 			atmci_writel(host, ATMCI_TDR, value);
 			nbytes += offset;
-- 
2.12.2

