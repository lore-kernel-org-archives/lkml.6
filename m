Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B12C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E8C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLw56g15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E8C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeKTBVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:21:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbeKTBVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b0cRTlKrmdkKKRNqK/c1JPrNiygQLyvmV71s8543BxY=; b=mLw56g15wSvMq3DM2HlxsAcyx
        O8wi1gzX8ZPWEFsSvaGT8hBkDRNcynRSGhyXGsX/egLtqgtY62253fw639T3DclB+SGa/hGX3rwVw
        KZmbKBC4So06JH7dl93nJalIr8zjZMBEi9DF4ylVhV6WxGngOTZEpe7K2BuFRAoQ/KuFZ+OugDcp4
        POhq1+CXySl1X7K0hTbQIO7YnFLPTkKuehBK2E2yAkRX0ujqM6LuhxJgdd9tEu4fzz2OrCYdqso57
        cBmdvPJtPKhlWvYg1OCJTYJAQYqC31oO9N2V2g1WA+eR+tHj3LBrL2+BoABHUUGc3n4LutpYJ2J+3
        XDlfI/s4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOkzr-0005rX-PM; Mon, 19 Nov 2018 14:57:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CB572018530A; Mon, 19 Nov 2018 15:57:54 +0100 (CET)
Date:   Mon, 19 Nov 2018 15:57:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v5 08/16] smt: Create cpu_smt_enabled static key for SMT
 specific code
Message-ID: <20181119145754.GA2131@hirez.programming.kicks-ass.net>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
 <91b719e53640f60666b40a3516da2b80703b2f76.1542418937.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b719e53640f60666b40a3516da2b80703b2f76.1542418937.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:53:51PM -0800, Tim Chen wrote:
> In later code, STIBP will be turned on/off in the context switch code
> path when SMT is enabled.  Checks for SMT is best
> avoided on such hot paths.
> 
> Create cpu_smt_enabled static key to turn on such SMT specific code
> statically.

AFAICT this patch only follows the SMT control knob but not the actual
topology state.

And, as I previously wrote, we already have sched_smt_present, which is
supposed to do much the same.

All you need is the below to make it accurately track the topology.

---
Subject: sched/smt: Make sched_smt_present track topology

Currently the sched_smt_present static key is only enabled when we
encounter SMT topology. However there is demand to also disable the key
when the topology changes such that there is no SMT present anymore.

Implement this by making the key count the number of cores that have SMT
enabled.

In particular, the SMT topology bits are set before we enable
interrrupts and similarly, are cleared after we disable interrupts for
the last time and die.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f12225f26b70..77e552928c67 100644
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
 
