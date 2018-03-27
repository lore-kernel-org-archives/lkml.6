Return-Path: <kernel-hardening-return-12771-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49IroDfAg3aG9nmuHGrYyJrTn4VIuQAkZ6UbD83vNq86a0575WC0tmtfJgKOgVC08CPotb6
ARC-Seal: i=1; a=rsa-sha256; t=1522165335; cv=none;
        d=google.com; s=arc-20160816;
        b=jFFQl2CABZ6u8fT5PPKx4gtEOEZaJ5wpkRkzKh3LQnY36dZqf7XiuJl4ZWOfJ9bTmD
         LSKdm1umGt0LoH7ziTTk56b636NtMP56ksXS8liwkJLh8WPQtDLvy8OuNNd22z8gvFyk
         dbc7hbMDTJZDyacT4IaruZhvhA8D+tx2IzlMuhw8XMOSN6IDLhoeBIy0iG6IFHov1sF9
         cv4IV2wuLEvHK8171zQFk3QeZoR2c8u+ut41C22DNni6I4pTGd4Cpv35DUHtpixxJ+u5
         WgGH1Y5unpyf6fgL3JVVsD/KhG7Y4e5tl4SCGejfmglg+oZh8ZAKPb5kqablO5G4zCyW
         rFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Ag1Atgnn0TdpM19/OWk9ZZoQ4A335k5sZgMog3Xy/y0=;
        b=pvdqx7t9Gi/ZnaVPIY8HV9ONVNWLqEskm6tKngaZypgiwlWCS5OBkiMUPRK2hY20Rh
         E3giiCfBN2Ydbpvgrf1fxbrXC9gu9daF7zZfw3SltgI7d5ghcR8ptlesxsl1KX/IyjNL
         ftJ0NsQs19dXciXHnxv/u1VSnWUc5zWNm9XJo6BvPsi305EvpvhLWZV9PKOrTUwM4fU7
         6w6XORbRylIpOhNIH1c5Ek0by2RtLuXMKkxN0bsJr9TMlsY5if9wkkdjJY+jgVNw0sPK
         VgjznpRWq1F+oYFs4+ZG17VfhuZlABG0kEWIde7skj4M/vg3RbImglqFW38oY2vFEXEn
         bWlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12771-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12771-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12771-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12771-gregkh=linuxfoundation.org@lists.openwall.com
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
Date: Tue, 27 Mar 2018 18:37:41 +0300
Message-ID: <20180327153742.17328-6-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327153742.17328-1-igor.stoppa@huawei.com>
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596106038584194215?=
X-GMAIL-MSGID: =?utf-8?q?1596106038584194215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Verify that pmalloc read-only protection is in place: trying to
overwrite a protected variable will crash the kernel.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 drivers/misc/lkdtm.h       |  1 +
 drivers/misc/lkdtm_core.c  |  3 +++
 drivers/misc/lkdtm_perms.c | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

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
index 53b85c9d16b8..4660ff0bfa44 100644
--- a/drivers/misc/lkdtm_perms.c
+++ b/drivers/misc/lkdtm_perms.c
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
