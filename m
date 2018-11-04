Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CA3C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9125A2082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9125A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeKDJOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:14:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKDJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:14:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA4011xM3847248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Nov 2018 17:01:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA40111D3847244;
        Sat, 3 Nov 2018 17:01:01 -0700
Date:   Sat, 3 Nov 2018 17:01:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-40fa3780bac2b654edf23f6b13f4e2dd550aea10@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        peterz@infradead.org, valentin.schneider@arm.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          valentin.schneider@arm.com, sudeep.holla@arm.com,
          peterz@infradead.org
In-Reply-To: <1540301851-3048-1-git-send-email-valentin.schneider@arm.com>
References: <1540301851-3048-1-git-send-email-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/core: Take the hotplug lock in
 sched_init_smp()
Git-Commit-ID: 40fa3780bac2b654edf23f6b13f4e2dd550aea10
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  40fa3780bac2b654edf23f6b13f4e2dd550aea10
Gitweb:     https://git.kernel.org/tip/40fa3780bac2b654edf23f6b13f4e2dd550aea10
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Tue, 23 Oct 2018 14:37:31 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 4 Nov 2018 00:57:44 +0100

sched/core: Take the hotplug lock in sched_init_smp()

When running on linux-next (8c60c36d0b8c ("Add linux-next specific files
for 20181019")) + CONFIG_PROVE_LOCKING=y on a big.LITTLE system (e.g.
Juno or HiKey960), we get the following report:

 [    0.748225] Call trace:
 [    0.750685]  lockdep_assert_cpus_held+0x30/0x40
 [    0.755236]  static_key_enable_cpuslocked+0x20/0xc8
 [    0.760137]  build_sched_domains+0x1034/0x1108
 [    0.764601]  sched_init_domains+0x68/0x90
 [    0.768628]  sched_init_smp+0x30/0x80
 [    0.772309]  kernel_init_freeable+0x278/0x51c
 [    0.776685]  kernel_init+0x10/0x108
 [    0.780190]  ret_from_fork+0x10/0x18

The static_key in question is 'sched_asym_cpucapacity' introduced by
commit:

  df054e8445a4 ("sched/topology: Add static_key for asymmetric CPU capacity optimizations")

In this particular case, we enable it because smp_prepare_cpus() will
end up fetching the capacity-dmips-mhz entry from the devicetree,
so we already have some asymmetry detected when entering sched_init_smp().

This didn't get detected in tip/sched/core because we were missing:

  commit cb538267ea1e ("jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations")

Calls to build_sched_domains() post sched_init_smp() will hold the
hotplug lock, it just so happens that this very first call is a
special case. As stated by a comment in sched_init_smp(), "There's no
userspace yet to cause hotplug operations" so this is a harmless
warning.

However, to both respect the semantics of underlying
callees and make lockdep happy, take the hotplug lock in
sched_init_smp(). This also satisfies the comment atop
sched_init_domains() that says "Callers must hold the hotplug lock".

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Cc: quentin.perret@arm.com
Link: http://lkml.kernel.org/r/1540301851-3048-1-git-send-email-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fd2fce8a001b..02a20ef196a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5859,11 +5859,14 @@ void __init sched_init_smp(void)
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
-	 * happen.
+	 * happen. The hotplug lock is nevertheless taken to satisfy lockdep,
+	 * but there won't be any contention on it.
 	 */
+	cpus_read_lock();
 	mutex_lock(&sched_domains_mutex);
 	sched_init_domains(cpu_active_mask);
 	mutex_unlock(&sched_domains_mutex);
+	cpus_read_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
