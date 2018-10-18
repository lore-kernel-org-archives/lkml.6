Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101CC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4392098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMUAu1bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4392098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeJSGHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:07:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44177 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeJSGHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:07:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so14806006pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GSyPvMvShkXKVRvkoHDAMGcjwACF+61OfuINflV+ipk=;
        b=mMUAu1buFvaPUVvQ0PWO9I/IaekUtXBnAQVo9MHqj/E1HjwLPl94fXOKcK4u8BaoFj
         dA2+h8rI+2cmWWUBpxOF6PwFS2yPm/ulH9qTNg4qogEbjtHlMbEdRtOioyua6/m4S+Qj
         XFdniRjHZNlEaaqHfaJG5FetUteVM5VhyBiog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GSyPvMvShkXKVRvkoHDAMGcjwACF+61OfuINflV+ipk=;
        b=AHPyoEV100hing0KshL2Whi/p3yFGlf+MHgqo9eg8Pm1Ys67UGPsWpkKDsgrpu0Ah6
         tJhbyQkZ7jlGNnuiE6TMBhUxRJgpo9ULnPQznJqR32V0OIRhIoOP2iT9KadTM/RKOXj+
         7mEi/zq5Hr2Pedg+dr3RDgVqzf/dkMc62ji7x3Wepw+HtodMscXKtQLx2usKIFlyDl+w
         LQeV/8PdHtG09hzPho56QBFXli8e/8cc+XsF+RkWbJQfqlLfHdu95p4odJ9IzuxTUwW7
         /R30jbEBeWByHUBAbTq1X/LCByhCRJN5MPyosp+xRmvhhYT0pjE4aNyeUXLaNEAFvZcp
         ThbA==
X-Gm-Message-State: ABuFfoi3M8MUef1WSlWzSpLw+F6DS1Wk1mLi8mEAtoPiPRHY4kBHVwXb
        3JjNFfT7vpZZw9U2wf8SVhBPXw==
X-Google-Smtp-Source: ACcGV61JZeZwh1THinN1ykTUSVdk3IBezZwNYGmr1593957Q0DHjq7zF88tiHxaB5THoAyj6wI1FKg==
X-Received: by 2002:a62:583:: with SMTP id 125-v6mr19730976pff.186.1539900240974;
        Thu, 18 Oct 2018 15:04:00 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id k71-v6sm31399727pge.44.2018.10.18.15.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:03:59 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH] clk: qcom: Remove unused arrays in SDM845 GCC
Date:   Thu, 18 Oct 2018 15:03:50 -0700
Message-Id: <20181018220350.220357-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change removes a parent map and parent name array that
appear to be completely unreferenced.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index fa1a196350f1..a7e72ebb79ba 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -99,22 +99,6 @@ static const char * const gcc_parent_names_4[] = {
 	"core_bi_pll_test_se",
 };
 
-static const struct parent_map gcc_parent_map_5[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_GPLL0_OUT_MAIN, 1 },
-	{ P_GPLL4_OUT_MAIN, 5 },
-	{ P_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
-};
-
-static const char * const gcc_parent_names_5[] = {
-	"bi_tcxo",
-	"gpll0",
-	"gpll4",
-	"gpll0_out_even",
-	"core_bi_pll_test_se",
-};
-
 static const struct parent_map gcc_parent_map_6[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
-- 
2.16.4

