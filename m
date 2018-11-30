Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C61AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6242E21473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcFTj9ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6242E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeK3SD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:03:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36878 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeK3SD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:03:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so2332757plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1lXBBwv4NN4mvT7Dldl1R3q9BjiaWJWe4/PYWu6QmEk=;
        b=XcFTj9hapUZivbByBp+FD7jxmeWfRUAMp/ToZLCmLbXsJPLjUwyfDdfyJlmCoCIGe7
         jCHgNGeDW1IJCIRBcBeNFML0CuT565zOIFrYFkElH3VvZfzbsgTx8d2ySyqwLjDeENXv
         +Dmkg2sCRQu9dKaPbRxjMy+rrvktsYAX/uHTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1lXBBwv4NN4mvT7Dldl1R3q9BjiaWJWe4/PYWu6QmEk=;
        b=LSnQhFMmr7APFg3kMkHm2yMSM1z4c0ZZzx/KBNAxapXLFq973U6KyPsdG9ODbBt1Ry
         FgTC3iDU2zCv5xRfto2a5JokbiKeErvWlOlI2ysCZdYTYh2dq3sBqaOBK9cS+9th8QBe
         qVbpwUE8jNWI/m3+sKbCB7D1oottdnss+TAM6zxUsFBDTu/IyM/NA4q0CFjBmnDb0Zv9
         emoSSEGAGLDAZ73cHz1DYsazdOT7UpLl0Yku5VJQZbZnlEYy6adOYsVQLvovogwEaIkE
         RPmKP9uAZe7S+gA3U/D3SuoRX6NKMqgxICnm3qSoQbJ3m26gCF2g00fdZv+iZ0tb7Hkt
         jPvA==
X-Gm-Message-State: AA+aEWbxUzZvQhOhsspqmerHPCjYTJduoyNdJJ6TcOgONgtC9+OF/jDR
        ketimwA20wU4ww5MQ5XuJWSqzw==
X-Google-Smtp-Source: AFSGD/V6yf51aBNRvFwAD3eXu8Hi4sjLSQbmwk3E6S9VakVMCjoah/o77ItVlMgQwQYNtaagQy9e+Q==
X-Received: by 2002:a17:902:e18c:: with SMTP id cd12mr4270754plb.279.1543560909910;
        Thu, 29 Nov 2018 22:55:09 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w128sm5859175pfw.79.2018.11.29.22.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 22:55:09 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 1/3] clk: qcom: gcc-msm8998: Mark hmss_dvm and lpass_at critical
Date:   Thu, 29 Nov 2018 22:52:57 -0800
Message-Id: <20181130065259.26497-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181130065259.26497-1-bjorn.andersson@linaro.org>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the two clocks enabled, so that the platform passes
clk_disable_unused().

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 9f0ae403d5f5..d89f8e7c2a59 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -1972,6 +1972,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_hmss_dvm_bus_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2015,6 +2016,7 @@ static struct clk_branch gcc_lpass_at_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_lpass_at_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
2.18.0

