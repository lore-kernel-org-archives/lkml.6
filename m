Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C40C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1142250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Zo8JpecH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1142250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbeKMK3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:29:54 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37134 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeKMK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:29:53 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8CC2710C06BC;
        Mon, 12 Nov 2018 16:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542069260; bh=V9b/thoqg7jVhvbjlbzBo/TItGT+hr4FaDmGnJCQelU=;
        h=From:To:CC:Subject:Date:References:From;
        b=Zo8JpecH+jePoZzJO3HbOksA9UoRmR1b1NBMr/I1iiaY1aSvaQn0U708es+5fz4py
         osNAJZKjV/2muvCDIfEH5xi+Ti1dEMyheQsnW2KHShlqLIYSkvutvf/X8G4EIfSAsP
         hBBgyo9xPBHqOtHNGvdjDHeyoYMCoV3IYqbDz5Un8IMcKGfaUgAbxXcZJF0ByRyS06
         ZgBMPazOSE+mInQbBQDAqNPq4x6txi+oMcFakYA9gdOoKEXyUJhHNOjBSeV4OPFcIM
         l3GUcwfNenoAIGnVJVlH5/vbgA36ckAIqdRHCZXfBhr4GLn6FZ2r70mt7yKHRF9t+U
         PPejirnyBDFiw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7A1E33F6D;
        Mon, 12 Nov 2018 16:34:15 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Mon, 12 Nov 2018 16:34:15 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Greg Hackmann" <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "gxt@pku.edu.cn" <gxt@pku.edu.cn>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH v4 6/6] arch: Move initrd= parsing into
 do_mounts_initrd.c
Thread-Topic: [PATCH v4 6/6] arch: Move initrd= parsing into
 do_mounts_initrd.c
Thread-Index: AQHUdVsG6LD9rqw+mkiEXoDtFpj/vg==
Date:   Tue, 13 Nov 2018 00:34:15 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A5929ED@us01wembx1.internal.synopsys.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181105225431.24485-7-f.fainelli@gmail.com>
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

On 11/5/18 2:58 PM, Florian Fainelli wrote:=0A=
> ARC, ARM, ARM64 and Unicore32 are all capable of parsing the "initrd=3D"=
=0A=
> command line parameter to allow specifying the physical address and size=
=0A=
> of an initrd. Move that parsing into init/do_mounts_initrd.c such that=0A=
> we no longer duplicate that logic.=0A=
>=0A=
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>=0A=
> ---=0A=
>  arch/arc/mm/init.c       | 25 +++++--------------------=0A=
>  arch/arm/mm/init.c       | 17 -----------------=0A=
>  arch/arm64/mm/init.c     | 18 ------------------=0A=
>  arch/unicore32/mm/init.c | 18 ------------------=0A=
>  init/do_mounts_initrd.c  | 17 +++++++++++++++++=0A=
>  5 files changed, 22 insertions(+), 73 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c=0A=
> index f8fe5668b30f..43bf4c3a1290 100644=0A=
> --- a/arch/arc/mm/init.c=0A=
> +++ b/arch/arc/mm/init.c=0A=
> @@ -78,24 +78,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u6=
4 size)=0A=
>  		base, TO_MB(size), !in_use ? "Not used":"");=0A=
>  }=0A=
>  =0A=
> -#ifdef CONFIG_BLK_DEV_INITRD=0A=
> -static int __init early_initrd(char *p)=0A=
> -{=0A=
> -	unsigned long start, size;=0A=
> -	char *endp;=0A=
> -=0A=
> -	start =3D memparse(p, &endp);=0A=
> -	if (*endp =3D=3D ',') {=0A=
> -		size =3D memparse(endp + 1, NULL);=0A=
> -=0A=
> -		initrd_start =3D (unsigned long)__va(start);=0A=
> -		initrd_end =3D (unsigned long)__va(start + size);=0A=
> -	}=0A=
> -	return 0;=0A=
> -}=0A=
> -early_param("initrd", early_initrd);=0A=
> -#endif=0A=
> -=0A=
>  /*=0A=
>   * First memory setup routine called from setup_arch()=0A=
>   * 1. setup swapper's mm @init_mm=0A=
> @@ -140,8 +122,11 @@ void __init setup_arch_memory(void)=0A=
>  	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEV_INITRD=0A=
> -	if (initrd_start)=0A=
> -		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);=0A=
> +	if (phys_initrd_size) {=0A=
> +		memblock_reserve(phys_initrd_start, phys_initrd_size);=0A=
> +		initrd_start =3D (unsigned long)__va(phys_initrd_start);=0A=
> +		initrd_end =3D initrd_start + phys_initrd_size;=0A=
> +	}=0A=
>  #endif=0A=
=0A=
The common code now uses phys_initrd*, and you also use the same in ARC cod=
e, do=0A=
we still need the initrd_* setting here ?=0A=
ARC semantics was using them as PA anyways.=0A=
=0A=
[snip]...=0A=
=0A=
>  /*=0A=
>   * This keeps memory configuration data used by a couple memory=0A=
>   * initialization functions, as well as show_mem() for the skipping=0A=
> diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c=0A=
> index 45865b72f4ea..732d21f4a637 100644=0A=
> --- a/init/do_mounts_initrd.c=0A=
> +++ b/init/do_mounts_initrd.c=0A=
> @@ -27,6 +27,23 @@ static int __init no_initrd(char *str)=0A=
>  =0A=
>  __setup("noinitrd", no_initrd);=0A=
>  =0A=
> +static int __init early_initrd(char *p)=0A=
> +{=0A=
> +	phys_addr_t start;=0A=
> +	unsigned long size;=0A=
> +	char *endp;=0A=
> +=0A=
> +	start =3D memparse(p, &endp);=0A=
> +	if (*endp =3D=3D ',') {=0A=
> +		size =3D memparse(endp + 1, NULL);=0A=
> +=0A=
> +		phys_initrd_start =3D start;=0A=
> +		phys_initrd_size =3D size;=0A=
> +	}=0A=
> +	return 0;=0A=
> +}=0A=
> +early_param("initrd", early_initrd);=0A=
> +=0A=
>  static int init_linuxrc(struct subprocess_info *info, struct cred *new)=
=0A=
>  {=0A=
>  	ksys_unshare(CLONE_FS | CLONE_FILES);=0A=
=0A=
