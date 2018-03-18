Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELuj7RYrfvHK55BvXEyaYsQCMjWMRkazwsmRkpdYL5Nu7qBvrT5ov7KmTRus4I1vnNnjTFPY
ARC-Seal: i=1; a=rsa-sha256; t=1521378848; cv=none;
        d=google.com; s=arc-20160816;
        b=GoKwdXrT2rIjaRBWr1REnZ4ma+ZdFxWnTWM6l2g1zM1IsXfEa/iVLMj3o61ZlTtQ+k
         X7bNCbQYLULz1PKguqej+728jJkAhWI/PlSJa3hVoEtIG4HlXaqoCc/14KAgC6QAz+WZ
         O7mmg9FDk6F/x99xa011hIYeWBQ3Su/E85WK1hH/FFnUDkg+V0UPNV/M4bPqLW2QSvbY
         S1CLkiz29IK5SKLUe0myJWnpAqkNDX37Xcm8ihziGYzH5oo7tYfbrFjBdbJmljTV6Cmm
         18ggr1xL1JIXdxEZ++vPave1tPfMbtPMzmUeV8kiLa91NYZNMSGynxVweZqtRWfLAIqC
         6wQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=NhNqaojmFfTv9rl95k5IBVPnSCJFoZ2OiGwfSk1pps4=;
        b=FMX4gYtowU4SVUZ0gHvq1w720vscuZzxldR4nKps4AdGDvdhbzdXB1t/l81CxS4Uhy
         G9IYKIUGtLaehwQtkHSX3IJHprACH4hkvyLj0mq4+grDkRmF0cg8x98198AeOOlz7LCm
         NWcvmIkmLhpQ4jSBt5KpmXJ4jMBGWHzRcN1oII52yb2b7Cua7NayWf6I1xaCbxe+JMmd
         jYyD+FWfHVDoJXQn31fDvY+022ckhBNauH2O9hfIfRV6RrC7x61ew4Tjf+YZcQJevdtg
         77E9FXFhn1zUKQJQJI1xfBBh2Ag/AiMcI7zcCGDw+9hgDeNQxeB41SNhxZkCkZMRt4Hh
         8X7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <linux@armlinux.org.uk>, <aryabinin@virtuozzo.com>,
	<marc.zyngier@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<liuwenliang@huawei.com>, <akpm@linux-foundation.org>,
	<afzal.mohd.ma@gmail.com>, <alexander.levin@verizon.com>
CC: <glider@google.com>, <dvyukov@google.com>, <christoffer.dall@linaro.org>,
	<linux@rasmusvillemoes.dk>, <mawilcox@microsoft.com>, <pombredanne@nexb.com>,
	<ard.biesheuvel@linaro.org>, <vladimir.murzin@arm.com>,
	<nicolas.pitre@linaro.org>, <tglx@linutronix.de>, <thgarnie@google.com>,
	<dhowells@redhat.com>, <keescook@chromium.org>, <arnd@arndb.de>,
	<geert@linux-m68k.org>, <tixy@linaro.org>, <mark.rutland@arm.com>,
	<james.morse@arm.com>, <zhichao.huang@linaro.org>, <jinb.park7@gmail.com>,
	<labbott@redhat.com>, <philip@cog.systems>, <grygorii.strashko@linaro.org>,
	<catalin.marinas@arm.com>, <opendmb@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<kvmarm@lists.cs.columbia.edu>, <linux-mm@kvack.org>
Subject: [PATCH 4/7] Replace memory function for kasan
Date: Sun, 18 Mar 2018 20:53:39 +0800
Message-ID: <20180318125342.4278-5-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180318125342.4278-1-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281347672612427?=
X-GMAIL-MSGID: =?utf-8?q?1595281347672612427?=
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

Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
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
