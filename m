Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97989C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6028F2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmuqzQzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6028F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeJQBGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQBG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40CD620866;
        Tue, 16 Oct 2018 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710106;
        bh=tCA8M4VFrVa7w5HZMTBTiGi9oNpHvyOsMT6AJuSa8Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmuqzQzJ/hZBPCmvIfDRr1NHH96SDxQUeI2XsXQqAqmHJwU9RQhMvjjBhp4dOQCfM
         CY622kk13ORpqFPBfrUmcB4x4zIYJHQLJebqfhj0emNhuxVqoII3xhLwVmN05g94nU
         jbv+SEW2jKbU8uRWbtMxmi7K2aw3vNUOw6A9c4H8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 103/135] clk: x86: Stop marking clocks as CLK_IS_CRITICAL
Date:   Tue, 16 Oct 2018 19:05:33 +0200
Message-Id: <20181016170522.446062934@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/x86/clk-pmc-atom.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -187,13 +187,6 @@ static struct clk_plt *plt_clk_register(
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


