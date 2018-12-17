Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678CBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AED20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJ94LMcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeLQJqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:46:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732160AbeLQJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so11542004wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rPu/KTYynL2hZ7Udac90NfGfOmFb5CPU0go+pwum/Ko=;
        b=GJ94LMcb2mXK/ECVCU6TpApvTHWweBWfPuTlBANuxKYmT4xaLEEdPjiPieHmsBgCCJ
         z4ECesqUmXpzpaYofaj1LKaF+l2Je+bQxM9psvo3s1WnbjqTzYEQWA5v+p8daXFv4J9Z
         Z8UZHjZ9x5J6+ubZs+m3Rzsq2Al5FdcnarC60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rPu/KTYynL2hZ7Udac90NfGfOmFb5CPU0go+pwum/Ko=;
        b=kUJyaQH7/ZtK99EqMDCpfPneyzVS8ElzpwMYT+B2wieu86dPqkDTwLUPbs8dAPeBf4
         1YRHIIP9qMUzt3Wo8JR4ErVOX7CxePGARlXhoPQhnvUaOuOg5syh9FCiI9xVMAm143Ds
         rIBHr77fRqNv1CFIihIn9FRDwNQumJu47ZrZuhgNqFuhgmKXmcFUCJ13C/GedWAzjSLy
         Cg27Qjkui5BEWTSyx+VTQkVHvnSeHzx/xNeUix1reST7ea0Ki1d2fJ90wpS+9Z4u59pz
         NHJqYUq8hTFg5Fvk198qwbcZt7c9/sW7vNvWCqUsfeRHKdX055EYeHTelDAXi3M6N0vP
         zUAw==
X-Gm-Message-State: AA+aEWZuit1iKvlzYmQBoJc8OP+UfDtQKMIz+P3fvOa6RhgE1hTWzqVn
        Flfsw6TuwMscRqW86SNnbnlmwg==
X-Google-Smtp-Source: AFSGD/WPbRY1qjo9wPqeWKiKnySAmHLHE2lhnFzt6KZue5DSPhSZN+WWivK1Ikwsj0MRbtN1VoM1JA==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr9480128wrq.5.1545040005201;
        Mon, 17 Dec 2018 01:46:45 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:44 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names from DT
Date:   Mon, 17 Dec 2018 10:46:22 +0100
Message-Id: <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow accessing the parent clock names required for the driver
operation by using the device tree node.

This permits extending the driver to other platforms without having to
modify its source code.

For backwards compatibility leave previous values as default.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/apcs-msm8916.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index a6c89a3..2453242 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -19,7 +19,7 @@
 
 static const u32 gpll0_a53cc_map[] = { 4, 5 };
 
-static const char * const gpll0_a53cc[] = {
+static const char *gpll0_a53cc[] = {
 	"gpll0_vote",
 	"a53pll",
 };
@@ -50,17 +50,39 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct clk_init_data init = { };
 	int ret = -ENODEV;
+	struct clk_bulk_data pclks[] = {
+		[0] = { .id = "aux", .clk = NULL },
+		[1] = { .id = "pll", .clk = NULL },
+	};
 
 	regmap = dev_get_regmap(parent, NULL);
 	if (!regmap) {
 		dev_err(dev, "failed to get regmap: %d\n", ret);
 		return ret;
 	}
-
 	a53cc = devm_kzalloc(dev, sizeof(*a53cc), GFP_KERNEL);
 	if (!a53cc)
 		return -ENOMEM;
 
+	/* check if the parent names are present in the device tree */
+	ret = devm_clk_bulk_get(parent, ARRAY_SIZE(pclks), pclks);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
+	if (!ret) {
+		gpll0_a53cc[0] = __clk_get_name(pclks[0].clk);
+		gpll0_a53cc[1] = __clk_get_name(pclks[1].clk);
+		a53cc->pclk = pclks[1].clk;
+	} else {
+		/* support old binding where only pll was explicitily defined */
+		a53cc->pclk = devm_clk_get(parent, NULL);
+		if (IS_ERR(a53cc->pclk)) {
+			ret = PTR_ERR(a53cc->pclk);
+			dev_err(dev, "failed to get clk: %d\n", ret);
+			return ret;
+		}
+	}
+
 	init.name = "a53mux";
 	init.parent_names = gpll0_a53cc;
 	init.num_parents = ARRAY_SIZE(gpll0_a53cc);
@@ -76,13 +98,6 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	a53cc->src_shift = 8;
 	a53cc->parent_map = gpll0_a53cc_map;
 
-	a53cc->pclk = devm_clk_get(parent, NULL);
-	if (IS_ERR(a53cc->pclk)) {
-		ret = PTR_ERR(a53cc->pclk);
-		dev_err(dev, "failed to get clk: %d\n", ret);
-		return ret;
-	}
-
 	a53cc->clk_nb.notifier_call = a53cc_notifier_cb;
 	ret = clk_notifier_register(a53cc->pclk, &a53cc->clk_nb);
 	if (ret) {
-- 
2.7.4

