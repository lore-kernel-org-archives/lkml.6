Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC79C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4B82702E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="I1fWJ4Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4B82702E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934048AbeF1Hb7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:31:59 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48934 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933821AbeF1Hb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:31:57 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 348EB5C0070;
        Thu, 28 Jun 2018 09:31:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530171116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=jJ/8gotlbHj4tbGClsbUbDRmmop7kNuRNCInkqLEDZU=;
        b=I1fWJ4Jf7K6HMtl9efBmfszwqBzJFg3O5OhhWkSd1pT3/pCVfQx7w+xmt45iQbynGhPAEE
        rzf4JDSrQP8wBoRXCwNnYfX1xrfOE2492bOGbNphetNM5TQzEFXYAmnTmwDw1xWr9edoRk
        uAxDXnbLdIBoz7Lnt9SwinRpOSDZMy4=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        michael@amarulasolutions.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] mmc: sdhci-esdhc-imx: support eMMC DDR mode when running at 3.3V
Date:   Thu, 28 Jun 2018 09:31:36 +0200
Message-Id: <20180628073136.21748-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
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

The uSDHC supports DDR modes for eMMC devices running at 3.3V. This
allows to run eMMC with 3.3V signaling voltage at DDR52 mode:

  # cat /sys/kernel/debug/mmc1/ios
  clock:          52000000 Hz
  vdd:            21 (3.3 ~ 3.4 V)
  bus mode:       2 (push-pull)
  chip select:    0 (don't care)
  power mode:     2 (on)
  bus width:      3 (8 bits)
  timing spec:    8 (mmc DDR52)
  signal voltage: 0 (3.30 V)
  driver type:    0 (driver type B)

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b716b933f00a..6f444731754d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1324,7 +1324,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
-		host->mmc->caps |= MMC_CAP_1_8V_DDR;
+		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
-- 
2.18.0

