Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17439C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFE32070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfADDkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 22:40:46 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:39675 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfADDkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 22:40:46 -0500
X-QQ-mid: bizesmtp3t1546573237tl9wlgwke
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 04 Jan 2019 11:40:26 +0800 (CST)
X-QQ-SSF: 01400000000000F0FF32000A0000000
X-QQ-FEAT: PtGvj5rALyjlMhMMnmy5u6k2qZ8So01nU0vK/rP8GIpMrpeddzPyCCAdwjUd+
        z8dotV4L0X0MwF2Yzm/K7EgTbhlMuYFJKh294/8/ma5zlQBOsQp4UN7Rs/gjOEx+C3IVzqT
        T/s0e7Fna/eeO+CVrtCSxtUlTucw4kPuH0aaz9HTZjvZUUwk4RjqkpXG6iAtq7j2TRk1w95
        yY3XWECCODrYEI7JXK8aZ0ImCufPIN3wiyfNHFBdUwwAoEvjAEMS2eqY2d5kvRAeqVZkVfP
        LATaCzj6ioyXPrYUK54FkWgrjTDJArHYh5if6MDCRRYMoW
X-QQ-GoodBg: 2
From:   huhai <huhai@kylinos.cn>
To:     will.deacon@arm.com, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuyun01@kylinos.cn, huhai <huhai@kylinos.cn>
Subject: [PATCH v2] arm64/lib: add accelerated do_csum for arm64
Date:   Fri,  4 Jan 2019 11:39:49 +0800
Message-Id: <20190104033949.7948-1-huhai@kylinos.cn>
X-Mailer: git-send-email 2.17.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_csum() in lib/checksum.c is too slow in ARM64,
and we can use assembly and algorithm to accelerate it.

V2: Fix compile warning reported by kbuild test robot <lkp@intel.com>

Signed-off-by: huhai <huhai@kylinos.cn>
---
 arch/arm64/include/asm/checksum.h |   3 +
 arch/arm64/lib/Makefile           |   2 +-
 arch/arm64/lib/checksum.c         | 145 ++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/checksum.c

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index 0b6f5a7d4027..0d7b80fb300e 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -26,6 +26,9 @@ static inline __sum16 csum_fold(__wsum csum)
 }
 #define csum_fold csum_fold
 
+#define do_csum do_csum
+unsigned int do_csum(const unsigned char *buff, unsigned int len);
+
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
 	__uint128_t tmp;
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 69ff9887f724..4134730a121b 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-lib-y		:= clear_user.o delay.o copy_from_user.o		\
+lib-y		:= checksum.o clear_user.o delay.o copy_from_user.o	\
 		   copy_to_user.o copy_in_user.o copy_page.o		\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
new file mode 100644
index 000000000000..5df8c6f9a8ac
--- /dev/null
+++ b/arch/arm64/lib/checksum.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Authors: huhai <huhai@kylinos.cn>
+ * Copyright (C) 2019,Tianjin KYLIN Information Technology Co., Ltd.
+ *
+ * This file contains network checksum routines that are better done
+ * in an architecture-specific manner due to speed.
+ *
+ * Acknowledgements:
+ * This file is based on arch/x86/lib/csum-partial_64.c and
+ * arch/alpha/lib/checksum.c, which was written by Thomas Gleixner
+ * and Rick Gorton respectively.
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <asm/checksum.h>
+
+static inline unsigned short from64to16(unsigned long x)
+{
+	/*
+	 * Using extract instructions is a bit more efficient
+	 * than the original shift/bitmask version.
+	 */
+	union {
+		unsigned long   ul;
+		unsigned int    ui[2];
+		unsigned short  us[4];
+	} in_v, tmp_v, out_v;
+
+	in_v.ul = x;
+	tmp_v.ul = (unsigned long) in_v.ui[0] + (unsigned long) in_v.ui[1];
+
+	/*
+	 * Since the bits of tmp_v.sh[3] are going to always be zero,
+	 * we don't have to bother to add that in.
+	 */
+	out_v.ul = (unsigned long) tmp_v.us[0] + (unsigned long) tmp_v.us[1]
+			+ (unsigned long) tmp_v.us[2];
+
+	/* Similarly, out_v.us[2] is always zero for the final add. */
+	return out_v.us[0] + out_v.us[1];
+}
+
+/*
+ * Do a 64-bit checksum on an arbitrary memory area.
+ * Returns a 16bit checksum.
+ */
+unsigned int do_csum(const unsigned char *buff, unsigned len)
+{
+	unsigned odd, count;
+	unsigned long result = 0;
+
+	if (unlikely(len == 0))
+		return result;
+	odd = 1 & (unsigned long) buff;
+	if (odd) {
+		result = *buff << 8;
+		len--;
+		buff++;
+	}
+	count = len >> 1;		/* nr of 16-bit words.. */
+	if (count) {
+		if (2 & (unsigned long) buff) {
+			result += *(unsigned short *)buff;
+			count--;
+			len -= 2;
+			buff += 2;
+		}
+		count >>= 1;		/* nr of 32-bit words.. */
+		if (count) {
+			unsigned long zero = 0;
+			unsigned count64;
+
+			if (4 & (unsigned long) buff) {
+				result += *(unsigned int *) buff;
+				count--;
+				len -= 4;
+				buff += 4;
+			}
+			count >>= 1;	/* nr of 64-bit words.. */
+
+			/* main loop using 64byte blocks */
+			count64 = count >> 3;
+			while (count64) {
+				__asm__ __volatile__(
+					"ldr x3, [%x1, #0]\n"
+					"adds %x0, %x0, x3\n"
+					"ldr x3, [%x1, #8]\n"
+					"adcs %x0, %x0, x3\n"
+					"ldr x3, [%x1, #16]\n"
+					"adcs %x0, %x0, x3\n"
+					"ldr x3, [%x1, #24]\n"
+					"adcs %x0, %x0, x3\n"
+					"ldr x3, [%x1, #32]\n"
+					"adcs %x0, %x0, x3\n"
+					"ldr x3, [%x1, #40]\n"
+					"adcs %x0, %x0, x3\n"
+					"ldr x3, [%x1, #48]\n"
+					"adcs %x0, %x0, x3\n"
+					"ldr x3, [%x1, #56]\n"
+					"adcs %x0, %x0, x3\n"
+					"adcs %x0, %x0, %x2\n"
+					: "=r" (result)
+					: "r" (buff), "r" (zero), "0" (result)
+					: "cc", "memory", "x3");
+
+				buff += 64;
+				count64--;
+			}
+
+			/* last up to 7 8byte blocks */
+			count %= 8;
+
+			while (count) {
+				__asm__ __volatile__(
+					"adds %x0, %x0, %x1\n"
+					"adcs %x0, %x0, %x2\n"
+					: "=r" (result)
+					: "r" (*(unsigned long *)buff), "r" (zero), "0" (result)
+					: "cc", "memory");
+				--count;
+				buff += 8;
+			}
+			result = (result & 0xffffffff) + (result >> 32);
+
+			if (len & 4) {
+				result += *(unsigned int *) buff;
+				buff += 4;
+			}
+		}
+		if (len & 2) {
+			result += *(unsigned short *) buff;
+			buff += 2;
+		}
+	}
+	if (len & 1)
+		result += *buff;
+
+	result = from64to16(result);
+	if (odd)
+		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
+
+	return result;
+}
-- 
2.17.0



