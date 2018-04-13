Return-Path: <kernel-hardening-return-12990-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+tVgae7e8IY9SnYusKv6YrK0dRzZgzcjquco5hKwQiohibinJNfb+n+bYvD0Na0sGQuLN5
ARC-Seal: i=1; a=rsa-sha256; t=1523627047; cv=none;
        d=google.com; s=arc-20160816;
        b=wLLvePEXkUjCq+dOWm5iJV+qS19abEFGKW/sb63PCNxy3Y1OTcXC9AT//aLtoJfVjk
         pPzM0Fys+B1i5pPHICs/hyfl1aZum4k4UtqXKnToiCmQ/SXOvgG3NRDQbRfGvq8Y5OtE
         A471K9aeugtwDrcNLMSjkcSYVOXPWbahQh+Lik/fg8lZS7spEZvClnlrR6ICl/grajfT
         CLcCxppCIe5Zx/bMU3AntsSMYclpOQk4WaKYOUbQaLPU4KuTND0EOovVhBka9dTP8le/
         C9kGIwhOGR0b3Z3e7Y/kXvJTX0rFZk1B4hrq3XhL1+MxnCO1htDB9HNaNU00eMfTdN4q
         upQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=gU1q5AL2YTeMdJiI2RT0RJnEZzj0Bh+10bhgrIzCaBk=;
        b=gQ2Cyd93cx8bMRp6ArdO9lpcorq/LDmkg+omxjqfO62Tt8uXQU9uZYNE0LPlzNXIXP
         VQkg06pLeYwv4P9HeA5s1L7zPkM+AyrGgTgriTabvfkDg061sZSlGUEgKkqp1FiOQwVu
         L8emES5DwObICopzXoXnM7y5jDNvCvvuhe48qlA/FBU8mvUE/uKb9HULRnI32cuNz1lX
         uRc7W69p1FTnYaA67vmfPGfP7EieAv8278SQDiX7PDWsxwJIRTOY1G1r+aZvh32YMHDe
         Jtd5vsusH+ysh6IZHJPlxVe7ti5XNEW0foYZvfKR/YNhdbRrnDG7ph2UvZpUsRARclq/
         qLTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mOL3UI+T;
       spf=pass (google.com: domain of kernel-hardening-return-12990-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12990-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mOL3UI+T;
       spf=pass (google.com: domain of kernel-hardening-return-12990-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12990-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To: willy@infradead.org,
	keescook@chromium.org,
	mhocko@kernel.org,
	corbet@lwn.net
Cc: david@fromorbit.com,
	rppt@linux.vnet.ibm.com,
	labbott@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 5/6] Pmalloc selftest
Date: Fri, 13 Apr 2018 17:41:30 +0400
Message-Id: <20180413134131.4651-6-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180413134131.4651-1-igor.stoppa@huawei.com>
References: <20180413134131.4651-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638755218012576?=
X-GMAIL-MSGID: =?utf-8?q?1597638755218012576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add basic self-test functionality for pmalloc.

The testing is introduced as early as possible, right after the main
dependency, genalloc, has passed successfully, so that it can help
diagnosing failures in pmalloc users.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 include/linux/test_pmalloc.h |  24 ++++++++
 init/main.c                  |   2 +
 mm/Kconfig                   |  10 ++++
 mm/Makefile                  |   1 +
 mm/test_pmalloc.c            | 137 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 174 insertions(+)
 create mode 100644 include/linux/test_pmalloc.h
 create mode 100644 mm/test_pmalloc.c

diff --git a/include/linux/test_pmalloc.h b/include/linux/test_pmalloc.h
new file mode 100644
index 000000000000..c7e2e451c17c
--- /dev/null
+++ b/include/linux/test_pmalloc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * test_pmalloc.h
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+
+#ifndef __LINUX_TEST_PMALLOC_H
+#define __LINUX_TEST_PMALLOC_H
+
+
+#ifdef CONFIG_TEST_PROTECTABLE_MEMORY
+
+void test_pmalloc(void);
+
+#else
+
+static inline void test_pmalloc(void){};
+
+#endif
+
+#endif
diff --git a/init/main.c b/init/main.c
index b795aa341a3a..27f8479c4578 100644
--- a/init/main.c
+++ b/init/main.c
@@ -91,6 +91,7 @@
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
+#include <linux/test_pmalloc.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -679,6 +680,7 @@ asmlinkage __visible void __init start_kernel(void)
 	 */
 	mem_encrypt_init();
 
+	test_pmalloc();
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 	    page_to_pfn(virt_to_page((void *)initrd_start)) < min_low_pfn) {
diff --git a/mm/Kconfig b/mm/Kconfig
index d7ef40eaa4e8..f98b4c0aebce 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -758,3 +758,13 @@ config PROTECTABLE_MEMORY
     depends on MMU
     depends on ARCH_HAS_SET_MEMORY
     default y
+
+config TEST_PROTECTABLE_MEMORY
+	bool "Run self test for pmalloc memory allocator"
+        depends on MMU
+	depends on ARCH_HAS_SET_MEMORY
+	select PROTECTABLE_MEMORY
+	default n
+	help
+	  Tries to verify that pmalloc works correctly and that the memory
+	  is effectively protected.
diff --git a/mm/Makefile b/mm/Makefile
index 6a6668f99799..802cba37013b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_PROTECTABLE_MEMORY) += pmalloc.o
+obj-$(CONFIG_TEST_PROTECTABLE_MEMORY) += test_pmalloc.o
 obj-$(CONFIG_KSM) += ksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_SLAB) += slab.o
