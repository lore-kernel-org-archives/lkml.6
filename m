Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD02C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A52222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Li0mLark"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfBLTnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:43:12 -0500
Received: from mail.efficios.com ([167.114.142.138]:57380 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBLTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:43:11 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 88ED91A1B1B;
        Tue, 12 Feb 2019 14:43:10 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id h1VCgYn5zwSv; Tue, 12 Feb 2019 14:43:10 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E04E21A1AFF;
        Tue, 12 Feb 2019 14:43:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E04E21A1AFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1550000589;
        bh=AWYbTmbbUu9whfET+jatobpOKB+ZZRz448Bik1cpDV0=;
        h=From:To:Date:Message-Id;
        b=Li0mLarkExrbEuurvDqnwcBnczDCJsAjyQMUiJ2vOiXPVanOiQ51nhdi4I6gxyzoj
         VtiTKYDxMRN/uGT2fLR8xt/7BLgbaVBZuXtdnLocaqcC0RLxWPy03E26fC0E8ljNeE
         pjlC9oDWEx54El2mDh5PB9Vxr1angPTVgyabDd0NQkte6hemd9fkQXDUOvr7tMuVNH
         i9pPFFAbJwxjNMmDBFRsKHYCZivGXSChQgbfpkug+tKuGmmvXhnwGwM7QScYCnwfHR
         SQ+x3MPlWXVXj0WcUMXiIk5XDRM4vm4OQTRL3yDs4fvjYAJOxg6zby5X1NOsjHRrxy
         rgpXpNiHSo1Gg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id IBjfZR3O_V4t; Tue, 12 Feb 2019 14:43:09 -0500 (EST)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 93EB91A1AEB;
        Tue, 12 Feb 2019 14:43:09 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 2/4] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux
Date:   Tue, 12 Feb 2019 14:42:51 -0500
Message-Id: <20190212194253.1951-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When available, use the cpu_id field from __rseq_abi on Linux to
implement sched_getcpu(). Fall-back on the vgetcpu vDSO if unavailable.

Benchmarks:

x86-64: Intel E5-2630 v3@2.40GHz, 16-core, hyperthreading

glibc sched_getcpu():                     13.7 ns (baseline)
glibc sched_getcpu() using rseq:           2.5 ns (speedup:  5.5x)
inline load cpuid from __rseq_abi TLS:     0.8 ns (speedup: 17.1x)

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
CC: Joseph Myers <joseph@codesourcery.com>
CC: Szabolcs Nagy <szabolcs.nagy@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ben Maurer <bmaurer@fb.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Dave Watson <davejwatson@fb.com>
CC: Paul Turner <pjt@google.com>
CC: libc-alpha@sourceware.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
---
 sysdeps/unix/sysv/linux/sched_getcpu.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/linux/sched_getcpu.c
index fb0d317f83..8bfb03778b 100644
--- a/sysdeps/unix/sysv/linux/sched_getcpu.c
+++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
@@ -24,8 +24,8 @@
 #endif
 #include <sysdep-vdso.h>
 
-int
-sched_getcpu (void)
+static int
+vsyscall_sched_getcpu (void)
 {
 #ifdef __NR_getcpu
   unsigned int cpu;
@@ -37,3 +37,24 @@ sched_getcpu (void)
   return -1;
 #endif
 }
+
+#ifdef __NR_rseq
+#include <linux/rseq.h>
+
+extern __attribute__ ((tls_model ("initial-exec")))
+__thread volatile struct rseq __rseq_abi;
+
+int
+sched_getcpu (void)
+{
+  int cpu_id = __rseq_abi.cpu_id;
+
+  return cpu_id >= 0 ? cpu_id : vsyscall_sched_getcpu ();
+}
+#else
+int
+sched_getcpu (void)
+{
+  return vsyscall_sched_getcpu ();
+}
+#endif
-- 
2.17.1

