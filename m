Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7FCC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3D7208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yL4QZp6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3D7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbeJEXV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbeJEXQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01AF92147D;
        Fri,  5 Oct 2018 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756213;
        bh=7ZS3HJZU5XfQ9cHV7f2wbzNhxJUXuhU07SVCjw9e3u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yL4QZp6cjByShrdpqY/E8gSQ3J7qtuUInfLaWxUS+R9e80YZEt3MNA2T2cv5pNH+X
         BI1iuhHMnkueQHsronjCK29y5vu42gMj9vqN/QDbiU9E/V/QTGBVrLg2QwzgF3gbRQ
         lTvjikF1abT92r8iImUqntIgZ+RbzHhapTzwCPHc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/23] clk: x86: Stop marking clocks as CLK_IS_CRITICAL
Date:   Fri,  5 Oct 2018 12:16:31 -0400
Message-Id: <20181005161634.20631-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161634.20631-1-sashal@kernel.org>
References: <20181005161634.20631-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f ]

Commit d31fd43c0f9a ("clk: x86: Do not gate clocks enabled by the
firmware"), which added the code to mark clocks as CLK_IS_CRITICAL, causes
all unclaimed PMC clocks on Cherry Trail devices to be on all the time,
resulting on the device not being able to reach S0i3 when suspended.

The reason for this commit is that on some Bay Trail / Cherry Trail devices
the r8169 ethernet controller uses pmc_plt_clk_4. Now that the clk-pmc-atom
driver exports an "ether_clk" alias for pmc_plt_clk_4 and the r8169 driver
has been modified to get and enable this clock (if present) the marking of
the clocks as CLK_IS_CRITICAL is no longer necessary.

This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
devices not being able to reach S0i3 greatly decreasing their battery
drain when suspended.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=193891#c102
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=196861
Cc: Johannes Stezenbach <js@sig21.net>
Cc: Carlo Caione <carlo@endlessm.com>
Reported-by: Johannes Stezenbach <js@sig21.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/x86/clk-pmc-atom.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
index 75151901ff7d..d977193842df 100644
--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -187,13 +187,6 @@ static struct clk_plt *plt_clk_register(struct platform_device *pdev, int id,
 	pclk->reg = base + PMC_CLK_CTL_OFFSET + id * PMC_CLK_CTL_SIZE;
 	spin_lock_init(&pclk->lock);
 
-	/*
-	 * If the clock was already enabled by the firmware mark it as critical
-	 * to avoid it being gated by the clock framework if no driver owns it.
-	 */
-	if (plt_clk_is_enabled(&pclk->hw))
-		init.flags |= CLK_IS_CRITICAL;
-
 	ret = devm_clk_hw_register(&pdev->dev, &pclk->hw);
 	if (ret) {
 		pclk = ERR_PTR(ret);
-- 
2.17.1

