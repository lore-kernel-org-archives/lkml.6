Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D95C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A682147D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2Cxd1+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A682147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeK3SD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:03:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47022 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeK3SD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:03:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so2070351pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZvfeZHAnMUYvaTlclKUDRPDClRnA84dF7+NxVt5aH0=;
        b=F2Cxd1+/NgU9DvQMYjySSP3ukJj+V6MQPz7ppeA7g8INTA1Z8RczvMqTY7xGahlzhL
         0Ve8Xvd3kf0j4jBFkkq+YkA3X2c31GJhDo3a86+qBqgTYul9O0oO+HvjHuOTuhliXDuk
         C8T2Akw3Sb6yOuIQZekJZem8kVcyEe6A0wT1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZvfeZHAnMUYvaTlclKUDRPDClRnA84dF7+NxVt5aH0=;
        b=dRSxhi9jIPn6Wq15eN2Qa6reDz2qNJ51TqADb/Fuxs4BIyGLw6+qG3pkPfFydQ6GkC
         6SoKaFim+mUfLchw6yE/MUt/Dan82soh3ekpQaZa9tAI/DMVnkbrY/vpCwrAaNvuLCst
         V/yHXa2Zboq/ipJBpPOouJ0w0rUJdJdVa8wpfSMohFMPnp1uNEly1pP2iiPRcEacB2+d
         JfkF5f4k6xVqDxp4lkZ6YlWDLYzYTpd7QpHSpfnhZNYKzHmbM4kcoIJe0z4pl3UCx3kB
         nyGMvXMsuxuBa6uLZ92uOzsZL4r5zsUMpCd3/DIi91L7pONeD1MDdonRaYTi8wYgrklK
         dObA==
X-Gm-Message-State: AA+aEWbrx5NHsf/nqc+AQOMT7zig9tC+w8v/NAKe1RBo0mySilxQaV66
        fVG4BHcId3/Vzw10X6/JpvG1FQ==
X-Google-Smtp-Source: AFSGD/Xgx74Aw0UFM8t+YqW061gK6uzM2pSDbDmzZYKAHqX13ixJ4GcP6hR6HNqr50YqJ+wNdvD5Zg==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr3937210pgi.301.1543560911037;
        Thu, 29 Nov 2018 22:55:11 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w128sm5859175pfw.79.2018.11.29.22.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 22:55:10 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 2/3] clk: qcom: gcc-msm8998: Disable halt check of UFS clocks
Date:   Thu, 29 Nov 2018 22:52:58 -0800
Message-Id: <20181130065259.26497-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181130065259.26497-1-bjorn.andersson@linaro.org>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the halt check of the UFS symbol clocks, in accordance with other
platforms. This makes clk_disable_unused() happy and makes it possible
to turn the clocks on again without an error.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index d89f8e7c2a59..3d232d266d72 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2403,7 +2403,7 @@ static struct clk_branch gcc_ufs_phy_aux_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 	.halt_reg = 0x75014,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75014,
 		.enable_mask = BIT(0),
@@ -2416,7 +2416,7 @@ static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 	.halt_reg = 0x7605c,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x7605c,
 		.enable_mask = BIT(0),
@@ -2429,7 +2429,7 @@ static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 
 static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
 	.halt_reg = 0x75010,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75010,
 		.enable_mask = BIT(0),
-- 
2.18.0

