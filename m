Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D9DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CD021927
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406693AbfBNSWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:22:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49046 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728922AbfBNSWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:22:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2204CEBD;
        Thu, 14 Feb 2019 10:22:54 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDA703F557;
        Thu, 14 Feb 2019 10:22:52 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
To:     Mark Rutland <mark.rutland@arm.com>,
        "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     'Will Deacon' <will.deacon@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
 <20190214155605.GC27547@lakrids.cambridge.arm.com>
Message-ID: <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
Date:   Thu, 14 Feb 2019 18:22:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214155605.GC27547@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 14/02/2019 15:56, Mark Rutland wrote:
> On Thu, Feb 14, 2019 at 07:26:24AM +0000, Zhang, Lei wrote:
>> On the Fujitsu-A64FX cores ver(1.0, 1.1), memory access may
>> cause an undefined fault (Data abort, DFSC=0b111111).
>> This fault occurs under a specific hardware condition when a
>> load/store instruction performs an address translation.
>> Any load/store instruction, except non-fault access
>> including Armv8 and SVE might cause this undefined fault.
>>
>> Since this erratum occurs only when TCR_ELx.NFD1=1,
>> I keep TCR_ELx.NFD1=0 during EL1/EL2.
>>
>> By doing above, the erratum occurs only in EL0.
>> I deal with this erratum in EL0 by a new fault handler
>> which ignores this undefined fault.

>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a4168d3..7c76c66 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -643,6 +643,29 @@ config QCOM_FALKOR_ERRATUM_E1041
>>  
>>  	  If unsure, say Y.
>>  
>> +config FUJITSU_ERRATUM_010001
>> +	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
>> +        depends on RANDOMIZE_BASE
>> +        default RANDOMIZE_BASE
>> +	help
>> +	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
>> +	  On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1), memory accesses
>> +	  may cause undefined fault (Data abort, DFSC=0b111111).
>> +	  This fault occurs under a specific hardware condition when a load/store
>> +          instruction performs an address translation using:
>> +	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
>> +	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
>> +	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
>> +	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
>> +
>> +	  The workaround is to set '0' to TCR_ELx.NFD1 at kernel-entry,
>> +	  to set '1' at kernel-exit. And also replace the fault handler
>> +	  for Data abort DFSC=0b111111 with a new fault handler to ignore this
>> +	  undefined fault.
>> +	  The workaround only affect the Fujitsu-A64FX.
> 
> I think that per Will's last comment, the expectation was that NFD1
> would be configured once in C code, rather than in the entry assembly.
> 
> Your code seems to expect KPTI is enabled, and if that's the case, NFD1
> doesn't provide much security benefit,

