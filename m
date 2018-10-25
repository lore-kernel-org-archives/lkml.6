Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D918CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993B720870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/6XjPm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993B720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeJYWxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbeJYWxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:31 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01BC32086D;
        Thu, 25 Oct 2018 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477233;
        bh=soP5hmq3U1fCx5SO3r/oZZHGL0haFi1J/pd8rtJys6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/6XjPm5fF0xDnWWKJbKE7unv5qrzRFd6Ju0KEyKaH6x5vGhma57vVECG5mDJ2Yus
         pDBz2q50dVQMU2ry6VvkYuOQQNaxlQx3jZiRKRU/NGSTp26xoFs/EGqTJKSxEtgwOG
         ouu/s5zzE91HLcixRixyBD+IGiZGp3+ds6FzoEhg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jisheng Zhang <jszhang@marvell.com>, len.brown@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 65/98] x86/idle: Restore trace_cpu_idle to mwait_idle() calls
Date:   Thu, 25 Oct 2018 10:18:20 -0400
Message-Id: <20181025141853.214051-65-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@marvell.com>

[ Upstream commit e43d0189ac02415fe4487f79fc35e8f147e9ea0d ]

Commit b253149b843f ("sched/idle/x86: Restore mwait_idle() to fix boot
hangs, to improve power savings and to improve performance") restores
mwait_idle(), but the trace_cpu_idle related calls are missing. This
causes powertop on my old desktop powered by Intel Core2 E6550 to
report zero wakeups and zero events.

Add them back to restore the proper behaviour.

Fixes: b253149b843f ("sched/idle/x86: Restore mwait_idle() to ...")
Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Cc: <len.brown@intel.com>
Cc: stable@vger.kernel.org # 4.1
Link: http://lkml.kernel.org/r/1440046479-4262-1-git-send-email-jszhang@marvell.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index a388bb883128..54499d34cf55 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -430,6 +430,7 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 static void mwait_idle(void)
 {
 	if (!current_set_polling_and_test()) {
+		trace_cpu_idle_rcuidle(1, smp_processor_id());
 		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
 			smp_mb(); /* quirk */
 			clflush((void *)&current_thread_info()->flags);
@@ -441,6 +442,7 @@ static void mwait_idle(void)
 			__sti_mwait(0, 0);
 		else
 			local_irq_enable();
+		trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	} else {
 		local_irq_enable();
 	}
-- 
2.17.1

