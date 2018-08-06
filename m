Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336EEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC481219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC481219EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeHFLU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:20:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:40461 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeHFLU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:20:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 02:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,451,1526367600"; 
   d="scan'208";a="63814325"
Received: from huama-mobl.gar.corp.intel.com (HELO [10.226.38.40]) ([10.226.38.40])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2018 02:12:45 -0700
Subject: Re: [PATCH v2 01/18] MIPS: intel: Add initial support for Intel MIPS
 SoCs
To:     Paul Burton <paul.burton@mips.com>,
        Songjun Wu <songjun.wu@linux.intel.com>
Cc:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-2-songjun.wu@linux.intel.com>
 <20180803174924.iqzmbtz5hrf5dlzu@pburton-laptop>
From:   Hua Ma <hua.ma@linux.intel.com>
Message-ID: <58a846cc-6964-8de3-2f0e-a131ed995a67@linux.intel.com>
Date:   Mon, 6 Aug 2018 17:12:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803174924.iqzmbtz5hrf5dlzu@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2018 1:49 AM, Paul Burton wrote:
> Hi Songjun / Hua,
>
> On Fri, Aug 03, 2018 at 11:02:20AM +0800, Songjun Wu wrote:
>> From: Hua Ma <hua.ma@linux.intel.com>
>>
>> Add initial support for Intel MIPS interAptiv SoCs made by Intel.
>> This series will add support for the grx500 family.
>>
>> The series allows booting a minimal system using a initramfs.
> Thanks for submitting this - I have some comments below.
Thanks for the review.

>> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
>> index ac7ad54f984f..bcd647060f3e 100644
>> --- a/arch/mips/Kbuild.platforms
>> +++ b/arch/mips/Kbuild.platforms
>> @@ -12,6 +12,7 @@ platforms += cobalt
>>   platforms += dec
>>   platforms += emma
>>   platforms += generic
>> +platforms += intel-mips
>>   platforms += jazz
>>   platforms += jz4740
>>   platforms += lantiq
> Oh EVA, why must you ruin nice things... Ideally I'd be suggesting that
> we use the generic platform but it doesn't yet have a nice way to deal
> with non-standard EVA setups.
yes, we only support EVA.

> It would be good if we could make sure that's the only reason for your
> custom platform though, so that once generic does support EVA we can
> migrate your system over. Most notably, it would be good to make use of
> the UHI-specified boot protocol if possible (ie. $r4==-2, $r5==&dtb).
>
> It looks like your prom_init_cmdline() supports multiple boot protocols
> - could you clarify which is actually used?
this patch only support build-in dts, we will do a clean up.

>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 08c10c518f83..2d34f17f3e24 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -409,6 +409,34 @@ config LANTIQ
>>   	select ARCH_HAS_RESET_CONTROLLER
>>   	select RESET_CONTROLLER
>>   
>> +config INTEL_MIPS
>> +	bool "Intel MIPS interAptiv SoC based platforms"
>> +	select BOOT_RAW
>> +	select CEVT_R4K
>> +	select COMMON_CLK
>> +	select CPU_MIPS32_3_5_EVA
>> +	select CPU_MIPS32_3_5_FEATURES
>> +	select CPU_MIPSR2_IRQ_EI
>> +	select CPU_MIPSR2_IRQ_VI
>> +	select CSRC_R4K
>> +	select DMA_NONCOHERENT
>> +	select GENERIC_ISA_DMA
>> +	select IRQ_MIPS_CPU
>> +	select MFD_CORE
>> +	select MFD_SYSCON
>> +	select MIPS_CPU_SCACHE
>> +	select MIPS_GIC
>> +	select SYS_HAS_CPU_MIPS32_R1
> For a system based on interAptiv you should never need to build a
> MIPS32r1 kernel, so you should remove the above select.
will remove.

