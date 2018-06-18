Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED98DC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC0D20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cLDTReQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC0D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755452AbeFRWxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:53:48 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:43824 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755329AbeFRWxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:53:43 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8195C1E04A8;
        Tue, 19 Jun 2018 00:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529362421; bh=vQrYm+ScHN7EoTx2vAfZNUlzQYRFDu3ujDGtokMUPrs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=cLDTReQV5vInSd4r/oq9k6b9zobM9RJszFDF/FevqErsqXfMwGDx32P5aPUMM6//u
         1DXEE0hi9YVPHGVomhMIfh+1EfA1hhyufdhGpyUtBZ8hvPzpBl2rI/BDt+nDrAq1oX
         rQzt1DElZ3b3FVNtBobqj1I3K9tdUv+4zbon0VGv5hpUDsfxg4JPJka32F9C7tiAY5
         2nx+KZaApbinMziW6qlM7Or8fNWeoIHAbnHbiZZ+mjwmIB+nO0Hr30spSR2BDZiTqF
         bSEOTzHuPhHgPS6j1UoLKhjx7Mq01XN4loC6Yzr0Gop0bPNbf6d+j0AM8ShjUHnTJJ
         jVaF+PPB9nrvA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8CC3A38FC;
        Mon, 18 Jun 2018 15:53:34 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 18 Jun 2018 15:53:23 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 19 Jun 2018 04:23:19 +0530
Received: from [10.10.161.98] (10.10.161.98) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 19 Jun 2018 04:23:19 +0530
Subject: Re: [RFC] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "hch@lst.de" <hch@lst.de>
References: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 i91ThhqBJlyU6MVUa6vZNv8E
Message-ID: <563bd0ab-e40c-f9ad-4e9c-dbf5b13358b5@synopsys.com>
Date:   Mon, 18 Jun 2018 15:53:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.10.161.98]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 05:58 AM, Eugeniy Paltsev wrote:
> The ARC HS processor provides an IOC port (I/O coherency bus
> interface) that allows external devices such as DMA devices
> to access memory through the cache hierarchy, providing
> coherency between I/O transactions and the complete memory
> hierarchy.

This is really nice: having this a per device behaviour has been desirabl=
e rather
than the current blunt system-wide behaviour.

However the patch doesn't seem to change the routing off non-coherent tra=
ffic -
everything would still go thru it - per the current default setting of
CREG_AXI_M_*_SLV[0-1] registers. Ideally you would want to disable that a=
s well,
an addon patch is fine.

>
> Some recent SoC with ARC HS (like HSDK) allow to select bus
> port (IOC or non-IOC port) for connecting DMA devices in runtime.
>
> With this patch we can use both HW-coherent and regular DMA
> peripherals simultaneously.
>
> For example we can connect USB and SDIO controllers through IOC port
> (so we don't need to need to maintain cache coherency for these
> devices manualy. All cache sync ops will be nop)
> And we can connect Ethernet directly to RAM port (so we had to
> maintain cache coherency manualy. Cache sync ops will be real
> flush/invalidate operations)
>
> Cache ops are set per-device and depends on "dma-coherent" device
> tree property:
> "dma_noncoherent_ops" are used if no "dma-coherent" property is
> present (or IOC is disabled)
> "dma_direct_ops" are used if "dma-coherent" property is present.

I agree with Christoph that creating a new file for this seems excessive.=


> NOTE 1:
> It works perfectly fine only if we don't have ZONE_HIGHMEM used
> as IOC doesn't cover all physical memory. As for today It configured
> to cover 1GiB starting from 0x8z (which is ZONE_NORMAL memory for
> us). Transactions outside this region are sent on the non-coherent
> I/O bus interface.
> We can't configure IOC to cover all physical memory as it has several
> limitations relating to aperture size and start address.
>
> And if we get DMA buffer from ZONE_HIGHMEM memory we need to
> do real flush/invalidate operations on that buffer, which is obviously
> not done by "dma_direct_ops".
>
> So I am not sure about "dma_direct_ops" using - probably we need to
> create our special cache ops like "arc_ioc_ops" which will handle
> ZONE_HIGHMEM case.
>
> (BTW: current ARC dma_noncoherent_ops implementation also has same
> problem if IOC and HIGHMEM are enabled.)

