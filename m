Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B41F206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UsSbQgmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B41F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJKCoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:44:19 -0400
Received: from mail.efficios.com ([167.114.142.138]:33082 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJKCns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:43:48 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 667E1183C1B;
        Wed, 10 Oct 2018 15:20:15 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id iIvzeBqiF7kF; Wed, 10 Oct 2018 15:20:14 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AEA01183C18;
        Wed, 10 Oct 2018 15:20:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AEA01183C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539199214;
        bh=BylZ1Ow4mkEMYbA1e+TyLlzHIq2RSTuuybDdAITGqRU=;
        h=From:To:Date:Message-Id;
        b=UsSbQgmpUmDNDV42HU3Fs/GlDavYO5Xrz0tjJMaJ4743S2IpofmTcdQEkSXwiriy0
         M8Q5YugaQQ9Grec9EMJNJjnowA6rAvErHq+d2MkpgTP2G+8OlmfyyqoFm2OIPGgxzv
         X3ljK5FYbd8xEoBRcLyzsPnkuOToY2maGXchTzs6vCNzwCyYYdttnxfs69DaTdX87D
         yNhiOW8Qd5i2bLy2/m3tXHrEN1cDvVVYkUQsdeMnYR8hyjuLHupR5cPfhXp4MAk1O+
         IqHUt2HJMqwpm3hJvpcqknRHL2dpCzjVFmjxn2O7krCc2xIGzPozQwV5r3sGzUL/X2
         VIPp78kh+N9hw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id SyqtElJ7zLld; Wed, 10 Oct 2018 15:20:14 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id A7D1C183BED;
        Wed, 10 Oct 2018 15:20:13 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH for 4.21 11/16] cpu-opv/selftests: Provide cpu-op library
Date:   Wed, 10 Oct 2018 15:19:31 -0400
Message-Id: <20181010191936.7495-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cpu-op helper library provides a user-space API to the cpu_opv()
system call.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: linux-kselftest@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: linux-api@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 tools/testing/selftests/cpu-opv/cpu-op.c | 353 +++++++++++++++++++++++++++++++
 tools/testing/selftests/cpu-opv/cpu-op.h |  42 ++++
 2 files changed, 395 insertions(+)
 create mode 100644 tools/testing/selftests/cpu-opv/cpu-op.c
 create mode 100644 tools/testing/selftests/cpu-opv/cpu-op.h

