Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDDAC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE48A2240E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HZpWrHFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE48A2240E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934090AbeFUVah (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:30:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933879AbeFUV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rhTeXBqlJbi6TwFnyRCNuWaY2Gfqwze39BCxvClSuWE=; b=HZpWrHFsF7vkV7R8xun6cbLiz
        z/dBv/3J+Mx9Tf0RhI7chVsbA7KABozmq3r7qJMgsJfIt7tnHHePYgboI6kZfnMoG+APFdlSOLqfo
        PU2KbjdOYpicBVLVjN6oJl8JGzacJR7t1Xk7rjWpKQZoA5zFrMYVWbV9TSF6TdPgzAMnGlBhiuZ2L
        KZegVCC+xs09mlLFEdmspKLproSiGvDQZoTpaqyZNV+7emQZfHim0ntSmQ9ALBM6bN3/N4Mrrhd8n
        8+GBLxzGhHZGOigvjEX+aiikmltv/DQAK19ZOBxStTAiVanKySfDJv5o4jDfCUcLWIISONelMkTLF
        aXRfewZHw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78g-0001cU-B4; Thu, 21 Jun 2018 21:29:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, Chris Mason <clm@fb.com>,
        Nick Terrell <terrelln@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 19/26] ida: Start new test_ida module
Date:   Thu, 21 Jun 2018 14:28:28 -0700
Message-Id: <20180621212835.5636-20-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start transitioning the IDA tests into kernel space.  Framework heavily
cribbed from test_xarray.c.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/Kconfig.debug                   |  3 +++
 lib/Makefile                        |  1 +
 lib/test_ida.c                      | 42 +++++++++++++++++++++++++++++
 tools/testing/radix-tree/Makefile   |  1 +
 tools/testing/radix-tree/idr-test.c | 22 ++++++++++++---
 tools/testing/radix-tree/main.c     |  3 +--
 tools/testing/radix-tree/test.h     |  3 +--
 7 files changed, 68 insertions(+), 7 deletions(-)
 create mode 100644 lib/test_ida.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d1158d19..2fff661d9070 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1827,6 +1827,9 @@ config TEST_HASH
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config TEST_IDA
+	tristate "Perform selftest on IDA functions"
+
 config TEST_PARMAN
 	tristate "Perform selftest on priority array manager"
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index 8153fdab287f..2ad90b716995 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_TEST_BPF) += test_bpf.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
+obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_TEST_KASAN) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
diff --git a/lib/test_ida.c b/lib/test_ida.c
new file mode 100644
index 000000000000..5a5a742d5f09
--- /dev/null
+++ b/lib/test_ida.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * test_ida.c: Test the IDA API
+ * Copyright (c) 2016-2018 Microsoft Corporation
+ * Copyright (c) 2018 Oracle Corporation
+ * Author: Matthew Wilcox <willy@infradead.org>
+ */
+
+static unsigned int tests_run;
+static unsigned int tests_passed;
+
+#ifdef __KERNEL__
+void ida_dump(struct ida *ida) { }
+#endif
+#define IDA_BUG_ON(ida, x) do {						\
+	tests_run++;							\
+	if (x) {							\
+		ida_dump(ida);						\
+		dump_stack();						\
+	} else {							\
+		tests_passed++;						\
+	}								\
+} while (0)
+
+static int ida_checks(void)
+{
+	DEFINE_IDA(ida);
+
+	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
+
+	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
+	return (tests_run != tests_passed) ? 0 : -EINVAL;
+}
+
+static void ida_exit(void)
+{
+}
+
+module_init(ida_checks);
+module_exit(ida_exit);
+MODULE_AUTHOR("Matthew Wilcox <willy@infradead.org>");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index db66f8a0d4be..b5a9db9e6a31 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -21,6 +21,7 @@ targets: generated/map-shift.h $(TARGETS)
 
 main:	$(OFILES)
 
+idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)
 
 multiorder: multiorder.o $(CORE_OFILES)
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index ee820fcc29b0..604b51dc9b38 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -309,6 +309,15 @@ void idr_checks(void)
 	idr_u32_test(0);
 }
 
+#define module_init(x)
+#define module_exit(x)
+#define MODULE_AUTHOR(x)
+#define MODULE_LICENSE(x)
+#define dump_stack()    assert(0)
+void ida_dump(struct ida *);
+
+#include "../../../lib/test_ida.c"
+
 /*
  * Check that we get the correct error when we run out of memory doing
  * allocations.  To ensure we run out of memory, just "forget" to preload.
@@ -488,7 +497,7 @@ void ida_simple_get_remove_test(void)
 	ida_destroy(&ida);
 }
 
-void ida_checks(void)
+void user_ida_checks(void)
 {
 	DEFINE_IDA(ida);
 	int id;
@@ -582,12 +591,19 @@ void ida_thread_tests(void)
 		pthread_join(threads[i], NULL);
 }
 
+void ida_tests(void)
+{
+	user_ida_checks();
+	ida_checks();
+	ida_exit();
+	ida_thread_tests();
+}
+
 int __weak main(void)
 {
 	radix_tree_init();
 	idr_checks();
-	ida_checks();
-	ida_thread_tests();
+	ida_tests();
 	radix_tree_cpu_dead(1);
 	rcu_barrier();
 	if (nr_allocated)
diff --git a/tools/testing/radix-tree/main.c b/tools/testing/radix-tree/main.c
index 257f3f8aacaa..c69a49b825aa 100644
--- a/tools/testing/radix-tree/main.c
+++ b/tools/testing/radix-tree/main.c
@@ -322,7 +322,7 @@ static void single_thread_tests(bool long_run)
 	printv(2, "after dynamic_height_check: %d allocated, preempt %d\n",
 		nr_allocated, preempt_count);
 	idr_checks();
-	ida_checks();
+	ida_tests();
 	rcu_barrier();
 	printv(2, "after idr_checks: %d allocated, preempt %d\n",
 		nr_allocated, preempt_count);
@@ -369,7 +369,6 @@ int main(int argc, char **argv)
 	iteration_test(0, 10 + 90 * long_run);
 	iteration_test(7, 10 + 90 * long_run);
 	single_thread_tests(long_run);
-	ida_thread_tests();
 
 	/* Free any remaining preallocated nodes */
 	radix_tree_cpu_dead(0);
diff --git a/tools/testing/radix-tree/test.h b/tools/testing/radix-tree/test.h
index 31f1d9b6f506..92d901eacf49 100644
--- a/tools/testing/radix-tree/test.h
+++ b/tools/testing/radix-tree/test.h
@@ -39,8 +39,7 @@ void multiorder_checks(void);
 void iteration_test(unsigned order, unsigned duration);
 void benchmark(void);
 void idr_checks(void);
-void ida_checks(void);
-void ida_thread_tests(void);
+void ida_tests(void);
 
 struct item *
 item_tag_set(struct radix_tree_root *root, unsigned long index, int tag);
-- 
2.17.1

