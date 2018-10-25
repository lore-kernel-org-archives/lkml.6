Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D51EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A9B20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLePvqOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A9B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeJYWxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbeJYWxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:10 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555342147A;
        Thu, 25 Oct 2018 14:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477212;
        bh=1n5SNyyr5qFt08kLKu2tpMLK0c62CjZoNp6440KVWyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLePvqOIfJmLQyuQStbxcYRnGBTm7aCKLOt+XdmRfiYfjjJ6kNKddEfxpmts/T6IS
         3SDasO61xBt9AniHIVzYxNS7lUADxm4B6sALcvI7omJiB6qCOI/leS6+1xgFnL+5C+
         9ShUbMeciy54QElImPIGQBvJ2JP4ftOY5aBQMRQE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Michael Turquette <mturquette@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 51/98] clk: rockchip: fix deadlock possibility in cpuclk
Date:   Thu, 25 Oct 2018 10:18:06 -0400
Message-Id: <20181025141853.214051-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stübner <heiko@sntech.de>

[ Upstream commit a5e1baf7dca10f8cf945394034013260297bc416 ]

Lockdep reported a possible deadlock between the cpuclk lock and for example
the i2c driver.

       CPU0                    CPU1
       ----                    ----
  lock(clk_lock);
                               local_irq_disable();
                               lock(&(&i2c->lock)->rlock);
                               lock(clk_lock);
  <Interrupt>
    lock(&(&i2c->lock)->rlock);

 *** DEADLOCK ***

The generic clock-types of the core ccf already use spin_lock_irqsave when
touching clock registers, so do the same for the cpuclk.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Michael Turquette <mturquette@linaro.org>
[mturquette@linaro.org: removed initialization of "flags"]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk-cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 75c8c45ef728..8539c4fd34cc 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -124,10 +124,11 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
 {
 	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
 	unsigned long alt_prate, alt_div;
+	unsigned long flags;
 
 	alt_prate = clk_get_rate(cpuclk->alt_parent);
 
-	spin_lock(cpuclk->lock);
+	spin_lock_irqsave(cpuclk->lock, flags);
 
 	/*
 	 * If the old parent clock speed is less than the clock speed
@@ -164,7 +165,7 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
 			cpuclk->reg_base + reg_data->core_reg);
 	}
 
-	spin_unlock(cpuclk->lock);
+	spin_unlock_irqrestore(cpuclk->lock, flags);
 	return 0;
 }
 
@@ -173,6 +174,7 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
 {
 	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
 	const struct rockchip_cpuclk_rate_table *rate;
+	unsigned long flags;
 
 	rate = rockchip_get_cpuclk_settings(cpuclk, ndata->new_rate);
 	if (!rate) {
@@ -181,7 +183,7 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
 		return -EINVAL;
 	}
 
-	spin_lock(cpuclk->lock);
+	spin_lock_irqsave(cpuclk->lock, flags);
 
 	if (ndata->old_rate < ndata->new_rate)
 		rockchip_cpuclk_set_dividers(cpuclk, rate);
@@ -201,7 +203,7 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
 	if (ndata->old_rate > ndata->new_rate)
 		rockchip_cpuclk_set_dividers(cpuclk, rate);
 
-	spin_unlock(cpuclk->lock);
+	spin_unlock_irqrestore(cpuclk->lock, flags);
 	return 0;
 }
 
-- 
2.17.1

