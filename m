Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74869ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B7214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj5ksQx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7B7214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbeJYWxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbeJYWxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:49 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38B42086D;
        Thu, 25 Oct 2018 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477251;
        bh=cbSHfCGldFQfgA6G4YXr5JHdOoC7UICgr8ILQAwk9C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mj5ksQx7R8mS/OUUGpqMTZSg7Lyw5sqYa0pUMRIBTPo3xnM0WFCqMAWD7slkjC4cl
         5H7RwJ02CA2fkOm//zLO1Ud4LURpAL0n3vU2DaZfUgGponMeUh6CDzPfc9uj7Y+l75
         nYu46Rb7oB+CAzmbGBvvH5IUixrAcmLlDBrsDdsk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-samsung-soc@vger.kernel.org, cw00.choi@samsung.com,
        daniel.lezcano@linaro.org, javier@osg.samsung.com,
        kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 77/98] clocksource/exynos_mct: Clear interrupt when cpu is shut down
Date:   Thu, 25 Oct 2018 10:18:32 -0400
Message-Id: <20181025141853.214051-77-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonyoung Shim <jy0922.shim@samsung.com>

[ Upstream commit bc7c36eedb0c7004aa06c2afc3c5385adada8fa3 ]

When a CPU goes offline a potentially pending timer interrupt is not
cleared. When the CPU comes online again then the pending interrupt is
delivered before the per cpu clockevent device is initialized. As a
consequence the tick interrupt handler dereferences a NULL pointer.

[   51.251378] Unable to handle kernel NULL pointer dereference at virtual address 00000040
[   51.289348] task: ee942d00 task.stack: ee960000
[   51.293861] PC is at tick_periodic+0x38/0xb0
[   51.298102] LR is at tick_handle_periodic+0x1c/0x90

Clear the pending interrupt in the cpu dying path.

Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Cc: cw00.choi@samsung.com
Cc: daniel.lezcano@linaro.org
Cc: stable@vger.kernel.org
Cc: javier@osg.samsung.com
Cc: kgene@kernel.org
Cc: krzk@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1484628876-22065-1-git-send-email-jy0922.shim@samsung.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index c844616028d2..714f9a767b17 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -487,6 +487,7 @@ static void exynos4_local_timer_stop(struct clock_event_device *evt)
 	if (mct_int_type == MCT_INT_SPI) {
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);
+		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
 	} else {
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 	}
-- 
2.17.1

