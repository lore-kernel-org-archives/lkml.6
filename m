Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76900C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E98F20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfA2QuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:50:10 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:7258 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfA2QuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:50:10 -0500
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="27013017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Jan 2019 09:50:09 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 29 Jan 2019 09:50:08 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: atmel-mci: enable 8 bits buswidth support
Date:   Tue, 29 Jan 2019 17:49:12 +0100
Message-ID: <20190129164950.31052-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for 8-bit buswidth.
Relevant SDCR value modified.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/mmc/host/atmel-mci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 47189f9ed4e2..735aa5871358 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1410,6 +1410,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_BUS_WIDTH_4:
 		slot->sdc_reg |= ATMCI_SDCBUS_4BIT;
 		break;
+	case MMC_BUS_WIDTH_8:
+		slot->sdc_reg |= ATMCI_SDCBUS_8BIT;
+		break;
 	}
 
 	if (ios->clock) {
@@ -2275,8 +2278,11 @@ static int atmci_init_slot(struct atmel_mci *host,
 	 * use only one bit for data to prevent fifo underruns and overruns
 	 * which will corrupt data.
 	 */
-	if ((slot_data->bus_width >= 4) && host->caps.has_rwproof)
+	if ((slot_data->bus_width >= 4) && host->caps.has_rwproof) {
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+		if (slot_data->bus_width >= 8)
+			mmc->caps |= MMC_CAP_8_BIT_DATA;
+	}
 
 	if (atmci_get_version(host) < 0x200) {
 		mmc->max_segs = 256;
-- 
2.17.1

