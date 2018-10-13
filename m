Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7645C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7599A2075B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C5mQ9wjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7599A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJMIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:30:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46772 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeJMIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:30:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so6641285plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 17:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMecC22tuMOwvBh+xSlzoJFNRLm0nG22sbs6lAw+ewo=;
        b=C5mQ9wjmgpiFwjZY0INecveyEkAHIL7RF9rCfl3sFtmaLr9EIIZguHynKdfoKZLllp
         qHCr0Hp3ZKl1Ace7P4l5jSZc8NJrUawFM4vIinEfEMtb8Rm7DUpCyzdBuk2DoDu7jm3K
         O7g1O6A2+Sg7YAIqnYY1H2Xfpy2DvdGB/yUBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMecC22tuMOwvBh+xSlzoJFNRLm0nG22sbs6lAw+ewo=;
        b=tNejS5fyoky9wLuV1gDQtdjd0dIoDInmCaymHS3bBrBdc08LJ7/6lhRe099T/EDQYE
         nTAoeMG4UoqDemER/T38doe00F2zW8NklF3J+RmILxk/gptEDgPTwZFJAGNKkWu8AGRi
         SWKbsuUnBamJw07jKe4PEPRKX4orSKTVqFYuJ8Gfr7DIcubCigDwEMSWVGuOpjMup4o+
         FoyafYKOmCWcOm9ABcrn+VxWN0+zE8EfmuvZg728Yf6P9mmpcWAr/0t4901UYCC/ceQE
         Le60JXMfotHqGkILISUlqEgUSL8QZIpMbkDAPbR9Q77TeYJUogTfPrI5zOkZkwI86d4v
         6JjA==
X-Gm-Message-State: ABuFfoixIbjA+/lszQi6cRfp0EF8sFcYa6Z107MF8D5tUWNm5/AMso0l
        qkV95YHDj4cxCArJqNQYzMsV2w==
X-Google-Smtp-Source: ACcGV60zinOTiLbqMDbgskmYskxGFYjBAV7mYupSuC7iM9NDHyEm1DX2/dOAjMEO+EwJS3BQfVDOPg==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21-v6mr8022699pls.38.1539392130480;
        Fri, 12 Oct 2018 17:55:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id n7-v6sm2766183pgv.63.2018.10.12.17.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 17:55:29 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/4] ath10k: snoc: fix unabalanced regulator error handling
Date:   Fri, 12 Oct 2018 17:55:02 -0700
Message-Id: <20181013005504.46399-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181013005504.46399-1-briannorris@chromium.org>
References: <20181013005504.46399-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a regulator fails to set its voltage, we end up with an unbalanced
call to regulator_disable(), because the error path starts with the
current regulator (which was never enabled).

Factor out the "on" function to perform (and unwind if failed) a single
regulator at a time, and then main loop (ath10k_snoc_vreg_on()) can just
worry about unwinding the regulators that were already enabled.

It also helps to factor out the "off" function, to avoid repeating some
code here.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 129 ++++++++++++++-----------
 1 file changed, 75 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index c6254db17dab..b63ae8b006b4 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1311,6 +1311,76 @@ static int ath10k_get_clk_info(struct ath10k *ar, struct device *dev,
 	return ret;
 }
 
