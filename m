Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDC12151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDC12151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbeKVGz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:55:27 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45230 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389265AbeKVGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:03 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYww-0000GM-2s; Wed, 21 Nov 2018 21:18:14 +0100
Message-Id: <20181121201723.248042794@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:40 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 10/24] sched/smt: Expose sched_smt_present static key
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=sched-smt--Expose-sched_smt_present-static-key.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the scheduler's 'sched_smt_present' static key globaly available, so
it can be used in the x86 speculation control code.

Provide a query function and a stub for the CONFIG_SMP=n case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/topology.h |    9 +++++++++
 kernel/sched/sched.h           |    3 ---
 2 files changed, 9 insertions(+), 3 deletions(-)

--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -34,10 +34,19 @@
 #define SD_NUMA			0x4000	/* cross-node balancing */
 
 #ifdef CONFIG_SCHED_SMT
+extern struct static_key_false sched_smt_present;
+
+static __always_inline bool sched_smt_active(void)
+{
+	return static_branch_likely(&sched_smt_present);
+}
+
 static inline int cpu_smt_flags(void)
 {
 	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
 }
+#else
+static inline bool sched_smt_active(void) { return false; }
 #endif
 
 #ifdef CONFIG_SCHED_MC
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -941,9 +941,6 @@ static inline int cpu_of(struct rq *rq)
 
 
 #ifdef CONFIG_SCHED_SMT
-
-extern struct static_key_false sched_smt_present;
-
 extern void __update_idle_core(struct rq *rq);
 
 static inline void update_idle_core(struct rq *rq)