diff --git a/mm/test_pmalloc.c b/mm/test_pmalloc.c
new file mode 100644
index 000000000000..b0e091bf6329
--- /dev/null
+++ b/mm/test_pmalloc.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * test_pmalloc.c
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+#include <linux/pmalloc.h>
+#include <linux/mm.h>
+#include <linux/test_pmalloc.h>
+#include <linux/bug.h>
+
+#define SIZE_1 (PAGE_SIZE * 3)
+#define SIZE_2 1000
+
+
+/* wrapper for is_pmalloc_object() with messages */
+static inline bool validate_alloc(bool expected, void *addr,
+				  unsigned long size)
+{
+	bool test;
+
+	test = is_pmalloc_object(addr, size) > 0;
+	pr_notice("must be %s: %s",
+		  expected ? "ok" : "no", test ? "ok" : "no");
+	return test == expected;
+}
+
+
+#define is_alloc_ok(variable, size)	\
+	validate_alloc(true, variable, size)
+
+
+#define is_alloc_no(variable, size)	\
+	validate_alloc(false, variable, size)
+
+/* tests the basic life-cycle of a pool */
+static bool create_and_destroy_pool(void)
+{
+	static struct pmalloc_pool *pool;
+
+	pr_notice("Testing pool creation and destruction capability");
+
+	pool = pmalloc_create_pool();
+	if (WARN(!pool, "Cannot allocate memory for pmalloc selftest."))
+		return false;
+	pmalloc_destroy_pool(pool);
+	return true;
+}
+
+
+/*  verifies that it's possible to allocate from the pool */
+static bool test_alloc(void)
+{
+	static struct pmalloc_pool *pool;
+	static void *p;
+
+	pr_notice("Testing allocation capability");
+	pool = pmalloc_create_pool();
+	if (WARN(!pool, "Unable to allocate memory for pmalloc selftest."))
+		return false;
+	p = pmalloc(pool,  SIZE_1 - 1);
+	pmalloc_protect_pool(pool);
+	pmalloc_destroy_pool(pool);
+	if (WARN(!p, "Failed to allocate memory from the pool"))
+		return false;
+	return true;
+}
+
+
+/* tests the identification of pmalloc ranges */
+static bool test_is_pmalloc_object(void)
+{
+	struct pmalloc_pool *pool;
+	void *pmalloc_p;
+	void *vmalloc_p;
+	bool retval = false;
+
+	pr_notice("Test correctness of is_pmalloc_object()");
+
+	vmalloc_p = vmalloc(SIZE_1);
+	if (WARN(!vmalloc_p,
+		 "Unable to allocate memory for pmalloc selftest."))
+		return false;
+	pool = pmalloc_create_pool();
+	if (WARN(!pool, "Unable to allocate memory for pmalloc selftest."))
+		return false;
+	pmalloc_p = pmalloc(pool,  SIZE_1 - 1);
+	if (WARN(!pmalloc_p, "Failed to allocate memory from the pool"))
+		goto error;
+	if (WARN_ON(unlikely(!is_alloc_ok(pmalloc_p, 10))) ||
+	    WARN_ON(unlikely(!is_alloc_ok(pmalloc_p, SIZE_1))) ||
+	    WARN_ON(unlikely(!is_alloc_ok(pmalloc_p, PAGE_SIZE))) ||
+	    WARN_ON(unlikely(!is_alloc_no(pmalloc_p, SIZE_1 + 1))) ||
+	    WARN_ON(unlikely(!is_alloc_no(vmalloc_p, 10))))
+		goto error;
+	retval = true;
+error:
+	pmalloc_protect_pool(pool);
+	pmalloc_destroy_pool(pool);
+	vfree(vmalloc_p);
+	return retval;
+}
+
+/* Test out of virtually contiguous memory */
+static void test_oovm(void)
+{
+	struct pmalloc_pool *pool;
+	unsigned int i;
+
+	pr_notice("Exhaust vmalloc memory with doubling allocations.");
+	pool = pmalloc_create_pool();
+	if (WARN(!pool, "Failed to create pool"))
+		return;
+	for (i = 1; i; i *= 2)
+		if (unlikely(!pzalloc(pool, i - 1)))
+			break;
+	pr_notice("vmalloc oom at %d allocation", i - 1);
+	pmalloc_protect_pool(pool);
+	pmalloc_destroy_pool(pool);
+}
+
+/**
+ * test_pmalloc()  -main entry point for running the test cases
+ */
+void test_pmalloc(void)
+{
+
+	pr_notice("pmalloc-selftest");
+
+	if (unlikely(!(create_and_destroy_pool() &&
+		       test_alloc() &&
+		       test_is_pmalloc_object())))
+		return;
+	test_oovm();
+}
-- 
2.14.1
