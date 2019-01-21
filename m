Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10568C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28842084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079119;
	bh=dKhWut6x0oD5RkUalPfUYb4qgmyXqd9ZSQyXetdLguE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eB/Pt8VdX2JKSb49SypyOadK0f2fDHkDo8RaekpeJH6lg0K+Lk/k45PDZJHAHCMSD
	 V1YOw1edLGCDGlLCtOUzW6OI5xZi5/VDdpv9n8YXE6wC5LNlLWkVX6ffSVB4Mkn4Tg
	 /EYOW5VmHEPVRAT6W4Sku3s2G5ekRwOoP7poYn1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfAUN6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731822AbfAUN6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:58:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEA220879;
        Mon, 21 Jan 2019 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079115;
        bh=dKhWut6x0oD5RkUalPfUYb4qgmyXqd9ZSQyXetdLguE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAtZfaB41cBGTAAkq66kd/40+AeULv2lUQ0922yWVz+iMlRgAl9uydXFR6DDYY/dg
         uovuKYyN8u8Rsusf3WBqz1gKzbz8/S+obSv+Xkm290RjOefWPF9HdN6ZOQA4uSPO/Q
         ciIX3V70utMVx7CuxotO8ScxLw9LpV6KxKyCQsLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonid Segal <leonid.s@variscite.com>,
        Manabu Igusa <migusa@arrowjapan.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 14/99] mmc: sdhci-msm: Disable CDR function on TX
Date:   Mon, 21 Jan 2019 14:48:06 +0100
Message-Id: <20190121134914.465637968@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Loic Poulain <loic.poulain@linaro.org>

commit a89e7bcb18081c611eb6cf50edd440fa4983a71a upstream.

The Clock Data Recovery (CDR) circuit allows to automatically adjust
the RX sampling-point/phase for high frequency cards (SDR104, HS200...).
CDR is automatically enabled during DLL configuration.
However, according to the APQ8016 reference manual, this function
must be disabled during TX and tuning phase in order to prevent any
interferences during tuning challenges and unexpected phase alteration
during TX transfers.

This patch enables/disables CDR according to the current transfer mode.

This fixes sporadic write transfer issues observed with some SDR104 and
HS200 cards.

Inspired by sdhci-msm downstream patch:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/432516/

Reported-by: Leonid Segal <leonid.s@variscite.com>
Reported-by: Manabu Igusa <migusa@arrowjapan.com>
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[georgi: backport to v4.19+]
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-msm.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -258,6 +258,8 @@ struct sdhci_msm_host {
 	bool mci_removed;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
+	bool use_cdr;
+	u32 transfer_mode;
 };
 
 static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
@@ -1025,6 +1027,26 @@ out:
 	return ret;
 }
 
+static void sdhci_msm_set_cdr(struct sdhci_host *host, bool enable)
+{
+	const struct sdhci_msm_offset *msm_offset = sdhci_priv_msm_offset(host);
+	u32 config, oldconfig = readl_relaxed(host->ioaddr +
+					      msm_offset->core_dll_config);
+
+	config = oldconfig;
+	if (enable) {
+		config |= CORE_CDR_EN;
+		config &= ~CORE_CDR_EXT_EN;
+	} else {
+		config &= ~CORE_CDR_EN;
+		config |= CORE_CDR_EXT_EN;
+	}
+
+	if (config != oldconfig)
+		writel_relaxed(config, host->ioaddr +
+			       msm_offset->core_dll_config);
+}
+
 static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1042,8 +1064,14 @@ static int sdhci_msm_execute_tuning(stru
 	if (host->clock <= CORE_FREQ_100MHZ ||
 	    !(ios.timing == MMC_TIMING_MMC_HS400 ||
 	    ios.timing == MMC_TIMING_MMC_HS200 ||
-	    ios.timing == MMC_TIMING_UHS_SDR104))
+	    ios.timing == MMC_TIMING_UHS_SDR104)) {
+		msm_host->use_cdr = false;
+		sdhci_msm_set_cdr(host, false);
 		return 0;
+	}
+
+	/* Clock-Data-Recovery used to dynamically adjust RX sampling point */
+	msm_host->use_cdr = true;
 
 	/*
 	 * For HS400 tuning in HS200 timing requires:
@@ -1525,6 +1553,19 @@ static int __sdhci_msm_check_write(struc
 	case SDHCI_POWER_CONTROL:
 		req_type = !val ? REQ_BUS_OFF : REQ_BUS_ON;
 		break;
+	case SDHCI_TRANSFER_MODE:
+		msm_host->transfer_mode = val;
+		break;
+	case SDHCI_COMMAND:
+		if (!msm_host->use_cdr)
+			break;
+		if ((msm_host->transfer_mode & SDHCI_TRNS_READ) &&
+		    SDHCI_GET_CMD(val) != MMC_SEND_TUNING_BLOCK_HS200 &&
+		    SDHCI_GET_CMD(val) != MMC_SEND_TUNING_BLOCK)
+			sdhci_msm_set_cdr(host, true);
+		else
+			sdhci_msm_set_cdr(host, false);
+		break;
 	}
 
 	if (req_type) {


