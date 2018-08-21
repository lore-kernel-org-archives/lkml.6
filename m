Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A97C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE9B2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ENE1nvnA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nt46aoZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE9B2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHUNhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:37:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeHUNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:37:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C842661327; Tue, 21 Aug 2018 10:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534846677;
        bh=GfbMSNSIY05qvPdZQqA5mvo4HP/qeiLrGlJWHEbhQsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENE1nvnAWG01Ul4fP0h6XsisVpcT/C8qZRYh4/c5pAGUJ7rVBS3wfWiqtZnBNfLcH
         z3K/jYUHLlpX//NoIhinxbhB5cSsx1DcfA6Q1EeELwuH0d8SSSLv/X0ZTHYfMcNq/Y
         sZa+/Vqgh9dkH8zSSwK8PY/f+QSisxL6RjvTNQzA=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D51961323;
        Tue, 21 Aug 2018 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534846676;
        bh=GfbMSNSIY05qvPdZQqA5mvo4HP/qeiLrGlJWHEbhQsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nt46aoZ+k7BJhvP6iiOhTHotYqZlzL2nvDxEVGv1cCDS089GMCQfXD7RUxkpyF7yQ
         NaDn48zkUZPCWTVSQgVDodL4QFRE++LrYD4SUvUQ+slUt/uUFUK25af+u5dpGu7JtL
         BBvTZUoeaDj7dGD4a+IsXHwoQ8630Y470Za+2I88=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D51961323
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
Subject: [PATCH V9 1/2] scsi: ufs: set the device reference clock setting
Date:   Tue, 21 Aug 2018 15:47:28 +0530
Message-Id: <1534846649-2456-2-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534846649-2456-1-git-send-email-sayalil@codeaurora.org>
References: <1534846649-2456-1-git-send-email-sayalil@codeaurora.org>
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
 drivers/scsi/ufs/ufs.h    | 14 ++++++++
 drivers/scsi/ufs/ufshcd.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h |  2 ++
 3 files changed, 108 insertions(+)

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
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c5b1bf1..e946844 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6296,6 +6296,91 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
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
+ufs_get_bref_clk_for_ref_clk_freq_hz(u32 freq)
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
+	hba->dev_ref_clk_freq = REF_CLK_FREQ_INVAL;
+
+	refclk = of_clk_get_by_name(np, "ref_clk");
+	if (!refclk)
+		return;
+
+	freq = clk_get_rate(refclk);
+	if (freq > REF_CLK_FREQ_52_MHZ) {
+		dev_err(hba->dev,
+		"%s: invalid ref_clk setting = %d\n",
+		__func__, freq);
+		return;
+	}
+
+	hba->dev_ref_clk_freq =
+		ufs_get_bref_clk_for_ref_clk_freq_hz(freq);
+}
+
+static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
+{
+	int err = 0;
+	int ref_clk = -1;
+	u32 freq = (u32)hba->dev_ref_clk_freq;
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
+	if (err)
+		dev_err(hba->dev, "%s: bRefClkFreq setting to %u Hz failed\n",
+		__func__, ufs_ref_clk_freqs[freq].freq_hz);
+	/*
+	 * It is good to print this out here to debug any later failures
+	 * related to gear switch.
+	 */
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
@@ -6361,6 +6446,12 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
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
@@ -7693,6 +7784,7 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 
 	INIT_LIST_HEAD(&hba->clk_list_head);
 
+	ufshcd_parse_dev_ref_clk_freq(hba);
 out_error:
 	return err;
 }
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

