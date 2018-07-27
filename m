Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D6320671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5YhsDnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D6320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbeG0UKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:10:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45698 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389106AbeG0UKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:10:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so2019470pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=za5CxvSp2kq8k58A6b/SgPjjdl8NPy5NiTzG8pBNcTw=;
        b=S5YhsDnvPwYlTmWw5SqxawobmMygCj2QnCiUByZuUKTI4O0Wgx8/S/NiCa2CWG9jHJ
         yAFcDMESmDqsFIToOlRTxXha4H9sL4sst+c54yuYtKJZtgYgMVNFyuddsKUrsPHgkTKo
         gxOwahyKMNujxaBeqyb5iP6o8v7h0P/y0EsyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=za5CxvSp2kq8k58A6b/SgPjjdl8NPy5NiTzG8pBNcTw=;
        b=j2qeJrLdGI9M6W/IaWcdkoScDVbblz5cqABFJzvQ9x1lI19WQ0PEXLlFrdpe9EXak0
         ZB3ukIwuZpMjNR7ndhfmFBtUu1awtm0QHotZWqKOenO/EO/yTi2cXNkEkRRskqaVBBzB
         EBK34/Pq4gwZ15hPgUYydd5JKStZoCTK1DvZH9RYjKc951sNbarmThA5CLK5fQBIC15K
         J5HjU5LNsJscoU+h+gmYFKZpnr962Dzl5Iqriw49McFajYj3BT0wpBvqI90Jwa/OFqvO
         Dkd7jksvDGes4TR757XH19aMiRxhbOD5PRj6Aw9exm6AeGVTIuGK++62ApSOvLDZSS4v
         AVFQ==
X-Gm-Message-State: AOUpUlE6/saTUmRszK1Bi4FAxfg4zAgaZxDX4YcH4w+F3jndg8WXhfo6
        IHV0K770LBgIdOaYa9LiEftf
X-Google-Smtp-Source: AAOMgpdVLzyJd1EwQvz/XVlsjRZL4Y/45JGHMi9G8/qEM5p0jR4QVtpGWVIUA4znyYJsgsrYjip44w==
X-Received: by 2002:a62:225d:: with SMTP id i90-v6mr7705770pfi.246.1532717211620;
        Fri, 27 Jul 2018 11:46:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:46:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/9] clk: actions: Cache regmap info in private clock descriptor
Date:   Sat, 28 Jul 2018 00:15:19 +0530
Message-Id: <20180727184527.13287-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support the reset controller, regmap info needs to
be cached in the private clock descriptor, owl_clk_desc. Hence,
save that and also make the clock descriptor struct non const.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-common.c | 3 ++-
 drivers/clk/actions/owl-common.h | 3 ++-
 drivers/clk/actions/owl-s700.c   | 4 ++--
 drivers/clk/actions/owl-s900.c   | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
index 61c1071b5180..32dd29e0a37e 100644
--- a/drivers/clk/actions/owl-common.c
+++ b/drivers/clk/actions/owl-common.c
@@ -39,7 +39,7 @@ static void owl_clk_set_regmap(const struct owl_clk_desc *desc,
 }
 
 int owl_clk_regmap_init(struct platform_device *pdev,
-			 const struct owl_clk_desc *desc)
+			struct owl_clk_desc *desc)
 {
 	void __iomem *base;
 	struct regmap *regmap;
@@ -57,6 +57,7 @@ int owl_clk_regmap_init(struct platform_device *pdev,
 	}
 
 	owl_clk_set_regmap(desc, regmap);
+	desc->regmap = regmap;
 
 	return 0;
 }
diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
index 4fd726ec54a6..56f01f7774aa 100644
--- a/drivers/clk/actions/owl-common.h
+++ b/drivers/clk/actions/owl-common.h
@@ -26,6 +26,7 @@ struct owl_clk_desc {
 	struct owl_clk_common		**clks;
 	unsigned long			num_clks;
 	struct clk_hw_onecell_data	*hw_clks;
+	struct regmap			*regmap;
 };
 
 static inline struct owl_clk_common *
@@ -35,7 +36,7 @@ static inline struct owl_clk_common *
 }
 
 int owl_clk_regmap_init(struct platform_device *pdev,
-			 const struct owl_clk_desc *desc);
+			struct owl_clk_desc *desc);
 int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks);
 
 #endif /* _OWL_COMMON_H_ */
diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index 5e9531392ee5..e7cacd677275 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -569,7 +569,7 @@ static struct clk_hw_onecell_data s700_hw_clks = {
 		.num    = CLK_NR_CLKS,
 };
 
-static const struct owl_clk_desc s700_clk_desc = {
+static struct owl_clk_desc s700_clk_desc = {
 	.clks       = s700_clks,
 	.num_clks   = ARRAY_SIZE(s700_clks),
 
@@ -578,7 +578,7 @@ static const struct owl_clk_desc s700_clk_desc = {
 
 static int s700_clk_probe(struct platform_device *pdev)
 {
-	const struct owl_clk_desc *desc;
+	struct owl_clk_desc *desc;
 
 	desc = &s700_clk_desc;
 	owl_clk_regmap_init(pdev, desc);
diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
index 7f60ed6afe63..bb7ee872d316 100644
--- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -684,7 +684,7 @@ static struct clk_hw_onecell_data s900_hw_clks = {
 	.num	= CLK_NR_CLKS,
 };
 
-static const struct owl_clk_desc s900_clk_desc = {
+static struct owl_clk_desc s900_clk_desc = {
 	.clks	    = s900_clks,
 	.num_clks   = ARRAY_SIZE(s900_clks),
 
@@ -693,7 +693,7 @@ static const struct owl_clk_desc s900_clk_desc = {
 
 static int s900_clk_probe(struct platform_device *pdev)
 {
-	const struct owl_clk_desc *desc;
+	struct owl_clk_desc *desc;
 
 	desc = &s900_clk_desc;
 	owl_clk_regmap_init(pdev, desc);
-- 
2.17.1

