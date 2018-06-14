Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 27F8EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC7208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC7208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754880AbeFNJYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:24:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:62780 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754664AbeFNJYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:24:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 02:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="49274152"
Received: from zhuyixin-mobl1.gar.corp.intel.com (HELO [10.226.38.83]) ([10.226.38.83])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2018 02:24:36 -0700
Subject: Re: [PATCH 3/7] MIPS: intel: Add initial support for Intel MIPS SoCs
To:     James Hogan <jhogan@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, chuanhua.lei@linux.intel.com,
        linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-4-songjun.wu@linux.intel.com>
 <20180612112346.GA8748@jamesdev>
From:   yixin zhu <yixin.zhu@linux.intel.com>
Message-ID: <69475880-5b64-4b51-b92f-d2dac011c7ed@linux.intel.com>
Date:   Thu, 14 Jun 2018 17:24:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180612112346.GA8748@jamesdev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2018 7:23 PM, James Hogan wrote:
> Hi,
> 
> Good to see this patch!
> 
> On Tue, Jun 12, 2018 at 01:40:30PM +0800, Songjun Wu wrote:
>> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
>> index ac7ad54f984f..bcd647060f3e 100644
>> --- a/arch/mips/Kbuild.platforms
>> +++ b/arch/mips/Kbuild.platforms
>> @@ -12,6 +12,7 @@ platforms += cobalt
>>   platforms += dec
>>   platforms += emma
>>   platforms += generic
>> +platforms += intel-mips
> 
> What are the main things preventing this from moving to the generic
> platform? Is it mainly the use of EVA (which generic doesn't yet
> support)?
> 
Yes. It's mainly because of EVA.

>> diff --git a/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h b/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
>> new file mode 100644
>> index 000000000000..3893855b60c6
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
> ...
>> +	/*
>> +	 * Get Config.K0 value and use it to program
>> +	 * the segmentation registers
> 
> Please can you describe (maybe with a table) the segment layout in human
> readable terms so the reader doesn't need to decode the SegCtl registers
> to understand where everything is in the virtual address space?
> 
Will add detailed EVA mapping description in code comments.

>> diff --git a/arch/mips/boot/dts/intel-mips/Makefile b/arch/mips/boot/dts/intel-mips/Makefile
>> new file mode 100644
>> index 000000000000..b16c0081639c
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/intel-mips/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_DTB_INTEL_MIPS_GRX500)	+= easy350_anywan.dtb
>> +obj-y	+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> 
> This needs updating to obj-$(CONFIG_BUILTIN_DTB) as per commit
> fca3aa166422 ("MIPS: dts: Avoid unneeded built-in.a in DTS dirs") in
> linux-next.
> 
>> diff --git a/arch/mips/intel-mips/Makefile b/arch/mips/intel-mips/Makefile
>> new file mode 100644
>> index 000000000000..9f272d06eecd
>> --- /dev/null
>> +++ b/arch/mips/intel-mips/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_INTEL_MIPS)	+= prom.o irq.o time.o
> 
> You can use obj-y, since this Makefile is only included if
> CONFIG_INTEL_MIPS=y (i.e. via the platform-$(CONFIG_INTEL_MIPS) below).
> 
> Also please split each file onto separate "obj-y += whatever.o" lines.
> 
Will use obj-y.
Will split it into per line per .o.

>> diff --git a/arch/mips/intel-mips/Platform b/arch/mips/intel-mips/Platform
>> new file mode 100644
>> index 000000000000..b34750eeaeb0
>> --- /dev/null
>> +++ b/arch/mips/intel-mips/Platform
>> @@ -0,0 +1,11 @@
>> +#
>> +# MIPs SoC platform
>> +#
>> +
>> +platform-$(CONFIG_INTEL_MIPS)			+= intel-mips/
> 
> ^^^ (this is what ensures the Makefile is only included for this
> platform)
> 
>> diff --git a/arch/mips/intel-mips/irq.c b/arch/mips/intel-mips/irq.c
>> new file mode 100644
>> index 000000000000..00637a5cdd20
>> --- /dev/null
>> +++ b/arch/mips/intel-mips/irq.c
>> @@ -0,0 +1,36 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2016 Intel Corporation.
>> + */
>> +#include <linux/init.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/of_irq.h>
>> +#include <asm/irq.h>
>> +
>> +#include <asm/irq_cpu.h>
>> +
>> +void __init arch_init_irq(void)
>> +{
>> +	struct device_node *intc_node;
>> +
>> +	pr_info("EIC is %s\n", cpu_has_veic ? "on" : "off");
>> +	pr_info("VINT is %s\n", cpu_has_vint ? "on" : "off");
>> +
>> +	intc_node = of_find_compatible_node(NULL, NULL,
>> +					    "mti,cpu-interrupt-controller");
>> +	if (!cpu_has_veic && !intc_node)
>> +		mips_cpu_irq_init();
>> +
>> +	irqchip_init();
>> +}
>> +
>> +int get_c0_perfcount_int(void)
>> +{
>> +	return gic_get_c0_perfcount_int();
>> +}
>> +EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
>> +
>> +unsigned int get_c0_compare_int(void)
>> +{
>> +	return gic_get_c0_compare_int();
>> +}
> 
> Worth having get_c0_fdc_int() too for the "Fast Debug Channel"?
> 
FDC not used in our product.

