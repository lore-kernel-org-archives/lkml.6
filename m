Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B678C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6510F21919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBIMrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:47:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54877 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:47:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CkwbW2632009
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:46:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CkvUw2632006;
        Sat, 9 Feb 2019 04:46:57 -0800
Date:   Sat, 9 Feb 2019 04:46:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hvm9ysmrjip75ebdzhzoh429@git.kernel.org>
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        jolsa@kernel.org, hpa@zytor.com
Reply-To: alexey.budankov@linux.intel.com, peterz@infradead.org,
          adrian.hunter@intel.com, ak@linux.intel.com, hpa@zytor.com,
          jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add fallback versions for
 CPU_{OR,EQUAL}()
Git-Commit-ID: de20e3200c962213cdc67c0933f0ddaeb9285e62
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

Commit-ID:  de20e3200c962213cdc67c0933f0ddaeb9285e62
Gitweb:     https://git.kernel.org/tip/de20e3200c962213cdc67c0933f0ddaeb9285e62
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 5 Feb 2019 15:02:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf tools: Add fallback versions for CPU_{OR,EQUAL}()

From the glibc sources, so that we can keep the tooling buildable in
older systems while using recent sched.h CPU_ macros.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-hvm9ysmrjip75ebdzhzoh429@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpu-set-sched.h | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/util/cpu-set-sched.h b/tools/perf/util/cpu-set-sched.h
new file mode 100644
index 000000000000..8cf4e40d322a
--- /dev/null
+++ b/tools/perf/util/cpu-set-sched.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: LGPL-2.1
+// Definitions taken from glibc for use with older systems, same licensing.
+#ifndef _CPU_SET_SCHED_PERF_H
+#define _CPU_SET_SCHED_PERF_H
+
+#include <features.h>
+#include <sched.h>
+
+#ifndef CPU_EQUAL
+#ifndef __CPU_EQUAL_S
+#if __GNUC_PREREQ (2, 91)
+# define __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2) \
+  (__builtin_memcmp (cpusetp1, cpusetp2, setsize) == 0)
+#else
+# define __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2) \
+  (__extension__							      \
+   ({ const __cpu_mask *__arr1 = (cpusetp1)->__bits;			      \
+      const __cpu_mask *__arr2 = (cpusetp2)->__bits;			      \
+      size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
+      size_t __i;							      \
+      for (__i = 0; __i < __imax; ++__i)				      \
+	if (__arr1[__i] != __arr2[__i])					      \
+	  break;							      \
+      __i == __imax; }))
+#endif
+#endif // __CPU_EQUAL_S
+
+#define CPU_EQUAL(cpusetp1, cpusetp2) \
+  __CPU_EQUAL_S (sizeof (cpu_set_t), cpusetp1, cpusetp2)
+#endif // CPU_EQUAL
+
+#ifndef CPU_OR
+#ifndef __CPU_OP_S
+#define __CPU_OP_S(setsize, destset, srcset1, srcset2, op) \
+  (__extension__							      \
+   ({ cpu_set_t *__dest = (destset);					      \
+      const __cpu_mask *__arr1 = (srcset1)->__bits;			      \
+      const __cpu_mask *__arr2 = (srcset2)->__bits;			      \
+      size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
+      size_t __i;							      \
+      for (__i = 0; __i < __imax; ++__i)				      \
+	((__cpu_mask *) __dest->__bits)[__i] = __arr1[__i] op __arr2[__i];    \
+      __dest; }))
+#endif // __CPU_OP_S
+
+#define CPU_OR(destset, srcset1, srcset2) \
+  __CPU_OP_S (sizeof (cpu_set_t), destset, srcset1, srcset2, |)
+#endif // CPU_OR
+
+#endif // _CPU_SET_SCHED_PERF_H
