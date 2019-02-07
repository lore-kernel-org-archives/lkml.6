Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D02C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DFA21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvkPpY9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfBGM4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:56:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46191 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfBGM4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:56:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so4723471pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QM6AyIeFhqZF+Crf5VtmkjaF1HKzGjJgsV+pTA3g5qA=;
        b=XvkPpY9t/wv6a6ikREXghG0cLkZ/Cv5jBfBIgOU7lwF5usRmxlds3hPtbFN9LncouH
         I8o9F6YztPDf39ZbYzuGoTPaHfqfdDCkMnvrLDG7hHNIdjErE1N2hqacQQPWysixODmp
         tOVep90ZPAB6fw8nlvMxi7tdUKPcxgxigcf2/q1m2L7LGcBwaSHyGZeOeHfBQxAuc0kT
         299c9OLb6K/jgaJfdK6S1unB9SE1vaIIoURghoEcLdfOgv5mqbqhFtW8yDhGUdCwifPP
         HdUm2CZ63I3SWbCFjGitXsdKrY/wI8SuqoZSTv9Jbi2eD675PDPTq+lBPUM4WAVvbWBt
         /56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QM6AyIeFhqZF+Crf5VtmkjaF1HKzGjJgsV+pTA3g5qA=;
        b=gkc5h2B8VhRHuxLYnukiIvY1PRGSptw36dncX5g0RbhR9xN36lqsu0aHyqIZYz57xe
         vUVBGw/Bdo1KnUHGjamadcaR+/VJYct4vtCdvi0js+E+bChgY5WVQ7iyE6XWEJFg+wjA
         cyK705M0XmY0Sht8/pPIqJXcw+Frs7fl4UfpuMPSl/ToLhoX0qYm067e410lFFJMVSSI
         0pbltnqdKPobh51aKE64iXHVuSOiwOWfqFED/Ij7ipoTuR1qC+PEIWRjRoSx2xbcSkYg
         OKtbKsnv24hftcbTXcitVQp0WCN/irO1UywH/qV+NQqGfx5WdNYlx4xCGlAalEUHdjHC
         HCMA==
X-Gm-Message-State: AHQUAuYj2zyWCe+rgAqeYhu/HF9xUs/ujrhVFHyKQZYjqkyeK5M0CAx/
        gvW9kyZ/jHc347e2J0zh8CS5jyRA7ro=
X-Google-Smtp-Source: AHgI3IaU2zPGXxh47voE6KbrMN+U89FCPC/CfwjfdPAF3OqdQ8QAM2HoSR57iehkvRc7ZdA4p8fhTw==
X-Received: by 2002:a17:902:622:: with SMTP id 31mr16034547plg.171.1549544193284;
        Thu, 07 Feb 2019 04:56:33 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id c7sm14985464pfa.24.2019.02.07.04.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:56:32 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 16/24] drivers: thermal: tsens: Introduce IP-specific max_sensor count
Date:   Thu,  7 Feb 2019 16:19:34 +0530
Message-Id: <d112623568e98a6329547d4692d50e3b3ba09274.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP can support 'm' sensors while the platform can enable 'n' sensors
of the 'm' where n <= m.

Track maximum sensors supported by the IP so that we can correctly track
what subset of the sensors are supported on the platform.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 4 ++--
 drivers/thermal/qcom/tsens-v0_1.c   | 1 +
 drivers/thermal/qcom/tsens-v2.c     | 1 +
 drivers/thermal/qcom/tsens.h        | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 020409d8daf0..d981effed493 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -208,13 +208,13 @@ int __init init_common(struct tsens_priv *priv)
 		return PTR_ERR(priv->rf[SENSOR_EN]);
 
 	/* now alloc regmap_fields in tm_map */
-	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
+	for (i = 0, j = LAST_TEMP_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
 	}
-	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
+	for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index ad1052e05e45..4f17b4b781b0 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -324,6 +324,7 @@ const struct tsens_features tsens_v0_1_feat = {
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
+	.max_sensors	= 11,
 };
 
 /* v0.1: 8916, 8974 */
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index e0aac59d72ec..8052266447f5 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -88,6 +88,7 @@ const struct tsens_features tsens_v2_feat = {
 	.crit_int	= 1,
 	.adc		= 0,
 	.srot_split	= 1,
+	.max_sensors	= 16,
 };
 
 const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e0c1ca1a7467..9db89dffb719 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -189,12 +189,14 @@ enum regfield_ids {
  * @adc:      do the sensors only output adc code (instead of temperature)?
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
+ * @max_sensors: maximum sensors supported by this version of the IP
  */
 struct tsens_features {
 	unsigned int ver_info:1;
 	unsigned int crit_int:1;
 	unsigned int adc:1;
 	unsigned int srot_split:1;
+	unsigned int max_sensors;
 };
 
 /**
-- 
2.17.1

