Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeEWHsD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:48:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55543 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932105AbeEWHrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:47:51 -0400
Subject: [PATCH v4 3/3] powerpc/lib: optimise PPC32 memcmp
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, segher@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1527004752.git.christophe.leroy@c-s.fr>
 <05bd657afedaf4a0de5abab0c5db2e88fa73bdfe.1527004752.git.christophe.leroy@c-s.fr>
Message-ID: <bb7ef10a-4777-7635-3e54-830dd3eeb8bb@c-s.fr>
Date: Wed, 23 May 2018 09:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <05bd657afedaf4a0de5abab0c5db2e88fa73bdfe.1527004752.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, memcmp() compares two chunks of memory
byte per byte.

This patch optimises the comparison by comparing word by word.

A small benchmark performed on an 8xx comparing two chuncks
of 512 bytes performed 100000 times gives:

Before : 5852274 TB ticks
After:   1488638 TB ticks

This is almost 4 times faster

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
  Not resending the entire serie

  v4: Dropped the special handling for when length is 0. Handling it 
through the small length path.

  arch/powerpc/lib/string_32.S | 48 
+++++++++++++++++++++++++++++++++++---------
  1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
index 40a576d56ac7..542e6cecbcaf 100644
--- a/arch/powerpc/lib/string_32.S
+++ b/arch/powerpc/lib/string_32.S
@@ -16,17 +16,45 @@
  	.text

  _GLOBAL(memcmp)
-	cmpwi	cr0, r5, 0
-	beq-	2f
-	mtctr	r5
-	addi	r6,r3,-1
-	addi	r4,r4,-1
-1:	lbzu	r3,1(r6)
-	lbzu	r0,1(r4)
-	subf.	r3,r0,r3
-	bdnzt	2,1b
+	srawi.	r7, r5, 2		/* Divide len by 4 */
+	mr	r6, r3
+	beq-	3f
+	mtctr	r7
+	li	r7, 0
+1:
+#ifdef __LITTLE_ENDIAN__
+	lwbrx	r3, r6, r7
+	lwbrx	r0, r4, r7
+#else
+	lwzx	r3, r6, r7
+	lwzx	r0, r4, r7
+#endif
+	addi	r7, r7, 4
+	cmplw	cr0, r3, r0
+	bdnzt	eq, 1b
+	bne	5f
+3:	andi.	r3, r5, 3
+	beqlr
+	cmplwi	cr1, r3, 2
+	blt-	cr1, 4f
+#ifdef __LITTLE_ENDIAN__
+	lhbrx	r3, r6, r7
+	lhbrx	r0, r4, r7
+#else
+	lhzx	r3, r6, r7
+	lhzx	r0, r4, r7
+#endif
+	addi	r7, r7, 2
+	subf.	r3, r0, r3
+	beqlr	cr1
+	bnelr
+4:	lbzx	r3, r6, r7
+	lbzx	r0, r4, r7
+	subf.	r3, r0, r3
  	blr
-2:	li	r3,0
+5:	li	r3, 1
+	bgtlr
+	li	r3, -1
  	blr
  EXPORT_SYMBOL(memcmp)

-- 
2.13.3
