Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A3CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2B920858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EEudRvsK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MBTMDW9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2B920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbeGMKHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:07:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeGMKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:07:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EF1760791; Fri, 13 Jul 2018 09:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475636;
        bh=FT59VhnnS/VkRQamqTv559NzdpNVswDPFE9jZCv5XjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEudRvsKHYTmh98ZyqD6OORJRsYWNTXFkXPHCPwttqL79ijOaymSEkcNvuffYLrTW
         Shjab8IGj/HGp+dHxwjOkblgKIzAIUFhTJfP7ByzLeGXYa7QYTaEzZ8dfK8wEpjT7K
         17iezPKw7wvXdVHhsGJRGvQSmPdEvkh0bvGo6TOI=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B72E460541;
        Fri, 13 Jul 2018 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475635;
        bh=FT59VhnnS/VkRQamqTv559NzdpNVswDPFE9jZCv5XjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBTMDW9AEPwvkLwax96cRP6Wxmq7h/KiUJLTRtAKP62j1SkTM/GkW4cH9uLKsz246
         quNapt4d+K92lkPCjuSEuUszY3T7xgLQVoAFLzNod44TNggE7M4HNrcp8AFWAyDt1H
         4MyAZXOPW1dEPFnSmgNvpmsXFZ75ZHfsKcCoaxNs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B72E460541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, sayalil@codeaurora.org,
        Talel Shenhar <tatias@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH RFC 4/7] mmc: core: add support for devfreq suspend/resume
Date:   Fri, 13 Jul 2018 15:23:00 +0530
Message-Id: <1531475583-7050-5-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support for devfreq suspend/resume
to be called on each system suspend/resume, runtime
suspend/resume, power restore.

Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/mmc/core/core.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h |   2 +
 drivers/mmc/core/host.c |   8 +++-
 drivers/mmc/core/mmc.c  |  27 ++++++++++++
 drivers/mmc/core/sd.c   |  13 ++++++
 5 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0eaee42..49103cf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -618,6 +618,111 @@ int mmc_init_clk_scaling(struct mmc_host *host)
 EXPORT_SYMBOL(mmc_init_clk_scaling);
 
 /**
+ * mmc_suspend_clk_scaling() - suspend clock scaling
+ * @host: pointer to mmc host structure
+ *
+ * This API will suspend devfreq feature for the specific host.
+ * The statistics collected by mmc will be cleared.
+ * This function is intended to be called by the pm callbacks
+ * (e.g. runtime_suspend, suspend) of the mmc device
+ */
+int mmc_suspend_clk_scaling(struct mmc_host *host)
+{
+	int err;
+
+	if (!host) {
+		WARN(1, "bad host parameter\n");
+		return -EINVAL;
+	}
+
+	if (!mmc_can_scale_clk(host) || !host->clk_scaling.enable)
+		return 0;
+
+	if (!host->clk_scaling.devfreq) {
+		pr_err("%s: %s: no devfreq is assosiated with this device\n",
+			mmc_hostname(host), __func__);
+		return -EPERM;
+	}
+
+	atomic_inc(&host->clk_scaling.devfreq_abort);
+	wake_up(&host->wq);
+	err = devfreq_suspend_device(host->clk_scaling.devfreq);
+	if (err) {
+		pr_err("%s: %s: failed to suspend devfreq\n",
+			mmc_hostname(host), __func__);
+		return err;
+	}
+	host->clk_scaling.enable = false;
+
+	host->clk_scaling.total_busy_time_us = 0;
+
+	pr_debug("%s: devfreq was removed\n", mmc_hostname(host));
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_suspend_clk_scaling);
+
+/**
+ * mmc_resume_clk_scaling() - resume clock scaling
+ * @host: pointer to mmc host structure
+ *
+ * This API will resume devfreq feature for the specific host.
+ * This API is intended to be called by the pm callbacks
+ * (e.g. runtime_suspend, suspend) of the mmc device
+ */
+int mmc_resume_clk_scaling(struct mmc_host *host)
+{
+	int err = 0;
+	u32 max_clk_idx = 0;
+	u32 devfreq_max_clk = 0;
+	u32 devfreq_min_clk = 0;
+
+	if (!host) {
+		WARN(1, "bad host parameter\n");
+		return -EINVAL;
+	}
+
+	if (!mmc_can_scale_clk(host))
+		return 0;
+
+	/*
+	 * If clock scaling is already exited when resume is called, like
+	 * during mmc shutdown, it is not an error and should not fail the
+	 * API calling this.
+	 */
+	if (!host->clk_scaling.devfreq) {
+		pr_warn("%s: %s: no devfreq is assosiated with this device\n",
+			mmc_hostname(host), __func__);
+		return 0;
+	}
+
+	atomic_set(&host->clk_scaling.devfreq_abort, 0);
+
+	max_clk_idx = host->clk_scaling.freq_table_sz - 1;
+	devfreq_max_clk = host->clk_scaling.freq_table[max_clk_idx];
+	devfreq_min_clk = host->clk_scaling.freq_table[0];
+
+	host->clk_scaling.curr_freq = devfreq_max_clk;
+	if (host->ios.clock < host->clk_scaling.freq_table[max_clk_idx])
+		host->clk_scaling.curr_freq = devfreq_min_clk;
+
+	host->clk_scaling.clk_scaling_in_progress = false;
+	host->clk_scaling.need_freq_change = false;
+
+	err = devfreq_resume_device(host->clk_scaling.devfreq);
+	if (err) {
+		pr_err("%s: %s: failed to resume devfreq (%d)\n",
+			mmc_hostname(host), __func__, err);
+	} else {
+		host->clk_scaling.enable = true;
+		pr_debug("%s: devfreq resumed\n", mmc_hostname(host));
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_resume_clk_scaling);
+
+/**
  * mmc_exit_devfreq_clk_scaling() - Disable clock scaling
  * @host: pointer to mmc host structure
  *
@@ -642,6 +747,13 @@ int mmc_exit_clk_scaling(struct mmc_host *host)
 		return -EPERM;
 	}
 
+	err = mmc_suspend_clk_scaling(host);
+	if (err) {
+		pr_err("%s: %s: fail to suspend clock scaling (%d)\n",
+			mmc_hostname(host), __func__,  err);
+		return err;
+	}
+
 	err = devfreq_remove_device(host->clk_scaling.devfreq);
 	if (err) {
 		pr_err("%s: remove devfreq failed (%d)\n",
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index fc0a9b7..249c20d 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -97,6 +97,8 @@ static inline void mmc_delay(unsigned int ms)
 extern bool mmc_can_scale_clk(struct mmc_host *host);
 extern int mmc_init_clk_scaling(struct mmc_host *host);
 extern int mmc_exit_clk_scaling(struct mmc_host *host);
+extern int mmc_suspend_clk_scaling(struct mmc_host *host);
+extern int mmc_resume_clk_scaling(struct mmc_host *host);
 
 int mmc_execute_tuning(struct mmc_card *card);
 int mmc_hs200_to_hs400(struct mmc_card *card);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 0504610..c3a71a5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -442,15 +442,19 @@ static ssize_t store_enable(struct device *dev,
 	mmc_get_card(host->card, NULL);
 
 	if (!value) {
-		/* mask host capability */
+		/* Suspend the clock scaling and mask host capability */
+		if (host->clk_scaling.enable)
+			mmc_suspend_clk_scaling(host);
 		host->caps2 &= ~MMC_CAP2_CLK_SCALE;
 		host->clk_scaling.state = MMC_LOAD_HIGH;
 		/* Set to max. frequency when disabling */
 		mmc_clk_update_freq(host, host->card->clk_scaling_highest,
 					host->clk_scaling.state);
 	} else if (value) {
-		/* Unmask host capability*/
+		/* Unmask host capability and resume scaling */
 		host->caps2 |= MMC_CAP2_CLK_SCALE;
+		if (!host->clk_scaling.enable)
+			mmc_resume_clk_scaling(host);
 	}
 
 	mmc_put_card(host->card, NULL);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c8aedf3..1d286af 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2161,6 +2161,13 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
 					EXT_CSD_POWER_OFF_LONG;
 
