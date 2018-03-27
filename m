Return-Path: <kernel-hardening-return-12750-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsvbnEH+ioTVWt+mwZ91jC0I09FLxsJiW9myFwQpUNCTacqdsWqs4/HCtTxeT03+t7ZGqnV
ARC-Seal: i=1; a=rsa-sha256; t=1522115866; cv=none;
        d=google.com; s=arc-20160816;
        b=AvkAOm0hiPLyb8stI2OzvECVNB91kaAUk7ZHkyiYKPR941tPIwGZTiJsxwKHoWDq+O
         8pMtAUy4IEgN9q9VX3COTBuV8dUtqOWbNSDVtGkJDdoOffQ1UVRBkLs11SYBIv2/oH7B
         F03NqA5bxkNLKhp6gYgEjuo93URP+CFmcU1C0NirEnmHmKaELLP6hDb3IOmb2cwdEiYX
         wWDNIobEF2Y33Yr7IzfkG+B+kIFu404ur+8/mQG6pMW5whxu+7KCVxPrNbScdBZtnuHr
         keL0Fy3tPUOm+713uK+ehxatoep6KGM1vuVonOyihSgBAJCaeD4/LlMjrdEDE2YDigm8
         N29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=r+/dQbGqp28pibuoRjnpcP730sLxUhZuApp/+iHgoXc=;
        b=EBvsDdAFIxT0mP/i3kCQnzM9zldeE9tXTY/38ykj4i0D67Dge6tqSKfCD72P/yQ4zV
         W8845Fu6keW1iponW3SXUtIxQk/390uJUtoMLfnEHRz3XIsiVFbugEiVNzwTnpx3AYgF
         gJxyAVAQ/zKtYSf2olhmqLeeZTtXYoeXkKi+kJHE3V0iw7JmeFuuY7ZU3BSqPzkk+1OG
         6M+7eUT4lA5Er9+VnehRIhZLR6cv1orIs1YJUzsoD8ZGBI9tiG4w9XDt1bZFM9szSwLe
         sklae6IaYG2dZp/jaCvWHpZrj8YpNovZQiRl/9aC+0zfO0bInCi1fohWVHDkXCmC18lX
         qs+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12750-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12750-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12750-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12750-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>,
	<igor.stoppa@gmail.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 5/6] lkdtm: crash on overwriting protected pmalloc var
Date: Tue, 27 Mar 2018 04:55:23 +0300
Message-ID: <20180327015524.14318-6-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327015524.14318-1-igor.stoppa@huawei.com>
References: <20180327015524.14318-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596054166607017634?=
X-GMAIL-MSGID: =?utf-8?q?1596054166607017634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Verify that pmalloc read-only protection is in place: trying to
overwrite a protected variable will crash the kernel.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 drivers/misc/lkdtm.h       |  1 +
 drivers/misc/lkdtm_core.c  |  3 +++
 drivers/misc/lkdtm_perms.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/misc/lkdtm.h b/drivers/misc/lkdtm.h
index 9e513dcfd809..dcda3ae76ceb 100644
--- a/drivers/misc/lkdtm.h
+++ b/drivers/misc/lkdtm.h
@@ -38,6 +38,7 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void);
 void __init lkdtm_perms_init(void);
 void lkdtm_WRITE_RO(void);
 void lkdtm_WRITE_RO_AFTER_INIT(void);
+void lkdtm_WRITE_RO_PMALLOC(void);
 void lkdtm_WRITE_KERN(void);
 void lkdtm_EXEC_DATA(void);
 void lkdtm_EXEC_STACK(void);
diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index 2154d1bfd18b..c9fd42bda6ee 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -155,6 +155,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(ACCESS_USERSPACE),
 	CRASHTYPE(WRITE_RO),
 	CRASHTYPE(WRITE_RO_AFTER_INIT),
+#ifdef CONFIG_PROTECTABLE_MEMORY
+	CRASHTYPE(WRITE_RO_PMALLOC),
+#endif
 	CRASHTYPE(WRITE_KERN),
 	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
 	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
diff --git a/drivers/misc/lkdtm_perms.c b/drivers/misc/lkdtm_perms.c
index 53b85c9d16b8..0ac9023fd2b0 100644
--- a/drivers/misc/lkdtm_perms.c
+++ b/drivers/misc/lkdtm_perms.c
@@ -9,6 +9,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mman.h>
 #include <linux/uaccess.h>
+#include <linux/pmalloc.h>
 #include <asm/cacheflush.h>
 
 /* Whether or not to fill the target memory area with do_nothing(). */
@@ -104,6 +105,33 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 	*ptr ^= 0xabcd1234;
 }
 
+#ifdef CONFIG_PROTECTABLE_MEMORY
+void lkdtm_WRITE_RO_PMALLOC(void)
+{
+	struct gen_pool *pool;
+	int *i;
+
+	pool = pmalloc_create_pool("pool", 0);
+	if (unlikely(!pool)) {
+		pr_info("Failed preparing pool for pmalloc test.");
+		return;
+	}
+
+	i = (int *)pmalloc(pool, sizeof(int), GFP_KERNEL);
+	if (unlikely(!i)) {
+		pr_info("Failed allocating memory for pmalloc test.");
+		pmalloc_destroy_pool(pool);
+		return;
+	}
+
+	*i = INT_MAX;
+	pmalloc_protect_pool(pool);
+
+	pr_info("attempting bad pmalloc write at %p\n", i);
+	*i = 0;
+}
+#endif
+
 void lkdtm_WRITE_KERN(void)
 {
 	size_t size;
-- 
2.14.1
