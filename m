Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A49C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4EC20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4EC20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLGNmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:42:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbeLGNmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:42:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB40D15BE;
        Fri,  7 Dec 2018 05:42:18 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B5DF3F5AF;
        Fri,  7 Dec 2018 05:42:18 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 108FA1AE0C13; Fri,  7 Dec 2018 13:42:40 +0000 (GMT)
Date:   Fri, 7 Dec 2018 13:42:40 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     kys@microsoft.com
Cc:     catalin.marinas@armm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Message-ID: <20181207134239.GC29076@arm.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122031059.16338-2-kys@linuxonhyperv.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:10:57AM +0000, kys@linuxonhyperv.com wrote:
> From: Michael Kelley <mikelley@microsoft.com>
> 
> Add ARM64-specific code to enable Hyper-V. This code includes:
> * Detecting Hyper-V and initializing the guest/Hyper-V interface
> * Setting up Hyper-V's synthetic clocks
> * Making hypercalls using the HVC instruction
> * Setting up VMbus and stimer0 interrupts
> * Setting up kexec and crash handlers
> This code is architecture dependent code and is mostly driven by
> architecture independent code in the VMbus driver in drivers/hv/hv.c
> and drivers/hv/vmbus_drv.c.
> 
> This code is built only when CONFIG_HYPERV is enabled.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  MAINTAINERS                  |   1 +
>  arch/arm64/Makefile          |   1 +
>  arch/arm64/hyperv/Makefile   |   2 +
>  arch/arm64/hyperv/hv_hvc.S   |  54 +++++
>  arch/arm64/hyperv/hv_init.c  | 441 +++++++++++++++++++++++++++++++++++
>  arch/arm64/hyperv/mshyperv.c | 178 ++++++++++++++
>  6 files changed, 677 insertions(+)
>  create mode 100644 arch/arm64/hyperv/Makefile
>  create mode 100644 arch/arm64/hyperv/hv_hvc.S
>  create mode 100644 arch/arm64/hyperv/hv_init.c
>  create mode 100644 arch/arm64/hyperv/mshyperv.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72f19cef4c48..326eeb32a0cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6837,6 +6837,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
>  F:	arch/x86/hyperv
>  F:	arch/arm64/include/asm/hyperv-tlfs.h
>  F:	arch/arm64/include/asm/mshyperv.h
> +F:	arch/arm64/hyperv
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/input/serio/hyperv-keyboard.c
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6cb9fc7e9382..ad9ec0579553 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -106,6 +106,7 @@ core-y		+= arch/arm64/kernel/ arch/arm64/mm/
>  core-$(CONFIG_NET) += arch/arm64/net/
>  core-$(CONFIG_KVM) += arch/arm64/kvm/
>  core-$(CONFIG_XEN) += arch/arm64/xen/
> +core-$(CONFIG_HYPERV) += arch/arm64/hyperv/
>  core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
>  libs-y		:= arch/arm64/lib/ $(libs-y)
>  core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> new file mode 100644
> index 000000000000..988eda55330c
> --- /dev/null
> +++ b/arch/arm64/hyperv/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y		:= hv_init.o hv_hvc.o mshyperv.o
> diff --git a/arch/arm64/hyperv/hv_hvc.S b/arch/arm64/hyperv/hv_hvc.S
> new file mode 100644
> index 000000000000..82636969b4f2
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_hvc.S
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Microsoft Hyper-V hypervisor invocation routines
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + */
> +
> +#include <linux/linkage.h>
> +
> +	.text
> +/*
> + * Do the HVC instruction.  For Hyper-V the argument is always 1.
> + * x0 contains the hypercall control value, while additional registers
> + * vary depending on the hypercall, and whether the hypercall arguments
> + * are in memory or in registers (a "fast" hypercall per the Hyper-V
> + * TLFS).  When the arguments are in memory x1 is the guest physical
> + * address of the input arguments, and x2 is the guest physical
> + * address of the output arguments.  When the arguments are in
> + * registers, the register values depends on the hypercall.  Note
> + * that this version cannot return any values in registers.
> + */
> +ENTRY(hv_do_hvc)
> +	hvc #1
> +	ret
> +ENDPROC(hv_do_hvc)
> +
> +/*
> + * This variant of HVC invocation is for hv_get_vpreg and
> + * hv_get_vpreg_128. The input parameters are passed in registers
> + * along with a pointer in x4 to where the output result should
> + * be stored. The output is returned in x15 and x16.  x18 is used as
> + * scratch space to avoid buildng a stack frame, as Hyper-V does
> + * not preserve registers x0-x17.
> + */
> +ENTRY(hv_do_hvc_fast_get)
> +	mov x18, x4
> +	hvc #1
> +	str x15,[x18]
> +	str x16,[x18,#8]
> +	ret
> +ENDPROC(hv_do_hvc_fast_get)

Why are you not following the ARM SMCCC? It would be /much/ better if you
could just follow the standard, which is already implemented by
include/linux/smccc.h.

Will