Can we highlight this fact, add error prints somewhere ?

> NOTE 2:
> In this RFC only hsdk.dts changes are shown to reduce patch size.
> AXS103 device tree changes are not shown.
>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  arch/arc/Kconfig                   |  1 +
>  arch/arc/boot/dts/hsdk.dts         |  4 ++++
>  arch/arc/include/asm/dma-mapping.h | 14 ++++++++++++++
>  arch/arc/mm/Makefile               |  2 +-
>  arch/arc/mm/cache.c                | 15 +--------------
>  arch/arc/mm/dma-mapping.c          | 20 ++++++++++++++++++++
>  arch/arc/mm/dma.c                  | 14 +-------------
>  7 files changed, 42 insertions(+), 28 deletions(-)
>  create mode 100644 arch/arc/include/asm/dma-mapping.h
>  create mode 100644 arch/arc/mm/dma-mapping.c
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index e81bcd271be7..0a2fcd2a8c32 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -17,6 +17,7 @@ config ARC
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
>  	select DMA_NONCOHERENT_OPS
> +	select DMA_DIRECT_OPS
>  	select DMA_NONCOHERENT_MMAP
>  	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LL=
SC)
>  	select GENERIC_CLOCKEVENTS
> diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
> index 006aa3de5348..ebb686c21393 100644
> --- a/arch/arc/boot/dts/hsdk.dts
> +++ b/arch/arc/boot/dts/hsdk.dts
> @@ -176,6 +176,7 @@
>  			phy-handle =3D <&phy0>;
>  			resets =3D <&cgu_rst HSDK_ETH_RESET>;
>  			reset-names =3D "stmmaceth";
> +			dma-coherent;
> =20
>  			mdio {
>  				#address-cells =3D <1>;
> @@ -194,12 +195,14 @@
>  			compatible =3D "snps,hsdk-v1.0-ohci", "generic-ohci";
>  			reg =3D <0x60000 0x100>;
>  			interrupts =3D <15>;
> +			dma-coherent;
>  		};
> =20
>  		ehci@40000 {
>  			compatible =3D "snps,hsdk-v1.0-ehci", "generic-ehci";
>  			reg =3D <0x40000 0x100>;
>  			interrupts =3D <15>;
> +			dma-coherent;
>  		};
> =20
>  		mmc@a000 {
> @@ -212,6 +215,7 @@
>  			clock-names =3D "biu", "ciu";
>  			interrupts =3D <12>;
>  			bus-width =3D <4>;
> +			dma-coherent;
>  		};
>  	};
> =20
> diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/=
dma-mapping.h
> new file mode 100644
> index 000000000000..640a851bd331
> --- /dev/null
> +++ b/arch/arc/include/asm/dma-mapping.h
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// (C) 2018 Synopsys, Inc. (www.synopsys.com)
> +
> +#ifndef ASM_ARC_DMA_MAPPING_H
> +#define ASM_ARC_DMA_MAPPING_H
> +
> +#define arch_setup_dma_ops arch_setup_dma_ops
> +
> +#include <asm-generic/dma-mapping.h>
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent);
> +
> +#endif
> diff --git a/arch/arc/mm/Makefile b/arch/arc/mm/Makefile
> index 3703a4969349..45683897c27b 100644
> --- a/arch/arc/mm/Makefile
> +++ b/arch/arc/mm/Makefile
> @@ -7,5 +7,5 @@
>  #
> =20
>  obj-y	:=3D extable.o ioremap.o dma.o fault.o init.o
> -obj-y	+=3D tlb.o tlbex.o cache.o mmap.o
> +obj-y	+=3D tlb.o tlbex.o cache.o mmap.o dma-mapping.o
>  obj-$(CONFIG_HIGHMEM)	+=3D highmem.o
> diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
> index 9dbe645ee127..c5d1f2a2c4da 100644
> --- a/arch/arc/mm/cache.c
> +++ b/arch/arc/mm/cache.c
> @@ -896,15 +896,6 @@ static void __dma_cache_wback_slc(phys_addr_t star=
t, unsigned long sz)
>  	slc_op(start, sz, OP_FLUSH);
>  }
> =20
> -/*
> - * DMA ops for systems with IOC
> - * IOC hardware snoops all DMA traffic keeping the caches consistent w=
ith
> - * memory - eliding need for any explicit cache maintenance of DMA buf=
fers
> - */
> -static void __dma_cache_wback_inv_ioc(phys_addr_t start, unsigned long=
 sz) {}