>> diff --git a/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h b/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
>> new file mode 100644
>> index 000000000000..ac5f3b943d2a
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
>> @@ -0,0 +1,61 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This file was derived from: include/asm-mips/cpu-features.h
>> + *	Copyright (C) 2003, 2004 Ralf Baechle
>> + *	Copyright (C) 2004 Maciej W. Rozycki
>> + *	Copyright (C) 2018 Intel Corporation.
>> + */
>> +
>> +#ifndef __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H
>> +#define __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H
>> +
>> +#define cpu_has_tlb		1
>> +#define cpu_has_4kex		1
>> +#define cpu_has_3k_cache	0
>> +#define cpu_has_4k_cache	1
>> +#define cpu_has_tx39_cache	0
>> +#define cpu_has_sb1_cache	0
>> +#define cpu_has_fpu		0
>> +#define cpu_has_32fpr		0
>> +#define cpu_has_counter		1
>> +#define cpu_has_watch		1
>> +#define cpu_has_divec		1
>> +
>> +#define cpu_has_prefetch	1
>> +#define cpu_has_ejtag		1
>> +#define cpu_has_llsc		1
>> +
>> +#define cpu_has_mips16		0
>> +#define cpu_has_mdmx		0
>> +#define cpu_has_mips3d		0
>> +#define cpu_has_smartmips	0
>> +#define cpu_has_mmips		0
>> +#define cpu_has_vz		0
>> +
>> +#define cpu_has_mips32r1	1
>> +#define cpu_has_mips32r2	1
>> +#define cpu_has_mips64r1	0
>> +#define cpu_has_mips64r2	0
>> +
>> +#define cpu_has_dsp		1
>> +#define cpu_has_dsp2		0
>> +#define cpu_has_mipsmt		1
>> +
>> +#define cpu_has_vint		1
>> +#define cpu_has_veic		0
>> +
>> +#define cpu_has_64bits		0
>> +#define cpu_has_64bit_zero_reg	0
>> +#define cpu_has_64bit_gp_regs	0
>> +#define cpu_has_64bit_addresses	0
>> +
>> +#define cpu_has_cm2		1
>> +#define cpu_has_cm2_l2sync	1
>> +#define cpu_has_eva		1
>> +#define cpu_has_tlbinv		1
>> +
>> +#define cpu_dcache_line_size()	32
>> +#define cpu_icache_line_size()	32
>> +#define cpu_scache_line_size()	32
> If you rebase atop linux-next or mips-next then you should find that
> many of these defines are now redundant, especially after removing the
> SYS_HAS_CPU_MIPS32_R1 select which means your kernel build will always
> target MIPS32r2.
>
> Due to architectural restrictions on where various options can be
> present, you should be able to remove:
>
>    - cpu_has_4kex
>    - cpu_has_3k_cache
>    - cpu_has_4k_cache
>    - cpu_has_32fpr
>    - cpu_has_divec
>    - cpu_has_prefetch
>    - cpu_has_llsc
>
> cpu_has_mmips defaults to a compile-time zero unless you select
> CONFIG_SYS_SUPPORTS_MICROMIPS, so please remove that one.
>
> cpu_has_64bit_gp_regs & cpu_has_64bit_addresses both default to zero
> already for 32bit kernel builds, so please remove those.
>
> cpu_has_cm2 & cpu_has_cm2_l2sync don't exist anywhere in-tree, so please
> remove those.
>
> Additionally cpu_has_sb1_cache is not used anywhere, or defined by
> asm/cpu-features.h & seems to just be left over in some platform
> override files including presumably one you based yours on. Please
> remove it too.
Thanks, will remove.

> Also you select CPU_MIPSR2_IRQ_EI but define cpu_has_veic as 0, could
> you check that mismatch?
The hardware does support, but the software does not support.

