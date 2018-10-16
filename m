Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E7FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F10208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F10208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeJPNhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:37:21 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36306 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbeJPNhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:37:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437388|-1;CH=green;FP=17380146656168811769|1|1|10|0|-1|-1|-1;HT=e02c03299;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.D2ivIYN_1539668903;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D2ivIYN_1539668903)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 16 Oct 2018 13:48:24 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, hch@infradead.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org,
        robh@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V9 21/21] csky: support dword access for get_user_size()
Date:   Tue, 16 Oct 2018 13:48:19 +0800
Message-Id: <4bc11ff0cff5960892a464189605f9bc808383fc.1539655732.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539655731.git.ren_guo@c-sky.com>
References: <cover.1539655731.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support dword access for get_user_size and redesign put_user_size with
the same style of get_user_size. It's Ok to use xxx_user_asm_common for
all size of variable with ldb, ldh, ldw, ld.d

ld.d rx, (addr, 0) could "rx <= addr" "and r(x+1) <= addr+4" and this also
follow abiv2 gcc ABI for dword access.

abiv1 couldn't support __get_user_dword now.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/uaccess.h | 140 ++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 84 deletions(-)

diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index acaf0e210..80233e4 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -96,90 +96,32 @@ extern int __put_user_bad(void);
 	__pu_err;							\
 })
 
-#define __put_user_size(x, ptr, size, retval)		\
-do {							\
-	retval = 0;					\
-	switch (size) {                                 \
-	case 1:						\
-		__put_user_asm_b(x, ptr, retval);	\
-		break;					\
-	case 2:						\
-		__put_user_asm_h(x, ptr, retval);	\
-		break;					\
-	case 4:						\
-		__put_user_asm_w(x, ptr, retval);	\
-		break;					\
-	case 8:						\
-		__put_user_asm_64(x, ptr, retval);	\
-		break;					\
-	default:					\
-		__put_user_bad();			\
-	}	                                        \
-} while (0)
-
-/*
- * We don't tell gcc that we are accessing memory, but this is OK
- * because we do not write to any memory gcc knows about, so there
- * are no aliasing issues.
- *
- * Note that PC at a fault is the address *after* the faulting
- * instruction.
- */
-#define __put_user_asm_b(x, ptr, err)			\
-do {							\
-	int errcode;					\
-	asm volatile(					\
-	"1:     stb   %1, (%2,0)	\n"		\
-	"       br    3f		\n"		\
-	"2:     mov   %0, %3		\n"		\
-	"       br    3f		\n"		\
-	".section __ex_table, \"a\"	\n"		\
-	".align   2			\n"		\
-	".long    1b,2b			\n"		\
-	".previous			\n"		\
-	"3:				\n"		\
-	: "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)	\
-	: "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)	\
-	: "memory");					\
-} while (0)
-
-#define __put_user_asm_h(x, ptr, err)			\
-do {							\
-	int errcode;					\
-	asm volatile(					\
-	"1:     sth   %1, (%2,0)	\n"		\
-	"       br    3f		\n"		\
-	"2:     mov   %0, %3		\n"		\
-	"       br    3f		\n"		\
-	".section __ex_table, \"a\"	\n"		\
-	".align   2			\n"		\
-	".long    1b,2b			\n"		\
-	".previous			\n"		\
-	"3:				\n"		\
-	: "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)	\
-	: "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)	\
-	: "memory");					\
-} while (0)
-
-#define __put_user_asm_w(x, ptr, err)			\
-do {							\
-	int errcode;					\
-	asm volatile(					\
-	"1:     stw   %1, (%2,0)	\n"		\
-	"       br    3f		\n"		\
-	"2:     mov   %0, %3		\n"		\
-	"       br    3f		\n"		\
-	".section __ex_table,\"a\"	\n"		\
-	".align   2			\n"		\
-	".long    1b, 2b		\n"		\
-	".previous			\n"		\
-	"3:				\n"		\
-	: "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)	\
-	: "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)	\
-	: "memory");					\
+#define __put_user_size(x, ptr, size, retval)			\
+do {								\
+	retval = 0;						\
+	switch (size) {						\
+	case 1:							\
+		__put_user_asm_common(x, ptr, "stb", retval);	\
+		break;						\
+	case 2:							\
+		__put_user_asm_common(x, ptr, "sth", retval);	\
+		break;						\
+	case 4:							\
+		__put_user_asm_common(x, ptr, "stw", retval);	\
+		break;						\
+	case 8:							\
+		__put_user_asm_dword(x, ptr, retval);		\
+		break;						\
+	default:						\
+		__put_user_bad();				\
+	}							\
 } while (0)
 
-#define __put_user_asm_64(x, ptr, err)				\
+#if defined(__CSKYABIV2__)
+#define __put_user_asm_dword(x, ptr, err)			\
+	__put_user_asm_common(x, ptr, "st.d", err)
+#else
+#define __put_user_asm_dword(x, ptr, err)			\
 do {								\
 	int tmp;						\
 	int errcode;						\
@@ -205,6 +147,25 @@ do {								\
 	: "0"(err), "1"(psrc), "2"(ptr), "3"(0), "4"(-EFAULT)	\
 	: "memory");						\
 } while (0)
+#endif
+
+#define __put_user_asm_common(x, ptr, ins, err)			\
+do {								\
+	int errcode;						\
+	asm volatile(						\
+	"1:   " ins "	%1, (%2,0)	\n"			\
+	"       br	3f		\n"			\
+	"2:     mov	%0, %3		\n"			\
+	"       br	3f		\n"			\
+	".section __ex_table, \"a\"	\n"			\
+	".align   2			\n"			\
+	".long    1b,2b			\n"			\
+	".previous			\n"			\
+	"3:				\n"			\
+	: "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)		\
+	: "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)		\
+	: "memory");						\
+} while (0)
 
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
@@ -222,6 +183,7 @@ do {								\
 	__gu_err;						\
 })
 
+extern int __get_user_bad(void);
 #define __get_user_size(x, ptr, size, retval)			\
 do {								\
 	switch (size) {						\
@@ -234,12 +196,24 @@ do {								\
 	case 4:							\
 		__get_user_asm_common((x), ptr, "ldw", retval);	\
 		break;						\
+	case 8:							\
+		__get_user_asm_common((x), ptr, "ld.d", retval);\
+		break;						\
 	default:						\
 		x = 0;						\
 		(retval) = __get_user_bad();			\
 	}							\
 } while (0)
 
+#if defined(__CSKYABIV2__)
+#define __get_user_asm_dword(x, ptr, err)			\
+	__get_user_asm_common(x, ptr, "ld.d", err)
+#else
+/* fixme: abiv1 not implement get_user_dword */
+#define __get_user_asm_dword(x, ptr, err)			\
+	__get_user_bad()
+#endif
+
 #define __get_user_asm_common(x, ptr, ins, err)			\
 do {								\
 	int errcode;						\
@@ -260,8 +234,6 @@ do {								\
 	: "memory");						\
 } while (0)
 
-extern int __get_user_bad(void);
-
 #define __copy_user(to, from, n)			\
 do {							\
 	int w0, w1, w2, w3;				\
-- 
2.7.4

