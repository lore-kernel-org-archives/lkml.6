Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B88C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CA72085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eos8S5Of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CA72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeJKCoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:44:19 -0400
Received: from mail.efficios.com ([167.114.142.138]:33292 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbeJKCnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:43:51 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DB34B183C53;
        Wed, 10 Oct 2018 15:20:17 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id JVp6CrB9PZB6; Wed, 10 Oct 2018 15:20:17 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 46432183C48;
        Wed, 10 Oct 2018 15:20:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 46432183C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539199217;
        bh=gHir4rIYo1hBb6B/d1ojb7dvAjlqUhljmuhdjIhh484=;
        h=From:To:Date:Message-Id;
        b=eos8S5Of4pj3YoyzP/cjITnB+ch3XYyZ2lEDZJMu/3TN3hqoHsRCIQO1bUWBYWVSO
         T1lB97WYx7YwG98c0d0aKVLt4bcvLhyfVLI5cEPkDKd0cUxU9PEEURbVjs/5LegPdr
         YWQJ+3nZX1NITgHFI8CsaT3pXGAaIFaz6+fdisBpbDyf8WFvakIrR2F7lfkHfRkExX
         1SH9p6nLDjIzOWM9j4eUYKbwZtC9EwHs4BVJfhjaBN5LjQRhV2ktFLf+Eum7c9NDHw
         w4+a98Ej2p2yZpnFQ4o5Za72CDFV1/yIaGTVOUbJGj7R43iy+zjvHmIuxpR0p9PEGH
         xRJ4ZyK1HSIPg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id hMlsn5oA2RLJ; Wed, 10 Oct 2018 15:20:17 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 82B1A183C2C;
        Wed, 10 Oct 2018 15:20:16 -0400 (EDT)
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
Subject: [RFC PATCH for 4.21 14/16] cpu-opv/selftests: Provide basic percpu ops test
Date:   Wed, 10 Oct 2018 15:19:34 -0400
Message-Id: <20181010191936.7495-15-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"basic_percpu_ops_test" implements a few simple per-cpu operations and
testing their correctness.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
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
 .../selftests/cpu-opv/basic_percpu_ops_test.c      | 295 +++++++++++++++++++++
 1 file changed, 295 insertions(+)
 create mode 100644 tools/testing/selftests/cpu-opv/basic_percpu_ops_test.c

diff --git a/tools/testing/selftests/cpu-opv/basic_percpu_ops_test.c b/tools/testing/selftests/cpu-opv/basic_percpu_ops_test.c
new file mode 100644
index 000000000000..2ce5202f25b2
--- /dev/null
+++ b/tools/testing/selftests/cpu-opv/basic_percpu_ops_test.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stddef.h>
+
+#include "percpu-op.h"
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+struct percpu_lock_entry {
+	intptr_t v;
+} __attribute__((aligned(128)));
+
+struct percpu_lock {
+	struct percpu_lock_entry c[CPU_SETSIZE];
+};
+
+struct test_data_entry {
+	intptr_t count;
+} __attribute__((aligned(128)));
+
+struct spinlock_test_data {
+	struct percpu_lock lock;
+	struct test_data_entry c[CPU_SETSIZE];
+	int reps;
+};
+
+struct percpu_list_node {
+	intptr_t data;
+	struct percpu_list_node *next;
+};
+
+struct percpu_list_entry {
+	struct percpu_list_node *head;
+} __attribute__((aligned(128)));
+
+struct percpu_list {
+	struct percpu_list_entry c[CPU_SETSIZE];
+};
+
+/* A simple percpu spinlock. */
+void rseq_percpu_lock(struct percpu_lock *lock, int cpu)
+{
+	for (;;) {
+		int ret;
+
+		ret = percpu_cmpeqv_storev(&lock->c[cpu].v,
+					   0, 1, cpu);
+		if (rseq_likely(!ret))
+			break;
+		if (rseq_unlikely(ret < 0)) {
+			perror("cpu_opv");
+			abort();
+		}
+		/* Retry if comparison fails. */
+	}
+	/*
+	 * Acquire semantic when taking lock after control dependency.
+	 * Matches rseq_smp_store_release().
+	 */
+	rseq_smp_acquire__after_ctrl_dep();
+}
+
+void rseq_percpu_unlock(struct percpu_lock *lock, int cpu)
+{
+	assert(lock->c[cpu].v == 1);
+	/*
+	 * Release lock, with release semantic. Matches
+	 * rseq_smp_acquire__after_ctrl_dep().
+	 */
+	rseq_smp_store_release(&lock->c[cpu].v, 0);
+}
+
+void *test_percpu_spinlock_thread(void *arg)
+{
+	struct spinlock_test_data *data = arg;
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	for (i = 0; i < data->reps; i++) {
+		int cpu = percpu_current_cpu();
+
+		rseq_percpu_lock(&data->lock, cpu);
+		data->c[cpu].count++;
+		rseq_percpu_unlock(&data->lock, cpu);
+	}
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	return NULL;
+}
+
+/*
+ * A simple test which implements a sharded counter using a per-cpu
+ * lock.  Obviously real applications might prefer to simply use a
+ * per-cpu increment; however, this is reasonable for a test and the
+ * lock can be extended to synchronize more complicated operations.
+ */
+void test_percpu_spinlock(void)
+{
+	const int num_threads = 200;
+	int i;
+	uint64_t sum;
+	pthread_t test_threads[num_threads];
+	struct spinlock_test_data data;
+
+	memset(&data, 0, sizeof(data));
+	data.reps = 5000;
+
+	for (i = 0; i < num_threads; i++)
+		pthread_create(&test_threads[i], NULL,
+			       test_percpu_spinlock_thread, &data);
+
+	for (i = 0; i < num_threads; i++)
+		pthread_join(test_threads[i], NULL);
+
+	sum = 0;
+	for (i = 0; i < CPU_SETSIZE; i++)
+		sum += data.c[i].count;
+
+	assert(sum == (uint64_t)data.reps * num_threads);
+}
+
+int percpu_list_push(struct percpu_list *list, struct percpu_list_node *node,
+		     int cpu)
+{
+	for (;;) {
+		intptr_t *targetptr, newval, expect;
+		int ret;
+
+		/* Load list->c[cpu].head with single-copy atomicity. */
+		expect = (intptr_t)RSEQ_READ_ONCE(list->c[cpu].head);
+		newval = (intptr_t)node;
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		node->next = (struct percpu_list_node *)expect;
+		ret = percpu_cmpeqv_storev(targetptr, expect, newval, cpu);
+		if (rseq_likely(!ret))
+			break;
+		if (rseq_unlikely(ret < 0)) {
+			perror("cpu_opv");
+			abort();
+		}
+		/* Retry if comparison fails. */
+	}
+	return cpu;
+}
+
+/*
+ * Unlike a traditional lock-less linked list; the availability of a
+ * rseq primitive allows us to implement pop without concerns over
+ * ABA-type races.
+ */
+struct percpu_list_node *percpu_list_pop(struct percpu_list *list,
+					 int cpu)
+{
+	struct percpu_list_node *head;
+	intptr_t *targetptr, expectnot, *load;
+	off_t offset;
+	int ret;
+
+	targetptr = (intptr_t *)&list->c[cpu].head;
+	expectnot = (intptr_t)NULL;
+	offset = offsetof(struct percpu_list_node, next);
+	load = (intptr_t *)&head;
+	ret = percpu_cmpnev_storeoffp_load(targetptr, expectnot,
+					   offset, load, cpu);
+	if (rseq_unlikely(ret < 0)) {
+		perror("cpu_opv");
+		abort();
+	}
+	if (ret > 0)
+		return NULL;
+	return head;
+}
+
+void *test_percpu_list_thread(void *arg)
+{
+	int i;
+	struct percpu_list *list = (struct percpu_list *)arg;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	for (i = 0; i < 100000; i++) {
+		struct percpu_list_node *node;
+
+		node = percpu_list_pop(list, percpu_current_cpu());
+		sched_yield();  /* encourage shuffling */
+		if (node)
+			percpu_list_push(list, node, percpu_current_cpu());
+	}
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	return NULL;
+}
+
+/* Simultaneous modification to a per-cpu linked list from many threads.  */
+void test_percpu_list(void)
+{
+	int i, j;
+	uint64_t sum = 0, expected_sum = 0;
+	struct percpu_list list;
+	pthread_t test_threads[200];
+	cpu_set_t allowed_cpus;
+
+	memset(&list, 0, sizeof(list));
+
+	/* Generate list entries for every usable cpu. */
+	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+		for (j = 1; j <= 100; j++) {
+			struct percpu_list_node *node;
+
+			expected_sum += j;
+
+			node = malloc(sizeof(*node));
+			assert(node);
+			node->data = j;
+			node->next = list.c[i].head;
+			list.c[i].head = node;
+		}
+	}
+
+	for (i = 0; i < 200; i++)
+		pthread_create(&test_threads[i], NULL,
+		       test_percpu_list_thread, &list);
+
+	for (i = 0; i < 200; i++)
+		pthread_join(test_threads[i], NULL);
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_list_node *node;
+
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+
+		while ((node = percpu_list_pop(&list, i))) {
+			sum += node->data;
+			free(node);
+		}
+	}
+
+	/*
+	 * All entries should now be accounted for (unless some external
+	 * actor is interfering with our allowed affinity while this
+	 * test is running).
+	 */
+	assert(sum == expected_sum);
+}
+
+int main(int argc, char **argv)
+{
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	printf("spinlock\n");
+	test_percpu_spinlock();
+	printf("percpu_list\n");
+	test_percpu_list();
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	return 0;
+
+error:
+	return -1;
+}
+
-- 
2.11.0

