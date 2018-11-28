Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567D2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC3C208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC3C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeK2B2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:28:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2B2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:28:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEPZUF2322745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:25:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEPYPF2322741;
        Wed, 28 Nov 2018 06:25:34 -0800
Date:   Wed, 28 Nov 2018 06:25:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-321a874a7ef85655e93b3206d0f36b4a6097f948@git.kernel.org>
Cc:     tglx@linutronix.de, keescook@chromium.org,
        torvalds@linux-foundation.org, asit.k.mallick@intel.com,
        david.c.stewart@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
        thomas.lendacky@amd.com, tim.c.chen@linux.intel.com,
        luto@kernel.org, longman9394@gmail.com, casey.schaufler@intel.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jcm@redhat.com, jkosina@suse.cz,
        aarcange@redhat.com, arjan@linux.intel.com, hpa@zytor.com,
        mingo@kernel.org
Reply-To: aarcange@redhat.com, peterz@infradead.org, jcm@redhat.com,
          jkosina@suse.cz, hpa@zytor.com, mingo@kernel.org,
          arjan@linux.intel.com, asit.k.mallick@intel.com,
          dave.hansen@intel.com, david.c.stewart@intel.com,
          ak@linux.intel.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, keescook@chromium.org,
          thomas.lendacky@amd.com, dwmw@amazon.co.uk,
          gregkh@linuxfoundation.org, longman9394@gmail.com,
          luto@kernel.org, tim.c.chen@linux.intel.com,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          casey.schaufler@intel.com
In-Reply-To: <20181125185004.430168326@linutronix.de>
References: <20181125185004.430168326@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] sched/smt: Expose sched_smt_present static key
Git-Commit-ID: 321a874a7ef85655e93b3206d0f36b4a6097f948
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

Commit-ID:  321a874a7ef85655e93b3206d0f36b4a6097f948
Gitweb:     https://git.kernel.org/tip/321a874a7ef85655e93b3206d0f36b4a6097f948
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:38 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:07 +0100

sched/smt: Expose sched_smt_present static key

Make the scheduler's 'sched_smt_present' static key globaly available, so
it can be used in the x86 speculation control code.

Provide a query function and a stub for the CONFIG_SMP=n case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
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
Link: https://lkml.kernel.org/r/20181125185004.430168326@linutronix.de

---
 include/linux/sched/smt.h | 18 ++++++++++++++++++
 kernel/sched/sched.h      |  4 +---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
new file mode 100644
index 000000000000..c9e0be514110
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 618577fc9aa8..4e524ab589c9 100644
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
