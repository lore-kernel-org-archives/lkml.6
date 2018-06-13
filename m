Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B25A0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5F2208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oFAUvhGV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HKjyjhDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5F2208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935173AbeFMKAy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:00:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934972AbeFMKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:00:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B16160792; Wed, 13 Jun 2018 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528884052;
        bh=ykgSTc/LRELZ7q3103HT5MbnBmMtBkOBUWjWgQAjRk8=;
        h=From:To:Cc:Subject:Date:From;
        b=oFAUvhGVQLUGQaqyMJ6D2qgperVeBLz5B2iEaV/OdcQ7bTpeKEGW1KUzudah47P37
         3t3/+OXKnQrmCN98mWmpJA/oRnNmCGigAllvOU2aOednstyrywDe7RE5BqiUqv5RC/
         zJLRIfV5VwY3iv+6KuBo/5+nSNO3i+zYIE2cWQfY=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69549600D0;
        Wed, 13 Jun 2018 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528884051;
        bh=ykgSTc/LRELZ7q3103HT5MbnBmMtBkOBUWjWgQAjRk8=;
        h=From:To:Cc:Subject:Date:From;
        b=HKjyjhDKWnltVgi75gQZoUzSQ1IY4tZIk+34FK3NY2BqJnGnAGkjKqRr5OvKVEc6/
         RgyRaoFZimQ52QQUiuoArLA1PXq7na99izfVoFN3mvCAStV4Oris6JJ3q9qCxgb7zg
         Hfe6M9Htqt1ZfnSc8iGQtGLaWNCso4NwL4Zlqhik=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69549600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: Move frequency table macro to common file
Date:   Wed, 13 Jun 2018 15:30:41 +0530
Message-Id: <1528884041-26366-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frequency table macro is used by multiple clock drivers, move frequency
table macro to common header file.

Change-Id: I78d76f04b6c335c05dd9325025be7db1e99cbeac
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h        | 2 ++
 drivers/clk/qcom/gcc-apq8084.c    | 2 --
 drivers/clk/qcom/gcc-ipq4019.c    | 2 --
 drivers/clk/qcom/gcc-ipq8074.c    | 2 --
 drivers/clk/qcom/gcc-msm8916.c    | 2 --
 drivers/clk/qcom/gcc-msm8974.c    | 2 --
 drivers/clk/qcom/gcc-msm8994.c    | 2 --
 drivers/clk/qcom/gcc-msm8996.c    | 2 --
 drivers/clk/qcom/gcc-msm8998.c    | 2 --
 drivers/clk/qcom/gcc-sdm845.c     | 2 --
 drivers/clk/qcom/mmcc-apq8084.c   | 2 --
 drivers/clk/qcom/mmcc-msm8974.c   | 2 --
 drivers/clk/qcom/mmcc-msm8996.c   | 2 --
 drivers/clk/qcom/videocc-sdm845.c | 2 --
 14 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index b209a2f..dbd5a9e 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -7,6 +7,8 @@
 #include <linux/clk-provider.h>
 #include "clk-regmap.h"
 
+#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
+
 struct freq_tbl {
 	unsigned long freq;
 	u8 src;
diff --git a/drivers/clk/qcom/gcc-apq8084.c b/drivers/clk/qcom/gcc-apq8084.c
index 486d961..9c99a71 100644
--- a/drivers/clk/qcom/gcc-apq8084.c
+++ b/drivers/clk/qcom/gcc-apq8084.c
@@ -106,8 +106,6 @@ enum {
 	"sleep_clk_src",
 };
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 static struct clk_pll gpll0 = {
 	.l_reg = 0x0004,
 	.m_reg = 0x0008,
diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
index 46cb256..8902ad4 100644
--- a/drivers/clk/qcom/gcc-ipq4019.c
+++ b/drivers/clk/qcom/gcc-ipq4019.c
@@ -179,8 +179,6 @@ struct clk_fepll {
 	"ddrpllapss",
 };
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 static const struct freq_tbl ftbl_gcc_audio_pwm_clk[] = {
 	F(48000000, P_XO, 1, 0, 0),
 	F(200000000, P_FEPLL200, 1, 0, 0),
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 0462f4a..505c626 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -32,8 +32,6 @@
 #include "clk-regmap-mux.h"
 #include "reset.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_XO,
 	P_GPLL0,
diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index d6c7f50..ac2b0aa 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -264,8 +264,6 @@ enum {
 	"sleep_clk",
 };
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 static struct clk_pll gpll0 = {
 	.l_reg = 0x21004,
 	.m_reg = 0x21008,
diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
index 348e30d..08e2900d 100644
--- a/drivers/clk/qcom/gcc-msm8974.c
+++ b/drivers/clk/qcom/gcc-msm8974.c
@@ -62,8 +62,6 @@ enum {
 	"gpll4_vote",
 };
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 static struct clk_pll gpll0 = {
 	.l_reg = 0x0004,
 	.m_reg = 0x0008,
diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 1e38efc..53f0f36 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -57,8 +57,6 @@ enum {
 	"gpll4",
 };
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 static struct clk_fixed_factor xo = {
 	.mult = 1,
 	.div = 1,
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 9f35b3f..9d3756c 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -32,8 +32,6 @@
 #include "reset.h"
 #include "gdsc.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_XO,
 	P_GPLL0,
diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 78d87f5..9f0ae40 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -25,8 +25,6 @@
 #include "reset.h"
 #include "gdsc.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_AUD_REF_CLK,
 	P_CORE_BI_PLL_TEST_SE,
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index e78e6f5..19b470f 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -25,8 +25,6 @@
 #include "gdsc.h"
 #include "reset.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_BI_TCXO,
 	P_AUD_REF_CLK,
diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index 30777f9..4ce1d7c 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -219,8 +219,6 @@ enum {
 	"sleep_clk_src",
 };
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 static struct clk_pll mmpll0 = {
 	.l_reg = 0x0004,
 	.m_reg = 0x0008,
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 715e7cd..9181851 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -184,8 +184,6 @@ enum {
 	"dsi1pllbyte",
 };
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 static struct clk_pll mmpll0 = {
 	.l_reg = 0x0004,
 	.m_reg = 0x0008,
diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index 1a25ee4..60f08b3 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -34,8 +34,6 @@
 #include "reset.h"
 #include "gdsc.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_XO,
 	P_MMPLL0,
diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
index 9073b7a..5d6a772 100644
--- a/drivers/clk/qcom/videocc-sdm845.c
+++ b/drivers/clk/qcom/videocc-sdm845.c
@@ -18,8 +18,6 @@
 #include "clk-pll.h"
 #include "gdsc.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_BI_TCXO,
 	P_CORE_BI_PLL_TEST_SE,
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

