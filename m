Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D2DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EC92145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JySuEp7A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aDx563yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EC92145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeIXM3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:29:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeIXM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:29:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 605CB60275; Mon, 24 Sep 2018 06:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537770541;
        bh=VAhVP+A+lsy4QVjFK4rpBIqPx3gQSdRc0msQBnMIhSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JySuEp7AQn407Hkab2JNfSrjCc90jNztayaH5GlcWH6mjPA4Pq7tKMsrvNHuoMdci
         Z16RXC0YtyAetUp1mWpxwSuRmoIEExVyJeRCvY6SZP6T+6+j5C1JM++IEkhz9oCNxs
         Ui4sndugD8TmXG4gzf1jmO0LdEQPCVVKR1qAfyfs=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55A016078C;
        Mon, 24 Sep 2018 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537770540;
        bh=VAhVP+A+lsy4QVjFK4rpBIqPx3gQSdRc0msQBnMIhSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDx563yCE/fg+m5cW9RH7pdBHJA5tbxAbobAG9Gt/a8egT4d3OCp5lt7CxzAh0XvH
         1k5q9qewdVsJdMoRqiTPNP1XApF0y/EjWHIcDHfg3AO4jMr3k8FG5Le6fjyhsbQt0J
         c/QTxn4XX619gc23dSTJ+kaAIctLmvwOJy4wCANc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55A016078C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org
Cc:     stummala@codeaurora.org, adrian.hunter@intel.com,
        jlbec@evilplan.org, linux-scsi@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V14 1/2] scsi: ufs: set the device reference clock setting
Date:   Mon, 24 Sep 2018 11:58:35 +0530
Message-Id: <1537770516-28410-2-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org>
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org>
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
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/scsi/ufs/ufs.h           | 14 +++++++
 drivers/scsi/ufs/ufshcd-pltfrm.c |  2 +
 drivers/scsi/ufs/ufshcd.c        | 87 ++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h        |  2 +
 4 files changed, 105 insertions(+)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 14e5bf7..a2e76b1 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -378,6 +378,20 @@ enum query_opcode {
 	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
 };
 
+/* bRefClkFreq attribute values */
+enum ufs_ref_clk_freq {
+	REF_CLK_FREQ_19_2_MHZ	= 0,
+	REF_CLK_FREQ_26_MHZ	= 1,
+	REF_CLK_FREQ_38_4_MHZ	= 2,
+	REF_CLK_FREQ_52_MHZ	= 3,
+	REF_CLK_FREQ_INVAL	= -1,
+};
+
+struct ufs_ref_clk {
+	u32 freq_hz;
+	enum ufs_ref_clk_freq val;
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
index c5b1bf1..64c62db 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6296,6 +6296,86 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
 	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
 }
 
+static struct ufs_ref_clk ufs_ref_clk_freqs[] = {
+	{19200000, REF_CLK_FREQ_19_2_MHZ},
+	{26000000, REF_CLK_FREQ_26_MHZ},
+	{38400000, REF_CLK_FREQ_38_4_MHZ},
+	{52000000, REF_CLK_FREQ_52_MHZ},
+	{0, REF_CLK_FREQ_INVAL},
+};
+
+static inline enum ufs_ref_clk_freq
+ufs_get_bref_clk_from_hz(u32 freq)
+{
+	int i = 0;
+
+	while (ufs_ref_clk_freqs[i].freq_hz != freq) {
+		if (!ufs_ref_clk_freqs[i].freq_hz)
+			return REF_CLK_FREQ_INVAL;
+		i++;
+	}
+
+	return ufs_ref_clk_freqs[i].val;
+}
+
+void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba)
+{
+	struct device *dev = hba->dev;
+	struct device_node *np = dev->of_node;
+	struct clk *refclk = NULL;
+	u32 freq = 0;
+
+	if (!np)
+		return;
+
+	refclk = of_clk_get_by_name(np, "ref_clk");
+	if (!refclk)
+		return;
+
+	freq = clk_get_rate(refclk);
+
+	hba->dev_ref_clk_freq =
+		ufs_get_bref_clk_from_hz(freq);
+
+	if (hba->dev_ref_clk_freq == REF_CLK_FREQ_INVAL)
+		dev_err(hba->dev,
+		"%s: invalid ref_clk setting = %d\n",
+		__func__, freq);
+}
+
+static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
+{
+	int err, ref_clk = -1;
+	u32 freq = hba->dev_ref_clk_freq;
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
+	if (ref_clk == hba->dev_ref_clk_freq)
+		goto out; /* nothing to update */
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &freq);
+
+	if (err) {
+		dev_err(hba->dev, "%s: bRefClkFreq setting to %u Hz failed\n",
+		__func__, ufs_ref_clk_freqs[freq].freq_hz);
+		goto out;
+	}
+
+	dev_dbg(hba->dev, "%s: bRefClkFreq setting to %u Hz succeeded\n",
+		__func__, ufs_ref_clk_freqs[freq].freq_hz);
+
+out:
+	return err;
+}
+
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize
  * @hba: per-adapter instance
@@ -6361,6 +6441,12 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 			"%s: Failed getting max supported power mode\n",
 			__func__);
 	} else {
+		/*
+		 * Set the right value to bRefClkFreq before attempting to
+		 * switch to HS gears.
+		 */
+		if (hba->dev_ref_clk_freq != REF_CLK_FREQ_INVAL)
+			ufshcd_set_dev_ref_clk(hba);
 		ret = ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
 		if (ret) {
 			dev_err(hba->dev, "%s: Failed setting power mode, err = %d\n",
@@ -7690,6 +7776,7 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 	hba->host = host;
 	hba->dev = dev;
 	*hba_handle = hba;
+	hba->dev_ref_clk_freq = REF_CLK_FREQ_INVAL;
 
 	INIT_LIST_HEAD(&hba->clk_list_head);
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 8110dcd..45013b6 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -548,6 +548,7 @@ struct ufs_hba {
 	void *priv;
 	unsigned int irq;
 	bool is_irq_enabled;
+	enum ufs_ref_clk_freq dev_ref_clk_freq;
 
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

