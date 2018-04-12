Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx48ZtvnsUL0a5HCnC6j/WKGALKLhEVsSWXwtxpxdjCFLW8FayX/9eNGeTZaaHhnWI7Wg41oF
ARC-Seal: i=1; a=rsa-sha256; t=1523538881; cv=none;
        d=google.com; s=arc-20160816;
        b=P1tmIbZKXFv3e5IUr3tS/GnFPNWBuAr7uFAZ6QuLX4aqJMpojO5m3lS/llIPJuOn30
         LK+WFelnD68ZXrfxkxcC5tg3sSXg2maHrX0sHP3HL3yHQJcc5hIq0sZmo8MTIJHh1fF1
         Ya5/ClAd0x2LLIOwvaQi8f0Dbe7QQ4Jl9bTwb9EnvIFAesEVF9VNZxk1LgkXf56HQfoZ
         RBHFiJY29D+AO06w44qWY5FWwtU5S4hjKAFI0Q2gn/4ks+PYd4LP7n4Ud6RDU33pJBp6
         0uPapWP6D4CYr2Ev8mePI7mBLO/v2poV5Cm+jGJ4p3fOzq7RDVLLe8Ax2CqSM1sZJMKi
         z4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=k91oUu22ye6SlrzBqdUCMY05uqDMu96qFBBkaYmIve0=;
        b=JsILcT65B8nHsFNqZ0B9ENzR+tIYPSl8gAuSVLN4CpvfJmP3ZUz8I3lEE9OgXb1RFG
         Zh2qM0/6BVmy43r7Y0n9x6VQE8Qr++d0Wc4VEctfgEftasQOdP9dKsPOfwRGHl22Ut/D
         SjY408CMGwWBXO5OOSErpYz6u4n6uvJL23oo3QyK2vsXsp6PIRZK5+tQJfxMcAtK8mb6
         rdBpDfjBodXdz6PrSJzTTCsQl7H3qBOwnPfZ4KeJtZZhK4dFu7McrWhuxbh8XCS/Okb0
         4j3I9OWeiAp2hqTNDYS9qL5n2k4WP5o/Y9y370NmknGtNicnK+b68/zP15SdTA8wrvDQ
         KorA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <aryabinin@virtuozzo.com>, <glider@google.com>, <dvyukov@google.com>,
	<corbet@lwn.net>, <linux@armlinux.org.uk>, <cdall@kernel.org>,
	<marc.zyngier@arm.com>, <arnd@arndb.de>, <nicolas.pitre@linaro.org>,
	<vladimir.murzin@arm.com>, <mingo@kernel.org>, <viro@zeniv.linux.org.uk>,
	<alexandre.belloni@bootlin.com>, <ard.biesheuvel@linaro.org>,
	<daniel.lezcano@linaro.org>, <pombredanne@nexb.com>,
	<kstewart@linuxfoundation.org>, <liuwenliang@huawei.com>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<mawilcox@microsoft.com>, <akpm@linux-foundation.org>,
	<mark.rutland@arm.com>, <afzal.mohd.ma@gmail.com>,
	<alexander.levin@verizon.com>, <tglx@linutronix.de>, <thgarnie@google.com>,
	<dhowells@redhat.com>, <keescook@chromium.org>, <geert@linux-m68k.org>,
	<tixy@linaro.org>, <julien.thierry@arm.com>, <james.morse@arm.com>,
	<zhichao.huang@linaro.org>, <jinb.park7@gmail.com>, <labbott@redhat.com>,
	<philip@cog.systems>, <grygorii.strashko@linaro.org>, <opendmb@gmail.com>,
	<mhocko@suse.com>, <kirill.shutemov@linux.intel.com>,
	<kasan-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.cs.columbia.edu>
Subject: [PATCH 3/6] Replace memory function for kasan
Date: Thu, 12 Apr 2018 20:54:08 +0800
Message-ID: <20180412125411.326-4-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412125411.326-1-liuwenliang@huawei.com>
References: <20180412125411.326-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597546306349659128?=
X-GMAIL-MSGID: =?utf-8?q?1597546306349659128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Ryabinin <a.ryabinin@samsung.com>

Functions like memset/memmove/memcpy do a lot of memory accesses.
If bad pointer passed to one of these function it is important
to catch this. Compiler's instrumentation cannot do this since
these functions are written in assembly.

KASan replaces memory functions with manually instrumented variants.
Original functions declared as weak symbols so strong definitions
in mm/kasan/kasan.c could replace them. Original functions have aliases
with '__' prefix in name, so we could call non-instrumented variant
if needed.

