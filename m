Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0272C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15720868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB15720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeKZFtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52733 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKZFtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:01 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzam-0003P1-4i; Sun, 25 Nov 2018 19:57:16 +0100
Message-Id: <20181125185004.430168326@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:38 +0100
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
        Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: [patch V2 10/28] sched/smt: Expose sched_smt_present static key
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=sched-smt-Expose-sched-smt-present-static-key.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the scheduler's 'sched_smt_present' static key globaly available, so
it can be used in the x86 speculation control code.

Provide a query function and a stub for the CONFIG_SMP=n case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---

v1 -> v2: Move SMT stuff to separate header. Unbreaks ia64 build

---
 include/linux/sched/smt.h |   18 ++++++++++++++++++
 kernel/sched/sched.h      |    4 +---
 2 files changed, 19 insertions(+), 3 deletions(-)

--- /dev/null
+++ b/include/linux/sched/smt.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_SMT_H
+#define _LINUX_SCHED_SMT_H
+
+#include <linux/static_key.h>
+
+#ifdef CONFIG_SCHED_SMT
+extern struct static_key_false sched_smt_present;
+
+static __always_inline bool sched_smt_active(void)
+{
+	return static_branch_likely(&sched_smt_present);
+}
+#else
+static inline bool sched_smt_active(void) { return false; }
+#endif
+
+#endif
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -23,6 +23,7 @@
 #include <linux/sched/prio.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/smt.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/sysctl.h>
 #include <linux/sched/task.h>
@@ -936,9 +937,6 @@ static inline int cpu_of(struct rq *rq)
 
 
 #ifdef CONFIG_SCHED_SMT
-
-extern struct static_key_false sched_smt_present;
-
 extern void __update_idle_core(struct rq *rq);
 
 static inline void update_idle_core(struct rq *rq)


