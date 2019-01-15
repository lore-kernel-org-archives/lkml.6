Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF2E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfAON6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:58:42 -0500
Received: from foss.arm.com ([217.140.101.70]:51642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfAON6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:58:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C7FEBD;
        Tue, 15 Jan 2019 05:58:39 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADFFB3F70D;
        Tue, 15 Jan 2019 05:58:37 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 1/4] arm64: uaccess: Cleanup get/put_user()
Date:   Tue, 15 Jan 2019 13:58:26 +0000
Message-Id: <1547560709-56207-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get/put_user_check() macro is made to return a value but this is never
used. Get rid of them and just use directly __get/put_user_error() as
a statement, reducing macro indirection.

Also, take this opportunity to rename __get/put_user_err() as it gets
a bit confusing having them along __get/put_user_error().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

---
 arch/arm64/include/asm/uaccess.h | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 547d7a0..8e40808 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -268,7 +268,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err), "=&r" (x)						\
 	: "r" (addr), "i" (-EFAULT))

-#define __get_user_err(x, ptr, err)					\
+#define __raw_get_user(x, ptr, err)					\
 do {									\
 	unsigned long __gu_val;						\
 	__chk_user_ptr(ptr);						\
@@ -297,28 +297,22 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)

-#define __get_user_check(x, ptr, err)					\
-({									\
+#define __get_user_error(x, ptr, err)					\
+do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
 		__p = uaccess_mask_ptr(__p);				\
-		__get_user_err((x), __p, (err));			\
+		__raw_get_user((x), __p, (err));			\
 	} else {							\
 		(x) = 0; (err) = -EFAULT;				\
 	}								\
-})
-
-#define __get_user_error(x, ptr, err)					\
-({									\
-	__get_user_check((x), (ptr), (err));				\
-	(void)0;							\
-})
+} while (0)

 #define __get_user(x, ptr)						\
 ({									\
 	int __gu_err = 0;						\
-	__get_user_check((x), (ptr), __gu_err);				\
+	__get_user_error((x), (ptr), __gu_err);				\
 	__gu_err;							\
 })

@@ -338,7 +332,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err)							\
 	: "r" (x), "r" (addr), "i" (-EFAULT))

-#define __put_user_err(x, ptr, err)					\
+#define __raw_put_user(x, ptr, err)					\
 do {									\
 	__typeof__(*(ptr)) __pu_val = (x);				\
 	__chk_user_ptr(ptr);						\
@@ -366,28 +360,22 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	uaccess_disable_not_uao();					\
 } while (0)

-#define __put_user_check(x, ptr, err)					\
-({									\
+#define __put_user_error(x, ptr, err)					\
+do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
 		__p = uaccess_mask_ptr(__p);				\
-		__put_user_err((x), __p, (err));			\
+		__raw_put_user((x), __p, (err));			\
 	} else	{							\
 		(err) = -EFAULT;					\
 	}								\
-})
-
-#define __put_user_error(x, ptr, err)					\
-({									\
-	__put_user_check((x), (ptr), (err));				\
-	(void)0;							\
-})
+} while (0)

 #define __put_user(x, ptr)						\
 ({									\
 	int __pu_err = 0;						\
-	__put_user_check((x), (ptr), __pu_err);				\
+	__put_user_error((x), (ptr), __pu_err);				\
 	__pu_err;							\
 })

--
1.9.1
