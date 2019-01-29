Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB59BC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55B021473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lL12U1+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfA2Vzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:55:49 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:48100 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfA2Vzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:55:49 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D53E910C123C;
        Tue, 29 Jan 2019 13:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548798948; bh=BT5h+pxmY2MHXLmOPS5aVFJo9j/OJrDDuaW57A9qYZo=;
        h=From:To:CC:Subject:Date:References:From;
        b=lL12U1+pcsLxRFBkc0dgHQ1pUxSZFHhzHr9/VcUhHcVHAlOCv7/evQrJOiRy7IHiV
         zOhB6to+OKYDlSxSTyyFs4Pi4feSZ668r0HDFzxUeUdORD+ZQZruYyMRBk6btoNZjk
         Bg1VhKSBZwpVmN8B4qLGRkSF146FfNTiu6AiqRdp9yXEpeqC56pHyg3utBpQPkA0Ze
         aqvC7QF9P3ISGf7pmdHGJeBayUItwLOVSLjyh9ZhRIiTtiq8z6tAr/csSXlTxJzn4c
         AG0CIRAAmEZQGXaY76J2VJguKMZ8yOB6BtkrOK7y6dOPTPfoQQ3JfwPuoPz6d5puO4
         7Mfkex8dMx2Fw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B561AA0079;
        Tue, 29 Jan 2019 21:55:48 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 29 Jan 2019 13:55:07 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 5/5] ARCv2: LIB: MEMCPY: fixed and optimised routine
Thread-Topic: [PATCH 5/5] ARCv2: LIB: MEMCPY: fixed and optimised routine
Thread-Index: AQHUt8Bg4ldN5eMuwEe0tmIorNdLiQ==
Date:   Tue, 29 Jan 2019 21:55:07 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642D5B4@US01WEMBX2.internal.synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
 <20190129104942.31705-6-Eugeniy.Paltsev@synopsys.com>
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

