Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F103C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1740F24067
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="TuGwDuqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1740F24067
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbeGEMPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:15:06 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38678 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbeGEMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:15:04 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F107F5C142E;
        Thu,  5 Jul 2018 14:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530792903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=2Al+2xKUreGlmPIsg6n2LqzTw2Ap2sjY6Lqn4CpfRhg=;
        b=TuGwDuqLzj0eCum6QCVn3xWwgHUUqok/MD+hjLlzo/vEXmjEys7UJhxCePX6fFI43tTpw2
        0Td/kwGJGgbBxkbLj10vNRhgXreIR0PAX+bLZluBvo6tfaEnSgWA4TCZAFvoLDsELV17Ho
        sSzr/p+QUbrxS4ROA3pbQskCJL2Ddko=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     marcel@ziswiler.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] mmc: sdhci-esdhc-imx: disable clocks before changing frequency
Date:   Thu,  5 Jul 2018 14:15:00 +0200
Message-Id: <20180705121500.6256-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-2.08 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.98)[99.91%];
         RCPT_COUNT_FIVE(0.00)[6];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
is set to 0. However, it could be that the stack asks for a frequency
change while clocks are on. In that case the function clears the
divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
enabled! This causes a short period of time where the clock is
undivided (on a i.MX 6DL a clock of 196MHz has been measured).

For older IP variants the driver disables clock by clearing some bits
in ESDHC_SYSTEM_CONTROL.

Make sure to disable card clock before chainging frequency for uSDHC
IP variants too. Also fix indent to make disable/enable clock look
alike.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 85fd5a8b0b6d..aa48f4b2541a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	int div = 1;
 	u32 temp, val;
 
+	if (esdhc_is_usdhc(imx_data)) {
+		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+			host->ioaddr + ESDHC_VENDOR_SPEC);
+	}
+
 	if (clock == 0) {
 		host->mmc->actual_clock = 0;
-
-		if (esdhc_is_usdhc(imx_data)) {
-			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
-			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
-					host->ioaddr + ESDHC_VENDOR_SPEC);
-		}
 		return;
 	}
 
@@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	if (esdhc_is_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
-		host->ioaddr + ESDHC_VENDOR_SPEC);
+			host->ioaddr + ESDHC_VENDOR_SPEC);
 	}
 
 	mdelay(1);
-- 
2.18.0

