Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D4CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C3921655
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D+MpWzVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C3921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeI0ASQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:18:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46371 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeI0ASQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:18:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so14324239pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntMWu9Fwh/h12KSZAv8z50y9JE1gOFf9M3fxZMoM6T8=;
        b=D+MpWzVoGe1VgkgRzrmb6bgIepU26/pXpaD9kzC1FQ3+a48YffVsBnO0k0+Pvl9Pw8
         NkmHDO9NhhqAspFIrTecMJvPFSq+Sq4TNYfA8k50NdKCnRoYm5vhLN5qCvdjfTVlIVMn
         N6yMVPhahWf6vJColaH6U18lRGBQzOzVKTFm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntMWu9Fwh/h12KSZAv8z50y9JE1gOFf9M3fxZMoM6T8=;
        b=mPpdymzj1XfnHI+Xhtm9R6qU2EujXxHAe8SjpWjfR08T92dNmbtKGiL5Mx0A49MNr3
         kImCXlDW5d6zzBtZab/Jr27x8lirNHAcmlpmbb+k5I4utSggL3z0qMvld7lkatC8rriz
         44Y0ydxTyxQn35+cgkTuXRbQl9Jd1+uAAeDeyNIK49Il5kP8B/kxYDYVZDQTZMbeeNtf
         d5iPYvsKOn7wYTRUkoZfqCsUVLptgA3ZzoxmPkWoavoepcXiNeN3PmvOH2+FOJMHFojD
         DJfrs7gCuF4+9TRBAmGI45k0TZHW08eXqPoqGTafb8s/ArM9/LA2n2w+2mCNpGBrC354
         +fow==
X-Gm-Message-State: ABuFfoiXmQ7ZcipDVEcdB0QNR2Y0APea+lzcJizqwvn2w8Y16nH2Ihlu
        iLz2cwXWRc4iLXN3p7ijrPqY9Q==
X-Google-Smtp-Source: ACcGV60K62XkVEkBizblZEAWTzuyVYY2E4om4CcWLxIskou/2eubJdLJC4XuyMp31dTrEfOPuu8S1w==
X-Received: by 2002:a63:a919:: with SMTP id u25-v6mr6729429pge.211.1537985048508;
        Wed, 26 Sep 2018 11:04:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id j16-v6sm12246816pfk.125.2018.09.26.11.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:03:42 -0700 (PDT)
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
Subject: [PATCH v3 2/2] soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()
Date:   Wed, 26 Sep 2018 11:02:34 -0700
Message-Id: <20180926180234.55620-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180926180234.55620-1-swboyd@chromium.org>
References: <20180926180234.55620-1-swboyd@chromium.org>
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
operation from cmd_db to the caller. Updating the only user of this code
shows that making this change allows us to remove a function and put the
lookup where the user is.

Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 54 ++++++++++-----------------
 drivers/soc/qcom/cmd-db.c             | 43 ++++-----------------
 include/soc/qcom/cmd-db.h             | 12 ++----
 3 files changed, 30 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index bbb8126ec5c5..dd1cb55949b6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -859,26 +859,6 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
 	return ret;
 }
 
-/* Get the list of RPMh voltage levels from cmd-db */
-static int a6xx_gmu_rpmh_arc_cmds(const char *id, void *vals, int size)
-{
-	u32 len = cmd_db_read_aux_data_len(id);
-
-	if (!len)
-		return 0;
-
-	if (WARN_ON(len > size))
-		return -EINVAL;
-
-	cmd_db_read_aux_data(id, vals, len);
-
-	/*
-	 * The data comes back as an array of unsigned shorts so adjust the
-	 * count accordingly
-	 */
-	return len >> 1;
-}
-
 /* Return the 'arc-level' for the given frequency */
 static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
 {
@@ -906,11 +886,25 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
 }
 
 static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
-		unsigned long *freqs, int freqs_count,
-		u16 *pri, int pri_count,
-		u16 *sec, int sec_count)
+		unsigned long *freqs, int freqs_count, const char *id)
 {
 	int i, j;
+	const u16 *pri, *sec;
+	size_t pri_count, sec_count;
+
+	pri = cmd_db_read_aux_data(id, &pri_count);
+	/*
+	 * The data comes back as an array of unsigned shorts so adjust the
+	 * count accordingly
+	 */
+	pri_count >>= 1;
+	if (!pri_count)
+		return -EINVAL;
+
+	sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
+	sec_count >>= 1;
+	if (!sec_count)
+		return -EINVAL;
 
 	/* Construct a vote for each frequency */
 	for (i = 0; i < freqs_count; i++) {
@@ -969,25 +963,15 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct msm_gpu *gpu = &adreno_gpu->base;
-
-	u16 gx[16], cx[16], mx[16];
-	u32 gxcount, cxcount, mxcount;
 	int ret;
 
-	/* Get the list of available voltage levels for each component */
-	gxcount = a6xx_gmu_rpmh_arc_cmds("gfx.lvl", gx, sizeof(gx));
-	cxcount = a6xx_gmu_rpmh_arc_cmds("cx.lvl", cx, sizeof(cx));
-	mxcount = a6xx_gmu_rpmh_arc_cmds("mx.lvl", mx, sizeof(mx));
-
 	/* Build the GX votes */
 	ret = a6xx_gmu_rpmh_arc_votes_init(&gpu->pdev->dev, gmu->gx_arc_votes,
-		gmu->gpu_freqs, gmu->nr_gpu_freqs,
-		gx, gxcount, mx, mxcount);
+		gmu->gpu_freqs, gmu->nr_gpu_freqs, "gfx.lvl");
 
 	/* Build the CX votes */
 	ret |= a6xx_gmu_rpmh_arc_votes_init(gmu->dev, gmu->cx_arc_votes,
-		gmu->gmu_freqs, gmu->nr_gmu_freqs,
-		cx, cxcount, mx, mxcount);
+		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl");
 
 	return ret;
 }
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

