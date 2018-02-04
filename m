Return-Path: <kernel-hardening-return-11578-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227I8Ln2HWpQ+/VSIADzTFsqkH2L7ViG1xIe+XnK4/dfT2aVDalZiIdD0a4MfRDeloQSXCL/
ARC-Seal: i=1; a=rsa-sha256; t=1517763725; cv=none;
        d=google.com; s=arc-20160816;
        b=Nya78i0x+ppGg6G82hmppvZnaNxZh6cPehwbWvln94aEu+vbdlBWJVQ24stzRzOIVC
         vFQrAwnDf5Z/M1VZfntxvtZX92IyCEL6NqAznH91GqeUO4GLt2j/6ySBofmN6HiCy2q4
         x9NAKTPmwoUREjnyImOFWYQ4rCsCE9XA/Aylo5jP0LwEq34iAh/sYNvSZ/Iug0zP+zh4
         5+zaUhmA3qaMmp5xEZr3I9bDJtf0UarVK+nuj6lCUUwLkoiJEVndNI8Cb86goC86okKy
         XW0gnhJMz1TQlwLpz5B3YKIIKnQ9ie0wm6yt8sTpwVEV5xWWjD4ffIIcLB1qMMRRESpm
         NrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=3Z0fIf7i8pRpbN1/RnXdljP9nReWzU+MFMZMwD6YkeA=;
        b=Zpbhzf6U7KLD+ItQeyGfYsSJrRyyJkBNJ91MBdtTB/7BG9AqpAz8vVRY78COlzZG+p
         hJkhG+TCrcvwKw+uN7/59pMaF707jgw+cI0jCIGJrdxqI4r4qemfk3LKu0DWJLbcbVE/
         osL0+op7CVPhhMpBquyUx4ONSl6fC+wVo0Jc65c8SN6mgA5Kqlfh3pTBtBmiNmZOuv7Y
         SAieBAjUBMiW0nOnEyGQ5u7Dl49ztpT4/bMO7PfEj5p7hSxt8czpOD/DpSsu1g5xTfp8
         bIa2TaOTqTyWU7KcnJ417mNtPRI13IWrkh8gsslKnUqHJWAn4IQfYrq33frlYIuCTFbc
         vhLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11578-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11578-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11578-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11578-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <willy@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 5/6] Pmalloc: self-test
Date: Sun, 4 Feb 2018 19:00:55 +0200
Message-ID: <20180204170056.28772-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180204164732.28241-1-igor.stoppa@huawei.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490615808474286?=
X-GMAIL-MSGID: =?utf-8?q?1591490615808474286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add basic self-test functionality for pmalloc.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 mm/Kconfig            |  9 ++++++++
 mm/Makefile           |  1 +
 mm/pmalloc-selftest.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/pmalloc-selftest.h | 26 ++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 mm/pmalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.h

diff --git a/mm/Kconfig b/mm/Kconfig
index 03ff7703d322..f5edfadd036a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -765,3 +765,12 @@ config GUP_BENCHMARK
 	  performance of get_user_pages_fast().
 
 	  See tools/testing/selftests/vm/gup_benchmark.c
+
+config PROTECTABLE_MEMORY_SELFTEST
+	bool "Run self test for pmalloc memory allocator"
+	depends on ARCH_HAS_SET_MEMORY
+	select GENERIC_ALLOCATOR
+	default n
+	help
+	  Tries to verify that pmalloc works correctly and that the memory
+	  is effectively protected.
diff --git a/mm/Makefile b/mm/Makefile
index a6a47e1b6e66..1e76a9b96180 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_ARCH_HAS_SET_MEMORY) += pmalloc.o
+obj-$(CONFIG_PROTECTABLE_MEMORY_SELFTEST) += pmalloc-selftest.o
 obj-$(CONFIG_KSM) += ksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_SLAB) += slab.o
diff --git a/mm/pmalloc-selftest.c b/mm/pmalloc-selftest.c
new file mode 100644
index 000000000000..9f6401ebd8d1
--- /dev/null
+++ b/mm/pmalloc-selftest.c
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * pmalloc-selftest.c
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+#include <linux/pmalloc.h>
+#include <linux/mm.h>
+
+
+#define SIZE_1 (PAGE_SIZE * 3)
+#define SIZE_2 1000
+
+#define validate_alloc(expected, variable, size)	\
+	pr_notice("must be " expected ": %s",		\
+		  is_pmalloc_object(variable, size) > 0 ? "ok" : "no")
+
+#define is_alloc_ok(variable, size)	\
+	validate_alloc("ok", variable, size)
+
+#define is_alloc_no(variable, size)	\
+	validate_alloc("no", variable, size)
+
+void pmalloc_selftest(void)
+{
+	struct gen_pool *pool_unprot;
+	struct gen_pool *pool_prot;
+	void *var_prot, *var_unprot, *var_vmall;
+
+	pr_notice("pmalloc self-test");
+	pool_unprot = pmalloc_create_pool("unprotected", 0);
+	pool_prot = pmalloc_create_pool("protected", 0);
+	BUG_ON(!(pool_unprot && pool_prot));
+
+	var_unprot = pmalloc(pool_unprot,  SIZE_1 - 1, GFP_KERNEL);
+	var_prot = pmalloc(pool_prot,  SIZE_1, GFP_KERNEL);
+	var_vmall = vmalloc(SIZE_2);
+	is_alloc_ok(var_unprot, 10);
+	is_alloc_ok(var_unprot, SIZE_1);
+	is_alloc_ok(var_unprot, PAGE_SIZE);
+	is_alloc_no(var_unprot, SIZE_1 + 1);
+	is_alloc_no(var_vmall, 10);
+
+
+	pfree(pool_unprot, var_unprot);
+	vfree(var_vmall);
+
+	pmalloc_protect_pool(pool_prot);
+
+	/* This will intentionally trigger a WARN because the pool being
+	 * destroyed is not protected, which is unusual and should happen
+	 * on error paths only, where probably other warnings are already
+	 * displayed.
+	 */
+	pmalloc_destroy_pool(pool_unprot);
+
+	/* This must not cause WARNings */
+	pmalloc_destroy_pool(pool_prot);
+}
diff --git a/mm/pmalloc-selftest.h b/mm/pmalloc-selftest.h
new file mode 100644
index 000000000000..b34ac86e14a8
--- /dev/null
+++ b/mm/pmalloc-selftest.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * pmalloc-selftest.h
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+
+#ifndef __PMALLOC_SELFTEST_H__
+#define __PMALLOC_SELFTEST_H__
+
+
+#ifdef CONFIG_PROTECTABLE_MEMORY_SELFTEST
+
+#include <linux/pmalloc.h>
+
+void pmalloc_selftest(void);
+
+#else
+
+static inline void pmalloc_selftest(void){};
+
+#endif
+
+#endif
-- 
2.16.0
