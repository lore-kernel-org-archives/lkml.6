Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABAFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E020321534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E020321534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeHTMNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:13:45 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:8569 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHTMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:13:39 -0400
X-IronPort-AV: E=Sophos;i="5.53,264,1531810800"; 
   d="scan'208";a="18003604"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Aug 2018 01:58:53 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Mon, 20 Aug 2018
 01:58:48 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <dgilbert@interlog.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 2/2] mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer conversion
Date:   Mon, 20 Aug 2018 10:54:45 +0200
Message-ID: <20180820085445.14632-3-ludovic.desroches@microchip.com>
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
it can't replace memcpy(dest, host->virt_base, data->sg->length) where
dest is the virtual address of the SG. Same for sg_copy_from_buffer
but in the opposite way.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 53d7e098ba08 ("mmc: android-goldfish: use sg_copy_{from,to}_buffer")
---
 drivers/mmc/host/android-goldfish.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 294de177632c..61e4e2a213c9 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -217,7 +217,7 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
 			 * We don't really have DMA, so we need
 			 * to copy from our platform driver buffer
 			 */
-			sg_copy_to_buffer(data->sg, 1, host->virt_base,
+			sg_copy_from_buffer(data->sg, 1, host->virt_base,
 					data->sg->length);
 		}
 		host->data->bytes_xfered += data->sg->length;
@@ -393,7 +393,7 @@ static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
 		 * We don't really have DMA, so we need to copy to our
 		 * platform driver buffer
 		 */
-		sg_copy_from_buffer(data->sg, 1, host->virt_base,
+		sg_copy_to_buffer(data->sg, 1, host->virt_base,
 				data->sg->length);
 	}
 }
-- 
2.12.2

