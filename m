Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26CBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F9D2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8Tt52Jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeLaSzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:55:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38555 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeLaSzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:55:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so12900200plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wGON2lybsGy7FC0OgCUYudVtpokObJD+vq+U001MecQ=;
        b=X8Tt52JcCR8ZkeN2DDakfZzHCPRVV4UzdKgl85bFhx1Btuy/aWNp56Wa1wbQuEAxvX
         /6FPeBENCGfp9th/naRoCzH1Em3pitOhqvpb8ASdME5jGaStYrLVfWR45Km9V/MoK3RH
         9hQfv8eqdpXnFgZsEYmGWIB+ds0g8icOp38qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wGON2lybsGy7FC0OgCUYudVtpokObJD+vq+U001MecQ=;
        b=hjcvYR2U7r5LzK4Juc11pL76qDZEhY76VWSicrXg3/fPbYBCWtPNBvfMqtrlarBrAV
         O6gn3g3W0JbheiEHnqKjFyGLUBu7yphG6mcG6tmHMrZV/cxNHCsz5FQKHCPcC63TOgdq
         EvGYJpM/Ico3DzGVp564hBSVaSOjEU2kn2tHxFnnv1rcNytyiIUadflJ9YJdSmvSsrxf
         +RtShOL+sP4yjO+M5y2QPAgyr2CEGJlpWxE8AxJDi1jLa/oEmIsVFD5KLdb/SvB67Pvu
         3IqPU0nf5JjTCkzx9uzFxhQP4PMZdEn1ysjdsDdg3hJgzpUcHuSmyMS56D2xB46kP9Ae
         jGCA==
X-Gm-Message-State: AJcUukf1e7lcWDt5GX1tSq9yzhoqFXB+nYgstaF2n3ZFmOMpUpanMtwx
        PokpVA/yrj1hk6CCoqgoawa97bsDJw==
X-Google-Smtp-Source: ALg8bN41CVinuICeb02ZWQO42BBaPPILhSZY7fz9tt82jxIo6da0gpuWlRJ39SrdVbBINotWx8zlpA==
X-Received: by 2002:a17:902:c05:: with SMTP id 5mr38534757pls.155.1546282544662;
        Mon, 31 Dec 2018 10:55:44 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
        by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 10:55:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/6] clk: actions: Add configurable PLL delay
Date:   Tue,  1 Jan 2019 00:25:12 +0530
Message-Id: <20181231185517.18517-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S500 SoC requires configurable delay for different PLLs. Hence, add
a separate macro for declaring a PLL with configurable delay and also
modify the existing OWL_PLL_NO_PARENT macro to use default delay so
that no need to modify the existing S700/S900 drivers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-pll.c |  2 +-
 drivers/clk/actions/owl-pll.h | 30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
index 058e06d7099f..02437bdedf4d 100644
--- a/drivers/clk/actions/owl-pll.c
+++ b/drivers/clk/actions/owl-pll.c
@@ -179,7 +179,7 @@ static int owl_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	regmap_write(common->regmap, pll_hw->reg, reg);
 
-	udelay(PLL_STABILITY_WAIT_US);
+	udelay(pll_hw->delay);
 
 	return 0;
 }
diff --git a/drivers/clk/actions/owl-pll.h b/drivers/clk/actions/owl-pll.h
index 0aae30abd5dc..6fb0d45bb088 100644
--- a/drivers/clk/actions/owl-pll.h
+++ b/drivers/clk/actions/owl-pll.h
@@ -13,6 +13,8 @@
 
 #include "owl-common.h"
 
+#define OWL_PLL_DEF_DELAY	50
+
 /* last entry should have rate = 0 */
 struct clk_pll_table {
 	unsigned int		val;
@@ -27,6 +29,7 @@ struct owl_pll_hw {
 	u8			width;
 	u8			min_mul;
 	u8			max_mul;
+	u8			delay;
 	const struct clk_pll_table *table;
 };
 
@@ -36,7 +39,7 @@ struct owl_pll {
 };
 
 #define OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,			\
-		   _width, _min_mul, _max_mul, _table)			\
+		   _width, _min_mul, _max_mul, _delay, _table)		\
 	{								\
 		.reg		= _reg,					\
 		.bfreq		= _bfreq,				\
@@ -45,6 +48,7 @@ struct owl_pll {
 		.width		= _width,				\
 		.min_mul	= _min_mul,				\
 		.max_mul	= _max_mul,				\
+		.delay		= _delay,				\
 		.table		= _table,				\
 	}
 
@@ -52,8 +56,8 @@ struct owl_pll {
 		_shift, _width, _min_mul, _max_mul, _table, _flags)	\
 	struct owl_pll _struct = {					\
 		.pll_hw	= OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,	\
-				     _width, _min_mul,			\
-				     _max_mul, _table),			\
+				     _width, _min_mul, _max_mul,	\
+				     OWL_PLL_DEF_DELAY,	_table),	\
 		.common = {						\
 			.regmap = NULL,					\
 			.hw.init = CLK_HW_INIT(_name,			\
@@ -67,8 +71,23 @@ struct owl_pll {
 		_shift, _width, _min_mul, _max_mul, _table, _flags)	\
 	struct owl_pll _struct = {					\
 		.pll_hw	= OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,	\
-				     _width, _min_mul,			\
-				     _max_mul, _table),			\
+				     _width, _min_mul, _max_mul,	\
+				     OWL_PLL_DEF_DELAY,	_table),	\
+		.common = {						\
+			.regmap = NULL,					\
+			.hw.init = CLK_HW_INIT_NO_PARENT(_name,		\
+					       &owl_pll_ops,		\
+					       _flags),			\
+		},							\
+	}
+
+#define OWL_PLL_NO_PARENT_DELAY(_struct, _name, _reg, _bfreq, _bit_idx,	\
+		_shift, _width, _min_mul, _max_mul, _delay, _table,	\
+		_flags)							\
+	struct owl_pll _struct = {					\
+		.pll_hw	= OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,	\
+				     _width, _min_mul,  _max_mul,	\
+				     _delay, _table),			\
 		.common = {						\
 			.regmap = NULL,					\
 			.hw.init = CLK_HW_INIT_NO_PARENT(_name,		\
@@ -78,7 +97,6 @@ struct owl_pll {
 	}
 
 #define mul_mask(m)		((1 << ((m)->width)) - 1)
-#define PLL_STABILITY_WAIT_US	(50)
 
 static inline struct owl_pll *hw_to_owl_pll(const struct clk_hw *hw)
 {
-- 
2.17.1

