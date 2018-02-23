Return-Path: <kernel-hardening-return-11924-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224JlTk6U7oIgSJAIBYhlH2Y1s/GlnwlL9eyYaUL+9EoR8gonH2Vf01u2tXbrQvR6U89w7DM
ARC-Seal: i=1; a=rsa-sha256; t=1519397558; cv=none;
        d=google.com; s=arc-20160816;
        b=pYfvAx8OTB9UQCHg3qBCbyhqUvp+9vFs+z+UuySgKAkEKTXDo5NR/rvMTS6ZSE04Om
         rDoWFyebe+ge3Ru7ZCneolxui/FPUCwOpll99AL2ZsV2smwRzVjQV9bRbyHdGh57agXt
         eUT7lEA9EX/lyA6MIKiK4lfJufDQtuhPXqoywooPhsF9FQ8kTHBKD4zKm7DmdddexOg3
         O+vY5Y+xkRggIG+D2WNsvLpShdgrsl9z4tBukcTQzZyHQ5fkN3QsSwsgzCWx12yCOIpt
         jZ0VxkCSzVFPtqYu8dRKZwbO2enliMouFBSVvvtJHEu/MzGXUKzHc72FZuZUMcf9ZHHB
         kqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=r+/dQbGqp28pibuoRjnpcP730sLxUhZuApp/+iHgoXc=;
        b=nC/rGzRjsb1/Vqbv+mCygpxtOsCpFPQzJZNTYEi5kgLBg1cxaof4HcBFWSAo3LVtc3
         RcsKLSNCXe1vLUxBcBRZeseTdnwQX2j4y2N2pVJxRoMbS+XjdFxTSD7OmNmeeRklahLQ
         utIBoFRocnOnMcJZ6BHQZlCGlSPBDKgKwhohHTymf7Yd6OSE+CQQJTnvzktfym3ODFFj
         UfJQ+I+WhYtEr2Yv5efM2pFQq51puMAuy0qKKL45mKoCjlh/GA8VrWcaLAo0L/hXfeCR
         1Q1Gkry6ymBU2QyXaI+UQZ/sonGnU8q5tVUOhmNRzaxx/F8rSMcQsTRewF2rZgnrOhh6
         IK1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11924-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11924-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11924-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11924-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <david@fromorbit.com>, <willy@infradead.org>, <keescook@chromium.org>,
	<mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 6/7] lkdtm: crash on overwriting protected pmalloc var
Date: Fri, 23 Feb 2018 16:48:06 +0200
Message-ID: <20180223144807.1180-7-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223144807.1180-1-igor.stoppa@huawei.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203814128727346?=
X-GMAIL-MSGID: =?utf-8?q?1593203814128727346?=
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
