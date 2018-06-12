Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B6EFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DAE208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb6g0B6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DAE208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeFLLX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752853AbeFLLXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:23:53 -0400
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C181208AE;
        Tue, 12 Jun 2018 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528802633;
        bh=XubKKVHNsxx7+mIjf/LZvYwEuNbmY1kL5nL31zUEbJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wb6g0B6BSH/JrskdqcAyCbDa9SDU4MOQ6qrtGaw4n4L4KtDwi6kzV4wSmsDTugN35
         R2GfGezizzk1QEzJevaZcA94qeoCjWk98YwUVGKXuAaTbtsImZxbCIxub0aXibvIA9
         TITucK4YjflvbVtajO+SlU+l8vMmaJD5Qk+ep1Qs=
Date:   Tue, 12 Jun 2018 12:23:48 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com, linux-mips@linux-mips.org,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/7] MIPS: intel: Add initial support for Intel MIPS SoCs
Message-ID: <20180612112346.GA8748@jamesdev>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-4-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20180612054034.4969-4-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Good to see this patch!

On Tue, Jun 12, 2018 at 01:40:30PM +0800, Songjun Wu wrote:
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index ac7ad54f984f..bcd647060f3e 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -12,6 +12,7 @@ platforms += cobalt
>  platforms += dec
>  platforms += emma
>  platforms += generic
> +platforms += intel-mips

What are the main things preventing this from moving to the generic
platform? Is it mainly the use of EVA (which generic doesn't yet
support)?

> diff --git a/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h b/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
> new file mode 100644
> index 000000000000..3893855b60c6
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
...
> +	/*
> +	 * Get Config.K0 value and use it to program
> +	 * the segmentation registers

Please can you describe (maybe with a table) the segment layout in human
readable terms so the reader doesn't need to decode the SegCtl registers
to understand where everything is in the virtual address space?

> diff --git a/arch/mips/boot/dts/intel-mips/Makefile b/arch/mips/boot/dts/intel-mips/Makefile
> new file mode 100644
> index 000000000000..b16c0081639c
> --- /dev/null
> +++ b/arch/mips/boot/dts/intel-mips/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_DTB_INTEL_MIPS_GRX500)	+= easy350_anywan.dtb
> +obj-y	+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))

This needs updating to obj-$(CONFIG_BUILTIN_DTB) as per commit
fca3aa166422 ("MIPS: dts: Avoid unneeded built-in.a in DTS dirs") in
linux-next.

> diff --git a/arch/mips/intel-mips/Makefile b/arch/mips/intel-mips/Makefile
> new file mode 100644
> index 000000000000..9f272d06eecd
> --- /dev/null
> +++ b/arch/mips/intel-mips/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_INTEL_MIPS)	+= prom.o irq.o time.o

You can use obj-y, since this Makefile is only included if
CONFIG_INTEL_MIPS=y (i.e. via the platform-$(CONFIG_INTEL_MIPS) below).

Also please split each file onto separate "obj-y += whatever.o" lines.

> diff --git a/arch/mips/intel-mips/Platform b/arch/mips/intel-mips/Platform
> new file mode 100644
> index 000000000000..b34750eeaeb0
> --- /dev/null
> +++ b/arch/mips/intel-mips/Platform
> @@ -0,0 +1,11 @@
> +#
> +# MIPs SoC platform
> +#
> +
> +platform-$(CONFIG_INTEL_MIPS)			+= intel-mips/

^^^ (this is what ensures the Makefile is only included for this
platform)

> diff --git a/arch/mips/intel-mips/irq.c b/arch/mips/intel-mips/irq.c
> new file mode 100644
> index 000000000000..00637a5cdd20
> --- /dev/null
> +++ b/arch/mips/intel-mips/irq.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 Intel Corporation.
> + */
> +#include <linux/init.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_irq.h>
> +#include <asm/irq.h>
> +
> +#include <asm/irq_cpu.h>
> +
> +void __init arch_init_irq(void)
> +{
> +	struct device_node *intc_node;
> +
> +	pr_info("EIC is %s\n", cpu_has_veic ? "on" : "off");
> +	pr_info("VINT is %s\n", cpu_has_vint ? "on" : "off");
> +
> +	intc_node = of_find_compatible_node(NULL, NULL,
> +					    "mti,cpu-interrupt-controller");
> +	if (!cpu_has_veic && !intc_node)
> +		mips_cpu_irq_init();
> +
> +	irqchip_init();
> +}
> +
> +int get_c0_perfcount_int(void)
> +{
> +	return gic_get_c0_perfcount_int();
> +}
> +EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
> +
> +unsigned int get_c0_compare_int(void)
> +{
> +	return gic_get_c0_compare_int();
> +}

Worth having get_c0_fdc_int() too for the "Fast Debug Channel"?

> diff --git a/arch/mips/intel-mips/prom.c b/arch/mips/intel-mips/prom.c
> new file mode 100644
> index 000000000000..9407858ddc94
> --- /dev/null
> +++ b/arch/mips/intel-mips/prom.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
> + * Copyright (C) 2016 Intel Corporation.
> + */
> +#include <linux/init.h>
> +#include <linux/export.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_fdt.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <asm/mips-cps.h>
> +#include <asm/smp-ops.h>
> +#include <asm/dma-coherence.h>
> +#include <asm/prom.h>
> +
> +#define IOPORT_RESOURCE_START   0x10000000
> +#define IOPORT_RESOURCE_END     0xffffffff
> +#define IOMEM_RESOURCE_START    0x10000000
> +#define IOMEM_RESOURCE_END      0xffffffff

