Return-Path: <kernel-hardening-return-11701-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227/WZ9GYLfmJRYP0No+T07/33PHZOZiFGZKwbYvJCUIzae7D3lwBHaNrJLaaJ7ui6xaVhsS
ARC-Seal: i=1; a=rsa-sha256; t=1518319371; cv=none;
        d=google.com; s=arc-20160816;
        b=nDvA6cOQi6Tj+kWyy4prjidzdmgX1otVCojrWDPA6K7gsdzBfprHYTFHHJwEBUKVgI
         Md9TK5quOeTu0MA+5mGbLa4S8SRjCCPVv0esThcx20Hw/7ZPGkQNOBh78IlsmutSN/p4
         6TpQlH0y7olIoihdTnRXRxaEVOQTf5UvDut7EZCWcbNDCz5WMtCOg+VAwMDSfMALVuhR
         SMhcSZASztVunlh21r5V0jDPwY40hnIBLWjDu2QE5psmQrrZkP7xeQbO/wcocQZfQZbR
         59+GPzi4NZu6q7l3LVhHEes++zBH2ULPlOtr0C9Qe2IastIMv0aCccYv/+NBCBvGLuR6
         zTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=shQOJj/GlMjcHILefHz2LdfZ7FSIbWF6xOovWvItmZ0=;
        b=wK8UGmV033bv/+9MCdsSUWOAe5FOY+uWGgEqlIXsKhE7UrsZPgYgvz+0apO34pJ8Du
         3pob0BlzH+rr0WHeBPfsP5CBLSYu+UxnF+BmLzzAnnZN+4iXm2aYpmDwSnDGZ/6uJ/8Z
         BO7/9xHNbvAoGK3wxhXBsCLazyJ1rpNWx6XAiGmzK1+u41DPWiK0odjGBHcG4Si/uCy1
         hLedVSBXdtzRN6xSah0giv6YGLAIGmSnTrpfKoTnZYV3lJwyCuDecJkqH/9zafgwi+GL
         WtMUhRw2rR17nLtpGzDqSup0Rz4lyoNkIWWq7iFRvzPdV6dAlco7RxayR/7qUEuQhXCh
         wGMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11701-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11701-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11701-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11701-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <willy@infradead.org>, <rdunlap@infradead.org>, <corbet@lwn.net>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<jglisse@redhat.com>, <hch@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 5/6] Pmalloc: self-test
Date: Sun, 11 Feb 2018 05:19:19 +0200
Message-ID: <20180211031920.3424-6-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180211031920.3424-1-igor.stoppa@huawei.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490615808474286?=
X-GMAIL-MSGID: =?utf-8?q?1592073253053250248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add basic self-test functionality for pmalloc.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 mm/Kconfig            |  9 ++++++++
 mm/Makefile           |  1 +
 mm/pmalloc-selftest.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/pmalloc-selftest.h | 24 ++++++++++++++++++++
 mm/pmalloc.c          |  2 ++
 5 files changed, 99 insertions(+)
 create mode 100644 mm/pmalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.h

diff --git a/mm/Kconfig b/mm/Kconfig
index be578fbdce6d..098aefef78b1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -766,3 +766,12 @@ config PROTECTABLE_MEMORY
     depends on ARCH_HAS_SET_MEMORY
     select GENERIC_ALLOCATOR
     default y
+
+config PROTECTABLE_MEMORY_SELFTEST
+	bool "Run self test for pmalloc memory allocator"
+	depends on ARCH_HAS_SET_MEMORY
+	select PROTECTABLE_MEMORY
+	default n
+	help
+	  Tries to verify that pmalloc works correctly and that the memory
+	  is effectively protected.
diff --git a/mm/Makefile b/mm/Makefile
index 959fdbdac118..f7bbbfde6967 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_PROTECTABLE_MEMORY) += pmalloc.o
+obj-$(CONFIG_PROTECTABLE_MEMORY_SELFTEST) += pmalloc-selftest.o
 obj-$(CONFIG_KSM) += ksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_SLAB) += slab.o
diff --git a/mm/pmalloc-selftest.c b/mm/pmalloc-selftest.c
new file mode 100644
index 000000000000..05acd62d23ec
--- /dev/null
+++ b/mm/pmalloc-selftest.c
@@ -0,0 +1,63 @@
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
+#include "pmalloc-selftest.h"
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
+	*(int *)var_prot = 0;
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
index 000000000000..63e430de74f8
--- /dev/null
+++ b/mm/pmalloc-selftest.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * pmalloc-selftest.h
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+
+#ifndef __MM_PMALLOC_SELFTEST_H
+#define __MM_PMALLOC_SELFTEST_H
+
+
+#ifdef CONFIG_PROTECTABLE_MEMORY_SELFTEST
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
diff --git a/mm/pmalloc.c b/mm/pmalloc.c
index e94bfb407c92..c9a472730afc 100644
--- a/mm/pmalloc.c
+++ b/mm/pmalloc.c
@@ -22,6 +22,7 @@
 #include <asm/page.h>
 
 #include <linux/pmalloc.h>
+#include "pmalloc-selftest.h"
 /*
  * pmalloc_data contains the data specific to a pmalloc pool,
  * in a format compatible with the design of gen_alloc.
@@ -492,6 +493,7 @@ static int __init pmalloc_late_init(void)
 		}
 	}
 	mutex_unlock(&pmalloc_mutex);
+	pmalloc_selftest();
 	return 0;
 }
 late_initcall(pmalloc_late_init);
-- 
2.14.1