We only set NFD1 when KASLR is in use, which would also enable KPTI if
CONFIG_UNMAP_KERNEL_AT_EL0 is compiled in. Details in e03e61c3173 ("arm64: kaslr: Set
TCR_EL1.NFD1 when CONFIG_RANDOMIZE_BASE=y")


> and it would be vastly simpler to set this in a cpufeature callback.

A64FX needs it to be unset unless you can handle the spurious fault. The
cpufeature callback would need to run for un-affected CPUs to set the TCR bit.


>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 0ec0c46..34a4f44 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -940,6 +940,14 @@ alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
>>  	dsb	nsh
>>  alternative_else_nop_endif
>>  #endif /* CONFIG_QCOM_FALKOR_ERRATUM_1003 */
>> +#ifdef CONFIG_FUJITSU_CPU_PART_A64FX
>> +alternative_if ARM64_WORKAROUND_FUJITSU_A64FX_0100001
>> +	mrs	\tmp, tcr_el1
>> +	and	\tmp, \tmp, #0xffbfffffffffffff
> 
> If this has to be written in assembly, it would be better as:
> 
> 	bic	\tmp, \tmp, #TCR_NFD1
> 	
>> +	msr	tcr_el1,\tmp
>> +	isb
>> +alternative_else_nop_endif
>> +#endif /* CONFIG_FUJITSU_CPU_PART_A64FX */
>>  	.endm

This TCR swivel has to be done before we make any memory accesses. If we ever
need another register in the trampoline we're going to be in trouble.


>>  	.macro tramp_unmap_kernel, tmp
>> @@ -952,6 +960,14 @@ alternative_else_nop_endif
>>  	 * it's only needed by Cavium ThunderX, which requires KPTI to be
>>  	 * disabled.
>>  	 */
>> +#ifdef CONFIG_FUJITSU_CPU_PART_A64FX
>> +alternative_if ARM64_WORKAROUND_FUJITSU_A64FX_0100001
>> +	mrs	\tmp, tcr_el1
>> +	orr	\tmp, \tmp, #0x40000000000000
> 
> Likewise:
> 	
> 	orr	\tmp, \tmp, #TCR_NFD1
> 
>> +	msr	tcr_el1,\tmp
>> +	isb
>> +alternative_else_nop_endif
>> +#endif /* CONFIG_FUJITSU_CPU_PART_A64FX */
>>  	.endm
>>  
>>  	.macro tramp_ventry, regsize = 64

>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index efb7b2c..1bf0377 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -666,6 +666,20 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>  	return 0;
>>  }
>>  
>> +static int do_bad_unknown_63(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>> +{
>> +	/*
>> +	 * On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
>> +	 * memory accesses may spuriously trigger data aborts with
>> +	 * DFSC=0b111111.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_FUJITSU_ERRATUM_010001) &&
>> +		cpus_have_cap(ARM64_WORKAROUND_FUJITSU_A64FX_0100001))
>> +			return 0;
>> +	return do_bad(addr, esr, regs);
>> +}
> 
> If we always left NFD1 clear on A64FX, we would not need this exception
> handler, as this should never occur.

I think we should do this: never set NFDx on A64FX. I don't think we can maintain the TCR
swivel before any memory access in the KPTI trampoline. (It already uses the FAR as a
scratch register!)

The errata means we can't use these bits. Its simpler than trying to work around the symptoms.


>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 73886a5..75f7d99 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -453,9 +453,29 @@ ENTRY(__cpu_setup)
>>  	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
>>  	 * both user and kernel.
>>  	 */
>> +#ifdef CONFIG_FUJITSU_ERRATUM_010001
>>  	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
>>  			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
>>  			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
>> +	/* Can use x19/x20/x5 */
>> +	mrs     x19, midr_el1
>> +	/* ERRATA_MIDR_RANGE(MIDR_FUJITSU_A64FX, 0, 0, 1, 0) */
>> +	mov	w20, #0x10	//#16
>> +	movk	w20, #0x460f, lsl #16
>> +	mov	w5, #0xffefffff

Hmmm.... this is masking out the least-significant variant bit, to make it match
your 1.0 and 1.1. This could be much more readable with some pre-processor trickery.

We should also move it out to a macro so the average reader of __cpu_setup() doesn't need
to parse it.


> Please do this detection and reconfiguration of TCR in C code, rather
> than in the __cpu_setup code.
> 
> In proc.S you can have:
> 
> #if defined(CONFIG_RANDOMIZE_BASE) && !defined(CONFIG_FUJITSU_ERRATUM_010001)
> #define KASLR_FLAGS	TCR_NFD1
> #else
> #define KASLR_FLAGS	0
> #endif
> 
> ... and in cpu_errata.c you can enable NFD1 on any CPU which is not
> A64FX.

I think having an errata callback that runs on unaffected cores is tricky. ("CPU
feature: Not affected by E010001").
As a halfway house, I have the below[0] simplified version of Zhang Lei's patch. It
doesn't do the TCR swivel in C, just masks out the TCR values on affected CPUs. I
obviously haven't tested this on an affected platform.


Thanks,

James

--------------------%<--------------------
From 41543072930af63f3229a5384061fe3bc1efd19a Mon Sep 17 00:00:00 2001
From: Zhang Lei <zhang.lei@jp.fujitsu.com>
Date: Thu, 14 Feb 2019 07:26:24 +0000
Subject: [PATCH] arm64: Add workaround for Fujitsu A64FX erratum 010001

On the Fujitsu-A64FX cores ver(1.0, 1.1), memory access may cause
an undefined fault (Data abort, DFSC=0b111111). This fault occurs under
a specific hardware condition when a load/store instruction performs an
address translation. Any load/store instruction, except non-fault access
including Armv8 and SVE might cause this undefined fault.

The TCR_ELx.NFD1 bit is used by the kernel when CONFIG_RANDOMIZE_BASE
is enabled to mitigate timing attacks against KASLR where the kernel
address space could be probed using the FFR and suppressed fault on
SVE loads.

Since this erratum causes spurious exceptions, which may overwrite
the exception registers, we clear the TCR_ELx.NFDx=1 bits when
booting on an affected CPU.

Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
[Generated MIDR value/mask for __cpu_setup(), removed spurious-fault handler
 and always disabled the NFDx bits on affected CPUs]
Signed-off-by: James Morse <james.morse@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 19 +++++++++++++++++++
 arch/arm64/include/asm/assembler.h     | 20 ++++++++++++++++++++
 arch/arm64/include/asm/cputype.h       |  9 +++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/mm/proc.S                   |  1 +
 6 files changed, 51 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 1f09d043d086..26d64e9f3a35 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -80,3 +80,4 @@ stable kernels.
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
 | Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
+| Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..b0b7f1c4e816 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -643,6 +643,25 @@ config QCOM_FALKOR_ERRATUM_E1041

 	  If unsure, say Y.

+config FUJITSU_ERRATUM_010001
+	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
+	default y
+	help
+	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
+	  On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1), memory
+	  accesses may cause undefined fault (Data abort, DFSC=0b111111).
+	  This fault occurs under a specific hardware condition when a
+	  load/store instruction performs an address translation using:
+	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
+	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
+	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
+	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
+
+	  The workaround is to ensure these bits are clear in TCR_ELx.
+	  The workaround only affect the Fujitsu-A64FX.
+
+	  If unsure, say Y.
+
 endmenu


diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 4feb6119c3c9..128d0fbfcb24 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -27,6 +27,7 @@

 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
+#include <asm/cputype.h>
 #include <asm/debug-monitors.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
@@ -604,6 +605,25 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 #endif
 	.endm

+/*
+ * tcr_clear_errata_bits - Clear TCR bits that trigger an errata on this CPU.
+ */
+	.macro	tcr_clear_errata_bits, tcr, tmp1, tmp2
+#ifdef CONFIG_FUJITSU_ERRATUM_010001
+	mrs	\tmp1, midr_el1
+
+	mov_q	\tmp2, MIDR_FUJITSU_ERRATUM_010001_MASK
+	and	\tmp1, \tmp1, \tmp2
+	mov_q	\tmp2, MIDR_FUJITSU_ERRATUM_010001
+	cmp	\tmp1, \tmp2
+	b.ne	10f
+
+	mov_q	\tmp2, TCR_CLEAR_FUJITSU_ERRATUM_010001
+	bic	\tcr, \tcr, \tmp2
+10:
+#endif /* CONFIG_FUJITSU_ERRATUM_010001 */
+	.endm
+
 /**
  * Errata workaround prior to disable MMU. Insert an ISB immediately prior
  * to executing the MSR that will change SCTLR_ELn[M] from a value of 1 to 0.
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 951ed1a4e5c9..c6c6b4de0688 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -76,6 +76,7 @@
 #define ARM_CPU_IMP_BRCM		0x42
 #define ARM_CPU_IMP_QCOM		0x51
 #define ARM_CPU_IMP_NVIDIA		0x4E
+#define ARM_CPU_IMP_FUJITSU		0x46

 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -104,6 +105,8 @@
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004

+#define FUJITSU_CPU_PART_A64FX		0x001
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -122,6 +125,12 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
+#define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
+
+/* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
+#define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
+#define MIDR_FUJITSU_ERRATUM_010001_MASK	~MIDR_VARIANT(1);
+#define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_NFD1 | TCR_NFD0)

 #ifndef __ASSEMBLY__

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index e9b0a7d75184..a69259cc1f16 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -302,6 +302,7 @@
 #define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
+#define TCR_NFD0		(UL(1) << 53)
 #define TCR_NFD1		(UL(1) << 54)

 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 73886a5f1f30..750e9f0500db 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -456,6 +456,7 @@ ENTRY(__cpu_setup)
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
+	tcr_clear_errata_bits x10, x9, x5

 #ifdef CONFIG_ARM64_USER_VA_BITS_52
 	ldr_l		x9, vabits_user
-- 
2.20.1
--------------------%<--------------------
