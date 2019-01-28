Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA14C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C15820855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696428;
	bh=rA3BSpmdBaghDtwFln+RvjM8tmQS+Y238CqwlyoaXBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hFEpxkPKVXmzBFikB3acHW/Y43KOmdR9vr0F+80+ICn/ye9gBT+VRhwLKPHnRoCMB
	 +yDnpV4uG/5qFB3zfy4raY9ifvPbnMK9LsZOS4S5BRFSrpuFqd2JDfEg54jFGBs92q
	 IGMKsN1IgaXOwZeEH0KyxwIdF3BZPNyQLg6aq0Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfA1R1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:27:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbfA1QAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2215A21852;
        Mon, 28 Jan 2019 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691222;
        bh=rA3BSpmdBaghDtwFln+RvjM8tmQS+Y238CqwlyoaXBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFxv8uEJtvhNp3RwXMDB1YJnFb+2mDJXEPAKHt3Ewxkym440kDnOu3CmXN1W2hFyH
         jiYXQwZ2N2W1kLmUirE7DojMfnADUhzGq2mYPEmFM0aC5tbCwrLoMRtzht3GzmeKcv
         4b56MfVh5B/j/Twc0fHV5A1MRG4+cLfLGDfkRVdc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yi Wang <wang.yi59@zte.com.cn>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 020/258] clk: boston: fix possible memory leak in clk_boston_setup()
Date:   Mon, 28 Jan 2019 10:55:26 -0500
Message-Id: <20190128155924.51521-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Wang <wang.yi59@zte.com.cn>

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