>> diff --git a/arch/mips/include/asm/mach-intel-mips/irq.h b/arch/mips/include/asm/mach-intel-mips/irq.h
>> new file mode 100644
>> index 000000000000..12a949084856
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-intel-mips/irq.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *  Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
>> + *  Copyright (C) 2018 Intel Corporation.
>> + */
>> +
>> +#ifndef __INTEL_MIPS_IRQ_H
>> +#define __INTEL_MIPS_IRQ_H
>> +
>> +#define MIPS_CPU_IRQ_BASE	0
>> +#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
> These 2 defines are the defaults anyway, so please remove them.
Thanks, will remove.
>> +#define NR_IRQS 256
> And if you don't actually need this then you could remove irq.h entirely
> - do you actually use more than 128 IRQs?
Yes, the hardware support 256 IRQs.

>> diff --git a/arch/mips/include/asm/mach-intel-mips/spaces.h b/arch/mips/include/asm/mach-intel-mips/spaces.h
>> new file mode 100644
>> index 000000000000..80e7b09f712c
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-intel-mips/spaces.h
>> % >% >%
>> +#define IO_SIZE			_AC(0x10000000, UL)
>> +#define IO_SHIFT		_AC(0x10000000, UL)
> These IO_ defines don't appear to be used anywhere?
Thanks, will remove.

>> +/* IO space one */
>> +#define __pa_symbol(x)		__pa(x)
> Can you explain why you need this, rather than the default definition of
> __pa_symbol()? The comment doesn't seem to describe much of anything.
Thanks, will remove.

>> diff --git a/arch/mips/include/asm/mach-intel-mips/war.h b/arch/mips/include/asm/mach-intel-mips/war.h
>> new file mode 100644
>> index 000000000000..1c95553151e1
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-intel-mips/war.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_MIPS_MACH_INTEL_MIPS_WAR_H
>> +#define __ASM_MIPS_MACH_INTEL_MIPS_WAR_H
>> +
>> +#define R4600_V1_INDEX_ICACHEOP_WAR	0
>> +#define R4600_V1_HIT_CACHEOP_WAR	0
>> +#define R4600_V2_HIT_CACHEOP_WAR	0
>> +#define R5432_CP0_INTERRUPT_WAR		0
>> +#define BCM1250_M3_WAR			0
>> +#define SIBYTE_1956_WAR			0
>> +#define MIPS4K_ICACHE_REFILL_WAR	0
>> +#define MIPS_CACHE_SYNC_WAR		0
>> +#define TX49XX_ICACHE_INDEX_INV_WAR	0
>> +#define ICACHE_REFILLS_WORKAROUND_WAR	0
>> +#define R10000_LLSC_WAR			0
>> +#define MIPS34K_MISSED_ITLB_WAR		0
>> +
>> +#endif /* __ASM_MIPS_MACH_INTEL_MIPS_WAR_H */
> Since you need none of these workarounds, you shouldn't need war.h at
> all.
Thanks, will remove this file.

>> diff --git a/arch/mips/intel-mips/Kconfig b/arch/mips/intel-mips/Kconfig
>> new file mode 100644
>> index 000000000000..35d2ae2b5408
>> --- /dev/null
>> +++ b/arch/mips/intel-mips/Kconfig
>> @@ -0,0 +1,22 @@
>> +if INTEL_MIPS
>> +
>> +choice
>> +	prompt "Built-in device tree"
>> +	help
>> +	  Legacy bootloaders do not pass a DTB pointer to the kernel, so
>> +	  if a "wrapper" is not being used, the kernel will need to include
>> +	  a device tree that matches the target board.
>> +
>> +	  The builtin DTB will only be used if the firmware does not supply
>> +	  a valid DTB.
>> +
>> +config DTB_INTEL_MIPS_NONE
>> +	bool "None"
>> +
>> +config DTB_INTEL_MIPS_GRX500
>> +	bool "Intel MIPS GRX500 Board"
>> +	select BUILTIN_DTB
>> +
>> +endchoice
>> +
>> +endif
> So do you actually have both styles of bootloader?
this patch only support the build-in, will do a clean up.

