Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98482ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48480214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f58A4adk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48480214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeIRCJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:09:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37484 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeIRCJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:09:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so8104376pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cl9qCndhHFyPmfRvTA/9yk4YZ1+VCCSmFRNZ4H0i7X8=;
        b=f58A4adkVafl2RhnPrQ8N1Vd8F8gnGqT9IYEtxM26OyW62l2WiehMSroo7ixKuMKmf
         wQNKFQgwo0NeY8sOF+Y40M107SAWzU7kKZbCrJPpAwJ2Vu1XEI6jdWU8KFGaDwR15qPo
         sHY+XCsWFfyP04Md30d2NGXRBK/80i1Wxd5SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cl9qCndhHFyPmfRvTA/9yk4YZ1+VCCSmFRNZ4H0i7X8=;
        b=op0dHlDXGr603AFbuYf0QOqGnNNUwbAz9ja7Omb5UXficvKcc5MeSRR06LZpjL54SM
         O90ydrh6ZcJ9RKimsQJgG9jwn8IAwrJCXqGbz0bdJywDzphZuyhXl4UHciRw1o5UOxz1
         dmO3IEl7YnzQK322dGhQctmxW26TosrX3SGx9ULbm4JDRC4MK+P/bxDe86smbKlj0QPS
         MUvrciOWPtwrE36CQr5Kxd5CBcNVbpZNlu9bP+OX/x3xrE7oEc3YRM72aQqc/2lwIqVs
         9qB9UuU6cmDadFchWZ9xtsPBeoDbXsrvqaHxNqyDpkgIOwPaudPOLNqQcvLz01TXxp3l
         yz9w==
X-Gm-Message-State: APzg51BcXL+l92jDQ3MQvroJ/AV6K93pJt7WAAMUjZCPHrd1tr9DFMFL
        yJAojoLwGjp4a+MsRY1D8AykKw==
X-Google-Smtp-Source: ANB0VdZpgyPtETBprw1Yrjq79tMQKLKZd7Q5vuCP7KdNd9ed/DJw+xzTwu9AmWlMr0ceToOPK5I0IA==
X-Received: by 2002:a62:4dc1:: with SMTP id a184-v6mr27418289pfb.5.1537216812578;
        Mon, 17 Sep 2018 13:40:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id g25-v6sm26858002pfd.23.2018.09.17.13.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 13:40:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH v2 2/2] soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()
Date:   Mon, 17 Sep 2018 13:40:07 -0700
Message-Id: <20180917204007.250862-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917204007.250862-1-swboyd@chromium.org>
References: <20180917204007.250862-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's change the function signature to return the pointer to memory or
an error pointer on failure, and take an argument that lets us return
the size of the aux data read. This way we can remove the
cmd_db_read_aux_data_len() API entirely and also get rid of the memcpy
operation from cmd_db to the caller.

Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 34 ++++++++++-----------
 drivers/soc/qcom/cmd-db.c             | 43 +++++----------------------
 include/soc/qcom/cmd-db.h             | 12 ++------
 3 files changed, 28 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index bbb8126ec5c5..e4387a3fa745 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -860,23 +860,23 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
 }
 
 /* Get the list of RPMh voltage levels from cmd-db */
-static int a6xx_gmu_rpmh_arc_cmds(const char *id, void *vals, int size)
+static const u16 *a6xx_gmu_rpmh_arc_cmds(const char *id, int *size)
 {
-	u32 len = cmd_db_read_aux_data_len(id);
-
-	if (!len)
-		return 0;
-
-	if (WARN_ON(len > size))
-		return -EINVAL;
-
-	cmd_db_read_aux_data(id, vals, len);
+	size_t len;
+	const u16 *vals;
 
+	vals = cmd_db_read_aux_data(id, &len);
 	/*
 	 * The data comes back as an array of unsigned shorts so adjust the
 	 * count accordingly
 	 */
-	return len >> 1;
+	len >>= 1;
+
+	if (!len || WARN_ON(len > 16))
+		len = 0;
+
+	*size = len;
+	return vals;
 }
 
 /* Return the 'arc-level' for the given frequency */
@@ -907,8 +907,8 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
 
 static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 		unsigned long *freqs, int freqs_count,
