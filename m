Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55805C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F532206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F532206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeK2C1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:27:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38225 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2C1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:27:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEOLGs2322627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:24:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEOLYm2322624;
        Wed, 28 Nov 2018 06:24:21 -0800
Date:   Wed, 28 Nov 2018 06:24:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Peter Zijlstra (Intel)" <tipbot@zytor.com>
Message-ID: <tip-c5511d03ec090980732e929c318a7a6374b5550e@git.kernel.org>
Cc:     asit.k.mallick@intel.com, dwmw@amazon.co.uk, keescook@chromium.org,
        gregkh@linuxfoundation.org, dave.hansen@intel.com, luto@kernel.org,
        thomas.lendacky@amd.com, tim.c.chen@linux.intel.com, hpa@zytor.com,
        jkosina@suse.cz, jpoimboe@redhat.com, mingo@kernel.org,
        ak@linux.intel.com, david.c.stewart@intel.com, jcm@redhat.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, longman9394@gmail.com, arjan@linux.intel.com,
        aarcange@redhat.com, linux-kernel@vger.kernel.org,
        casey.schaufler@intel.com
Reply-To: arjan@linux.intel.com, longman9394@gmail.com,
          aarcange@redhat.com, peterz@infradead.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, casey.schaufler@intel.com,
          ak@linux.intel.com, mingo@kernel.org, jpoimboe@redhat.com,
          jcm@redhat.com, david.c.stewart@intel.com, dave.hansen@intel.com,
          thomas.lendacky@amd.com, luto@kernel.org, keescook@chromium.org,
          gregkh@linuxfoundation.org, hpa@zytor.com, jkosina@suse.cz,
          tim.c.chen@linux.intel.com, asit.k.mallick@intel.com,
          dwmw@amazon.co.uk
In-Reply-To: <20181125185004.246110444@linutronix.de>
References: <20181125185004.246110444@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] sched/smt: Make sched_smt_present track topology
Git-Commit-ID: c5511d03ec090980732e929c318a7a6374b5550e
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

Commit-ID:  c5511d03ec090980732e929c318a7a6374b5550e
Gitweb:     https://git.kernel.org/tip/c5511d03ec090980732e929c318a7a6374b5550e
Author:     Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate: Sun, 25 Nov 2018 19:33:36 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:06 +0100

sched/smt: Make sched_smt_present track topology

Currently the 'sched_smt_present' static key is enabled when at CPU bringup
SMT topology is observed, but it is never disabled. However there is demand
to also disable the key when the topology changes such that there is no SMT
present anymore.

Implement this by making the key count the number of cores that have SMT
enabled.

In particular, the SMT topology bits are set before interrrupts are enabled
and similarly, are cleared after interrupts are disabled for the last time
and the CPU dies.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185004.246110444@linutronix.de


---
 kernel/sched/core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 091e089063be..6fedf3a98581 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5738,15 +5738,10 @@ int sched_cpu_activate(unsigned int cpu)
 
 #ifdef CONFIG_SCHED_SMT
 	/*
-	 * The sched_smt_present static key needs to be evaluated on every
-	 * hotplug event because at boot time SMT might be disabled when
-	 * the number of booted CPUs is limited.
-	 *
-	 * If then later a sibling gets hotplugged, then the key would stay
-	 * off and SMT scheduling would never be functional.
+	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) > 1)
-		static_branch_enable_cpuslocked(&sched_smt_present);
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_inc_cpuslocked(&sched_smt_present);
 #endif
 	set_cpu_active(cpu, true);
 
@@ -5790,6 +5785,14 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu_mult(call_rcu, call_rcu_sched);
 
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * When going down, decrement the number of cores with SMT present.
+	 */
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_dec_cpuslocked(&sched_smt_present);
+#endif
+
 	if (!sched_smp_initialized)
 		return 0;
 
