Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10561C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FAC2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="swEIvVzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfBDV3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:29:12 -0500
Received: from mail.efficios.com ([167.114.142.138]:51998 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfBDV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:29:12 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BD35F18D488;
        Mon,  4 Feb 2019 16:29:10 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Wm_yGKXtHAec; Mon,  4 Feb 2019 16:29:10 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 185D418D468;
        Mon,  4 Feb 2019 16:29:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 185D418D468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1549315750;
        bh=AWYbTmbbUu9whfET+jatobpOKB+ZZRz448Bik1cpDV0=;
        h=From:To:Date:Message-Id;
        b=swEIvVzZjmPW4ef9/eLKjmkFWYYGmNm9nM+R76v/g0PNEosDYTn6xN/VoEv8aUNgV
         9dAeDSDwHyGN52BaBs9uyCXMfS0Hk1wKElj4yvuHsUDtXf8voHZGR2HwoLnji0osxT
         zeiCQ+FTTWXNt/KPIxnhpH3lGMHhIk0xvmCyV8U7sslHsDFC8eQEaw2vIkiJsO4Y0Y
         fpCmo1B14Fj9Sbk9lXRxyycwSHyKj0ccQFbUvBHMxMTve0zO4GiePC9Qx/Dop2449z
         OWsLAqXBhFJhuBUWEo8Bt3KI7oBjgAqFEKaHid+Fo0nMbAWgOPnhUX0+pd9ti0VHJb
         6qcT8aPXhmFqQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id AO-lk1P72LiB; Mon,  4 Feb 2019 16:29:10 -0500 (EST)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id BB03D18D45B;
        Mon,  4 Feb 2019 16:29:09 -0500 (EST)
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
Subject: [RFC PATCH 2/4] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux
Date:   Mon,  4 Feb 2019 16:29:00 -0500
Message-Id: <20190204212902.31474-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204212902.31474-1-mathieu.desnoyers@efficios.com>
References: <20190204212902.31474-1-mathieu.desnoyers@efficios.com>
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

