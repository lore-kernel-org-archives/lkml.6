Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D685C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F3A20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0TgYZxVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F3A20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeKIIT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728952AbeKIHdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:39 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AF2921019;
        Thu,  8 Nov 2018 21:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714171;
        bh=4ydZzn2d/FUpijWjbzl9GPUV72FYUWxOGZWcUTpPawQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0TgYZxVp7a4Yy9bvJojqHk99suG0X4b/8NZy71riy8Cw076bEEf/UyEvUUhNk38WD
         6prEYBhEof27b3v34AiLMz02auJGAOXp7VFJhNxrVkr0iHiEE5muIX2E5vqn4psXwJ
         hLt5dBPAcl5izpIDq6x7ayqmqCqvwT3XqdXYQaG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>,
        len.brown@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 094/144] x86/idle: Restore trace_cpu_idle to mwait_idle() calls
Date:   Thu,  8 Nov 2018 13:51:05 -0800
Message-Id: <20181108215104.216320008@linuxfoundation.org>
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