+	err = mmc_suspend_clk_scaling(host);
+	if (err) {
+		pr_err("%s: %s: fail to suspend clock scaling (%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
+
 	mmc_claim_host(host);
 
 	if (mmc_card_suspended(host->card))
@@ -2190,6 +2197,8 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	}
 out:
 	mmc_release_host(host);
+	if (err)
+		mmc_resume_clk_scaling(host);
 	return err;
 }
 
@@ -2228,6 +2237,10 @@ static int _mmc_resume(struct mmc_host *host)
 
 out:
 	mmc_release_host(host);
+	err = mmc_resume_clk_scaling(host);
+	if (err)
+		pr_err("%s: %s: fail to resume clock scaling (%d)\n",
+			mmc_hostname(host), __func__, err);
 	return err;
 }
 
@@ -2335,6 +2348,15 @@ static int _mmc_hw_reset(struct mmc_host *host)
 		mmc_pwrseq_reset(host);
 	}
 
+	/* Suspend clk scaling to avoid switching frequencies intermittently */
+
+	ret = mmc_suspend_clk_scaling(host);
+	if (ret) {
+		pr_err("%s: %s: fail to suspend clock scaling (%d)\n",
+			mmc_hostname(host), __func__, ret);
+		return ret;
+	}
+
 	ret = mmc_init_card(host, card->ocr, card);
 	if (ret) {
 		pr_err("%s: %s: mmc_init_card failed (%d)\n",
@@ -2342,6 +2364,11 @@ static int _mmc_hw_reset(struct mmc_host *host)
 		return ret;
 	}
 
+	ret = mmc_resume_clk_scaling(host);
+	if (ret)
+		pr_err("%s: %s: fail to resume clock scaling (%d)\n",
+			mmc_hostname(host), __func__, ret);
+
 	return ret;
 }
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 40144c1..5ae2916 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1131,6 +1131,13 @@ static int _mmc_sd_suspend(struct mmc_host *host)
 {
 	int err = 0;
 
+	err = mmc_suspend_clk_scaling(host);
+	if (err) {
+		pr_err("%s: %s: fail to suspend clock scaling (%d)\n",
+			mmc_hostname(host), __func__,  err);
+		return err;
+	}
+
 	mmc_claim_host(host);
 
 	if (mmc_card_suspended(host->card))
@@ -1182,6 +1189,12 @@ static int _mmc_sd_resume(struct mmc_host *host)
 	err = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
 
+	err = mmc_resume_clk_scaling(host);
+	if (err) {
+		pr_err("%s: %s: fail to resume clock scaling (%d)\n",
+			mmc_hostname(host), __func__, err);
+		goto out;
+	}
 out:
 	mmc_release_host(host);
 	return err;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

