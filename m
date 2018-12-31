Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B09EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457A421720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270036;
	bh=zNQiVZu79ORBk6xjVlo+Uw9nZUqfx3OvWb5TvTpojfk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bi38/iWccsf8QEloFVMHWldMhr5bTF+rp+pNtzQWzkD4me+3IjSsvaVBGGGIbKzJp
	 9YPp0h+yqXdNmG6+yl2LIuHwG1y194s1nLbgGuDdaHdANvq0aoRgnS3AekYgBRnydP
	 7/JA2L6oUBLttoWQhxljry6oQV1J/3G7RrER3UoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeLaP1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeLaP1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:27:14 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB362133F;
        Mon, 31 Dec 2018 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270034;
        bh=zNQiVZu79ORBk6xjVlo+Uw9nZUqfx3OvWb5TvTpojfk=;
        h=From:To:Cc:Subject:Date:From;
        b=tD/r0CzxkKCiIRgWuckxnH++kj3rtbuT3cpANJdpKmEIuZqjM+pEx59vUXEzNQabI
         Svtf+Y/fhxAZapLaVWPRfNgHiIDJisS23rIMpUhGctBNr8sGQHgh+0CbfomadsuQiy
         xqLPvtWaygKIKxzrNYei8HsjZ1Etk2nxQlg9bPMc=
From:   guoren@kernel.org
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 06/14] clocksource/drivers/c-sky: fixup qemu fail to bootup sometimes.
Date:   Mon, 31 Dec 2018 23:27:03 +0800
Message-Id: <1546270024-3961-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Timer startup must after timer_irq_enable. For qemu, timer tick
irq hanppens but irq not enable, so it will cause qemu boot failed.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Tested-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
---
 drivers/clocksource/timer-mp-csky.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-mp-csky.c b/drivers/clocksource/timer-mp-csky.c
index a8acc43..3cb6dbc 100644
--- a/drivers/clocksource/timer-mp-csky.c
+++ b/drivers/clocksource/timer-mp-csky.c
@@ -79,11 +79,11 @@ static int csky_mptimer_starting_cpu(unsigned int cpu)
 
 	to->clkevt.cpumask = cpumask_of(cpu);
 
+	enable_percpu_irq(csky_mptimer_irq, 0);
+
 	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
 					2, ULONG_MAX);
 
-	enable_percpu_irq(csky_mptimer_irq, 0);
-
 	return 0;
 }
 
-- 
2.7.4

