Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B456AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361F920837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361F920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeHaPry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:47:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38800 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeHaPrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:47:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 51A5520731; Fri, 31 Aug 2018 13:40:48 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 279F0206F6;
        Fri, 31 Aug 2018 13:40:48 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] spi: dw-mmio: avoid hardcoded field mask
Date:   Fri, 31 Aug 2018 13:40:46 +0200
Message-Id: <20180831114046.27094-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a mask for the IF_SI_OWNER field.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/spi/spi-dw-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 351f49976161..a768461614a0 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -36,6 +36,7 @@ struct dw_spi_mmio {
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
 #define OCELOT_IF_SI_OWNER_OFFSET		4
 #define JAGUAR2_IF_SI_OWNER_OFFSET		6
+#define MSCC_IF_SI_OWNER_MASK			GENMASK(1, 0)
 #define MSCC_IF_SI_OWNER_SISL			0
 #define MSCC_IF_SI_OWNER_SIBM			1
 #define MSCC_IF_SI_OWNER_SIMC			2
@@ -102,7 +103,7 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 
 	/* Select the owner of the SI interface */
 	regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
-			   0x3 << if_si_owner_offset,
+			   MSCC_IF_SI_OWNER_MASK << if_si_owner_offset,
 			   MSCC_IF_SI_OWNER_SIMC << if_si_owner_offset);
 
 	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
-- 
2.19.0.rc1

