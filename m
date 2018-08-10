Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E766EC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960FA223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDR/wORi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960FA223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeHJMVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:21:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38760 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHJMVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:21:35 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so3842285plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=za5CxvSp2kq8k58A6b/SgPjjdl8NPy5NiTzG8pBNcTw=;
        b=MDR/wORiIicegXE/lZK20080EUGevP30xgio1IZYAVaXU2kPY3gAwlFD4CdURu1UML
         1ebLkImhU/zXnpZFmZh++SLYUh/OxZgxVHmF9Y6q2pNlZP5HUzqVgCClLtKcoPPTxqOx
         32SUt2A8BEYeyxhRF4qqu8kVeRa4Jt7g4w4Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=za5CxvSp2kq8k58A6b/SgPjjdl8NPy5NiTzG8pBNcTw=;
        b=hnxDzY3CUFnBA6+B5DhSAwZyssitX6jL7pkAdzGuY+RTfEwo2EoznjIUL2RNksx5jg
         NW4VtTrUhS8joK6qPUokF/v/K00GrGcXrl8/hJAV4i0NvRv+AlclzFRpOVjFYKLNkSek
         yUEgkxPBH3Yo1kRCl7k0QgnK/0QhMb6ZvU4ZK4g4sZMKWiauxdTeDiaOTNvWQkis++NO
         Fku5+D2Xvu1F5bZyVQXMR6/kGbJSi8y3MLhjfLs9ehw9x5i5Gt3ai2RTHLy+15tOnM31
         u4Wg9qMAyzkTDdYiQm0kU+e3V8a6pC4EhRCaqUjhTmmg/ovoD1G/DcO/Dcw2JIIZ9Uv1
         LAgg==
X-Gm-Message-State: AOUpUlEDhstjb0EhBgJEsClZSH9p0EBS46IpJYFWtxNXJn3aw/O1Sh3K
        9qXvUmOsoZAouow/tPBTlPEU
X-Google-Smtp-Source: AA+uWPwHdPEa00JmJrlRDcme7M+4twtse8PVpmI9XdLGdRmmMuvGW5LQCzwJ944o0WP0/PcKHHZxrw==
X-Received: by 2002:a17:902:6f02:: with SMTP id w2-v6mr5450151plk.216.1533894747003;
        Fri, 10 Aug 2018 02:52:27 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:52:26 -0700 (PDT)
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
Subject: [PATCH v3 1/9] clk: actions: Cache regmap info in private clock descriptor
Date:   Fri, 10 Aug 2018 15:21:05 +0530
Message-Id: <20180810095113.25292-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
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

