Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC0BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B0522477
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="qlJoTy/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B0522477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934766AbeF1IOM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:14:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49418 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934470AbeF1INg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:13:36 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 4E0615C0C49;
        Thu, 28 Jun 2018 10:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530173615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AW0AXaKWv0I5JtfJLm0H1BTgUszfU1M/rHZROIKYnb0=;
        b=qlJoTy/1L8i1FCJGtqEIu0c5FeY3WBKZwEs9r+p/3zFCB/pVTe9U1t4GRSAzQm3gZlc9Jk
        hQEUWMByStJoew92HCPrn2a01xhwolswgKCx4LeLinxwgVtlX6TIN5CwmyKC5A+gxOcVpR
        lXqeoakriB9zaoBbaujuCLpRKjnD2mM=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        michael@amarulasolutions.com, rmk+kernel@armlinux.org.uk,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] mmc: sdhci-esdhc-imx: prevent stack from using higher speed modes
Date:   Thu, 28 Jun 2018 10:13:31 +0200
Message-Id: <20180628081331.13051-4-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628081331.13051-1-stefan@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[kernel];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
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

If pinctrl configurations for higher speed modes are missing, the
stack currently uses the no 1.8V quirk. This comes close to what
we need but not exactly: E.g. if a eMMC chip uses 1.8V signaling
(by specifying a 1.8V only vqmmc-supply) while not providing any
100MHz/200MHz pinctrl configurations then the SDHCI_QUIRK2_NO_1_8_V
leads the stack to print signaling voltage switch failed errors
continuously:
  mmc1: Switching to 3.3V signalling voltage failed

Presumably because the stack tries to use 3.3V signaling:

  # cat /sys/kernel/debug/mmc1/ios
  ...
  timing spec:    8 (mmc DDR52)
  signal voltage: 0 (3.30 V)
  ...

With using SDHCI_QUIRK2_NO_UHS_HS200_HS400 we prevent the stack
from choosing any modes require speeds higher than 52MHz while
still allowing to select modes using 1.8V at lower speeds (e.g.
DDR52):

  # cat /sys/kernel/debug/mmc1/ios
  ...
  timing spec:    8 (mmc DDR52)
  signal voltage: 1 (1.80 V)
  ...

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 20a420b765b3..4a1c33018072 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1165,10 +1165,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 			 * fall back to not supporting uhs by specifying no
 			 * 1.8v quirk
 			 */
-			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+			host->quirks2 |= SDHCI_QUIRK2_NO_UHS_HS200_HS400;
 		}
 	} else {
-		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+		host->quirks2 |= SDHCI_QUIRK2_NO_UHS_HS200_HS400;
 	}
 
 	/* call to generic mmc_of_parse to support additional capabilities */
-- 
2.18.0