>> diff --git a/arch/mips/intel-mips/prom.c b/arch/mips/intel-mips/prom.c
>> new file mode 100644
>> index 000000000000..9407858ddc94
>> --- /dev/null
>> +++ b/arch/mips/intel-mips/prom.c
>> @@ -0,0 +1,184 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
>> + * Copyright (C) 2016 Intel Corporation.
>> + */
>> +#include <linux/init.h>
>> +#include <linux/export.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <asm/mips-cps.h>
>> +#include <asm/smp-ops.h>
>> +#include <asm/dma-coherence.h>
>> +#include <asm/prom.h>
>> +
>> +#define IOPORT_RESOURCE_START   0x10000000
>> +#define IOPORT_RESOURCE_END     0xffffffff
>> +#define IOMEM_RESOURCE_START    0x10000000
>> +#define IOMEM_RESOURCE_END      0xffffffff
> 
> The _END ones seem to be unused?
> 
Will remove unused _END macros.

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
> 
> Please describe the boot register protocol in the commit message and/or
> a comment in this function.
>Will add boot register protocol description in code comment.

> Is it compatible with the UHI boot protocol, such that this could
> potentially be converted to use the generic platform in future?
> 
It is compatible with the UHI boot protocol.

>> +}
>> +
>> +static int __init plat_enable_iocoherency(void)
>> +{
>> +	int supported = 0;
>> +
>> +	if (mips_cps_numiocu(0) != 0) {
>> +		/* Nothing special needs to be done to enable coherency */
>> +		pr_info("Coherence Manager IOCU detected\n");
>> +		/* Second IOCU for MPE or other master access register */
>> +		write_gcr_reg0_base(0xa0000000);
>> +		write_gcr_reg0_mask(0xf8000000 | CM_GCR_REGn_MASK_CMTGT_IOCU1);
>> +		supported = 1;
>> +	}
>> +
>> +	/* hw_coherentio = supported; */
>> +
>> +	return supported;
>> +}
>> +
>> +static void __init plat_setup_iocoherency(void)
>> +{
>> +#ifdef CONFIG_DMA_NONCOHERENT
>> +	/*
>> +	 * Kernel has been configured with software coherency
>> +	 * but we might choose to turn it off and use hardware
>> +	 * coherency instead.
> 
> That sounds a big risky. Software coherency will I think perform cache
> line invalidation when syncing buffers from device to CPU (see
> __dma_sync_virtual), so that the underlying RAM written by the
> supposedly incoherent DMA is visible. If its coherent afterall then it
> may be sat in a dirty line in the cache, and not have been written back
> to RAM yet before it gets invalidated?
> 
The comment in code is not accurate.
HW coherence is not supported and software coherence is always enabled.
Will correct the comments and clean the code.

>> +	 */
>> +	if (plat_enable_iocoherency()) {
>> +		if (coherentio == IO_COHERENCE_DISABLED)
>> +			pr_info("Hardware DMA cache coherency disabled\n");
>> +		else
>> +			pr_info("Hardware DMA cache coherency enabled\n");
>> +	} else {
>> +		if (coherentio == IO_COHERENCE_ENABLED)
>> +			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
>> +		else
>> +			pr_info("Software DMA cache coherency enabled\n");
>> +	}
>> +#else
>> +	if (!plat_enable_iocoherency())
>> +		panic("Hardware DMA cache coherency not supported!");
>> +#endif
>> +}
> 
> 
>> +void __init device_tree_init(void)
>> +{
>> +	if (!initial_boot_params)
>> +		return;
> 
> Redundant check. unflatten_and_copy_device_tree() now handles that and
> emits a message.
> 
Will remove the redundant check.

>> +
>> +	unflatten_and_copy_device_tree();
>> +}
>> +
>> +#define CPC_BASE_ADDR		0x12310000
> 
> Please put this at the top of the file with other #defines.
> 
Will move this to the top with other #defines.

>> +
>> +phys_addr_t mips_cpc_default_phys_base(void)
>> +{
>> +	return CPC_BASE_ADDR;
>> +}
> 
>> diff --git a/arch/mips/intel-mips/time.c b/arch/mips/intel-mips/time.c
>> new file mode 100644
>> index 000000000000..77ad4014fe9d
>> --- /dev/null
>> +++ b/arch/mips/intel-mips/time.c
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2016 Intel Corporation.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/of.h>
>> +
>> +#include <asm/time.h>
>> +
>> +static inline u32 get_counter_resolution(void)
>> +{
>> +	u32 res;
>> +
>> +	__asm__ __volatile__(".set	push\n"
> 
> Preferably each line of asm should end \n\t and the final line doesn't
> need \n or \t. Look at the .s compiler output to see the difference.
> 
>> +			     ".set	mips32r2\n"
>> +			     "rdhwr	%0, $3\n"
> 
> Hmm, it'd be nice to abstract this in mipsregs.h, but that can always
> wait. You could use MIPS_HWR_CCRES though (i.e. off top of my head
> something like "%0, $%1\n" and have a "i" (MIPS_HWR_CCRES) input.
> 
>> +			     ".set pop\n"
>> +			     : "=&r" (res)
> 
> I don't think you strictly need an early clobber there since there are
> no register inputs, "=r" should do fine.
> 
>> +			     : /* no input */
>> +			     : "memory");
> 
> I don't think that operation clobbers any memory?
>
Will replace the assembly code with fixed value 2 as the chip resolution 
is the half of the clock.

> Thanks
> James
>
Thanks
Yixin
