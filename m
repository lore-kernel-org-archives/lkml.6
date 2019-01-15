Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DB920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfAON6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:58:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfAON6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:58:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8425115AB;
        Tue, 15 Jan 2019 05:58:41 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B84943F70D;
        Tue, 15 Jan 2019 05:58:39 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 2/4] arm64: uaccess: Implement unsafe accessors
Date:   Tue, 15 Jan 2019 13:58:27 +0000
Message-Id: <1547560709-56207-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of get/put_user_unsafe default to get/put_user
which toggle PAN before each access, despite having been told by the caller
that multiple accesses to user memory were about to happen.

Provide implementations for user_access_begin/end to turn PAN off/on and
implement unsafe accessors that assume PAN was already turned off.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

---
 arch/arm64/include/asm/uaccess.h | 79 ++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 8e40808..6a70c75 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -270,31 +270,26 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)

 #define __raw_get_user(x, ptr, err)					\
 do {									\
-	unsigned long __gu_val;						\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__get_user_asm("ldrb", "ldtrb", "%w", __gu_val, (ptr),  \
+		__get_user_asm("ldrb", "ldtrb", "%w", (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 2:								\
-		__get_user_asm("ldrh", "ldtrh", "%w", __gu_val, (ptr),  \
+		__get_user_asm("ldrh", "ldtrh", "%w", (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 4:								\
-		__get_user_asm("ldr", "ldtr", "%w", __gu_val, (ptr),	\
+		__get_user_asm("ldr", "ldtr", "%w", (x), (ptr),		\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 8:								\
-		__get_user_asm("ldr", "ldtr", "%x",  __gu_val, (ptr),	\
+		__get_user_asm("ldr", "ldtr", "%x",  (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	uaccess_disable_not_uao();					\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)

 #define __get_user_error(x, ptr, err)					\
@@ -302,8 +297,13 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
+		unsigned long __gu_val;					\
+		__chk_user_ptr(__p);					\
 		__p = uaccess_mask_ptr(__p);				\
-		__raw_get_user((x), __p, (err));			\
+		uaccess_enable_not_uao();				\
+		__raw_get_user(__gu_val, __p, (err));			\
+		uaccess_disable_not_uao();				\
+		(x) = (__force __typeof__(*__p)) __gu_val;		\
 	} else {							\
 		(x) = 0; (err) = -EFAULT;				\
 	}								\
@@ -334,30 +334,26 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)

 #define __raw_put_user(x, ptr, err)					\
 do {									\
-	__typeof__(*(ptr)) __pu_val = (x);				\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__put_user_asm("strb", "sttrb", "%w", __pu_val, (ptr),	\
+		__put_user_asm("strb", "sttrb", "%w", (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 2:								\
-		__put_user_asm("strh", "sttrh", "%w", __pu_val, (ptr),	\
+		__put_user_asm("strh", "sttrh", "%w", (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 4:								\
-		__put_user_asm("str", "sttr", "%w", __pu_val, (ptr),	\
+		__put_user_asm("str", "sttr", "%w", (x), (ptr),		\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 8:								\
-		__put_user_asm("str", "sttr", "%x", __pu_val, (ptr),	\
+		__put_user_asm("str", "sttr", "%x", (x), (ptr),		\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	uaccess_disable_not_uao();					\
 } while (0)

 #define __put_user_error(x, ptr, err)					\
@@ -365,9 +361,13 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
+		__typeof__(*(ptr)) __pu_val = (x);			\
+		__chk_user_ptr(__p);					\
 		__p = uaccess_mask_ptr(__p);				\
-		__raw_put_user((x), __p, (err));			\
-	} else	{							\
+		uaccess_enable_not_uao();				\
+		__raw_put_user(__pu_val, __p, (err));			\
+		uaccess_disable_not_uao();				\
+	} else {							\
 		(err) = -EFAULT;					\
 	}								\
 } while (0)
@@ -381,6 +381,45 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)

 #define put_user	__put_user

+static __must_check inline bool user_access_begin(const void __user *ptr,
+						  size_t len)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return false;
+
+	uaccess_enable_not_uao();
+	return true;
+}
+#define user_access_begin(ptr, len)	user_access_begin(ptr, len)
+#define user_access_end()		uaccess_disable_not_uao()
+
+#define unsafe_get_user(x, ptr, err)					\
+do {									\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	unsigned long __gu_val;						\
+	int __gu_err = 0;						\
+	might_fault();							\
+	__chk_user_ptr(__p);						\
+	__p = uaccess_mask_ptr(__p);					\
+	__raw_get_user(__gu_val, __p, __gu_err);			\
+	(x) = (__force __typeof__(*__p)) __gu_val;			\
+	if (__gu_err != 0)						\
+		goto err;						\
+} while (0)
+
+#define unsafe_put_user(x, ptr, err)					\
+do {									\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	int __pu_err = 0;						\
+	might_fault();							\
+	__chk_user_ptr(__p);						\
+	__p = uaccess_mask_ptr(__p);					\
+	__raw_put_user(__pu_val, __p, __pu_err);			\
+	if (__pu_err != 0)						\
+		goto err;						\
+} while (0)
+
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user(to, from, n)					\
 ({									\
--
1.9.1
