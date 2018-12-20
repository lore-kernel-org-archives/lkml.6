Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C107AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A4A21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J7Ky28zF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeLTEAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 23:00:40 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:34156 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeLTEAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 23:00:40 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D930424E0772;
        Wed, 19 Dec 2018 20:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545278439; bh=sjXAVwCRa0Kz6z6iiLbwRnyxG9V+nrlRD3wztmKsyKE=;
        h=From:To:CC:Subject:Date:References:From;
        b=J7Ky28zFW34qVD9+2hA0TXAPPA8FuO5rm/h3DbfyBgNcWqC2rLyyHQp8kFpC5XW8E
         gploC7nGbXU/u13MqVmwbBpY5/KE4Khgmi3qf5R6stX2qq03XsMf2qzh0x1HgW5kpn
         Z/aR5mK+PoE5JHNdGgpFrzRXQTfuZ1iNfS/zDpY3czz/MRAsORSbGM2Z4NMFMZtsNO
         3EcMJYDI0fuzNGVgDFUfIooKBSnjDM19uxm5ovm0I+LuK+OmFQuWY5JbptApG1OMh8
         0fKBxoZhuo/h3rDyEsb37IQTZlKWG4HSGxlFeR077DigD2raXxWbKkFmIklAN1CRfi
         n9LPwbAvIWlDg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id BF37B5B66;
        Wed, 19 Dec 2018 20:00:39 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Wed, 19 Dec 2018 20:00:39 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ARC: adjust memblock_reserve of kernel memory
Thread-Topic: [PATCH] ARC: adjust memblock_reserve of kernel memory
Thread-Index: AQHUl7Y3xyclRc6qjkizV/X3iTxkVw==
Date:   Thu, 20 Dec 2018 04:00:39 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642269A@US01WEMBX2.internal.synopsys.com>
References: <20181219161616.10422-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 8:16 AM, Eugeniy Paltsev wrote:=0A=
> In setup_arch_memory we reserve the memory area wherein the kernel=0A=
> is located. Current implementation may reserve more memory than=0A=
> it actually required in case of CONFIG_LINUX_LINK_BASE is not=0A=
> equal to CONFIG_LINUX_RAM_BASE. This happens because we calculate=0A=
> start of the reserved region relatively to the CONFIG_LINUX_RAM_BASE=0A=
> and end of the region relatively to the CONFIG_LINUX_RAM_BASE.=0A=
>=0A=
> For example in case of HSDK board we wasted 256MiB of physical memory:=0A=
> ------------------->8------------------------------=0A=
> Memory: 770416K/1048576K available (5496K kernel code,=0A=
>     240K rwdata, 1064K rodata, 2200K init, 275K bss,=0A=
>     278160K reserved, 0K cma-reserved)=0A=
> ------------------->8------------------------------=0A=
>=0A=
> Fix that.=0A=
>=0A=
> Cc: stable@vger.kernel.org=0A=
=0A=
For backports, please also check how far back this needs to be applied (els=
e we=0A=
get bot emails specifying they don't apply to ver x, y z)=0A=
=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/mm/init.c | 3 ++-=0A=
>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c=0A=
> index f8fe5668b30f..a56e6a8ed259 100644=0A=
> --- a/arch/arc/mm/init.c=0A=
> +++ b/arch/arc/mm/init.c=0A=
> @@ -137,7 +137,8 @@ void __init setup_arch_memory(void)=0A=
>  	 */=0A=
>  =0A=
>  	memblock_add_node(low_mem_start, low_mem_sz, 0);=0A=
> -	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);=0A=
> +	memblock_reserve(CONFIG_LINUX_LINK_BASE,=0A=
> +			 __pa(_end) - CONFIG_LINUX_LINK_BASE);=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEV_INITRD=0A=
>  	if (initrd_start)=0A=
=0A=
So I looked into the history for restricting stable, and it seems this was=
=0A=
introduced with our earlier work for HSDK.=0A=
=0A=
Before commit 9ed68785f7f this code was ok, since low_mem_start =3D=0A=
CONFIG_LINUX_LINK_BASE.=0A=
With the patch we changed low_mem_start to CONFIG_LINUX_RAM_BASE and missed=
 this.=0A=
=0A=
-Vineet=0A=
