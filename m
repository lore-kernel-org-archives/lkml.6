Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1854921904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dxv12iw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfBGM5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:57:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42978 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfBGM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:57:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so4450851pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TBXOh+qCZb1AbvhplyZXyYZ1SSUAH9q1meg8o/qp39A=;
        b=Dxv12iw1540JjbRcyK2umnt9oXCAqkHsByXWPmEn1LVFPu2+B21yLM0K1sJznok8QQ
         EWxZg0ZAdBmuGcfmVux11ZIjQrnIMCBbCz4CMNGT2ftRiZnvJSsfs35IkSV1JLliz6+W
         cFom0VgHRXbl/oPGwYJyoTlgRctZJk6yqRUj117llYHYZBcTX9xrf1c8GOBwcyx9HLLt
         +g1qsVZUGcmkkLzNp9Rp/6bWwu9Nrz1gH12O7qGOeXSs46kOBlzJCfIIiC+VAP/giUvh
         t4y94WWhhp/KiGr1/QwVtcZ4HtcISy3hMBu3HGtT3+dQthfe/e9U6Srobab0cdFsXFcG
         fwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TBXOh+qCZb1AbvhplyZXyYZ1SSUAH9q1meg8o/qp39A=;
        b=rvUszTTYwtuhAnh2AGVvQ4PabwPuk8/QH44eGhFZ8JL5xqkF06SoUMneR9Hzhnoh6L
         DU0tg8Fui5do8A3u7/hXj7aKVVSfGhnvARpNbRNZUjCfPmELe0hRG9n4n9hvR+mKiSTb
         g8MFJzZhwszO70qLxz0ei7kXSQ9duzkOM3ClmGCzt6amqbNuOQNEpEOnrn0uBMjxxhr6
         EcKzA2tr/ZrEZZW+ke6AlKFJ413c7KWP1Tc0Lcz2yx2ALHdBBQL/lSOzjXN/Ge+qp0O2
         6qZR4k72Ha6qqWEi2KEMnfM/yrULpQrgJK6a9YphyrCWkATW5bpR9QO29/svoc8NOgzc
         TTpg==
X-Gm-Message-State: AHQUAuYoaGaMulDCA3wDuQIm7TRpuw3WA/nniyK9uDVlHqL4vsIY2YCA
        FfGIiFM15rsPodlx79lpNqUgnJ743VI=
X-Google-Smtp-Source: AHgI3IYYmiAw+FmWPwkuYe1480YXN+cV/Hs36LDUyGThrQywJlslEwoZ5Zchc5gijv4TnhahQXgoRg==
X-Received: by 2002:a63:a55:: with SMTP id z21mr14775670pgk.401.1549544271802;
        Thu, 07 Feb 2019 04:57:51 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id n14sm3714273pgd.48.2019.02.07.04.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:57:51 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 06/24] drivers: thermal: tsens: Function prototypes should have argument names
Date:   Thu,  7 Feb 2019 16:19:24 +0530
Message-Id: <1ff476080e60beab71905ef39f2f703c52ae92f9.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_patch complains a lot as follows:

WARNING: function definition argument 'struct tsens_priv *' should also have an identifier name
+       int (*init)(struct tsens_priv *);

Fix it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 61ca2905ee7a..4d6a406f8dca 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -47,15 +47,15 @@ struct tsens_sensor {
  */
 struct tsens_ops {
 	/* mandatory callbacks */
-	int (*init)(struct tsens_priv *);
-	int (*calibrate)(struct tsens_priv *);
-	int (*get_temp)(struct tsens_priv *, int, int *);
+	int (*init)(struct tsens_priv *priv);
+	int (*calibrate)(struct tsens_priv *priv);
+	int (*get_temp)(struct tsens_priv *priv, int i, int *temp);
 	/* optional callbacks */
-	int (*enable)(struct tsens_priv *, int);
-	void (*disable)(struct tsens_priv *);
-	int (*suspend)(struct tsens_priv *);
-	int (*resume)(struct tsens_priv *);
-	int (*get_trend)(struct tsens_priv *, int, enum thermal_trend *);
+	int (*enable)(struct tsens_priv *priv, int i);
+	void (*disable)(struct tsens_priv *priv);
+	int (*suspend)(struct tsens_priv *priv);
+	int (*resume)(struct tsens_priv *priv);
+	int (*get_trend)(struct tsens_priv *priv, int i, enum thermal_trend *trend);
 };
 
 enum reg_list {
@@ -111,10 +111,10 @@ struct tsens_priv {
 	struct tsens_sensor		sensor[0];
 };
 
-char *qfprom_read(struct device *, const char *);
-void compute_intercept_slope(struct tsens_priv *, u32 *, u32 *, u32);
-int init_common(struct tsens_priv *);
-int get_temp_common(struct tsens_priv *, int, int *);
+char *qfprom_read(struct device *dev, const char *cname);
+void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
+int init_common(struct tsens_priv *priv);
+int get_temp_common(struct tsens_priv *priv, int i, int *temp);
 
 /* TSENS v1 targets */
 extern const struct tsens_plat_data data_8916, data_8974, data_8960;
-- 
2.17.1

