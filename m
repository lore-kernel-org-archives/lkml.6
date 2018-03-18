Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELu+AKwv0U8mpmfeZYTbzRP0VPr6hZ0qZK6xW39xs6Kih98HLXmPIXRrJfWROmYhIEXcpide
ARC-Seal: i=1; a=rsa-sha256; t=1521378830; cv=none;
        d=google.com; s=arc-20160816;
        b=n/y5qNbTKCQMwPBqjhhpPdV7DtOq4VD0qyYukt0jc4aleJkenBD9Hh72fNuvgbDdD8
         1HiD8NP4TyUEYFncLMskYrcwffFDkSiOamAM21QqYnYgxPIg7KYV3Pj1QKjPvKMTUX4a
         y1QLP5bXX5Dbc/YDEikYYbqMuHTkNo/eNwtHul5rWJfoSOtD+uNR1De77RpAWE4plWwx
         RiqdbNHnAir+1823+/ST26p1Pk3URoHPauop8JZAD4BWLyp/dFrYG71qu9t6+O9d65ON
         x53a+mQK3CzXNOl2rTRwvqCkYe57E/9xFaABn6oF48lr6vMo5RTIPF75OH3SUsDBDcjq
         gvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=9+sAnrjRN4VGCXvwvmg1qAhpKOCUbv4sD0W4/o9Xe3g=;
        b=KnFQmZBNumF1q+5Gc5q50+6fmeSusgOCRRKSB3zi/I97zpVAL19BcvpZIotdpHi8YU
         GbD/iXdk4YJx+ldMoINJ4hLlz1HHHQR8zas4VT2Dr0+7hRCpJ2+9m7LyK1u2pwN6RlDT
         HQdWMTFBFSPb+W/tc7rl5YpdJEPMALFlbqJQ1/t6SzhFnx7H9YkqSWnoYP1Ghozzluk3
         19BZyB6CiyAhUNzXO/oaFMA7NoSKaXZYywdndLc9w6vHJNhknnfeWs5O7Jmmq6xlSgXp
         zGOnhuKSOTHm/3YFErWU4kCj3pNGqjeaIxadDiYFDyIIBP24G7hZmSMh+iobrMc5T943
         YfPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
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
Subject: [PATCH v2 0/7] KASan for arm
Date: Sun, 18 Mar 2018 20:53:35 +0800
Message-ID: <20180318125342.4278-1-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327886471398?=
X-GMAIL-MSGID: =?utf-8?q?1595281327886471398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changelog:
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
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>

Abbott Liu (3):
  2 1-byte checks more safer for memory_is_poisoned_16
  Add TTBR operator for kasan_init
  Define the virtual space of KASan's shadow region

Andrey Ryabinin (4):
  Disable instrumentation for some code
  Replace memory function for kasan
  Initialize the mapping of KASan shadow memory
  Enable KASan for arm

 arch/arm/Kconfig                      |   1 +
 arch/arm/boot/compressed/Makefile     |   1 +
 arch/arm/boot/compressed/decompress.c |   2 +
 arch/arm/boot/compressed/libfdt_env.h |   2 +
 arch/arm/include/asm/cp15.h           | 104 ++++++++++++
 arch/arm/include/asm/kasan.h          |  23 +++
 arch/arm/include/asm/kasan_def.h      |  52 ++++++
 arch/arm/include/asm/kvm_hyp.h        |  52 ------
 arch/arm/include/asm/memory.h         |   5 +
 arch/arm/include/asm/pgalloc.h        |   7 +-
 arch/arm/include/asm/string.h         |  17 ++
 arch/arm/include/asm/thread_info.h    |   4 +
 arch/arm/kernel/entry-armv.S          |   5 +-
 arch/arm/kernel/entry-common.S        |   6 +-
 arch/arm/kernel/head-common.S         |   7 +-
 arch/arm/kernel/setup.c               |   2 +
 arch/arm/kernel/unwind.c              |   3 +-
 arch/arm/kvm/hyp/cp15-sr.c            |  12 +-
 arch/arm/kvm/hyp/switch.c             |   6 +-
 arch/arm/lib/memcpy.S                 |   3 +
 arch/arm/lib/memmove.S                |   5 +-
 arch/arm/lib/memset.S                 |   3 +
 arch/arm/mm/Makefile                  |   3 +
 arch/arm/mm/init.c                    |   6 +
 arch/arm/mm/kasan_init.c              | 290 ++++++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c                     |   7 +-
 arch/arm/mm/pgd.c                     |  14 ++
 arch/arm/vdso/Makefile                |   2 +
 mm/kasan/kasan.c                      |  24 ++-
 29 files changed, 588 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm/include/asm/kasan.h
 create mode 100644 arch/arm/include/asm/kasan_def.h
 create mode 100644 arch/arm/mm/kasan_init.c

-- 
2.9.0
