Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD99C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C11821557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9aPmW/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C11821557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391032AbeIUXi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:38:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46338 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeIUXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:38:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so6278425pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=rC4Rj3P1k/Q6QD7WX93Els8mh/I6lZrdcdTj1aL5lPo=;
        b=L9aPmW/6bCVDL7k9UHGBoUikgajoxeo8OWrAVQqvSQoTYtgyISqRUbQaeGVf9StkI3
         /Z43sLecr2+DBgdf2CzrH5DmmEknRnaJhj3bEQMVB7VdOy/P+x/mcSw1OMnxogCS0uPT
         lYI6x9O4TYvzamDWVrRvf184a9Z2x61dL0b58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rC4Rj3P1k/Q6QD7WX93Els8mh/I6lZrdcdTj1aL5lPo=;
        b=S57zhFe8OCXECQ/4Ku6lNCYULl/dvStcyejI+AYS7SNrTJXWdGGqne0DJ9OaPx05JL
         K8oZNmQT+z28s0HWeWv/iO1nkNgurW1jZYVPDsOT6J8UkaUR1X3yJzCbH3B9GZ5guL2d
         zbwM271eLJx2jR+vuUQ+vHvYzLBG7VlvLcrDmBUngXCLeLwwQHJrEFcz5FQK1Xxjhn1d
         HHtGwehpvkB6pyioy7NsBpEkxWJ2ZOQF49Z6La80mzn3P1PuOQYONmd72ANFQVFz6YdO
         2ycGJLVla+0xgkVfrFm/lIk4Sb5dj7sxtDmhnBiWvxYl0WobglnS0cVoZqQX/KNxm72G
         yWBA==
X-Gm-Message-State: APzg51AKEFbeTxzasaU5aVtBrqwqYQ2dnoxiZCidXCqsApjbYlybKlf6
        b7UD53eXOiffZVdWh3mrt7LmLgwBe0Zhkw==
X-Google-Smtp-Source: ANB0VdZVgdDwSptuQEMsIf/2cGmme8+3gazHFRqHgPXtYspTuNlZ6xZTz4zrVfgCykOiR968ceQ8Fw==
X-Received: by 2002:a62:6b41:: with SMTP id g62-v6mr12338220pfc.113.1537552109056;
        Fri, 21 Sep 2018 10:48:29 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id s85-v6sm47315331pfa.116.2018.09.21.10.48.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 10:48:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/16] thermal: tsens: Pass register offsets as private data
Date:   Fri, 21 Sep 2018 10:46:16 -0700
Message-Id: <0d972069de14750f76b8545af6abfa44aad9c485.1537547011.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918193448.GA1367@tuxbook-pro>
References: <20180918193448.GA1367@tuxbook-pro>
In-Reply-To: <cover.1537547011.git.amit.kucheria@linaro.org>
References: <cover.1537547011.git.amit.kucheria@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Here is a fixup patch. Eduardo, if you like I can resend the entire series
or you can find the entire series hosted with all tags applied here:
https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=up/thermal/tsens-preirq-cleanup-v4

 drivers/thermal/qcom/tsens-8916.c | 1 +
 drivers/thermal/qcom/tsens-8974.c | 1 +
 drivers/thermal/qcom/tsens-v2.c   | 2 ++
 drivers/thermal/qcom/tsens.c      | 2 ++
 drivers/thermal/qcom/tsens.h      | 9 +++++++++
 5 files changed, 15 insertions(+)

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
index 9a8e8f7b4ae1..3c8776e55252 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -144,6 +144,8 @@ static int tsens_probe(struct platform_device *pdev)
 		else
 			tmdev->sensor[i].hw_id = i;
 	}
+	for (i = 0; i < REG_ARRAY_SIZE; i++)
+		tmdev->reg_offsets[i] = data->reg_offsets[i];
 
 	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->get_temp)
 		return -EINVAL;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b9c4bcf255fa..f62d2b6281da 100644
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
+ * @reg_offsets: Register offsets for commonly used registers
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
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