We must use __memcpy/__memset to replace memcpy/memset when we copy
.data to RAM and when we clear .bss, because kasan_early_init can't
be called before the initialization of .data and .bss.

Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 arch/arm/boot/compressed/decompress.c |  2 ++
 arch/arm/boot/compressed/libfdt_env.h |  2 ++
 arch/arm/include/asm/string.h         | 17 +++++++++++++++++
 arch/arm/kernel/head-common.S         |  4 ++--
 arch/arm/lib/memcpy.S                 |  3 +++
 arch/arm/lib/memmove.S                |  5 ++++-
 arch/arm/lib/memset.S                 |  3 +++
 7 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index a2ac3fe..0596077 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -49,8 +49,10 @@ extern int memcmp(const void *cs, const void *ct, size_t count);
 #endif
 
 #ifdef CONFIG_KERNEL_XZ
+#ifndef CONFIG_KASAN
 #define memmove memmove
 #define memcpy memcpy
+#endif
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
index 0743781..736ed36 100644
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ b/arch/arm/boot/compressed/libfdt_env.h
@@ -17,4 +17,6 @@ typedef __be64 fdt64_t;
 #define fdt64_to_cpu(x)		be64_to_cpu(x)
 #define cpu_to_fdt64(x)		cpu_to_be64(x)
 
+#undef memset
+
 #endif
diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index 111a1d8..1f9016b 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -15,15 +15,18 @@ extern char * strchr(const char * s, int c);
 
 #define __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *, const void *, __kernel_size_t);
+extern void *__memcpy(void *dest, const void *src, __kernel_size_t n);
 
 #define __HAVE_ARCH_MEMMOVE
 extern void * memmove(void *, const void *, __kernel_size_t);
+extern void *__memmove(void *dest, const void *src, __kernel_size_t n);
 
 #define __HAVE_ARCH_MEMCHR
 extern void * memchr(const void *, int, __kernel_size_t);
 
 #define __HAVE_ARCH_MEMSET
 extern void * memset(void *, int, __kernel_size_t);
+extern void *__memset(void *s, int c, __kernel_size_t n);
 
 #define __HAVE_ARCH_MEMSET32
 extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
@@ -39,4 +42,18 @@ static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 	return __memset64(p, v, n * 8, v >> 32);
 }
 
+
+
+#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
+
+/*
+ * For files that not instrumented (e.g. mm/slub.c) we
+ * should use not instrumented version of mem* functions.
+ */
+
+#define memcpy(dst, src, len) __memcpy(dst, src, len)
+#define memmove(dst, src, len) __memmove(dst, src, len)
+#define memset(s, c, n) __memset(s, c, n)
+#endif
+
 #endif
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 6e0375e..c79b829 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -99,7 +99,7 @@ __mmap_switched:
  THUMB(	ldmia	r4!, {r0, r1, r2, r3} )
  THUMB(	mov	sp, r3 )
 	sub	r2, r2, r1
-	bl	memcpy				@ copy .data to RAM
+	bl	__memcpy			@ copy .data to RAM
 #endif
 
    ARM(	ldmia	r4!, {r0, r1, sp} )
@@ -107,7 +107,7 @@ __mmap_switched:
  THUMB(	mov	sp, r3 )
 	sub	r2, r1, r0
 	mov	r1, #0
-	bl	memset				@ clear .bss
+	bl	__memset			@ clear .bss
 
 	ldmia	r4, {r0, r1, r2, r3}
 	str	r9, [r0]			@ Save processor ID
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index 64111bd..79a83f8 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -61,6 +61,8 @@
 
 /* Prototype: void *memcpy(void *dest, const void *src, size_t n); */
 
+.weak memcpy
+ENTRY(__memcpy)
 ENTRY(mmiocpy)
 ENTRY(memcpy)
 
@@ -68,3 +70,4 @@ ENTRY(memcpy)
 
 ENDPROC(memcpy)
 ENDPROC(mmiocpy)
+ENDPROC(__memcpy)
diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index 69a9d47..313db6c 100644
--- a/arch/arm/lib/memmove.S
+++ b/arch/arm/lib/memmove.S
@@ -27,12 +27,14 @@
  * occurring in the opposite direction.
  */
 
+.weak memmove
+ENTRY(__memmove)
 ENTRY(memmove)
 	UNWIND(	.fnstart			)
 
 		subs	ip, r0, r1
 		cmphi	r2, ip
-		bls	memcpy
+		bls	__memcpy
 
 		stmfd	sp!, {r0, r4, lr}
 	UNWIND(	.fnend				)
@@ -225,3 +227,4 @@ ENTRY(memmove)
 18:		backward_copy_shift	push=24	pull=8
 
 ENDPROC(memmove)
+ENDPROC(__memmove)
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index ed6d35d..64aa06a 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -16,6 +16,8 @@
 	.text
 	.align	5
 
+.weak memset
+ENTRY(__memset)
 ENTRY(mmioset)
 ENTRY(memset)
 UNWIND( .fnstart         )
@@ -135,6 +137,7 @@ UNWIND( .fnstart            )
 UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
+ENDPROC(__memset)
 
 ENTRY(__memset32)
 UNWIND( .fnstart         )
-- 
2.9.0
