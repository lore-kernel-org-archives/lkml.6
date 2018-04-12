Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx48RmeK4XuX74Qtw6frSMFmf2AsTVoppFPipxMb5tGBq5BggyMsRAh2zh1Tei27uihdZIXSk
ARC-Seal: i=1; a=rsa-sha256; t=1523538883; cv=none;
        d=google.com; s=arc-20160816;
        b=c3FXa9OHQPJqjIRRQu1l0I9EIfgLkZumLUYkQzcbXmLxRxSaMNoHPP7jMbC9h0EdX5
         qJdduViEs6BEQYCoRagvofhRvUnehc4tZE/OiZZ1E+Ga24QXhiVZlPwyY+bDsQAiMGJP
         kdUSnxnFyLe5CfhNA3H0FuIkbLZsNJVAwVkS9z9uxaGBBk4hD97DKoQEO+7ySM5Ug/uN
         mdUIusaxx/UBzC0OQ80gtcwIICCtAUm9WyqKyGuHZtDfRKORbtYlaGGRLzvc+s+okaw3
         UY42Y4Kv2pWkozgeYdTMwelcUl9LNcxsemtpF/gQPpLjzJEEr5xiX1K83pYknNPCnVsr
         /qaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=3vnx6Tyb5wvY864h2WL0+nfNcZmFAIU33gxK2DcHZhM=;
        b=keKfwvXAhZO/oQdz9GUbmuudm54TJ+mejv2kvnBFAei9h3O5WnWtTKJ5SkdAOn4YNH
         mBsN1fxnf8+u2E53DWYAqpKo3YoaXyrUzfQTtu9z0eNpHiDvcpiJ7O6r71RpHfkwuqhg
         EfUtI+Ir/XbcpEBsDI9QMAYoMuXJQK7yybSwSwSynG8PenNNKHr6+jiiwmq+tELV7XXA
         5Tt2QRSfnIzxneZwFPgTPUeoW5ipIX732NzQKaMzHk2ewrZMzdPjO/eTbH5wd7GmSREI
         fgT3nlZYeGaSgRA3ke8frhXNOKyKuN0hCny2DZYXQ4pdiQW9hWkQuRw0Kih4FUOIs7nC
         As0w==
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
Subject: [PATCH 0/6] KASan for arm
Date: Thu, 12 Apr 2018 20:54:05 +0800
Message-ID: <20180412125411.326-1-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597546308387361224?=
X-GMAIL-MSGID: =?utf-8?q?1597546308387361224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Ryabinin <a.ryabinin@samsung.com>

Changelog:
v4 - v3
- Remove the fix of type conversion in kasan_cache_create because it has
  been fix in the latest version in:
  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
- Change some Reviewed-by tag into Reported-by tag to avoid misleading.
  ---Reported by: Marc Zyngier <marc.zyngier@arm.com>
                  Russell King - ARM Linux <linux@armlinux.org.uk>
- Disable instrumentation for arch/arm/mm/physaddr.c

v3 - v2
- Remove this patch: 2 1-byte checks more safer for memory_is_poisoned_16
  because a unaligned load/store of 16 bytes is rare on arm, and this
  patch is very likely to affect the performance of modern CPUs.
  ---Acked by: Russell King - ARM Linux <linux@armlinux.org.uk>
- Fixed some link error which kasan_pmd_populate,kasan_pte_populate and
  kasan_pud_populate are in section .meminit.text but the function
  kasan_alloc_block which is called by kasan_pmd_populate,
  kasan_pte_populate and kasan_pud_populate is in section .init.text. So
  we need change kasan_pmd_populate,kasan_pte_populate and
  kasan_pud_populate into the section .init.text.
  ---Reported by: Florian Fainelli <f.fainelli@gmail.com>
- Fixed some compile error which caused by the wrong access instruction in
  arch/arm/kernel/entry-common.S.
  ---Reported by: kbuild test robot <lkp@intel.com>
