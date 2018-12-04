Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA6BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4603A206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE3oufYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4603A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeLDLEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeLDLEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939B1214DE;
        Tue,  4 Dec 2018 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921480;
        bh=aCqfoQCmjqEVVva0g0UsUHNejmRvsBMIAL4O8d0axPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rE3oufYZ1j2cb+MtAIWLB7oIcRa1D1Z0/YU6Xoy73QoSBun2LXE+dWBb5mBc+xQTD
         T6p6GB3Gu6RlIQ8+eOAZIicDAjYse09yiEzqF8qCjmvBCjhIUog19UFLi5N0zYJQlL
         k8NoAzG0PO5EYvgtI7W2JDxNmsUH5DM+uSfE/EZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 087/146] sched/smt: Make sched_smt_present track topology
Date:   Tue,  4 Dec 2018 11:49:33 +0100
Message-Id: <20181204103730.330415318@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra (Intel) peterz@infradead.org

commit c5511d03ec090980732e929c318a7a6374b5550e upstream

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5617,15 +5617,10 @@ int sched_cpu_activate(unsigned int cpu)
 
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
 
@@ -5669,6 +5664,14 @@ int sched_cpu_deactivate(unsigned int cp
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
 


