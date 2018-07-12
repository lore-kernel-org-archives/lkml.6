Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692FEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B7421476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="QEPqjXDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B7421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbeGLIQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:16:24 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55852 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeGLIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:16:24 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F118A5C1D4D;
        Thu, 12 Jul 2018 10:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531382856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=CoNj8VE2HyQ6bHChp8a68xGOzll7C1bZjM219+8MM3M=;
        b=QEPqjXDXWHNf4CFmwC9aRSpSWKkvKKXOmpV+D9j+rMuMsOlZsV4EjAAndrYgQ07+i+kP7H
        NfYWI9Z+RKvHawdS72ee1vDfJyYrtklpHOqTAOsHhXThyuJnCwSmZngIPmaHYxX/yuBAS/
        ggk7dy8usxZ0jr6VUvv0yUHHcXf9M1g=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before changing frequency
Date:   Thu, 12 Jul 2018 10:07:24 +0200
Message-Id: <20180712080725.14250-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-2.00 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.90)[99.59%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
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

Make sure to disable card clock before changing frequency for uSDHC
IP variants too.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 85fd5a8b0b6d..acacd8481473 100644
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
 
-- 
2.18.0

