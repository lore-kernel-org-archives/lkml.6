Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2849C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7248220651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956392;
	bh=lLhzsMl61+adZZj9ZpyxxBI0h6ks0VVJ7o5u2S9EXzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LiYpgw+QvSn+KRcjAcKmbzGhrXKowOXt8as/6H4anMM1hPay8rH3Jgd6zZUPaaaF9
	 H3Gt0gL8MizeBulGCs2ZYnxdxjxd8rjPRXRauU2OXf8IsY0/cL2MJBcUBpFhZR7M75
	 u2tYjBFSNr8oKzFE0vaQS9JXLYe5pMI9ZGTUrOnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfBWVNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbfBWVLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3181820855;
        Sat, 23 Feb 2019 21:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956306;
        bh=lLhzsMl61+adZZj9ZpyxxBI0h6ks0VVJ7o5u2S9EXzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4PSNQwTK5zlWg+COzKkIvC63eIsJAVJNNDdMh86DWfWUr3tCKRl2HVdQ/JK9HT93
         8O2JnvUAcMlOygm393udkrwVwYvW7s6Wz6dv/7WpDgUWIbJ9lIK7eC9eeySwaoNVjm
         C6WYnuNfslSaQHzG5eyMao1rRWi/UVCr+hfXnD5o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 3.18 06/18] xtensa: SMP: fix secondary CPU initialization
Date:   Sat, 23 Feb 2019 16:11:23 -0500
Message-Id: <20190223211135.203082-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211135.203082-1-sashal@kernel.org>
References: <20190223211135.203082-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 32a7726c4f4aadfabdb82440d84f88a5a2c8fe13 ]

- add missing memory barriers to the secondary CPU synchronization spin
  loops; add comment to the matching memory barrier in the boot_secondary
  and __cpu_die functions;
- use READ_ONCE/WRITE_ONCE to access cpu_start_id/cpu_start_ccount
  instead of reading/writing them directly;
- re-initialize cpu_running every time before starting secondary CPU to
  flush possible previous CPU startup results.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/head.S |  5 ++++-
 arch/xtensa/kernel/smp.c  | 34 +++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/xtensa/kernel/head.S b/arch/xtensa/kernel/head.S
index 64140998e1173..16bdb414784ad 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -281,12 +281,13 @@ should_never_return:
 
 	movi	a2, cpu_start_ccount
 1:
+	memw
 	l32i	a3, a2, 0
 	beqi	a3, 0, 1b
 	movi	a3, 0
 	s32i	a3, a2, 0
-	memw
 1:
+	memw
 	l32i	a3, a2, 0
 	beqi	a3, 0, 1b
 	wsr	a3, ccount
@@ -323,11 +324,13 @@ ENTRY(cpu_restart)
 	rsr	a0, prid
 	neg	a2, a0
 	movi	a3, cpu_start_id
+	memw
 	s32i	a2, a3, 0
 #if XCHAL_DCACHE_IS_WRITEBACK
 	dhwbi	a3, 0
 #endif
 1:
+	memw
 	l32i	a2, a3, 0
 	dhi	a3, 0
 	bne	a2, a0, 1b
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 4d02e38514f54..545144d1431d5 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -192,9 +192,11 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
 	int i;
 
 #ifdef CONFIG_HOTPLUG_CPU
-	cpu_start_id = cpu;
-	system_flush_invalidate_dcache_range(
-			(unsigned long)&cpu_start_id, sizeof(cpu_start_id));
+	WRITE_ONCE(cpu_start_id, cpu);
+	/* Pairs with the third memw in the cpu_restart */
+	mb();
+	system_flush_invalidate_dcache_range((unsigned long)&cpu_start_id,
+					     sizeof(cpu_start_id));
 #endif
 	smp_call_function_single(0, mx_cpu_start, (void *)cpu, 1);
 
@@ -203,18 +205,21 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
 			ccount = get_ccount();
 		while (!ccount);
 
-		cpu_start_ccount = ccount;
+		WRITE_ONCE(cpu_start_ccount, ccount);
 
-		while (time_before(jiffies, timeout)) {
+		do {
+			/*
+			 * Pairs with the first two memws in the
+			 * .Lboot_secondary.
+			 */
 			mb();
-			if (!cpu_start_ccount)
-				break;
-		}
+			ccount = READ_ONCE(cpu_start_ccount);
+		} while (ccount && time_before(jiffies, timeout));
 
-		if (cpu_start_ccount) {
+		if (ccount) {
 			smp_call_function_single(0, mx_cpu_stop,
-					(void *)cpu, 1);
-			cpu_start_ccount = 0;
+						 (void *)cpu, 1);
+			WRITE_ONCE(cpu_start_ccount, 0);
 			return -EIO;
 		}
 	}
@@ -234,6 +239,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	pr_debug("%s: Calling wakeup_secondary(cpu:%d, idle:%p, sp: %08lx)\n",
 			__func__, cpu, idle, start_info.stack);
 
+	init_completion(&cpu_running);
 	ret = boot_secondary(cpu, idle);
 	if (ret == 0) {
 		wait_for_completion_timeout(&cpu_running,
@@ -295,8 +301,10 @@ void __cpu_die(unsigned int cpu)
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	while (time_before(jiffies, timeout)) {
 		system_invalidate_dcache_range((unsigned long)&cpu_start_id,
-				sizeof(cpu_start_id));
-		if (cpu_start_id == -cpu) {
+					       sizeof(cpu_start_id));
+		/* Pairs with the second memw in the cpu_restart */
+		mb();
+		if (READ_ONCE(cpu_start_id) == -cpu) {
 			platform_cpu_kill(cpu);
 			return;
 		}
-- 
2.19.1

