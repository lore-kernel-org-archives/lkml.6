Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9659205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9659205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJQAwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:52:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:15637 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeJQAwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:52:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="100736193"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2018 10:00:56 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 4/7] selftests/resctrl: Add built in benchmark
Date:   Tue, 16 Oct 2018 09:56:38 -0700
Message-Id: <1539709001-38018-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Built-in benchmark fill_buf generates stressful memory bandwidth
and cache traffic.

Later it will be used as a default benchmark by various resctrl tests
such as MBA (Memory Bandwidth Allocation) and MBM (Memory Bandwidth
Monitoring) tests.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 178 +++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
new file mode 100644
index 000000000000..a94d1e83a736
--- /dev/null
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fill_buf benchmark
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <inttypes.h>
+#include <malloc.h>
+#include <string.h>
+
+#include "resctrl.h"
+
+#define CL_SIZE			(64)
+#define PAGE_SIZE		(4 * 1024)
+#define MB			(1024 * 1024)
+
+static unsigned char *startptr;
+
+static void sb(void)
+{
+	asm volatile("sfence\n\t"
+		     : : : "memory");
+}
+
+static void ctrl_handler(int signo)
+{
+	free(startptr);
+	printf("\nEnding\n");
+	sb();
+	exit(EXIT_SUCCESS);
+}
+
+static void cl_flush(void *p)
+{
+	asm volatile("clflush (%0)\n\t"
+		     : : "r"(p) : "memory");
+}
+
+static void mem_flush(void *p, size_t s)
+{
+	char *cp = (char *)p;
+	size_t i = 0;
+
+	s = s / CL_SIZE; /* mem size in cache llines */
+
+	for (i = 0; i < s; i++)
+		cl_flush(&cp[i * CL_SIZE]);
+
+	sb();
+}
+
+static void *malloc_and_init_memory(size_t s)
+{
+	uint64_t *p64;
+	size_t s64;
+
+	void *p = memalign(PAGE_SIZE, s);
+
+	p64 = (uint64_t *)p;
+	s64 = s / sizeof(uint64_t);
+
+	while (s64 > 0) {
+		*p64 = (uint64_t) rand();
+		p64 += (CL_SIZE / sizeof(uint64_t));
+		s64 -= (CL_SIZE / sizeof(uint64_t));
+	}
+
+	return p;
+}
+
+static void fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr)
+{
+	while (1) {
+		unsigned char sum, *p;
+
+		p = start_ptr;
+		/* Read two chars in each cache line to stress cache */
+		while (p < (end_ptr - 1024)) {
+			sum += p[0] + p[32] + p[64] + p[96] + p[128] +
+			       p[160] + p[192] + p[224] + p[256] + p[288] +
+			       p[320] + p[352] + p[384] + p[416] + p[448] +
+			       p[480] + p[512] + p[544] + p[576] + p[608] +
+			       p[640] + p[672] + p[704] + p[736] + p[768] +
+			       p[800] + p[832] + p[864] + p[896] + p[928] +
+			       p[960] + p[992];
+			p += 1024;
+		}
+	}
+}
+
+static void fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr)
+{
+	while (1) {
+		while (start_ptr < end_ptr) {
+			*start_ptr = '1';
+			start_ptr += (CL_SIZE / 2);
+		}
+		start_ptr = startptr;
+	}
+}
+
+static void
+fill_cache(unsigned long long buf_size, int malloc_and_init,
+	   int memflush, int op)
+{
+	unsigned char *start_ptr, *end_ptr;
+	unsigned long long i;
+
+	if (malloc_and_init) {
+		start_ptr = malloc_and_init_memory(buf_size);
+		printf("Started benchmark with memalign\n");
+	} else {
+		start_ptr = malloc(buf_size);
+		printf("Started benchmark with malloc\n");
+	}
+
+	if (start_ptr == NULL)
+		return;
+
+	startptr = start_ptr;
+	end_ptr = start_ptr + buf_size;
+
+	/*
+	 * It's better to touch the memory once to avoid any compiler
+	 * optimizations
+	 */
+	if (!malloc_and_init) {
+		for (i = 0; i < buf_size; i++)
+			*start_ptr++ = (unsigned char)rand();
+	}
+
+	start_ptr = startptr;
+
+	/* Flush the memory before using to avoid "cache hot pages" effect */
+	if (memflush) {
+		mem_flush(start_ptr, buf_size);
+		printf("Started benchmark with memflush\n");
+	} else {
+		printf("Started benchmark *without* memflush\n");
+	}
+
+	if (op == 0)
+		fill_cache_read(start_ptr, end_ptr);
+	else
+		fill_cache_write(start_ptr, end_ptr);
+
+	free(startptr);
+
+	exit(EXIT_FAILURE);
+}
+
+int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int op)
+{
+	unsigned long long cache_size = span * MB;
+
+	/* set up ctrl-c handler */
+	if (signal(SIGINT, ctrl_handler) == SIG_ERR)
+		printf("Failed to catch SIGINT!\n");
+	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
+		printf("Failed to catch SIGHUP!\n");
+
+	printf("Cache size in Bytes = %llu\n", cache_size);
+
+	fill_cache(cache_size, malloc_and_init_memory, memflush, op);
+	printf("Unable to allocate memory\n");
+
+	exit(EXIT_FAILURE);
+}
-- 
2.5.0