>> diff --git a/arch/mips/intel-mips/prom.c b/arch/mips/intel-mips/prom.c
>> new file mode 100644
>> index 000000000000..a1b1393c13bc
>> --- /dev/null
>> +++ b/arch/mips/intel-mips/prom.c
>> % >% >%
>> +static void __init prom_init_cmdline(void)
>> +{
>> +	int i;
>> +	int argc;
>> +	char **argv;
>> +
>> +	/*
>> +	 * If u-boot pass parameters, it is ok, however, if without u-boot
>> +	 * JTAG or other tool has to reset all register value before it goes
>> +	 * emulation most likely belongs to this category
>> +	 */
>> +	if (fw_arg0 == 0 || fw_arg1 == 0)
>> +		return;
> I don't understand what you're trying to say here, or why this check
> exists. If you boot with fw_arg0 == fw_arg1 == 0 then you'd just hit the
> loop below right, and execute zero iterations of it? That seems like it
> would be fine without this special case.
this patch do not support this , will remove.

>> +	/*
>> +	 * a0: fw_arg0 - the number of string in init cmdline
>> +	 * a1: fw_arg1 - the address of string in init cmdline
>> +	 *
>> +	 * In accordance with the MIPS UHI specification,
>> +	 * the bootloader can pass the following arguments to the kernel:
>> +	 * - $a0: -2.
>> +	 * - $a1: KSEG0 address of the flattened device-tree blob.
>> +	 */
>> +	if (fw_arg0 == -2)
>> +		return;
>> +
>> +	argc = fw_arg0;
>> +	argv = (char **)KSEG1ADDR(fw_arg1);
>> +
>> +	arcs_cmdline[0] = '\0';
>> +
>> +	for (i = 0; i < argc; i++) {
>> +		char *p = (char *)KSEG1ADDR(argv[i]);
>> +
>> +		if (argv[i] && *p) {
>> +			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
>> +			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
>> +		}
>> +	}
> Why do you need to use kseg1? Why can't the arguments be accessed
> cached?
>
> Are the arguments passed as virtual or physical addresses? If virtual &
> we can access them cached then you could replace all of this with a call
> to fw_init_cmdline().
this patch only support build-in dts, will remove .

>> +static int __init plat_enable_iocoherency(void)
>> +{
>> +	if (!mips_cps_numiocu(0))
>> +		return 0;
>> +
>> +	/* Nothing special needs to be done to enable coherency */
>> +	pr_info("Coherence Manager IOCU detected\n");
>> +	/* Second IOCU for MPE or other master access register */
>> +	write_gcr_reg0_base(0xa0000000);
>> +	write_gcr_reg0_mask(0xf8000000 | CM_GCR_REGn_MASK_CMTGT_IOCU1);
>> +	return 1;
>> +}
>> +
>> +static void __init plat_setup_iocoherency(void)
>> +{
>> +	if (plat_enable_iocoherency() &&
>> +	    coherentio == IO_COHERENCE_DISABLED) {
>> +		pr_info("Hardware DMA cache coherency disabled\n");
>> +		return;
>> +	}
>> +	panic("This kind of IO coherency is not supported!");
>> +}
> Since you select CONFIG_DMA_NONCOHERENT in Kconfig, coherentio will
> always equal IO_COHERENCE_DISABLED. That suggests to me that the above 2
> functions are probably useless, or at least needlessly convoluted.
Thanks, will remove.

>> +static int __init plat_publish_devices(void)
>> +{
>> +	if (!of_have_populated_dt())
>> +		return 0;
>> +	return of_platform_populate(NULL, of_default_bus_match_table, NULL,
>> +				    NULL);
>> +}
>> +arch_initcall(plat_publish_devices);
> The core DT code calls of_platform_populate() already (see
> of_platform_default_populate_init()), so you can remove this function.
>
> Thanks,
>      Paul
Thanks, will remove.

