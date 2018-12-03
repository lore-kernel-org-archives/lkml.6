Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB791C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2780206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2780206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeLCN4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:56:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37862 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCN4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:56:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58CD2169E;
        Mon,  3 Dec 2018 05:55:29 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D32993F614;
        Mon,  3 Dec 2018 05:55:27 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
Date:   Mon,  3 Dec 2018 13:55:18 +0000
Message-Id: <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
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
---
 arch/arm64/include/asm/sysreg.h  |  2 +
 arch/arm64/include/asm/uaccess.h | 89 +++++++++++++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 842fb95..4e6477b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -108,6 +108,8 @@
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
 
+#define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
+
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
 #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 07c3408..cabfcae 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
 	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
 }
 
+#define unsafe_user_region_active	uaccess_region_active
+static inline bool uaccess_region_active(void)
+{
+	if (system_uses_ttbr0_pan()) {
+		u64 ttbr;
+
+		ttbr = read_sysreg(ttbr1_el1);
+		return ttbr & TTBR_ASID_MASK;
+	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
+		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
+				false :
+				!read_sysreg_s(SYS_PSTATE_PAN);
+	}
+
+	return false;
+}
+
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
  * current addr_limit.
@@ -276,11 +293,9 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err), "=&r" (x)						\
 	: "r" (addr), "i" (-EFAULT))
 
-#define __get_user_err(x, ptr, err)					\
+#define __get_user_err_unsafe(x, ptr, err)				\
 do {									\
 	unsigned long __gu_val;						\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__get_user_asm("ldrb", "ldtrb", "%w", __gu_val, (ptr),  \
@@ -301,17 +316,26 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	uaccess_disable_not_uao();					\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)
 
-#define __get_user_check(x, ptr, err)					\
+#define __get_user_err_check(x, ptr, err)				\
+do {									\
+	__typeof__(x) __gu_dest;					\
+	__chk_user_ptr(ptr);						\
+	uaccess_enable_not_uao();					\
+	__get_user_err_unsafe((__gu_dest), (ptr), (err));		\
+	uaccess_disable_not_uao();					\
+	(x) = __gu_dest;						\
+} while (0)
+
+#define __get_user_err(x, ptr, err, accessor)				\
 ({									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
 		__p = uaccess_mask_ptr(__p);				\
-		__get_user_err((x), __p, (err));			\
+		accessor((x), __p, (err));				\
 	} else {							\
 		(x) = 0; (err) = -EFAULT;				\
 	}								\
@@ -319,14 +343,14 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 
 #define __get_user_error(x, ptr, err)					\
 ({									\
-	__get_user_check((x), (ptr), (err));				\
+	__get_user_err((x), (ptr), (err), __get_user_err_check);	\
 	(void)0;							\
 })
 
 #define __get_user(x, ptr)						\
 ({									\
 	int __gu_err = 0;						\
-	__get_user_check((x), (ptr), __gu_err);				\
+	__get_user_err((x), (ptr), __gu_err, __get_user_err_check);	\
 	__gu_err;							\
 })
 
@@ -346,41 +370,46 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err)							\
 	: "r" (x), "r" (addr), "i" (-EFAULT))
 
-#define __put_user_err(x, ptr, err)					\
+#define __put_user_err_unsafe(x, ptr, err)				\
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
+} while (0)
+
+#define __put_user_err_check(x, ptr, err)				\
+do {									\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	__chk_user_ptr(ptr);						\
+	uaccess_enable_not_uao();					\
+	__put_user_err_unsafe(__pu_val, (ptr), (err));			\
 	uaccess_disable_not_uao();					\
 } while (0)
 
-#define __put_user_check(x, ptr, err)					\
+#define __put_user_err(x, ptr, err, accessor)				\
 ({									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
 		__p = uaccess_mask_ptr(__p);				\
-		__put_user_err((x), __p, (err));			\
+		accessor((x), __p, (err));				\
 	} else	{							\
 		(err) = -EFAULT;					\
 	}								\
@@ -388,19 +417,39 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 
 #define __put_user_error(x, ptr, err)					\
 ({									\
-	__put_user_check((x), (ptr), (err));				\
+	__put_user_err((x), (ptr), (err), __put_user_err_check);	\
 	(void)0;							\
 })
 
 #define __put_user(x, ptr)						\
 ({									\
 	int __pu_err = 0;						\
-	__put_user_check((x), (ptr), __pu_err);				\
+	__put_user_err((x), (ptr), __pu_err, __put_user_err_check);	\
 	__pu_err;							\
 })
 
 #define put_user	__put_user
 
+
+#define user_access_begin()	uaccess_enable_not_uao()
+#define user_access_end()	uaccess_disable_not_uao()
+
+#define unsafe_get_user(x, ptr, err)					\
+do {									\
+	int __gu_err = 0;						\
+	__get_user_err((x), (ptr), __gu_err, __get_user_err_unsafe);	\
+	if (__gu_err != 0)						\
+		goto err;						\
+} while (0)
+
+#define unsafe_put_user(x, ptr, err)					\
+do {									\
+	int __pu_err = 0;						\
+	__put_user_err((x), (ptr), __pu_err, __put_user_err_unsafe);	\
+	if (__pu_err != 0)						\
+		goto err;						\
+} while (0)
+
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user(to, from, n)					\
 ({									\
-- 
1.9.1

