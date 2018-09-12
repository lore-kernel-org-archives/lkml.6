Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AD5C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A73204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdS5xPkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A73204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeILO6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:58:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34233 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbeILO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:58:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so1277792eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=f5bkI9k4W2c9XfxovD/lpb7m212pStl1rJ1cHBfU/w8=;
        b=VdS5xPkqWD6huuj6drH9txEG/ptP+bfjajMdOn+cz2qpUtJh5vgHCFhg8v7ObU0t1D
         OxcIdFHzjrQIscgwb1WYW5ZTRfRNEN0eFsNsLjpJJ2P5KLWhHBfCQyQRjagq5jxRMyMB
         DQLwd/g2rjIrv71lJ+mmjLQbtv3Z0mHGx+rys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f5bkI9k4W2c9XfxovD/lpb7m212pStl1rJ1cHBfU/w8=;
        b=hF9eQDwJzx6/P3RQiZ1xyRx4V166epzy6WY6v9EzDc1fu0SJS7/NqFbRYX4ne7kOmW
         E2G/0JbaNgkEKLvB8VMhG+q1+IVBm/CtIQ/TtA1U5c25A2bX9IA9jym4nEhLYj9y86aR
         19q1PLZJgqmIEgD6AtEv36kv5pC1YcovBHMAUYwZzarwpQdGtl8M4mCio22jzUU4sWHc
         qPfEviIe8NzcKV62OxPPrJePoclII0efJZ83ZUqbethzHvlqC5u1u2VpqIHCoSCq42xv
         AxO6o1yf/14w6nZwTAlFDaE/EVb9VPf+M4dPaXh1qorym+R37oKuqsmXg/A552W39aY1
         w73w==
X-Gm-Message-State: APzg51B8XY3PRHZ/82AEi2Dh4CJYGkzVaLjXsbDvnB5ZQxFWf2Y9hQQr
        1hb86ycNfyLr/2dwLb4sghiLVx/bPsY=
X-Google-Smtp-Source: ANB0Vda6nzPa9Nf5fkD2j1meLN4TlS0Av8gySTdcrZ+8tMwv417kv8e5jHmghUsxHV1rb4UllTUIPA==
X-Received: by 2002:a50:a804:: with SMTP id j4-v6mr1808568edc.105.1536746054401;
        Wed, 12 Sep 2018 02:54:14 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id h8-v6sm400574edi.68.2018.09.12.02.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:54:13 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 07/16] thermal: tsens: Pass register offsets as private data
Date:   Wed, 12 Sep 2018 15:22:52 +0530
Message-Id: <dccdcf386d8d5298a77ec31cde699852cc4409c5.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers have moved around across TSENS generations. For example, the
CTRL register was at offset 0x0 in the SROT region on msm8916 but is at
offset 0x4 in newer v2 based TSENS HW blocks.

Allow passing offsets of important registers so that we can continue to
use common functions.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8916.c | 1 +
 drivers/thermal/qcom/tsens-8974.c | 1 +
 drivers/thermal/qcom/tsens-v2.c   | 2 ++
 drivers/thermal/qcom/tsens.c      | 3 +++
 drivers/thermal/qcom/tsens.h      | 9 +++++++++
 5 files changed, 16 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
index c4955c85e922..c6dd620ac029 100644
--- a/drivers/thermal/qcom/tsens-8916.c
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -100,5 +100,6 @@ static const struct tsens_ops ops_8916 = {
 const struct tsens_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
 	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
 };
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
index 7e149edbfeb6..3d3fda3d731b 100644
--- a/drivers/thermal/qcom/tsens-8974.c
+++ b/drivers/thermal/qcom/tsens-8974.c
@@ -232,4 +232,5 @@ static const struct tsens_ops ops_8974 = {
 const struct tsens_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
 };
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 1bdef92e4521..381a212872bf 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -68,10 +68,12 @@ static const struct tsens_ops ops_generic_v2 = {
 
 const struct tsens_data data_tsens_v2 = {
 	.ops            = &ops_generic_v2,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
 const struct tsens_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
 };
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9a8e8f7b4ae1..f1ec9bbe4717 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -144,6 +144,9 @@ static int tsens_probe(struct platform_device *pdev)
 		else
 			tmdev->sensor[i].hw_id = i;
 	}
+	for (i = 0; i < REG_ARRAY_SIZE; i++) {
+		tmdev->reg_offsets[i] = data->reg_offsets[i];
+	}
 
 	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->get_temp)
 		return -EINVAL;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b9c4bcf255fa..7b7feee5dc46 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -48,15 +48,23 @@ struct tsens_ops {
 	int (*get_trend)(struct tsens_device *, int, enum thermal_trend *);
 };
 
+enum reg_list {
+	SROT_CTRL_OFFSET,
+
+	REG_ARRAY_SIZE,
+};
+
 /**
  * struct tsens_data - tsens instance specific data
  * @num_sensors: Max number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
+ * @reg_offsets: Register offsets for commonly used registers
  */
 struct tsens_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
+	const u16		reg_offsets[REG_ARRAY_SIZE];
 	unsigned int		*hw_ids;
 };
 
@@ -72,6 +80,7 @@ struct tsens_device {
 	struct regmap			*tm_map;
 	struct regmap			*srot_map;
 	u32				tm_offset;
+	u16				reg_offsets[REG_ARRAY_SIZE];
 	struct tsens_context		ctx;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
-- 
2.17.1

