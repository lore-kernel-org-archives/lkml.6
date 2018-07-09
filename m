Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C51C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C01F20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmxIMbpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C01F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeGILoa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:44:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33226 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932842AbeGILo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:44:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so13510843pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wik4a7EH1S7fZsbVdZxGmOdjNtd0gVTKmBfpirkIe5U=;
        b=cmxIMbpD8tI6sHlYKfOGZTrtpbKOXwRQAZpFgJ7Tmng7kIAQwvzxbrapIaZqYRwktU
         vCHpfBelrhTc2r+ApsBGPEQ/DYYGVl3+BInYKvh+som3IzeI0W4wcrty+F66xvaBS6yf
         sQ/r7HkoUE704DVuLzOvIkWaY4248qLY3h/F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wik4a7EH1S7fZsbVdZxGmOdjNtd0gVTKmBfpirkIe5U=;
        b=Vqif4Uzl/vwQEKulRELbMPXp1WuAIZyzu7JLat+LS1JxcKV9A2PBbCCIuqtUww6BwY
         EIDIca0jFtf3pl2/jVnCbPxu0bmy0lzbAgfXEwgScHsfGTw4r0ouJcACihctdS7sGEgP
         1l0CDjyfm1H12X4EH4dufpcR9o4wFS5lbpai/WJMfpQFY7Unb378wmovRldGOokt00KX
         p7XGdbzRw/j8wrfeXiU91a0D7cClSLEU85zqr/c/U9o3BAbpzGWGe/V2GNKN0eh52met
         UAmHXH1PrZe557gqvnUifNJChGsCf38hq6ssD7gDZ81yQOg4xfy4G/E5EsnMxS57ncZ3
         QZ2w==
X-Gm-Message-State: APt69E0Mk6lt95XMUIgB2oa/m0nEJ5tWMcbGi4+lFoXN1ELnz/IWP7aP
        PaLks4jVQKmWLsTHpc27OX8ci5S3SNE=
X-Google-Smtp-Source: AAOMgpeQX8drmcMIx8i1HrSb1QXrS54KGm9AeJzZT5DpaehkeneqCAWl7HtBFt3Ydkxr7KLDsNz9aQ==
X-Received: by 2002:a62:c00c:: with SMTP id x12-v6mr20946530pff.216.1531136666907;
        Mon, 09 Jul 2018 04:44:26 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id z10-v6sm23139630pfh.83.2018.07.09.04.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:44:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v6 5/7] thermal: tsens: Add generic support for TSENS v2 IP
Date:   Mon,  9 Jul 2018 17:13:27 +0530
Message-Id: <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 uses v2 of the TSENS IP block but the get_temp() function
appears to be identical across v2.x.y in code seen so far. We use the
generic get_temp() function defined as part of ops_generic_v2.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 6 +++++-
 drivers/thermal/qcom/tsens.c    | 3 +++
 drivers/thermal/qcom/tsens.h    | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 34ba6c7..f40150f 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -69,8 +69,12 @@ static const struct tsens_ops ops_generic_v2 = {
 	.get_temp	= get_temp_tsens_v2,
 };
 
+const struct tsens_data data_tsens_v2 = {
+	.ops            = &ops_generic_v2,
+};
+
+/* Kept around for backward compatibility with old msm8996.dtsi */
 const struct tsens_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
 };
-
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3440166c..a2c9bfa 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,tsens-v2",
+		.data = &data_tsens_v2,
 	},
 	{}
 };
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index d785b37..14331eb 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -88,6 +88,9 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
 int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 
-extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
+/* TSENS v1 targets */
+extern const struct tsens_data data_8916, data_8974, data_8960;
+/* TSENS v2 targets */
+extern const struct tsens_data data_8996, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.7.4

