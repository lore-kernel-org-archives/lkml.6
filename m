Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACD221829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fZ3FH6Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACD221829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeHMTG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:06:59 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:56045 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:06:59 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E89F124E0262;
        Mon, 13 Aug 2018 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534177444; bh=ulOtXWp9+aW67dMzvtRC+8eVZhNBcXIrdFhBsI3athI=;
        h=From:To:CC:Subject:Date:References:From;
        b=fZ3FH6RmyCE1/QIvcn43fJNTTs+nnVf+6Lz7Xq0yANk9QdZ8m8rTvdfzIBNzxo2ur
         m9KECSjn+PkqfKol8wqQfT9XdSXZcLvVyyt4CDmXJ9FQCzFPzjQx2mqD/z+gXUD62L
         hO2wviD5L9tfNyd+B/vXofSRoFrcpMdTt1scwrsFr3egAL6UhKV5Y/bs5qOHu8eVBm
         I/nhHdYS/ZmpA8CdMfzBAaIRFeuer5fy60bYQRr2PKZcCyayN9zlpVKj3EveGornaM
         rPm9ghlnITV1ym0x0MK6VxuXub4wKvdYazPKy1vmY+g3j5Uz9jkprl0eMhDysF6GLX
         WxdbQUNCBBdKw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id D85A53DF3;
        Mon, 13 Aug 2018 09:24:03 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 13 Aug 2018 09:24:03 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Topic: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Index: AQHUKCIcL8IFt0D6VUGgJAndTq4yWQ==
Date:   Mon, 13 Aug 2018 16:24:02 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08C83D@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <20180730162636.3556-3-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 09:26 AM, Eugeniy Paltsev wrote:=0A=
> @@ -1263,11 +1254,7 @@ void __init arc_cache_init_master(void)=0A=
>  	if (is_isa_arcv2() && ioc_enable)=0A=
>  		arc_ioc_setup();=0A=
>  =0A=
> -	if (is_isa_arcv2() && ioc_enable) {=0A=
> -		__dma_cache_wback_inv =3D __dma_cache_wback_inv_ioc;=0A=
> -		__dma_cache_inv =3D __dma_cache_inv_ioc;=0A=
> -		__dma_cache_wback =3D __dma_cache_wback_ioc;=0A=
> -	} else if (is_isa_arcv2() && l2_line_sz && slc_enable) {=0A=
> +	if (is_isa_arcv2() && l2_line_sz && slc_enable) {=0A=
>  		__dma_cache_wback_inv =3D __dma_cache_wback_inv_slc;=0A=
>  		__dma_cache_inv =3D __dma_cache_inv_slc;=0A=
>  		__dma_cache_wback =3D __dma_cache_wback_slc;=0A=
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c=0A=
> index cefb776a99ff..4d1466905e48 100644=0A=
> --- a/arch/arc/mm/dma.c=0A=
> +++ b/arch/arc/mm/dma.c=0A=
> @@ -33,19 +33,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, =
dma_addr_t *dma_handle,=0A=
>  	if (!page)=0A=
>  		return NULL;=0A=
>  =0A=
> -	/*=0A=
> -	 * IOC relies on all data (even coherent DMA data) being in cache=0A=
> -	 * Thus allocate normal cached memory=0A=
> -	 *=0A=
> -	 * The gains with IOC are two pronged:=0A=
> -	 *   -For streaming data, elides need for cache maintenance, saving=0A=
> -	 *    cycles in flush code, and bus bandwidth as all the lines of a=0A=
> -	 *    buffer need to be flushed out to memory=0A=
> -	 *   -For coherent data, Read/Write to buffers terminate early in cache=
=0A=
> -	 *   (vs. always going to memory - thus are faster)=0A=
> -	 */=0A=
> -	if ((is_isa_arcv2() && ioc_enable) ||=0A=
> -	    (attrs & DMA_ATTR_NON_CONSISTENT))=0A=
> +	if (attrs & DMA_ATTR_NON_CONSISTENT)=0A=
>  		need_coh =3D 0;=0A=
>  =0A=
>  	/*=0A=
> @@ -95,8 +83,7 @@ void arch_dma_free(struct device *dev, size_t size, voi=
d *vaddr,=0A=
>  	struct page *page =3D virt_to_page(paddr);=0A=
>  	int is_non_coh =3D 1;=0A=
>  =0A=
> -	is_non_coh =3D (attrs & DMA_ATTR_NON_CONSISTENT) ||=0A=
> -			(is_isa_arcv2() && ioc_enable);=0A=
> +	is_non_coh =3D (attrs & DMA_ATTR_NON_CONSISTENT);=0A=
>  =0A=
>  	if (PageHighMem(page) || !is_non_coh)=0A=
>  		iounmap((void __force __iomem *)vaddr);=0A=
> @@ -182,3 +169,20 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_=
addr_t paddr,=0A=
>  		break;=0A=
>  	}=0A=
>  }=0A=
=0A=
I think we have some shenanigans with @ioc_enable now.=0A=
Do note that it was more of a debug hack using when the hw feature was intr=
oduced=0A=
to be able to run same kernel on various FPGA bitfiles but just flicking a =
global=0A=
variable via the debugger.=0A=
=0A=
So per code below, if @ioc_enable is NOT set, we still use software assiste=
d cache=0A=
maintenance, but dma_{alloc,free} don't do use that variable. Have you trie=
d=0A=
testing the combination when @ioc_enable is set to 0 before boot ? And is t=
hat works ?=0A=
=0A=
> +=0A=
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> +			const struct iommu_ops *iommu, bool coherent)=0A=
> +{=0A=
> +	/*=0A=
> +	 * IOC hardware snoops all DMA traffic keeping the caches consistent=0A=
> +	 * with memory - eliding need for any explicit cache maintenance of=0A=
> +	 * DMA buffers - so we can use dma_direct cache ops.=0A=
> +	 */=0A=
> +	if (is_isa_arcv2() && ioc_enable && coherent) {=0A=
> +		set_dma_ops(dev, &dma_direct_ops);=0A=
> +		dev_info(dev, "use dma_direct_ops cache ops\n");=0A=
> +	} else {=0A=
> +		set_dma_ops(dev, &dma_noncoherent_ops);=0A=
> +		dev_info(dev, "use dma_noncoherent_ops cache ops\n");=0A=
> +	}=0A=
> +}=0A=
=0A=
