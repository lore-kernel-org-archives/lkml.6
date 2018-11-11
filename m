Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9884C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A598020871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A598020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbeKLGYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:24:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49908 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730193AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000l7-8v; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001iF-2p; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Stefan Agner" <stefan@agner.ch>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.197064231@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 241/366] mmc: sdhci-esdhc-imx: allow 1.8V modes
 without 100/200MHz pinctrl states
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit 92748beac07c471d995fbec642b63572dc01b3dc upstream.

If pinctrl nodes for 100/200MHz are missing, the controller should
not select any mode which need signal frequencies 100MHz or higher.
To prevent such speed modes the driver currently uses the quirk flag
SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
signaling is required for all faster modes and slower modes use 3.3V
signaling only.

However, there are eMMC modes which use 1.8V signaling and run below
100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
the stack has no valid mode to use. In this tenuous situation the
kernel continuously prints voltage switching errors:
  mmc1: Switching to 3.3V signalling voltage failed

Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
altering the SDHCI capability register. With that the stack is able
to select 1.8V modes even if no faster pinctrl states are available:
  # cat /sys/kernel/debug/mmc1/ios
  ...
  timing spec:    8 (mmc DDR52)
  signal voltage: 1 (1.80 V)
  ...

Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
Signed-off-by: Stefan Agner <stefan@agner.ch>
Fixes: ad93220de7da ("mmc: sdhci-esdhc-imx: change pinctrl state according
to uhs mode")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16:
 - There is no SDHCI_SUPPORT_HS400 flag to clear
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -261,6 +261,15 @@ static u32 esdhc_readl_le(struct sdhci_h
 				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
 					| SDHCI_SUPPORT_SDR50
 					| SDHCI_USE_SDR50_TUNING;
+
+			/*
+			 * Do not advertise faster UHS modes if there are no
+			 * pinctrl states for 100MHz/200MHz.
+			 */
+			if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
+			    IS_ERR_OR_NULL(imx_data->pins_200mhz))
+				val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50
+					 | SDHCI_SUPPORT_SDR104);
 		}
 	}
 
@@ -1108,15 +1117,6 @@ static int sdhci_esdhc_imx_probe(struct
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_200MHZ);
-		if (IS_ERR(imx_data->pins_100mhz) ||
-				IS_ERR(imx_data->pins_200mhz)) {
-			dev_warn(mmc_dev(host->mmc),
-				"could not get ultra high speed state, work on normal mode\n");
-			/* fall back to not support uhs by specify no 1.8v quirk */
-			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
-		}
-	} else {
-		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
 
 	err = sdhci_add_host(host);

