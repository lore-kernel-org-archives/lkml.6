Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585D5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B10206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B10206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbeGPIGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:06:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbeGPIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:06:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66E10C03;
        Mon, 16 Jul 2018 07:40:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 06/54] mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states
Date:   Mon, 16 Jul 2018 09:35:03 +0200
Message-Id: <20180716073451.761083604@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org> # v4.13+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-esdhc-imx.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -305,6 +305,15 @@ static u32 esdhc_readl_le(struct sdhci_h
 
 			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 				val |= SDHCI_SUPPORT_HS400;
+
+			/*
+			 * Do not advertise faster UHS modes if there are no
+			 * pinctrl states for 100MHz/200MHz.
+			 */
+			if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
+			    IS_ERR_OR_NULL(imx_data->pins_200mhz))
+				val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50
+					 | SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
 		}
 	}
 
@@ -1135,18 +1144,6 @@ sdhci_esdhc_imx_probe_dt(struct platform
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_200MHZ);
-		if (IS_ERR(imx_data->pins_100mhz) ||
-				IS_ERR(imx_data->pins_200mhz)) {
-			dev_warn(mmc_dev(host->mmc),
-				"could not get ultra high speed state, work on normal mode\n");
-			/*
-			 * fall back to not supporting uhs by specifying no
-			 * 1.8v quirk
-			 */
-			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
-		}
-	} else {
-		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
 
 	/* call to generic mmc_of_parse to support additional capabilities */


