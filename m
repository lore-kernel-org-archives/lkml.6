Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8127C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77BC21B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901670;
	bh=qscIGtc1GttMLfFy3nMbx3N93isr3sYtQJR8C9roDCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ck0lkiWxIT6tcbSbNLy+4kXCKd+SYh5cHWVe170+UfcCCVtBY6mZtpD7sj5KeM75P
	 u8WcFiEcPAbA85XRfeHTw8FP9SYC6tohQNhZc8OOrSajOAp5VUM647FAunCV/gTPYp
	 QTmRCca7/1DBDm9pNlBby0K6tqocuJyiGtw0zU68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfBKQO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbfBKOVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A976E222B5;
        Mon, 11 Feb 2019 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894890;
        bh=qscIGtc1GttMLfFy3nMbx3N93isr3sYtQJR8C9roDCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmNAJK0hOV1pHtLhT9t1EkulbwvofKrBTP51RMHyRpUGmnFU4/iClErL/62Ojcftm
         kvrgJNsDO0Ye+HWDfzL8+t0LSvY8kke6lQCUgm2anXdyEsbRXNAoZ19njnYCtj/k1c
         nocvlp5dSVn9m1Z89yyLZqXYChXjKvn+g+B2YgsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 023/352] clk: boston: fix possible memory leak in clk_boston_setup()
Date:   Mon, 11 Feb 2019 15:14:10 +0100
Message-Id: <20190211141847.827562703@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 46fda5b5067a391912cf73bf3d32c26b6a22ad09 ]

Smatch report warnings:
drivers/clk/imgtec/clk-boston.c:76 clk_boston_setup() warn: possible memory leak of 'onecell'
drivers/clk/imgtec/clk-boston.c:83 clk_boston_setup() warn: possible memory leak of 'onecell'
drivers/clk/imgtec/clk-boston.c:90 clk_boston_setup() warn: possible memory leak of 'onecell'

'onecell' is malloced in clk_boston_setup(), but not be freed
before leaving from the error handling cases.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imgtec/clk-boston.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
index 15af423cc0c9..f5d54a64d33c 100644
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
2.19.1