- Disable instrumentation for arch/arm/kvm/hyp/*.
  ---Acked by: Marc Zyngier <marc.zyngier@arm.com>
- Update the set of supported architectures in
  Documentation/dev-tools/kasan.rst.
  ---Acked by:Dmitry Vyukov <dvyukov@google.com>
- The version 2 is tested by:
  Florian Fainelli <f.fainelli@gmail.com> (compile test)
  kbuild test robot <lkp@intel.com>       (compile test)
  Joel Stanley <joel@jms.id.au>           (on ASPEED ast2500(ARMv5))

v2 - v1
- Fixed some compiling error which happens on changing kernel compression
  mode to lzma/xz/lzo/lz4.
  ---Reported by: Florian Fainelli <f.fainelli@gmail.com>,
             Russell King - ARM Linux <linux@armlinux.org.uk>
- Fixed a compiling error cause by some older arm instruction set(armv4t)
  don't suppory movw/movt which is reported by kbuild.
- Changed the pte flag from _L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN to
  pgprot_val(PAGE_KERNEL).
  ---Reported by: Russell King - ARM Linux <linux@armlinux.org.uk>
- Moved Enable KASan patch as the last one.
  ---Reported by: Florian Fainelli <f.fainelli@gmail.com>,
     Russell King - ARM Linux <linux@armlinux.org.uk>
- Moved the definitions of cp15 registers from
  arch/arm/include/asm/kvm_hyp.h to arch/arm/include/asm/cp15.h.
  ---Asked by: Mark Rutland <mark.rutland@arm.com>
- Merge the following commits into the commit
  Define the virtual space of KASan's shadow region:
  1) Define the virtual space of KASan's shadow region;
  2) Avoid cleaning the KASan shadow area's mapping table;
  3) Add KASan layout;
- Merge the following commits into the commit
  Initialize the mapping of KASan shadow memory:
  1) Initialize the mapping of KASan shadow memory;
  2) Add support arm LPAE;
  3) Don't need to map the shadow of KASan's shadow memory;
     ---Reported by: Russell King - ARM Linux <linux@armlinux.org.uk>
  4) Change mapping of kasan_zero_page int readonly.
- The version 1 is tested by Florian Fainelli <f.fainelli@gmail.com>
  on a Cortex-A5 (no LPAE).

Hi,all:
   These patches add arch specific code for kernel address sanitizer
(see Documentation/kasan.txt).

   1/8 of kernel addresses reserved for shadow memory. There was no
big enough hole for this, so virtual addresses for shadow were
stolen from user space.

   At early boot stage the whole shadow region populated with just
one physical page (kasan_zero_page). Later, this page reused
as readonly zero shadow for some memory that KASan currently
don't track (vmalloc).

  After mapping the physical memory, pages for shadow memory are
allocated and mapped.

  KASan's stack instrumentation significantly increases stack's
consumption, so CONFIG_KASAN doubles THREAD_SIZE.

  Functions like memset/memmove/memcpy do a lot of memory accesses.
If bad pointer passed to one of these function it is important
to catch this. Compiler's instrumentation cannot do this since
these functions are written in assembly.

  KASan replaces memory functions with manually instrumented variants.
Original functions declared as weak symbols so strong definitions
in mm/kasan/kasan.c could replace them. Original functions have aliases
with '__' prefix in name, so we could call non-instrumented variant
if needed.

  Some files built without kasan instrumentation (e.g. mm/slub.c).
Original mem* function replaced (via #define) with prefixed variants
to disable memory access checks for such files.

  On arm LPAE architecture,  the mapping table of KASan shadow memory(if
PAGE_OFFSET is 0xc0000000, the KASan shadow memory's virtual space is
0xb6e000000~0xbf000000) can't be filled in do_translation_fault function,
because kasan instrumentation maybe cause do_translation_fault function
accessing KASan shadow memory. The accessing of KASan shadow memory in
do_translation_fault function maybe cause dead circle. So the mapping table
of KASan shadow memory need be copyed in pgd_alloc function.


Most of the code comes from:
https://github.com/aryabinin/linux/commit/0b54f17e70ff50a902c4af05bb92716eb95acefe

These patches are tested on vexpress-ca15, vexpress-ca9


Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>

Abbott Liu (2):
  Add TTBR operator for kasan_init
  Define the virtual space of KASan's shadow region

Andrey Ryabinin (4):
  Disable instrumentation for some code
  Replace memory function for kasan
  Initialize the mapping of KASan shadow memory
  Enable KASan for arm

 Documentation/dev-tools/kasan.rst     |   2 +-
 arch/arm/Kconfig                      |   1 +
 arch/arm/boot/compressed/Makefile     |   1 +
 arch/arm/boot/compressed/decompress.c |   2 +
 arch/arm/boot/compressed/libfdt_env.h |   2 +
 arch/arm/include/asm/cp15.h           | 104 ++++++++++++
 arch/arm/include/asm/kasan.h          |  35 ++++
 arch/arm/include/asm/kasan_def.h      |  64 +++++++
 arch/arm/include/asm/kvm_hyp.h        |  52 ------
 arch/arm/include/asm/memory.h         |   5 +
 arch/arm/include/asm/pgalloc.h        |   7 +-
 arch/arm/include/asm/string.h         |  17 ++
 arch/arm/include/asm/thread_info.h    |   4 +
 arch/arm/kernel/entry-armv.S          |   5 +-
 arch/arm/kernel/entry-common.S        |   9 +-
 arch/arm/kernel/head-common.S         |   7 +-
 arch/arm/kernel/setup.c               |   2 +
 arch/arm/kernel/unwind.c              |   3 +-
 arch/arm/kvm/hyp/Makefile             |   4 +
 arch/arm/kvm/hyp/cp15-sr.c            |  12 +-
 arch/arm/kvm/hyp/switch.c             |   6 +-
 arch/arm/lib/memcpy.S                 |   3 +
 arch/arm/lib/memmove.S                |   5 +-
 arch/arm/lib/memset.S                 |   3 +
 arch/arm/mm/Makefile                  |   4 +
 arch/arm/mm/init.c                    |   6 +
 arch/arm/mm/kasan_init.c              | 302 ++++++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c                     |   7 +-
 arch/arm/mm/pgd.c                     |  14 ++
 arch/arm/vdso/Makefile                |   2 +
 30 files changed, 616 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm/include/asm/kasan.h
 create mode 100644 arch/arm/include/asm/kasan_def.h
 create mode 100644 arch/arm/mm/kasan_init.c

-- 
2.9.0
