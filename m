Return-Path: <kernel-hardening-return-12991-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4++msM/6AW6h+WNEZaS7IWTZPSsdxRXaMIdF3gXJ/QBFiAWAl+LcocciciFWZl7w1NPskBk
ARC-Seal: i=1; a=rsa-sha256; t=1523627056; cv=none;
        d=google.com; s=arc-20160816;
        b=gR+eplEB9O9mci57npkzyy+d/3HCBquhGtzlMJ3rLZChwCahgtxMoVRsjwOY9X7jZI
         62Twz/NXksAbbgJQNniQwmNnF2bcMIsGpKeQzpZlpccK2dUO9uxOtCEZBuabOkYER0SB
         Tp9M49TpV3nPLi5vc4w3UbZaLUy74/8rRc1FhPFIpSj6NJJI4XbNmRoOff/vZC8UWpak
         qJ5PxWtW66v32nSbQkk9Bb0lYQksV3P1laAc7CNylrfV8VapC862Z4pRsyVzMIGsD8g3
         5uVnDkGviIynJoeVSNOXr5bm4Yn286+v/In8HnbM4S3HZ5ONdRpGoPmlSpMMowY/s169
         oC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=07XywjeaHFrDXVbl8LnLF2bNdgKv2lnLYdnvTw1+COw=;
        b=o900k9DENKMbOXR8jOloVJovW0+1KM7a/fLmgc5Ugkacz+HsmbPive+vLeAriCXbbx
         f4q6uNhOHBsU4akJkNykVqe23oXZ1wxSyzVdxsi/icLk377Vxt4phF0M0a9le7YOc548
         WSfzL7s2rSY0yXdXgOxr2cheQgX9Qxpv/wCxtEQZ9U67ddhxIOkV+JyIdGFw/jH5iwfm
         mqlQm2Qn0gHv5O8wpYu+52YVWupz8Ialdu6ZL2vpvVg3QCKwwT0hCpOWoi7PQHMYpAJK
         GeAq9dDymoEMI1VNUZu9CDEmsClxz+XiLhsbHKkftR0QvPG/xCjQ+PkxDMUS+sqPzgof
         ppJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BP9R5XlF;
       spf=pass (google.com: domain of kernel-hardening-return-12991-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12991-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BP9R5XlF;
       spf=pass (google.com: domain of kernel-hardening-return-12991-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12991-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 6/6] lkdtm: crash on overwriting protected pmalloc var
Date: Fri, 13 Apr 2018 17:41:31 +0400
Message-Id: <20180413134131.4651-7-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180413134131.4651-1-igor.stoppa@huawei.com>
References: <20180413134131.4651-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638764671049586?=
X-GMAIL-MSGID: =?utf-8?q?1597638764671049586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Verify that pmalloc read-only protection is in place: trying to
overwrite a protected variable will crash the kernel.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 drivers/misc/lkdtm/core.c  |  3 +++
 drivers/misc/lkdtm/lkdtm.h |  1 +
 drivers/misc/lkdtm/perms.c | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2154d1bfd18b..c9fd42bda6ee 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
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
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 9e513dcfd809..dcda3ae76ceb 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -38,6 +38,7 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void);
 void __init lkdtm_perms_init(void);
 void lkdtm_WRITE_RO(void);
 void lkdtm_WRITE_RO_AFTER_INIT(void);
+void lkdtm_WRITE_RO_PMALLOC(void);
 void lkdtm_WRITE_KERN(void);
 void lkdtm_EXEC_DATA(void);
 void lkdtm_EXEC_STACK(void);
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 53b85c9d16b8..4660ff0bfa44 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -9,6 +9,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mman.h>
 #include <linux/uaccess.h>
+#include <linux/pmalloc.h>
 #include <asm/cacheflush.h>
 
 /* Whether or not to fill the target memory area with do_nothing(). */
@@ -104,6 +105,30 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 	*ptr ^= 0xabcd1234;
 }
 
+#ifdef CONFIG_PROTECTABLE_MEMORY
+void lkdtm_WRITE_RO_PMALLOC(void)
+{
+	struct pmalloc_pool *pool;
+	int *i;
+
+	pool = pmalloc_create_pool();
+	if (WARN(!pool, "Failed preparing pool for pmalloc test."))
+		return;
+
+	i = (int *)pmalloc(pool, sizeof(int));
+	if (WARN(!i, "Failed allocating memory for pmalloc test.")) {
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
