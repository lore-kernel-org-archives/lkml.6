Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3D120989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ohJOYPqc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l032v9V/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbfA3Qf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:35:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfA3Qfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:35:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 833EC6098C; Wed, 30 Jan 2019 16:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866153;
        bh=2Tk+TrxJxJhMg7atMc26iWcwJP3M7XeGqGlTNfP4Jvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohJOYPqcZqseG+2bxPKiGHSnkgbCs+M8pGyMCqGWSwZ869GD2D+bxT+FY2caU0oYu
         3FStAZE22CgPrupgQeMf/uIrtLcKP+0nCS1V6tJZ/Z5lZe5vTY7hyWu0Rd6Nde++ce
         eTdmpccM/TybPBClOFzZZ0keSE39wuIVnvpcDJx4=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74C8B6098A;
        Wed, 30 Jan 2019 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866151;
        bh=2Tk+TrxJxJhMg7atMc26iWcwJP3M7XeGqGlTNfP4Jvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l032v9V/70AijNa5znImMNze5NGqOaoGFgbpFpmHXJqS6Ih7eHDmWx05M+8+Xzyut
         6Ua+oE6/9D1+J6hZxTbxfLWCsGbEO4MpuFCBDGh+OMn4KLGCJSYSlV2q5KTli6ihM4
         aIt+3U+wiyqPBbFzarz//miah5hGqgJyiU/BrAD0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74C8B6098A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1 1/4] clk: qcom: smd: Add XO clock for MSM8998
Date:   Wed, 30 Jan 2019 09:35:44 -0700
Message-Id: <1548866144-30265-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XO clock generally feeds into other clock controllers as the parent
for a lot of clock generators.

Fixes: 6131dc81211c (clk: qcom: smd: Add support for MSM8998 rpm clocks)
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 22dd42a..5b1d718 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -656,6 +656,8 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
 };
 
 /* msm8998 */
+DEFINE_CLK_SMD_RPM_BRANCH(msm8998, xo_clk_src, xo_a_clk_src,
+			  QCOM_SMD_RPM_MISC_CLK, 0, 19200000);
 DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
 DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 2);
 DEFINE_CLK_SMD_RPM(msm8998, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
@@ -678,6 +680,8 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
 DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6);
 static struct clk_smd_rpm *msm8998_clks[] = {
+	[RPM_SMD_XO_CLK_SRC] = &msm8998_xo_clk_src,
+	[RPM_SMD_XO_A_CLK_SRC] = &msm8998_xo_a_clk_src,
 	[RPM_SMD_SNOC_CLK] = &msm8998_snoc_clk,
 	[RPM_SMD_SNOC_A_CLK] = &msm8998_snoc_a_clk,
 	[RPM_SMD_CNOC_CLK] = &msm8998_cnoc_clk,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

