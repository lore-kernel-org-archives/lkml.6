Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeBIQSq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:18:46 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:59983 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeBIQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:18:44 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org, llvm-dev@lists.llvm.org,
        llvmlinux@lists.linuxfoundation.org, bp@alien8.de
Subject: [RFC HACK] Make clang hate percpu.h less in 32-bit mode
Date: Fri,  9 Feb 2018 16:18:33 +0000
Message-Id: <20180209161833.4605-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither clang nor GCC like this very much with -m32:

	long long ret;
	asm ("movb $5, %0" : "=q" (ret));

However, GCC can tolerate this variant:

	long long ret;
	switch (sizeof(ret)) {
	case 1:
		asm ("movb $5, %0" : "=q" (ret));
	case 8:
		;
	}

Clang, on the other hand, won't accept that because it validates the 
inline asm for the '1' case *before* the optimisation phase where it 
realises that it wouldn't have to emit it anyway.

This patch puts some casts in to make clang less unhappy. I don't like
it very much.

Note that we don't have the same problem for the "=r" case, where a 
64-bit value *also* doesn't fit. This is because even if it *does* have 
to emit it, clang will happily and silently do so even though it's 
clearly bogus:

	long long ret;
	asm ("movl $5, %0" : "=r" (ret));

 $ clang -c -o q.o q.c -m32
 $ gcc -c -o q.o q.c -m32
q.c: In function ‘foo’:
q.c:6:1: warning: unsupported size for integer register


---

 arch/x86/include/asm/percpu.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index ba3c523aaf16..3b0e413670e4 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -99,7 +99,7 @@ do {							\
 	case 1:						\
 		asm(op "b %1,"__percpu_arg(0)		\
 		    : "+m" (var)			\
-		    : "qi" ((pto_T__)(val)));		\
+		    : "qi" ((unsigned char)(unsigned long)(val))); \
 		break;					\
 	case 2:						\
 		asm(op "w %1,"__percpu_arg(0)		\
@@ -144,7 +144,7 @@ do {									\
 		else							\
 			asm("addb %1, "__percpu_arg(0)			\
 			    : "+m" (var)				\
-			    : "qi" ((pao_T__)(val)));			\
+			    : "qi" ((unsigned char)(unsigned long)(val))); \
 		break;							\
 	case 2:								\
 		if (pao_ID__ == 1)					\
@@ -182,12 +182,14 @@ do {									\
 
 #define percpu_from_op(op, var)				\
 ({							\
+	unsigned char pfo_u8__;				\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
 		asm(op "b "__percpu_arg(1)",%0"		\
-		    : "=q" (pfo_ret__)			\
+		    : "=q" (pfo_u8__)			\
 		    : "m" (var));			\
+		pfo_ret__ = (typeof(var))(unsigned long)pfo_u8__;	\
 		break;					\
 	case 2:						\
 		asm(op "w "__percpu_arg(1)",%0"		\
@@ -211,12 +213,14 @@ do {									\
 
 #define percpu_stable_op(op, var)			\
 ({							\
+	unsigned char pfo_u8__;				\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
 		asm(op "b "__percpu_arg(P1)",%0"	\
-		    : "=q" (pfo_ret__)			\
+		    : "=q" (pfo_u8__)			\
 		    : "p" (&(var)));			\
+		pfo_ret__ = (typeof(var))(unsigned long)pfo_u8__;	\
 		break;					\
 	case 2:						\
 		asm(op "w "__percpu_arg(P1)",%0"	\
-- 
2.14.3