The _END ones seem to be unused?

> +static void __init prom_init_cmdline(void)
> +{
> +	int i;
> +	int argc;
> +	char **argv;
> +
> +	/*
> +	 * If u-boot pass parameters, it is ok, however, if without u-boot
> +	 * JTAG or other tool has to reset all register value before it goes
> +	 * emulation most likely belongs to this category
> +	 */
> +	if (fw_arg0 == 0 || fw_arg1 == 0)
> +		return;
> +
> +	argc = fw_arg0;
> +	argv = (char **)KSEG1ADDR(fw_arg1);
> +
> +	arcs_cmdline[0] = '\0';
> +
> +	for (i = 0; i < argc; i++) {
> +		char *p = (char *)KSEG1ADDR(argv[i]);
> +
> +		if (argv[i] && *p) {
> +			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
> +			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
> +		}
> +	}

Please describe the boot register protocol in the commit message and/or
a comment in this function.

Is it compatible with the UHI boot protocol, such that this could
potentially be converted to use the generic platform in future?

> +}
> +
> +static int __init plat_enable_iocoherency(void)
> +{
> +	int supported = 0;
> +
> +	if (mips_cps_numiocu(0) != 0) {
> +		/* Nothing special needs to be done to enable coherency */
> +		pr_info("Coherence Manager IOCU detected\n");
> +		/* Second IOCU for MPE or other master access register */
> +		write_gcr_reg0_base(0xa0000000);
> +		write_gcr_reg0_mask(0xf8000000 | CM_GCR_REGn_MASK_CMTGT_IOCU1);
> +		supported = 1;
> +	}
> +
> +	/* hw_coherentio = supported; */
> +
> +	return supported;
> +}
> +
> +static void __init plat_setup_iocoherency(void)
> +{
> +#ifdef CONFIG_DMA_NONCOHERENT
> +	/*
> +	 * Kernel has been configured with software coherency
> +	 * but we might choose to turn it off and use hardware
> +	 * coherency instead.

That sounds a big risky. Software coherency will I think perform cache
line invalidation when syncing buffers from device to CPU (see
__dma_sync_virtual), so that the underlying RAM written by the
supposedly incoherent DMA is visible. If its coherent afterall then it
may be sat in a dirty line in the cache, and not have been written back
to RAM yet before it gets invalidated?

> +	 */
> +	if (plat_enable_iocoherency()) {
> +		if (coherentio == IO_COHERENCE_DISABLED)
> +			pr_info("Hardware DMA cache coherency disabled\n");
> +		else
> +			pr_info("Hardware DMA cache coherency enabled\n");
> +	} else {
> +		if (coherentio == IO_COHERENCE_ENABLED)
> +			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
> +		else
> +			pr_info("Software DMA cache coherency enabled\n");
> +	}
> +#else
> +	if (!plat_enable_iocoherency())
> +		panic("Hardware DMA cache coherency not supported!");
> +#endif
> +}


> +void __init device_tree_init(void)
> +{
> +	if (!initial_boot_params)
> +		return;

Redundant check. unflatten_and_copy_device_tree() now handles that and
emits a message.

> +
> +	unflatten_and_copy_device_tree();
> +}
> +
> +#define CPC_BASE_ADDR		0x12310000

Please put this at the top of the file with other #defines.

> +
> +phys_addr_t mips_cpc_default_phys_base(void)
> +{
> +	return CPC_BASE_ADDR;
> +}

> diff --git a/arch/mips/intel-mips/time.c b/arch/mips/intel-mips/time.c
> new file mode 100644
> index 000000000000..77ad4014fe9d
> --- /dev/null
> +++ b/arch/mips/intel-mips/time.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 Intel Corporation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clocksource.h>
> +#include <linux/of.h>
> +
> +#include <asm/time.h>
> +
> +static inline u32 get_counter_resolution(void)
> +{
> +	u32 res;
> +
> +	__asm__ __volatile__(".set	push\n"

Preferably each line of asm should end \n\t and the final line doesn't
need \n or \t. Look at the .s compiler output to see the difference.

> +			     ".set	mips32r2\n"
> +			     "rdhwr	%0, $3\n"

Hmm, it'd be nice to abstract this in mipsregs.h, but that can always
wait. You could use MIPS_HWR_CCRES though (i.e. off top of my head
something like "%0, $%1\n" and have a "i" (MIPS_HWR_CCRES) input.

> +			     ".set pop\n"
> +			     : "=&r" (res)

I don't think you strictly need an early clobber there since there are
no register inputs, "=r" should do fine.

> +			     : /* no input */
> +			     : "memory");

I don't think that operation clobbers any memory?

Thanks
James

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWx+tQQAKCRA1zuSGKxAj
8mCmAP0YcFeLhdWqRmrKx1Kj4nfiSw+n/mHL8icm7Xm3VueBfQD7Biu4QqJeSQjd
BFlbigIdSVe9+Xuw1j0TVLxMMvws7Q4=
=Em5k
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
