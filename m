Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E02C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3775520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iFfq25+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3775520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbeGXTmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:42:09 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:40361 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388386AbeGXTmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:42:09 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9794910C08ED;
        Tue, 24 Jul 2018 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532457263; bh=t4jaKtzJ1JHtLzO3oOQ5w0Rx+ZF3Of5Tzs4fqDWhgm8=;
        h=From:To:CC:Subject:Date:References:From;
        b=iFfq25+yidZ4OBip/3IS8HzsI5yN9YJi+f72SxC9NOaWR43iJhcxoY3ByWQouKaQt
         RlTYtXPXphYthKXW/q4ANpXDQyG94w3/qAFGIFz8Atttw2agFabVKSJo9kwAwzUa7y
         igloaJPNbY7mp1pJ4hFPyA8oOezhN+5qIs2qjMoXICaotm0u9iYt9+45EmHkj7Dn7u
         7fyOKYU0TIFl2zZkdcGjThMVSSNyj+doytuGjTt6GPUN3Hs23M5+IbEbKvYYB1KUYu
         amDJtFFxOzYHvKEU90VhmPDXtkWfQ0pop8BeIpBm2VRihWpV5tVlbiG5YRI/wWl4wV
         7JLBqW2AvusLQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 82A4B3E80;
        Tue, 24 Jul 2018 11:34:23 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue, 24
 Jul 2018 11:34:23 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] ARC: fix broken noncoherent cache ops
Thread-Topic: [PATCH] ARC: fix broken noncoherent cache ops
Thread-Index: AQHUI1hxAX2+V/l89Ei+Glv9aIIiNQ==
Date:   Tue, 24 Jul 2018 18:34:22 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08382A@us01wembx1.internal.synopsys.com>
References: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
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

On 07/24/2018 07:13 AM, Eugeniy Paltsev wrote:=0A=
> All DMA devices on ARC haven't worked with SW cache control=0A=
> since commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")=0A=
> This happens because we don't check direction argument at all in=0A=
> new implementation. Fix that.=0A=
=0A=
Good find and I presume painful to debug.=0A=
=0A=
Interesting though how the error tricked finally as the root cause was=0A=
arc_dma_sync_single*() were broken to begin with.=0A=
=0A=
Prior to common ops rework, arc_dma_sync_single_for_device() would uncondit=
ionally=0A=
do cache wback, independent of the direction (by calling _dma_cache_sync he=
lper=0A=
with TO_DEVICE). In 713a74624bba ("arc: simplify=0A=
arc_dma_sync_single_for_{cpu,device}") Christoph changed this to skip the h=
elper.=0A=
And then in a8eb92d02dd7, the usage of these routines was prolifirated to t=
he more=0A=
common kernel API dma_*map_page() API and that is where the original defici=
ency=0A=
showed up. I'll add this bit of history to changelog to remember this bette=
r.=0A=
=0A=
=0A=
> Fixies: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
> NOTE:=0A=
>  * This patch was stress tested on HSDK with bonie++ (usb and sdio)=0A=
>    with IOC disabled. The ethernet wasn't tested because it doesn't=0A=
>    work with SW cache control as for today (see STAR 9001336019)=0A=
>=0A=
>  arch/arc/mm/dma.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--=0A=
>  1 file changed, 44 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c=0A=
> index 8c1071840979..cefb776a99ff 100644=0A=
> --- a/arch/arc/mm/dma.c=0A=
> +++ b/arch/arc/mm/dma.c=0A=
> @@ -129,14 +129,56 @@ int arch_dma_mmap(struct device *dev, struct vm_are=
a_struct *vma,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Cache operations depending on function and direction argument, inspir=
ed by=0A=
> + * https://lkml.org/lkml/2018/5/18/979=0A=
> + * "dma_sync_*_for_cpu and direction=3DTO_DEVICE (was Re: [PATCH 02/20]=
=0A=
> + * dma-mapping: provide a generic dma-noncoherent implementation)"=0A=
> + *=0A=
> + *          |   map          =3D=3D  for_device     |   unmap     =3D=3D=
  for_cpu=0A=
> + *          |-----------------------------------------------------------=
-----=0A=
> + * TO_DEV   |   writeback        writeback      |   none          none=
=0A=
> + * FROM_DEV |   invalidate       invalidate     |   invalidate    invali=
date=0A=
> + * BIDIR    |   writeback+inv    writeback+inv  |   invalidate    invali=
date=0A=
> + *=0A=
> + * NOTE: we don't check the validity of direction argument as it is done=
 in=0A=
> + * upper layer functions (in include/linux/dma-mapping.h)=0A=
> + */=0A=
> +=0A=
=0A=
Very nice !  Added to for-curr=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
>  void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,=0A=
>  		size_t size, enum dma_data_direction dir)=0A=
>  {=0A=
> -	dma_cache_wback(paddr, size);=0A=
> +	switch (dir) {=0A=
> +	case DMA_TO_DEVICE:=0A=
> +		dma_cache_wback(paddr, size);=0A=
> +		break;=0A=
> +=0A=
> +	case DMA_FROM_DEVICE:=0A=
> +		dma_cache_inv(paddr, size);=0A=
> +		break;=0A=
> +=0A=
> +	case DMA_BIDIRECTIONAL:=0A=
> +		dma_cache_wback_inv(paddr, size);=0A=
> +		break;=0A=
> +=0A=
> +	default:=0A=
> +		break;=0A=
> +	}=0A=
>  }=0A=
>  =0A=
>  void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,=0A=
>  		size_t size, enum dma_data_direction dir)=0A=
>  {=0A=
> -	dma_cache_inv(paddr, size);=0A=
> +	switch (dir) {=0A=
> +	case DMA_TO_DEVICE:=0A=
> +		break;=0A=
> +=0A=
> +	case DMA_FROM_DEVICE:=0A=
> +	case DMA_BIDIRECTIONAL:=0A=
> +		dma_cache_inv(paddr, size);=0A=
> +		break;=0A=
> +=0A=
> +	default:=0A=
> +		break;=0A=
> +	}=0A=
>  }=0A=
=0A=