diff --git a/tools/testing/selftests/cpu-opv/cpu-op.c b/tools/testing/selftests/cpu-opv/cpu-op.c
new file mode 100644
index 000000000000..575cd51da421
--- /dev/null
+++ b/tools/testing/selftests/cpu-opv/cpu-op.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * cpu-op.c
+ *
+ * Copyright (C) 2017 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; only
+ * version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <syscall.h>
+#include <assert.h>
+#include <signal.h>
+
+#include "cpu-op.h"
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+#define ACCESS_ONCE(x)		(*(__volatile__  __typeof__(x) *)&(x))
+#define WRITE_ONCE(x, v)	__extension__ ({ ACCESS_ONCE(x) = (v); })
+#define READ_ONCE(x)		ACCESS_ONCE(x)
+
+int cpu_opv(struct cpu_op *cpu_opv, int cpuopcnt, int cpu, int flags)
+{
+	return syscall(__NR_cpu_opv, cpu_opv, cpuopcnt, cpu, flags);
+}
+
+int cpu_op_get_current_cpu(void)
+{
+	int cpu;
+
+	cpu = sched_getcpu();
+	if (cpu < 0) {
+		perror("sched_getcpu()");
+		abort();
+	}
+	return cpu;
+}
+
+int cpu_op_cmpxchg(void *v, void *expect, void *old, void *n, size_t len,
+		   int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_MEMCPY_OP,
+			.len = len,
+			.u.memcpy_op.dst = (unsigned long)old,
+			.u.memcpy_op.src = (unsigned long)v,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+		[1] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = len,
+			.u.compare_op.a = (unsigned long)v,
+			.u.compare_op.b = (unsigned long)expect,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[2] = {
+			.op = CPU_MEMCPY_OP,
+			.len = len,
+			.u.memcpy_op.dst = (unsigned long)v,
+			.u.memcpy_op.src = (unsigned long)n,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+int cpu_op_add(void *v, int64_t count, size_t len, int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_ADD_OP,
+			.len = len,
+			.u.arithmetic_op.p = (unsigned long)v,
+			.u.arithmetic_op.count = count,
+			.u.arithmetic_op.expect_fault_p = 0,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+int cpu_op_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv,
+			 int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = sizeof(intptr_t),
+			.u.compare_op.a = (unsigned long)v,
+			.u.compare_op.b = (unsigned long)&expect,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[1] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v,
+			.u.memcpy_op.src = (unsigned long)&newv,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+static int cpu_op_cmpeqv_storep_expect_fault(intptr_t *v, intptr_t expect,
+					     intptr_t *newp, int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = sizeof(intptr_t),
+			.u.compare_op.a = (unsigned long)v,
+			.u.compare_op.b = (unsigned long)&expect,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[1] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v,
+			.u.memcpy_op.src = (unsigned long)newp,
+			.u.memcpy_op.expect_fault_dst = 0,
+			/* Return EAGAIN on src fault. */
+			.u.memcpy_op.expect_fault_src = 1,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+int cpu_op_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+				 off_t voffp, intptr_t *load, int cpu)
+{
+	int ret;
+
+	do {
+		intptr_t oldv = READ_ONCE(*v);
+		intptr_t *newp = (intptr_t *)(oldv + voffp);
+
+		if (oldv == expectnot)
+			return 1;
+		ret = cpu_op_cmpeqv_storep_expect_fault(v, oldv, newp, cpu);
+		if (!ret) {
+			*load = oldv;
+			return 0;
+		}
+	} while (ret > 0);
+
+	return -1;
+}
+
+int cpu_op_cmpeqv_storev_storev(intptr_t *v, intptr_t expect,
+				intptr_t *v2, intptr_t newv2,
+				intptr_t newv, int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = sizeof(intptr_t),
+			.u.compare_op.a = (unsigned long)v,
+			.u.compare_op.b = (unsigned long)&expect,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[1] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v2,
+			.u.memcpy_op.src = (unsigned long)&newv2,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+		[2] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v,
+			.u.memcpy_op.src = (unsigned long)&newv,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+int cpu_op_cmpeqv_storev_mb_storev(intptr_t *v, intptr_t expect,
+				   intptr_t *v2, intptr_t newv2,
+				   intptr_t newv, int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = sizeof(intptr_t),
+			.u.compare_op.a = (unsigned long)v,
+			.u.compare_op.b = (unsigned long)&expect,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[1] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v2,
+			.u.memcpy_op.src = (unsigned long)&newv2,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+		[2] = {
+			.op = CPU_MB_OP,
+		},
+		[3] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v,
+			.u.memcpy_op.src = (unsigned long)&newv,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+int cpu_op_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+				intptr_t *v2, intptr_t expect2,
+				intptr_t newv, int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = sizeof(intptr_t),
+			.u.compare_op.a = (unsigned long)v,
+			.u.compare_op.b = (unsigned long)&expect,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[1] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = sizeof(intptr_t),
+			.u.compare_op.a = (unsigned long)v2,
+			.u.compare_op.b = (unsigned long)&expect2,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[2] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v,
+			.u.memcpy_op.src = (unsigned long)&newv,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+int cpu_op_cmpeqv_memcpy_storev(intptr_t *v, intptr_t expect,
+				void *dst, void *src, size_t len,
+				intptr_t newv, int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = sizeof(intptr_t),
+			.u.compare_op.a = (unsigned long)v,
+			.u.compare_op.b = (unsigned long)&expect,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[1] = {
+			.op = CPU_MEMCPY_OP,
+			.len = len,
+			.u.memcpy_op.dst = (unsigned long)dst,
+			.u.memcpy_op.src = (unsigned long)src,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+		[2] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v,
+			.u.memcpy_op.src = (unsigned long)&newv,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+int cpu_op_cmpeqv_memcpy_mb_storev(intptr_t *v, intptr_t expect,
+				   void *dst, void *src, size_t len,
+				   intptr_t newv, int cpu)
+{
+	struct cpu_op opvec[] = {
+		[0] = {
+			.op = CPU_COMPARE_EQ_OP,
+			.len = sizeof(intptr_t),
+			.u.compare_op.a = (unsigned long)v,
+			.u.compare_op.b = (unsigned long)&expect,
+			.u.compare_op.expect_fault_a = 0,
+			.u.compare_op.expect_fault_b = 0,
+		},
+		[1] = {
+			.op = CPU_MEMCPY_OP,
+			.len = len,
+			.u.memcpy_op.dst = (unsigned long)dst,
+			.u.memcpy_op.src = (unsigned long)src,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+		[2] = {
+			.op = CPU_MB_OP,
+		},
+		[3] = {
+			.op = CPU_MEMCPY_OP,
+			.len = sizeof(intptr_t),
+			.u.memcpy_op.dst = (unsigned long)v,
+			.u.memcpy_op.src = (unsigned long)&newv,
+			.u.memcpy_op.expect_fault_dst = 0,
+			.u.memcpy_op.expect_fault_src = 0,
+		},
+	};
+
+	return cpu_opv(opvec, ARRAY_SIZE(opvec), cpu, 0);
+}
+
+int cpu_op_addv(intptr_t *v, int64_t count, int cpu)
+{
+	return cpu_op_add(v, count, sizeof(intptr_t), cpu);
+}
diff --git a/tools/testing/selftests/cpu-opv/cpu-op.h b/tools/testing/selftests/cpu-opv/cpu-op.h
new file mode 100644
index 000000000000..075687a1365f
--- /dev/null
+++ b/tools/testing/selftests/cpu-opv/cpu-op.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * cpu-op.h
+ *
+ * (C) Copyright 2017-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef CPU_OPV_H
+#define CPU_OPV_H
+
+#include <stdlib.h>
+#include <stdint.h>
+#include <linux/cpu_opv.h>
+
+int cpu_opv(struct cpu_op *cpuopv, int cpuopcnt, int cpu, int flags);
+int cpu_op_get_current_cpu(void);
+
+int cpu_op_cmpxchg(void *v, void *expect, void *old, void *_new, size_t len,
+		   int cpu);
+int cpu_op_add(void *v, int64_t count, size_t len, int cpu);
+
+int cpu_op_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu);
+int cpu_op_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+				 off_t voffp, intptr_t *load, int cpu);
+int cpu_op_cmpeqv_storev_storev(intptr_t *v, intptr_t expect,
+				intptr_t *v2, intptr_t newv2,
+				intptr_t newv, int cpu);
+int cpu_op_cmpeqv_storev_mb_storev(intptr_t *v, intptr_t expect,
+				   intptr_t *v2, intptr_t newv2,
+				   intptr_t newv, int cpu);
+int cpu_op_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+				intptr_t *v2, intptr_t expect2,
+				intptr_t newv, int cpu);
+int cpu_op_cmpeqv_memcpy_storev(intptr_t *v, intptr_t expect,
+				void *dst, void *src, size_t len,
+				intptr_t newv, int cpu);
+int cpu_op_cmpeqv_memcpy_mb_storev(intptr_t *v, intptr_t expect,
+				   void *dst, void *src, size_t len,
+				   intptr_t newv, int cpu);
+int cpu_op_addv(intptr_t *v, int64_t count, int cpu);
+
+#endif  /* CPU_OPV_H_ */
-- 
2.11.0

