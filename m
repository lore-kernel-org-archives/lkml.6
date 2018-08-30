Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188BDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC0920838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jGQ2PLB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC0920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeH3Vj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:39:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44163 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeH3Vj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:39:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so4190728pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XcJSe78V8boHm9GZNkvLbiaAQhjcHuNbYLHww8/UvTE=;
        b=jGQ2PLB4Oc8wKUevs17KJyWm5G3B/BRnnkj4aO4WKsjdQ5RB3WcttL1DdPVb4bp1sV
         ystCCfTcIv5WpSjvww2pKr6a8xliJlY5uv4GFJJ9DirZ8o/ZtMXYucB0E1rg724woiJG
         LkCsK3K0PsGTkt+gDJyMxshn9K8m/yDtqc4KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XcJSe78V8boHm9GZNkvLbiaAQhjcHuNbYLHww8/UvTE=;
        b=EFbPgTubyjY7cZJkrS+cJEnBP+ZGPS4cIcDH1/D5haJa2Pfw7nhq3HY26cm5H/wO//
         xQW18NtTShPBSw9wSft0aAWs8zVzizbRGEgxfD2zPM33yXeevCSNPYBaUcAWB+hlNwWc
         bS2y77iurR8VHLrRsra04iOiMbonFxXTnG9Sp93aQd/w3m7ar5j/iwqox7boNPhDoCuh
         Jy2sMmuh5ccjtxT5s4TzaXssiwUG89jFWXolSAFOixZ/pYwxl8nFwDrDqd9PYGsxlaOH
         S39PPTU7kRy5KhmGJsS89MQZGCEzRKwk9wsRmHFdGgi/M8LKwTWTYDrKePG5Ku2Iek5z
         3tMw==
X-Gm-Message-State: APzg51CLM+a5Geah2NGkFvPb6N7nGwPUBJ7FL6H/hhQBs9vzCDAWJ/7V
        ZRogY3JEHeBTECdFu3DX+GaQNQ==
X-Google-Smtp-Source: ANB0VdaolXqgkTk1j74RaNJWVtlME5XEPQFbIgHO75nLBJ1dS8+qJUQPg6SrobJtPyTnOzR5ZumfjA==
X-Received: by 2002:a63:e647:: with SMTP id p7-v6mr10260017pgj.218.1535650575834;
        Thu, 30 Aug 2018 10:36:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id m15-v6sm11508335pfj.171.2018.08.30.10.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 10:36:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Taniya Das <tdas@codeaurora.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: qcom: Allocate space for NULL terimation in DFS table
Date:   Thu, 30 Aug 2018 10:34:37 -0700
Message-Id: <20180830173437.63601-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table allocated in clk_rcg2_dfs_populate_freq_table() is
eventually iterated over by qcom_find_freq() which assumes that the
table is NULL terminated.  Allocate one extra space in the array for
the NULL termination.  Initting of the NULL termination is implicit
due to kcalloc().

Fixes: cc4f6944d0e3 ("clk: qcom: Add support for RCG to register for DFS")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/qcom/clk-rcg2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index d5d77f9ad170..6e3bd195d012 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -993,7 +993,8 @@ static int clk_rcg2_dfs_populate_freq_table(struct clk_rcg2 *rcg)
 	struct freq_tbl *freq_tbl;
 	int i;
 
-	freq_tbl = kcalloc(MAX_PERF_LEVEL, sizeof(*freq_tbl), GFP_KERNEL);
+	/* Allocate space for 1 extra since table is NULL terminated */
+	freq_tbl = kcalloc(MAX_PERF_LEVEL + 1, sizeof(*freq_tbl), GFP_KERNEL);
 	if (!freq_tbl)
 		return -ENOMEM;
 	rcg->freq_tbl = freq_tbl;
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