+static int __ath10k_snoc_vreg_on(struct ath10k *ar,
+				 struct ath10k_vreg_info *vreg_info)
+{
+	int ret;
+
+	ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc regulator %s being enabled\n",
+		   vreg_info->name);
+
+	ret = regulator_set_voltage(vreg_info->reg, vreg_info->min_v,
+				    vreg_info->max_v);
+	if (ret) {
+		ath10k_err(ar,
+			   "failed to set regulator %s voltage-min: %d voltage-max: %d\n",
+			   vreg_info->name, vreg_info->min_v, vreg_info->max_v);
+		return ret;
+	}
+
+	if (vreg_info->load_ua) {
+		ret = regulator_set_load(vreg_info->reg, vreg_info->load_ua);
+		if (ret < 0) {
+			ath10k_err(ar, "failed to set regulator %s load: %d\n",
+				   vreg_info->name, vreg_info->load_ua);
+			goto err_set_load;
+		}
+	}
+
+	ret = regulator_enable(vreg_info->reg);
+	if (ret) {
+		ath10k_err(ar, "failed to enable regulator %s\n",
+			   vreg_info->name);
+		goto err_enable;
+	}
+
+	if (vreg_info->settle_delay)
+		udelay(vreg_info->settle_delay);
+
+	return 0;
+
+err_enable:
+	regulator_set_load(vreg_info->reg, 0);
+err_set_load:
+	regulator_set_voltage(vreg_info->reg, 0, vreg_info->max_v);
+
+	return ret;
+}
+
+static int __ath10k_snoc_vreg_off(struct ath10k *ar,
+				  struct ath10k_vreg_info *vreg_info)
+{
+	int ret;
+
+	ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc regulator %s being disabled\n",
+		   vreg_info->name);
+
+	ret = regulator_disable(vreg_info->reg);
+	if (ret)
+		ath10k_err(ar, "failed to disable regulator %s\n",
+			   vreg_info->name);
+
+	ret = regulator_set_load(vreg_info->reg, 0);
+	if (ret < 0)
+		ath10k_err(ar, "failed to set load %s\n", vreg_info->name);
+
+	ret = regulator_set_voltage(vreg_info->reg, 0, vreg_info->max_v);
+	if (ret)
+		ath10k_err(ar, "failed to set voltage %s\n", vreg_info->name);
+
+	return ret;
+}
+
 static int ath10k_snoc_vreg_on(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
@@ -1324,53 +1394,21 @@ static int ath10k_snoc_vreg_on(struct ath10k *ar)
 		if (!vreg_info->reg)
 			continue;
 
-		ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc regulator %s being enabled\n",
-			   vreg_info->name);
-
-		ret = regulator_set_voltage(vreg_info->reg, vreg_info->min_v,
-					    vreg_info->max_v);
-		if (ret) {
-			ath10k_err(ar,
-				   "failed to set regulator %s voltage-min: %d voltage-max: %d\n",
-				   vreg_info->name, vreg_info->min_v, vreg_info->max_v);
-			goto err_reg_config;
-		}
-
-		if (vreg_info->load_ua) {
-			ret = regulator_set_load(vreg_info->reg,
-						 vreg_info->load_ua);
-			if (ret < 0) {
-				ath10k_err(ar,
-					   "failed to set regulator %s load: %d\n",
-					   vreg_info->name,
-					   vreg_info->load_ua);
-				goto err_reg_config;
-			}
-		}
-
-		ret = regulator_enable(vreg_info->reg);
-		if (ret) {
-			ath10k_err(ar, "failed to enable regulator %s\n",
-				   vreg_info->name);
+		ret = __ath10k_snoc_vreg_on(ar, vreg_info);
+		if (ret)
 			goto err_reg_config;
-		}
-
-		if (vreg_info->settle_delay)
-			udelay(vreg_info->settle_delay);
 	}
 
 	return 0;
 
 err_reg_config:
-	for (; i >= 0; i--) {
+	for (i = i - 1; i >= 0; i--) {
 		vreg_info = &ar_snoc->vreg[i];
 
 		if (!vreg_info->reg)
 			continue;
 
-		regulator_disable(vreg_info->reg);
-		regulator_set_load(vreg_info->reg, 0);
-		regulator_set_voltage(vreg_info->reg, 0, vreg_info->max_v);
+		__ath10k_snoc_vreg_off(ar, vreg_info);
 	}
 
 	return ret;
@@ -1389,24 +1427,7 @@ static int ath10k_snoc_vreg_off(struct ath10k *ar)
 		if (!vreg_info->reg)
 			continue;
 
-		ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc regulator %s being disabled\n",
-			   vreg_info->name);
-
-		ret = regulator_disable(vreg_info->reg);
-		if (ret)
-			ath10k_err(ar, "failed to disable regulator %s\n",
-				   vreg_info->name);
-
-		ret = regulator_set_load(vreg_info->reg, 0);
-		if (ret < 0)
-			ath10k_err(ar, "failed to set load %s\n",
-				   vreg_info->name);
-
-		ret = regulator_set_voltage(vreg_info->reg, 0,
-					    vreg_info->max_v);
-		if (ret)
-			ath10k_err(ar, "failed to set voltage %s\n",
-				   vreg_info->name);
+		ret = __ath10k_snoc_vreg_off(ar, vreg_info);
 	}
 
 	return ret;
-- 
2.19.1.331.ge82ca0e54c-goog

