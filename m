Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DC5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131F921870
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131F921870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeHMMIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:08:53 -0400
Received: from exmail.andestech.com ([59.124.169.137]:35662 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeHMMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:08:53 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7D9Q0pv066588;
        Mon, 13 Aug 2018 17:26:00 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 13 Aug 2018
 17:27:14 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, Zong Li <zong@andestech.com>
Subject: [PATCH 3/3] nds32: Extract the checking and getting pointer to a macro
Date:   Mon, 13 Aug 2018 17:26:53 +0800
Message-ID: <f414fc2028f08e7a56229dbfd83c2fee4dd40193.1534151351.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534151350.git.zong@andestech.com>
References: <cover.1534151350.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7D9Q0pv066588
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/include/asm/uaccess.h | 80 ++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index e1a2b5b..362a32d 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -75,54 +75,54 @@ static inline void set_fs(mm_segment_t fs)
  * versions are void (ie, don't return a value as such).
  */
 
-#define get_user(x, ptr)						\
-({									\
-	long __e = -EFAULT;						\
-	const __typeof__(*(ptr)) __user *__p = (ptr);			\
-	if (likely(access_ok(VERIFY_READ, __p, sizeof(*__p)))) {	\
-		__e = __get_user(x, __p);				\
-	} else {							\
-		(x) = 0;						\
-	}								\
-	__e;								\
-})
+#define get_user	__get_user					\
 
 #define __get_user(x, ptr)						\
 ({									\
 	long __gu_err = 0;						\
-	__get_user_err((x), (ptr), __gu_err);				\
+	__get_user_check((x), (ptr), __gu_err);				\
 	__gu_err;							\
 })
 
 #define __get_user_error(x, ptr, err)					\
 ({									\
-	__get_user_err((x), (ptr), err);				\
+	__get_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
+#define __get_user_check(x, ptr, err)					\
+({									\
+	const __typeof__(*(ptr)) __user *__p = (ptr);			\
+	might_fault();							\
+	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
+		__get_user_err((x), __p, (err));			\
+	} else {							\
+		(x) = 0; (err) = -EFAULT;				\
+	}								\
+})
+
 #define __get_user_err(x, ptr, err)					\
 do {									\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	unsigned long __gu_val;						\
-	__chk_user_ptr(__gu_addr);					\
-	switch (sizeof(*(__gu_addr))) {					\
+	__chk_user_ptr(ptr);						\
+	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__get_user_asm("lbi", __gu_val, __gu_addr, (err));	\
+		__get_user_asm("lbi", __gu_val, (ptr), (err));		\
 		break;							\
 	case 2:								\
-		__get_user_asm("lhi", __gu_val, __gu_addr, (err));	\
+		__get_user_asm("lhi", __gu_val, (ptr), (err));		\
 		break;							\
 	case 4:								\
-		__get_user_asm("lwi", __gu_val, __gu_addr, (err));	\
+		__get_user_asm("lwi", __gu_val, (ptr), (err));		\
 		break;							\
 	case 8:								\
-		__get_user_asm_dword(__gu_val, __gu_addr, (err));	\
+		__get_user_asm_dword(__gu_val, (ptr), (err));		\
 		break;							\
 	default:							\
 		BUILD_BUG(); 						\
 		break;							\
 	}								\
-	(x) = (__typeof__(*(__gu_addr)))__gu_val;			\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)
 
 #define __get_user_asm(inst, x, addr, err)				\
@@ -170,15 +170,7 @@ do {									\
 		: "r"(addr), "i"(-EFAULT)				\
 		: "cc")
 
-#define put_user(x, ptr)						\
-({									\
-	long __e = -EFAULT;						\
-	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	if (likely(access_ok(VERIFY_WRITE, __p, sizeof(*__p)))) {	\
-		__e = __put_user(x, __p);				\
-	}								\
-	__e;								\
-})
+#define put_user	__put_user					\
 
 #define __put_user(x, ptr)						\
 ({									\
@@ -189,27 +181,37 @@ do {									\
 
 #define __put_user_error(x, ptr, err)					\
 ({									\
-	__put_user_err((x), (ptr), err);				\
+	__put_user_err((x), (ptr), (err));				\
 	(void)0;							\
 })
 
+#define __put_user_check(x, ptr, err)					\
+({									\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	might_fault();							\
+	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
+		__put_user_err((x), __p, (err));			\
+	} else	{							\
+		(err) = -EFAULT;					\
+	}								\
+})
+
 #define __put_user_err(x, ptr, err)					\
 do {									\
-	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
-	__typeof__(*(__pu_addr)) __pu_val = (x);			\
-	__chk_user_ptr(__pu_addr);					\
-	switch (sizeof(*(__pu_addr))) {					\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	__chk_user_ptr(ptr);						\
+	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__put_user_asm("sbi", __pu_val, __pu_addr, (err));	\
+		__put_user_asm("sbi", __pu_val, (ptr), (err));		\
 		break;							\
 	case 2: 							\
-		__put_user_asm("shi", __pu_val, __pu_addr, (err));	\
+		__put_user_asm("shi", __pu_val, (ptr), (err));		\
 		break;							\
 	case 4: 							\
-		__put_user_asm("swi", __pu_val, __pu_addr, (err));	\
+		__put_user_asm("swi", __pu_val, (ptr), (err));		\
 		break;							\
 	case 8:								\
-		__put_user_asm_dword(__pu_val, __pu_addr, (err));	\
+		__put_user_asm_dword(__pu_val, (ptr), (err));		\
 		break;							\
 	default:							\
 		BUILD_BUG(); 						\
-- 
2.7.4