-		u16 *pri, int pri_count,
-		u16 *sec, int sec_count)
+		const u16 *pri, int pri_count,
+		const u16 *sec, int sec_count)
 {
 	int i, j;
 
@@ -970,14 +970,14 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct msm_gpu *gpu = &adreno_gpu->base;
 
-	u16 gx[16], cx[16], mx[16];
+	const u16 *gx, *cx, *mx;
 	u32 gxcount, cxcount, mxcount;
 	int ret;
 
 	/* Get the list of available voltage levels for each component */
-	gxcount = a6xx_gmu_rpmh_arc_cmds("gfx.lvl", gx, sizeof(gx));
-	cxcount = a6xx_gmu_rpmh_arc_cmds("cx.lvl", cx, sizeof(cx));
-	mxcount = a6xx_gmu_rpmh_arc_cmds("mx.lvl", mx, sizeof(mx));
+	gx = a6xx_gmu_rpmh_arc_cmds("gfx.lvl", &gxcount);
+	cx = a6xx_gmu_rpmh_arc_cmds("cx.lvl", &cxcount);
+	mx = a6xx_gmu_rpmh_arc_cmds("mx.lvl", &mxcount);
 
 	/* Build the GX votes */
 	ret = a6xx_gmu_rpmh_arc_votes_init(&gpu->pdev->dev, gmu->gx_arc_votes,
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 5c9cc6824891..c701b3b010f1 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -192,55 +192,28 @@ EXPORT_SYMBOL(cmd_db_read_addr);
 /**
  * cmd_db_read_aux_data() - Query command db for aux data.
  *
- *  @id: Resource to retrieve AUX Data on.
- *  @data: Data buffer to copy returned aux data to. Returns size on NULL
- *  @len: Caller provides size of data buffer passed in.
+ *  @id: Resource to retrieve AUX Data on
+ *  @len: size of data buffer returned
  *
- *  Return: size of data on success, errno otherwise
+ *  Return: pointer to data on success, error pointer otherwise
  */
-int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
+const void *cmd_db_read_aux_data(const char *id, size_t *len)
 {
 	int ret;
 	const struct entry_header *ent;
 	const struct rsc_hdr *rsc_hdr;
-	u16 ent_len;
-
-	if (!data)
-		return -EINVAL;
 
 	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
 	if (ret)
-		return ret;
-
-	ent_len = le16_to_cpu(ent->len);
-	if (len < ent_len)
-		return -EINVAL;
+		return ERR_PTR(ret);
 
-	len = min_t(u16, ent_len, len);
-	memcpy(data, rsc_offset(rsc_hdr, ent), len);
+	if (len)
+		*len = le16_to_cpu(ent->len);
 
-	return len;
+	return rsc_offset(rsc_hdr, ent);
 }
 EXPORT_SYMBOL(cmd_db_read_aux_data);
 
-/**
- * cmd_db_read_aux_data_len - Get the length of the auxiliary data stored in DB.
- *
- * @id: Resource to retrieve AUX Data.
- *
- * Return: size on success, 0 on error
- */
-size_t cmd_db_read_aux_data_len(const char *id)
-{
-	int ret;
-	const struct entry_header *ent;
-
-	ret = cmd_db_get_header(id, &ent, NULL);
-
-	return ret < 0 ? 0 : le16_to_cpu(ent->len);
-}
-EXPORT_SYMBOL(cmd_db_read_aux_data_len);
-
 /**
  * cmd_db_read_slave_id - Get the slave ID for a given resource address
  *
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index 578180cbc134..af9722223925 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -18,9 +18,7 @@ enum cmd_db_hw_type {
 #if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
 u32 cmd_db_read_addr(const char *resource_id);
 
-int cmd_db_read_aux_data(const char *resource_id, u8 *data, size_t len);
-
-size_t cmd_db_read_aux_data_len(const char *resource_id);
+const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
 
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
 
@@ -29,12 +27,8 @@ int cmd_db_ready(void);
 static inline u32 cmd_db_read_addr(const char *resource_id)
 { return 0; }
 
-static inline int cmd_db_read_aux_data(const char *resource_id, u8 *data,
-				       size_t len)
-{ return -ENODEV; }
-
-static inline size_t cmd_db_read_aux_data_len(const char *resource_id)
-{ return -ENODEV; }
+static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
+{ return ERR_PTR(-ENODEV); }
 
 static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
 { return -ENODEV; }
-- 
Sent by a computer through tubes

