Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+nk8o4rIxZBTnVsJEjcZIVPnAFpD+vd80RzOBeQVpHSn7IyVnfPyL8cylF0p1FJq59qvUz
ARC-Seal: i=1; a=rsa-sha256; t=1523561393; cv=none;
        d=google.com; s=arc-20160816;
        b=ssl0BhReKUsJ3K89dNFwDlfOSoz44mU1eRbCkeDo4+TpKbAyE/uk8f3IQehvfWmPis
         dp04pc9Ux6lapqFPY78HKoeVecAU1Mvn0fu5ej7eDjK5IfqAw8zc4v5srKrHeCoPjTEq
         q2rs7/42E9Y5+m+TMaQYGf/fR5hJrjYHb7KmFoKIVnI/oj1s47JY5CE1fz1kMsq6LG4D
         9Ha16mUze52OQXrL8jG9uRcpyUlWt3mGCvHwhEx+N8x0t9vv8E5bVciRSVXXpjBx2741
         btOWWmBZ4IWvUMVopWkbOOBM9PYdaUcRdMySm64FNrDHBi2eFmSZb9U8B8MyEoxndvN/
         E9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SzqMRF9Nik2yJhG+kNbLUhHNcLdq+Xms96O6j1UUNVk=;
        b=ecyklSBJFcuP+qF55aNzEZVmr8gSW3s/+fkpr649MVcSj4t2YOaAiSNcGjfxKeKKUS
         50CvqTPByg7KvCIB9MB3hA+rJPKyUvcJVmcAAOWeMG0DCRK4x8jLrZkVSO62FYYfMsv5
         lRX0MzO+VMMLuIg+zpddnj8M+1LiqkyyvXZbgXdkvcGX1nN01z6TgrCz08pGjBo75ZyE
         8GEt9jgcBjB2hpnJvOSL+fUIWqH3wjcLfbQsSfc27sC9b8K1SRBG5KEY5/fodSlTujKZ
         9vln5tG+C+whgYfhGhIXXymhFdIMe2MmADL61j1c/7b8S/MZU5NvJot/KjZVHW4KDVRs
         E1RA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeDLT3b (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 12 Apr 2018 15:29:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:45756 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbeDLT21 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Apr 2018 15:28:27 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH for 4.18 19/23] rseq: selftests: Provide percpu_op API
Date: Thu, 12 Apr 2018 15:27:56 -0400
Message-Id: <20180412192800.15708-20-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597569911605150174?=
X-GMAIL-MSGID: =?utf-8?q?1597569911605150174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce percpu-op.h API. It uses rseq internally as fast-path if
invoked from the right CPU, else cpu_opv as slow-path if called
from the wrong CPU or if rseq fails.

This allows acting on per-cpu data from various CPUs transparently from
user-space: cpu_opv will take care of migrating the thread to the
requested CPU. Use-cases such as rebalancing memory across per-cpu
memory pools, or migrating tasks for a user-space scheduler, are thus
facilitated. This also handles debugger single-stepping.

The use from userspace is, e.g. for a counter increment:

    int cpu, ret;

    cpu = rseq_cpu_start();
    ret = percpu_addv(&data->c[cpu].count, 1, cpu);
    if (unlikely(ret)) {
         perror("percpu_addv");
         return -1;
    }
    return 0;

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Shuah Khan <shuahkh@osg.samsung.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Paul Turner <pjt@google.com>
CC: Andrew Hunter <ahh@google.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: linux-api@vger.kernel.org
---
 tools/testing/selftests/rseq/percpu-op.h | 163 +++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/percpu-op.h

diff --git a/tools/testing/selftests/rseq/percpu-op.h b/tools/testing/selftests/rseq/percpu-op.h
new file mode 100644
index 000000000000..c17d165438a6
--- /dev/null
+++ b/tools/testing/selftests/rseq/percpu-op.h
@@ -0,0 +1,163 @@
+/*
+ * percpu-op.h
+ *
+ * (C) Copyright 2017 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef PERCPU_OP_H
+#define PERCPU_OP_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <stdlib.h>
+#include "rseq.h"
+#include "cpu-op.h"
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv,
+			 int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_storev(v, expect, newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_storev(v, expect, newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpnev_storeoffp_load(v, expectnot, voffp, load, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpnev_storeoffp_load(v, expectnot, voffp,
+						    load, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	if (rseq_unlikely(rseq_addv(v, count, cpu)))
+		return cpu_op_addv(v, count, cpu);
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_storev_storev(intptr_t *v, intptr_t expect,
+				intptr_t *v2, intptr_t newv2,
+				intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_trystorev_storev(v, expect, v2, newv2,
+					   newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_storev_storev(v, expect, v2, newv2,
+						   newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_storev_storev_release(intptr_t *v, intptr_t expect,
+					intptr_t *v2, intptr_t newv2,
+					intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_trystorev_storev_release(v, expect, v2, newv2,
+						   newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_storev_mb_storev(v, expect, v2, newv2,
+						      newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+				intptr_t *v2, intptr_t expect2,
+				intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_cmpeqv_storev(v, expect, v2, expect2, newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_cmpeqv_storev(v, expect, v2, expect2,
+						   newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_memcpy_storev(intptr_t *v, intptr_t expect,
+				void *dst, void *src, size_t len,
+				intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
+					   newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_memcpy_storev(v, expect, dst, src, len,
+						   newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_memcpy_storev_release(intptr_t *v, intptr_t expect,
+					void *dst, void *src, size_t len,
+					intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_trymemcpy_storev_release(v, expect, dst, src, len,
+						   newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_memcpy_mb_storev(v, expect, dst, src, len,
+						      newv, cpu);
+	}
+	return 0;
+}
+
+#endif  /* PERCPU_OP_H_ */
-- 
2.11.0

