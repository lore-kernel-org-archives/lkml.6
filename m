Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932300AbeENN5V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:57:21 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:60016 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbeENN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:57:19 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-m68k@vger.kernel.org
Cc: Martijn Coenen <maco@android.com>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/uaccess: Revive 64-bit get_user()
Date: Mon, 14 May 2018 15:57:15 +0200
Message-Id: <1526306235-29755-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revive support for 64-bit get_user(), which was disabled in commit
d94af931af42152e ("[PATCH] m68k: clean up uaccess.h") due to a "broken"
typeof in (then brand new) gcc-4.1.

  - Keep on using u64 for the temporary, as __typeof__() doesn't drop
    the const qualifier,
  - Move it into a union (like mips32 does) to get rid of the cast, as
    using get_user() to fetch a __user pointer would cause a "cast to
    pointer from integer of different size" warning otherwise.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/uaccess_mm.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess_mm.h b/arch/m68k/include/asm/uaccess_mm.h
index 75c172e909acdf18..c4cb889660aa0c35 100644
--- a/arch/m68k/include/asm/uaccess_mm.h
+++ b/arch/m68k/include/asm/uaccess_mm.h
@@ -141,10 +141,12 @@ asm volatile ("\n"					\
 	case 4:								\
 		__get_user_asm(__gu_err, x, ptr, u32, l, r, -EFAULT);	\
 		break;							\
-/*	case 8:	disabled because gcc-4.1 has a broken typeof		\
- 	    {								\
- 		const void *__gu_ptr = (ptr);				\
- 		u64 __gu_val;						\
+	case 8: {							\
+		const void *__gu_ptr = (ptr);				\
+		union {							\
+			u64 l;						\
+			__typeof__(*(ptr)) t;				\
+		} __gu_val;						\
 		asm volatile ("\n"					\
 			"1:	"MOVES".l	(%2)+,%1\n"		\
 			"2:	"MOVES".l	(%2),%R1\n"		\
@@ -162,13 +164,13 @@ asm volatile ("\n"					\
 			"	.long	1b,10b\n"			\
 			"	.long	2b,10b\n"			\
 			"	.previous"				\
-			: "+d" (__gu_err), "=&r" (__gu_val),		\
+			: "+d" (__gu_err), "=&r" (__gu_val.l),		\
 			  "+a" (__gu_ptr)				\
 			: "i" (-EFAULT)					\
 			: "memory");					\
-		(x) = (__force typeof(*(ptr)))__gu_val;			\
+		(x) = __gu_val.t;					\
 		break;							\
-	    }	*/							\
+	}								\
 	default:							\
 		__gu_err = __get_user_bad();				\
 		break;							\
-- 
2.7.4