> -static void __dma_cache_inv_ioc(phys_addr_t start, unsigned long sz) {=
}
> -static void __dma_cache_wback_ioc(phys_addr_t start, unsigned long sz)=
 {}
> -
>  /*
>   * Exported DMA API
>   */
> @@ -1253,11 +1244,7 @@ void __init arc_cache_init_master(void)
>  	if (is_isa_arcv2() && ioc_enable)
>  		arc_ioc_setup();
> =20
> -	if (is_isa_arcv2() && ioc_enable) {
> -		__dma_cache_wback_inv =3D __dma_cache_wback_inv_ioc;
> -		__dma_cache_inv =3D __dma_cache_inv_ioc;
> -		__dma_cache_wback =3D __dma_cache_wback_ioc;
> -	} else if (is_isa_arcv2() && l2_line_sz && slc_enable) {

Maybe also tweak the boot printing in setup.c to indicate that we now do =
per
peripheral ioc !

> +	if (is_isa_arcv2() && l2_line_sz && slc_enable) {
>  		__dma_cache_wback_inv =3D __dma_cache_wback_inv_slc;
>  		__dma_cache_inv =3D __dma_cache_inv_slc;
>  		__dma_cache_wback =3D __dma_cache_wback_slc;
> diff --git a/arch/arc/mm/dma-mapping.c b/arch/arc/mm/dma-mapping.c
> new file mode 100644
> index 000000000000..9d0d310bbf5a
> --- /dev/null
> +++ b/arch/arc/mm/dma-mapping.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// (C) 2018 Synopsys, Inc. (www.synopsys.com)
> +
> +#include <linux/dma-mapping.h>
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent)
> +{
> +	const struct dma_map_ops *dma_ops =3D &dma_noncoherent_ops;
> +
> +	/*
> +	 * IOC hardware snoops all DMA traffic keeping the caches consistent
> +	 * with memory - eliding need for any explicit cache maintenance of
> +	 * DMA buffers - so we can use dma_direct cache ops.
> +	 */
> +	if (is_isa_arcv2() && ioc_enable && coherent)
> +		dma_ops =3D &dma_direct_ops;
> +
> +	set_dma_ops(dev, dma_ops);

Add a debug printk here maybe ?

> +}
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 8c1071840979..4fd130e786c7 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -33,19 +33,7 @@ void *arch_dma_alloc(struct device *dev, size_t size=
, dma_addr_t *dma_handle,
>  	if (!page)
>  		return NULL;
> =20
> -	/*
> -	 * IOC relies on all data (even coherent DMA data) being in cache
> -	 * Thus allocate normal cached memory
> -	 *
> -	 * The gains with IOC are two pronged:
> -	 *   -For streaming data, elides need for cache maintenance, saving
> -	 *    cycles in flush code, and bus bandwidth as all the lines of a
> -	 *    buffer need to be flushed out to memory
> -	 *   -For coherent data, Read/Write to buffers terminate early in cac=
he
> -	 *   (vs. always going to memory - thus are faster)
> -	 */
> -	if ((is_isa_arcv2() && ioc_enable) ||
> -	    (attrs & DMA_ATTR_NON_CONSISTENT))
> +	if (attrs & DMA_ATTR_NON_CONSISTENT)
>  		need_coh =3D 0;
> =20
>  	/*


