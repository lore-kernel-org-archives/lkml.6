Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB58C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6379C20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZZSYwnaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6379C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeKBVAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:00:04 -0400
Received: from mail.efficios.com ([167.114.142.138]:45244 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKBVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:00:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E64732488C0;
        Fri,  2 Nov 2018 07:53:06 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id skhbbq-SB2sz; Fri,  2 Nov 2018 07:53:06 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 94FA52488BB;
        Fri,  2 Nov 2018 07:53:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 94FA52488BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541159586;
        bh=ARIXVDaQRUZ7X2dcuyortmQVt+ZsZwR9tFSZPo3/9TE=;
        h=From:To:Date:Message-Id;
        b=ZZSYwnaWvaHeKXt1fPCsxFWd4tkBzWSXDVX2O5uWZ/j5MuURmLQG4GBpLDoOUVmxB
         tHmhi9imrNCjYMmvtsKWDy69aD3p4bSDk8EiXgqK34Oztt/FrE3nferm9K9BA6v4Rl
         Z8+cst2yRmsOjTnPwWBgQ7WOFsZTW/ssXzJsZr9gd/8yKDu0fICERrSJFUtBntZaDu
         QzRMaM6XZJnMSXIsSzVrZRIwTYhF/SV/JweutFJgVIxLkyUrTdM+XdAfU6BLTzBfVN
         ELSuMv5ldHA8ms7AHygqxqKNrQrGQeVs6UOhDb68mgHqhJ6HxKATh/yKRRnn9wjTHx
         j3/WmM1Hd+mrw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id r582tG_CYFPt; Fri,  2 Nov 2018 07:53:06 -0400 (EDT)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 4EA4B2488AF;
        Fri,  2 Nov 2018 07:53:06 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     libc-alpha@sourceware.org
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC PATCH 2/2] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux
Date:   Fri,  2 Nov 2018 07:52:59 -0400
Message-Id: <20181102115259.11383-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102115259.11383-1-mathieu.desnoyers@efficios.com>
References: <20181102115259.11383-1-mathieu.desnoyers@efficios.com>
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
index b69eeda15c..e1a206075c 100644
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
+	int cpu_id = __rseq_abi.cpu_id;
+
+	return cpu_id >= 0 ? cpu_id : vsyscall_sched_getcpu ();
+}
+#else
+int
+sched_getcpu (void)
+{
+	return vsyscall_sched_getcpu ();
+}
+#endif
-- 
2.17.1

