Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D368C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A0920848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="esrzBH+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeLCSfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:35:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34249 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeLCSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:35:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so6115798pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bxN1Bkl0sGb272jZKTW/rlZvTSKF7fLwHr1tSNNpIkc=;
        b=esrzBH+TR03Yy7QOusnb+0P1SrHFpIi0TVavFVtlBPKbVlyFYq4iYN7Fsg4zEEbh5W
         uSpfrXJdJUU9O2Ls+iBGF8JMV8lfCZp0rg+Cp9Hd+QCeaL7yFeyKIu4Fb4Kd1NXbfab4
         3GhPc0Y+WLfD7Z0U/bUv7MtCcVghKhRbgSVvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bxN1Bkl0sGb272jZKTW/rlZvTSKF7fLwHr1tSNNpIkc=;
        b=Z6/ymRxDCqiMlt1JFYxA5sxxgBsQCFPJvkiYcwKEdZpqcHdZRNiV6Biz9sdCkix3PZ
         mAiNaqScK5JQxrlOyWNeyr5/Ia6IYE02CrSFIjNQwiMJ/QxQLJRxTlcy/E1tdKoDC8cW
         caCchHKjxlav6D5+He5rVPYrAaLC78Fxwx3nkLsEYZK/1A5t9ErHw6Z25e7sCt78JAXc
         LHMJD4PsBGZm1M+KWeflEQ+vWUxjk7TTVVgTIzfD0xwuMdogRjb360BlD9r7+t2KalZE
         Neho+Hb2hC3CDoy7MOk0cMhkqCgTlmC7CA3sDSApwsrluI9Am9gya0iVh9kmlHEx0Dze
         zRqQ==
X-Gm-Message-State: AA+aEWZ85f2D90kLk4kZnzJpBRLenLUBEbhQ8EJLEj3Nhd3iT2P6EmPE
        xYl56l6oPB4X/AaU5fCS7aCIWg==
X-Google-Smtp-Source: AFSGD/X0fR33u/afdE+r130QvsGiknKIxRH0fEK+aHC4oKOXL1r07JFLlffvvX3fHbPxnmD3a+rznQ==
X-Received: by 2002:a63:a91a:: with SMTP id u26mr13944081pge.349.1543862135802;
        Mon, 03 Dec 2018 10:35:35 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f6sm20180969pfg.188.2018.12.03.10.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:35:35 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 2/3] clk: qcom: gcc-msm8998: Disable halt check of UFS clocks
Date:   Mon,  3 Dec 2018 10:33:29 -0800
Message-Id: <20181203183330.2073-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181203183330.2073-1-bjorn.andersson@linaro.org>
References: <20181203183330.2073-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the halt check of the UFS symbol clocks, in accordance with other
platforms. This makes clk_disable_unused() happy and makes it possible
to turn the clocks on again without an error.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/clk/qcom/gcc-msm8998.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index aed7f1f92614..792b431f9945 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2375,7 +2375,7 @@ static struct clk_branch gcc_ufs_phy_aux_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 	.halt_reg = 0x75014,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75014,
 		.enable_mask = BIT(0),
@@ -2388,7 +2388,7 @@ static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 	.halt_reg = 0x7605c,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x7605c,
 		.enable_mask = BIT(0),
@@ -2401,7 +2401,7 @@ static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 
 static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
 	.halt_reg = 0x75010,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75010,
 		.enable_mask = BIT(0),
-- 
2.18.0

