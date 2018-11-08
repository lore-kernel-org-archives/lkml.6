Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA1FECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FED21019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck8+O/DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FED21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeKIHdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbeKIHdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:43 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09EB921479;
        Thu,  8 Nov 2018 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714175;
        bh=jeSS1fh388oTuNBSX4IRZnmetc6p+5YOgSMUnQo90bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ck8+O/DSORx4LLXVRiqoAplF54WJwL0I/HpYFnd/cYDzo902Ym/GtzctC+a5WfZEL
         WRFDzBRPFHw7+GPZMCRY152gy2agEVusPMJwEUclAlM9mAEBtQoKhUjCPdNzyqzdyP
         Ih+yYsnZCE1SvJkwHGLqnNdsrJbSsGdmyconjSxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 080/144] clk: rockchip: fix deadlock possibility in cpuclk
Date:   Thu,  8 Nov 2018 13:50:51 -0800
Message-Id: <20181108215101.127234986@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



