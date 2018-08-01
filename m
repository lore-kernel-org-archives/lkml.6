Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A167C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83E4208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YivwBqiK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K1Y7PimY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83E4208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbeHAKeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:34:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733177AbeHAKeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:34:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F42E60BE8; Wed,  1 Aug 2018 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533113371;
        bh=FyNOACEZWG8K105KvmZVnoSDzf1QMCYFrcJ6clQwJUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YivwBqiKA/aBC6A/UpQWO2RY9poaC3DhRtY5h3dBXCjapTf7PEMBEAzKLnPH4d488
         Fxvz55u+EK6xbVVBHc0F8XTAxsa+n0BbuhaiUfAVVuSEENze3WTXmC7RSFyLO7YOxa
         uxTJKKxsAYxdqyUhmi8rmSP3onx6wzuQuaLPdnA8=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 808DF60B62;
        Wed,  1 Aug 2018 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533113366;
        bh=FyNOACEZWG8K105KvmZVnoSDzf1QMCYFrcJ6clQwJUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1Y7PimYcOgg73RHSFDbNujIckc1Fp/zzBDA8/GjfQjlZDrxlFpA+7tvyDoAfPkbM
         zVnwkafbT5l2+MqIBJHHayrrcEHcuvipSYAEvaaoMwLXC9QT4nMWn7QDGsFF6s7TER
         oViFxVfy8vsJG4ld0H/47Ig6Cgs8RZ87wHRs2yho=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 808DF60B62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org
Cc:     adrian.hunter@intel.com, linux-scsi@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V7 1/2] scsi: ufs: set the device reference clock setting
Date:   Wed,  1 Aug 2018 14:18:57 +0530
Message-Id: <1533113338-31750-2-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533113338-31750-1-git-send-email-sayalil@codeaurora.org>
References: <1533113338-31750-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

UFS host supplies the reference clock to UFS device and UFS device
specification allows host to provide one of the 4 frequencies (19.2 MHz,
26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
device reference clock frequency setting in the device based on what
frequency it is supplying to UFS device.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/scsi/ufs/ufs.h           |  8 ++++
 drivers/scsi/ufs/ufshcd-pltfrm.c |  2 +
 drivers/scsi/ufs/ufshcd.c        | 84 ++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h        |  2 +
 4 files changed, 96 insertions(+)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 14e5bf7..89e0a33 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -378,6 +378,14 @@ enum query_opcode {
 	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
 };
 
+/* bRefClkFreq attribute values */
+enum ref_clk_freq {
+	REF_CLK_FREQ_19_2_MHZ	= 19200000,
+	REF_CLK_FREQ_26_MHZ	= 26000000,
+	REF_CLK_FREQ_38_4_MHZ	= 38400000,
+	REF_CLK_FREQ_52_MHZ	= 52000000,
+};
+
 /* Query response result code */
 enum {
 	QUERY_RESULT_SUCCESS                    = 0x00,
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index e82bde0..0953563 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -343,6 +343,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	ufshcd_parse_dev_ref_clk_freq(hba);
+
 	ufshcd_init_lanes_per_dir(hba);
 
 	err = ufshcd_init(hba, mmio_base, irq);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c5b1bf1..619313b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6296,6 +6296,84 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
 	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
 }
 
+void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba)
+{
+	struct device *dev = hba->dev;
+	struct device_node *np = dev->of_node;
+	struct clk *refclk = NULL;
+
+	if (!np)
+		return;
+
+	refclk = of_clk_get_by_name(np, "ref_clk");
+	if (refclk)
+		hba->dev_ref_clk_freq  = clk_get_rate(refclk);
+	else if (!refclk ||
+		(hba->dev_ref_clk_freq > REF_CLK_FREQ_52_MHZ)) {
+		dev_err(hba->dev,
+		"%s: invalid ref_clk setting = %u\n",
+		__func__, hba->dev_ref_clk_freq);
+		hba->dev_ref_clk_freq = 0;
+	}
+}
+
+static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
+{
+	int err = 0;
+	int ref_clk = -1;
+	static const char * const ref_clk_freqs[] = {"19.2 MHz", "26 MHz",
+						     "38.4 MHz", "52 MHz"};
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
+
+	if (err) {
+		dev_err(hba->dev, "%s: failed reading bRefClkFreq. err = %d\n",
+			 __func__, err);
+		goto out;
+	}
+
+	switch (hba->dev_ref_clk_freq) {
+	case REF_CLK_FREQ_19_2_MHZ:
+		hba->dev_ref_clk_freq = 0x0;
+		break;
+	case REF_CLK_FREQ_26_MHZ:
+		hba->dev_ref_clk_freq = 0x1;
+		break;
+	case REF_CLK_FREQ_38_4_MHZ:
+		hba->dev_ref_clk_freq = 0x2;
+		break;
+	case REF_CLK_FREQ_52_MHZ:
+		hba->dev_ref_clk_freq = 0x3;
+		break;
+	default:
+		dev_err(hba->dev,
+		"%s: invalid ref_clk setting = %u\n",
+		__func__, hba->dev_ref_clk_freq);
+		goto out;
+	}
+
+	if (ref_clk == hba->dev_ref_clk_freq)
+		goto out; /* nothing to update */
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0,
+			&hba->dev_ref_clk_freq);
+
+	if (err)
+		dev_err(hba->dev, "%s: bRefClkFreq setting to %s failed\n",
+			__func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
+	/*
+	 * It is good to print this out here to debug any later failures
+	 * related to gear switch.
+	 */
+	dev_dbg(hba->dev, "%s: bRefClkFreq setting to %s succeeded\n",
+			__func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
+
+out:
+	return err;
+}
+
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize
  * @hba: per-adapter instance
@@ -6361,6 +6439,12 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 			"%s: Failed getting max supported power mode\n",
 			__func__);
 	} else {
+		/*
+		 * Set the right value to bRefClkFreq before attempting to
+		 * switch to HS gears.
+		 */
+		if (hba->dev_ref_clk_freq)
+			ufshcd_set_dev_ref_clk(hba);
 		ret = ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
 		if (ret) {
 			dev_err(hba->dev, "%s: Failed setting power mode, err = %d\n",
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 8110dcd..101a75c 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -548,6 +548,7 @@ struct ufs_hba {
 	void *priv;
 	unsigned int irq;
 	bool is_irq_enabled;
+	u32 dev_ref_clk_freq;
 
 	/* Interrupt aggregation support is broken */
 	#define UFSHCD_QUIRK_BROKEN_INTR_AGGR			0x1
@@ -746,6 +747,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
 				u32 val, unsigned long interval_us,
 				unsigned long timeout_ms, bool can_sleep);
+void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba);
 
 static inline void check_upiu_size(void)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

