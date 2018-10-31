Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30EAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC49C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC49C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJaQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:37:26 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:58492 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeJaQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:37:26 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 007A5BFE1B26685DCA5D;
        Wed, 31 Oct 2018 15:39:53 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9V7dlrR015819;
        Wed, 31 Oct 2018 15:39:47 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018103115400974-7800103 ;
          Wed, 31 Oct 2018 15:40:09 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     paul.burton@mips.com, sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
Subject: [PATCH v3 1/2] clk: boston: fix possible memory leak in clk_boston_setup()
Date:   Wed, 31 Oct 2018 15:41:41 +0800
Message-Id: <1540971702-3133-2-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540971702-3133-1-git-send-email-wang.yi59@zte.com.cn>
References: <1540971702-3133-1-git-send-email-wang.yi59@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-31 15:40:09,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-31 15:39:39,
        Serialize complete at 2018-10-31 15:39:39
X-MAIL: mse01.zte.com.cn w9V7dlrR015819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch report warnings:
drivers/clk/imgtec/clk-boston.c:76 clk_boston_setup() warn: possible memory leak of 'onecell'
drivers/clk/imgtec/clk-boston.c:83 clk_boston_setup() warn: possible memory leak of 'onecell'
drivers/clk/imgtec/clk-boston.c:90 clk_boston_setup() warn: possible memory leak of 'onecell'

'onecell' is malloced in clk_boston_setup(), but not be freed
before leaving from the error handling cases.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/clk/imgtec/clk-boston.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
index 15af423..f5d54a6 100644
--- a/drivers/clk/imgtec/clk-boston.c
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -73,27 +73,32 @@ static void __init clk_boston_setup(struct device_node *np)
 	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_INPUT] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_SYS] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_CPU] = hw;
 
 	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
 	if (err)
 		pr_err("failed to add DT provider: %d\n", err);
+
+	return;
+
+error:
+	kfree(onecell);
 }
 
 /*
-- 
1.8.3.1