On 1/29/19 2:49 AM, Eugeniy Paltsev wrote:=0A=
> Optimise code to use efficient unaligned memory access which is=0A=
> available on ARCv2. This allows us to really simplify memcpy code=0A=
> and speed up the code one and a half times (in case of unaligned=0A=
> source or destination).=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/Kconfig                      |  4 +++=0A=
>  arch/arc/lib/Makefile                 |  5 +++-=0A=
>  arch/arc/lib/memcpy-archs-unaligned.S | 46 +++++++++++++++++++++++++++++=
++++++=0A=
>  3 files changed, 54 insertions(+), 1 deletion(-)=0A=
>  create mode 100644 arch/arc/lib/memcpy-archs-unaligned.S=0A=
>=0A=
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
> index a1d976c612a6..88f1a3205b8f 100644=0A=
> --- a/arch/arc/Kconfig=0A=
> +++ b/arch/arc/Kconfig=0A=
> @@ -396,6 +396,10 @@ config ARC_USE_UNALIGNED_MEM_ACCESS=0A=
>  	  which is disabled by default. Enable unaligned access in=0A=
>  	  hardware and use it in software.=0A=
>  =0A=
> +#dummy symbol for using in makefile=0A=
> +config ARC_NO_UNALIGNED_MEM_ACCESS=0A=
> +	def_bool !ARC_USE_UNALIGNED_MEM_ACCESS=0A=
> +=0A=
=0A=
Not needed - you can use the kconfig symbols in Makefile.=0A=
See arch/arc/kernel/Makefile=0A=
=0A=
>  config ARC_HAS_LL64=0A=
>  	bool "Insn: 64bit LDD/STD"=0A=
>  	help=0A=
> diff --git a/arch/arc/lib/Makefile b/arch/arc/lib/Makefile=0A=
> index b1656d156097..59cc8b61342e 100644=0A=
> --- a/arch/arc/lib/Makefile=0A=
> +++ b/arch/arc/lib/Makefile=0A=
> @@ -8,4 +8,7 @@=0A=
>  lib-y	:=3D strchr-700.o strcpy-700.o strlen.o memcmp.o=0A=
>  =0A=
>  lib-$(CONFIG_ISA_ARCOMPACT)	+=3D memcpy-700.o memset.o strcmp.o=0A=
> -lib-$(CONFIG_ISA_ARCV2)		+=3D memcpy-archs.o memset-archs.o strcmp-archs=
.o=0A=
> +lib-$(CONFIG_ISA_ARCV2)		+=3D memset-archs.o strcmp-archs.o=0A=
> +=0A=
> +lib-$(CONFIG_ARC_NO_UNALIGNED_MEM_ACCESS)	+=3D memcpy-archs.o=0A=
> +lib-$(CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS)	+=3D memcpy-archs-unaligned.o=
=0A=
=0A=
ifdef CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS=0A=
lib-$(CONFIG_ISA_ARCV2) +=3Dmemcpy-archs-unaligned.o=0A=
else=0A=
lib-$(CONFIG_ISA_ARCV2) +=3Dmemcpy-archs.o=0A=
endif=0A=
=0A=
> diff --git a/arch/arc/lib/memcpy-archs-unaligned.S b/arch/arc/lib/memcpy-=
archs-unaligned.S=0A=
> new file mode 100644=0A=
> index 000000000000..e09b51d4de70=0A=
> --- /dev/null=0A=
> +++ b/arch/arc/lib/memcpy-archs-unaligned.S=0A=
> @@ -0,0 +1,46 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0+ */=0A=
> +//=0A=
> +// ARCv2 memcpy implementation optimized for unaligned memory access usi=
ng.=0A=
> +//=0A=
> +// Copyright (C) 2019 Synopsys=0A=
> +// Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> +=0A=
> +#include <linux/linkage.h>=0A=
> +=0A=
> +#ifdef CONFIG_ARC_HAS_LL64=0A=
> +# define LOADX(DST,RX)		ldd.ab	DST, [RX, 8]=0A=
> +# define STOREX(SRC,RX)		std.ab	SRC, [RX, 8]=0A=
> +# define ZOLSHFT		5=0A=
> +# define ZOLAND			0x1F=0A=
> +#else=0A=
> +# define LOADX(DST,RX)		ld.ab	DST, [RX, 4]=0A=
> +# define STOREX(SRC,RX)		st.ab	SRC, [RX, 4]=0A=
> +# define ZOLSHFT		4=0A=
> +# define ZOLAND			0xF=0A=
> +#endif=0A=
> +=0A=
> +ENTRY_CFI(memcpy)=0A=
> +	mov	r3, r0		; don;t clobber ret val=0A=
> +=0A=
> +	lsr.f	lp_count, r2, ZOLSHFT=0A=
> +	lpnz	@.Lcopy32_64bytes=0A=
> +	;; LOOP START=0A=
> +	LOADX	(r6, r1)=0A=
> +	LOADX	(r8, r1)=0A=
> +	LOADX	(r10, r1)=0A=
> +	LOADX	(r4, r1)=0A=
> +	STOREX	(r6, r3)=0A=
> +	STOREX	(r8, r3)=0A=
> +	STOREX	(r10, r3)=0A=
> +	STOREX	(r4, r3)=0A=
> +.Lcopy32_64bytes:=0A=
> +=0A=
> +	and.f	lp_count, r2, ZOLAND ;Last remaining 31 bytes=0A=
> +	lpnz	@.Lcopyremainingbytes=0A=
> +	;; LOOP START=0A=
> +	ldb.ab	r5, [r1, 1]=0A=
> +	stb.ab	r5, [r3, 1]=0A=
=0A=
=0A=
=0A=
> +.Lcopyremainingbytes:=0A=
> +=0A=
> +	j	[blink]=0A=
> +END_CFI(memcpy)=0A=
=0A=
