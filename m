Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE04C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08719206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKxAaEoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08719206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeK2Fv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:51:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36584 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2Fv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:51:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so5346870plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIAgi7flrHP9j2TT5g7TAEqMEq30Wos3dnpqumwDaGE=;
        b=JKxAaEooIyUOB/Y3XRv1BG08e4wGkOC/d+4nNcoAr+hb3VSQVOnPUNB9r+9PpllcBC
         8QD1TauTfJKT2/KFNgBIxnPFJo4J0iDps7VPMgWKuvEGm8L9zHqabhiDGroxSw1rCf4g
         yXn2vjte2S+BCI/mqqTyJrRydkToN3xH6p/5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIAgi7flrHP9j2TT5g7TAEqMEq30Wos3dnpqumwDaGE=;
        b=qZjwfjj8VDgK6MWhEDYRFo9HjV0tdr2WdbrL+sPQC+vMdEhzFt7NAIEALUv+CavHYk
         pZ9S2TrMke9sjljJ9s2kc+i+TWw8/QnzEiURYdPmsA4QwllEFA0lE6JEGKDxMOv+DIV0
         1RmNZuoFrONva0MPgC/ylmcPbG28bKB6znc4tt9wwdYNyzt9NDMrb+Dz2MTgF5l4DoIw
         PbupThxNsQTF4dONQNmdidB1si8Rb4mNz4YaAJIE6xOp5oEDrTL++xJQHMpNbYMdNgks
         ppeGTf4SqFH8LOLNpGWX+tZIRCi6+vFv+zf+o7tyF5g2GTPCpUmZq49CRliLB0o70dWv
         zwwQ==
X-Gm-Message-State: AA+aEWZE6tnXVWlDf2uhVj/GooaWWHXRJGQ5TSQvjObu0z0c9k4UiOOK
        65ptPvKdDvBAH5iutOCLZQ35dw==
X-Google-Smtp-Source: AFSGD/W7+2XiOfvTSlUhMYGhXpyF34gCltsGx7JpW/O6tjP9R1+8cbeKvzXKBJMroopHUFpy2H56xA==
X-Received: by 2002:a17:902:76c2:: with SMTP id j2mr38620374plt.339.1543430962589;
        Wed, 28 Nov 2018 10:49:22 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id e86sm10765672pfb.6.2018.11.28.10.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:49:21 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: qcom: gpu_cc_gmu_clk_src has 5 parents, not 6
Date:   Wed, 28 Nov 2018 10:48:59 -0800
Message-Id: <20181128184859.70476-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an earlier version of commit 453361cdd757 ("clk: qcom: Add graphics
clock controller driver for SDM845") there were 6 listed parents for
"gpu_cc_gmu_clk_src".  In the version that landed there were 5.
...but "num_parents" was still left at 6.  On my system this goes boom
at bootup.

Fixes: 453361cdd757 ("clk: qcom: Add graphics clock controller driver for SDM845")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/qcom/gpucc-sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
index 80898cea259a..e40efba1bf7d 100644
--- a/drivers/clk/qcom/gpucc-sdm845.c
+++ b/drivers/clk/qcom/gpucc-sdm845.c
@@ -85,7 +85,7 @@ static struct clk_rcg2 gpu_cc_gmu_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpu_cc_gmu_clk_src",
 		.parent_names = gpu_cc_parent_names_0,
-		.num_parents = 6,
+		.num_parents = 5,
 		.ops = &clk_rcg2_shared_ops,
 	},
 };
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

