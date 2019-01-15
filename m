Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE2C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C763205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GiWuwTjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfAOBJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:09:30 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39918 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOBJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:09:30 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9D67624E1175;
        Mon, 14 Jan 2019 17:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547514569; bh=hNjojRQr7ZRu2ZUvPh38A1DMhrXhO6q7jLuboqcg9rE=;
        h=From:To:CC:Subject:Date:References:From;
        b=GiWuwTjw20MP002PGt+duKXOeIhK7FoT+gXQ+t6MKSWuvGXQTWmQBdK2jIZEpcqRY
         4HWc7zBvDDsqRbfH/jumSLqbuEjT5FTkyBUPutbXbVeWFjxjENgmgdJAYk2r2qrcKN
         E0VjIJ7PQu07lEiWvMZSC96bWTbi/hJ3Pex1ck+wukHvjAHIMHxrHOfXDKaRcvfw5C
         H2vzvMn5J+GA/qtKMkgjqgosqaqD11nR4oeAEnH4YQB4/PpsMQohHSgla291DppYka
         qUegbcbUMtGGFrfcIkjR3q59oeqhqRP9bQeHilZJQFnjkO+3KLOP/PlvLJOBMMTMn1
         5G15sPjU0otrA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8CD895887;
        Mon, 14 Jan 2019 17:09:29 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Mon, 14 Jan 2019 17:09:13 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 1/2] ARCv2: LIB: memeset: fix doing prefetchw outside of
 buffer
Thread-Topic: [PATCH 1/2] ARCv2: LIB: memeset: fix doing prefetchw outside
 of buffer
Thread-Index: AQHUrBw2ZJte6r90DkSex+vHyLGaMw==
Date:   Tue, 15 Jan 2019 01:09:13 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464272C9@US01WEMBX2.internal.synopsys.com>
References: <20190114151649.32726-1-Eugeniy.Paltsev@synopsys.com>
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

On 1/14/19 7:17 AM, Eugeniy Paltsev wrote:=0A=
> Current ARCv2 memeset implementation may call 'prefetchw'=0A=
> instruction for address which lies outside of memset area.=0A=
> So we got one modified (dirty) cache line outside of memset=0A=
> area. This may lead to data corruption if this area is used=0A=
> for DMA IO.=0A=
>=0A=
> Another issue is that current ARCv2 memeset implementation=0A=
> may call 'prealloc' instruction for L1 cache line which=0A=
> doesn't fully belongs to memeset area in case of 128B L1 D$=0A=
> line length. That leads to data corruption.=0A=
>=0A=
> Fix prefetchw/prealloc instructions using in case of 64B L1 data=0A=
> cache line (default case) and don't use prefetch* instructions=0A=
> for other possible L1 data cache line lengths (32B and 128B).=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/lib/memset-archs.S | 30 +++++++++++++++++++++++-------=0A=
>  1 file changed, 23 insertions(+), 7 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/lib/memset-archs.S b/arch/arc/lib/memset-archs.S=0A=
> index 62ad4bcb841a..c7717832336f 100644=0A=
> --- a/arch/arc/lib/memset-archs.S=0A=
> +++ b/arch/arc/lib/memset-archs.S=0A=
> @@ -7,11 +7,32 @@=0A=
>   */=0A=
>  =0A=
>  #include <linux/linkage.h>=0A=
> +#include <asm/cache.h>=0A=
>  =0A=
>  #undef PREALLOC_NOT_AVAIL=0A=
>  =0A=
> +/*=0A=
> + * The memset implementation below is optimized to use prefetchw and pre=
alloc=0A=
> + * instruction in case of CPU with 64B L1 data cache line (L1_CACHE_SHIF=
T =3D=3D 6)=0A=
> + * If you want to implement optimized memset for other possible L1 data =
cache=0A=
> + * line lengths (32B and 128B) you should rewrite code carefully checkin=
g=0A=
> + * we don't call any prefetchw/prealloc instruction for L1 cache lines w=
hich=0A=
> + * don't belongs to memset area.=0A=
=0A=
Good point. FWIW, it is possible to support those non common line lengths b=
y using=0A=
L1_CACHE_SHIFT etc in asm code below but I agree its not worth the trouble.=
=0A=
=0A=
> + */=0A=
> +#if L1_CACHE_SHIFT!=3D6=0A=
> +# define PREALLOC_INSTR(...)=0A=
> +# define PREFETCHW_INSTR(...)=0A=
> +#else  /* L1_CACHE_SHIFT!=3D6 */=0A=
> +# define PREFETCHW_INSTR(...)	prefetchw __VA_ARGS__=0A=
> +# ifdef PREALLOC_NOT_AVAIL=0A=
> +#  define PREALLOC_INSTR(...)	prefetchw __VA_ARGS__=0A=
> +# else=0A=
> +#  define PREALLOC_INSTR(...)	prealloc __VA_ARGS__=0A=
> +# endif=0A=
> +#endif /* L1_CACHE_SHIFT!=3D6 */=0A=
> +=0A=
>  ENTRY_CFI(memset)=0A=
> -	prefetchw [r0]		; Prefetch the write location=0A=
> +	PREFETCHW_INSTR([r0])	; Prefetch the first write location=0A=
>  	mov.f	0, r2=0A=
>  ;;; if size is zero=0A=
>  	jz.d	[blink]=0A=
> @@ -48,11 +69,7 @@ ENTRY_CFI(memset)=0A=
>  =0A=
>  	lpnz	@.Lset64bytes=0A=
>  	;; LOOP START=0A=
> -#ifdef PREALLOC_NOT_AVAIL=0A=
> -	prefetchw [r3, 64]	;Prefetch the next write location=0A=
> -#else=0A=
> -	prealloc  [r3, 64]=0A=
> -#endif=0A=
> +	PREALLOC_INSTR([r3, 64]) ;Prefetch the next write location=0A=
=0A=
These are not solving the issue - I'd break this up and move these bits to =
your=0A=
next patch.=0A=
=0A=
>  #ifdef CONFIG_ARC_HAS_LL64=0A=
>  	std.ab	r4, [r3, 8]=0A=
>  	std.ab	r4, [r3, 8]=0A=
> @@ -85,7 +102,6 @@ ENTRY_CFI(memset)=0A=
>  	lsr.f	lp_count, r2, 5 ;Last remaining  max 124 bytes=0A=
>  	lpnz	.Lset32bytes=0A=
>  	;; LOOP START=0A=
> -	prefetchw   [r3, 32]	;Prefetch the next write location=0A=
=0A=
So the real fix for issue at hand is this line. I'll keep this for the fix =
and=0A=
beef up the changelog. Thing is existing code was already skipping the last=
 64B=0A=
from the main loop (thus avoided prefetching the next line), but then reint=
roduced=0A=
prefetchw is last 32B loop, spoiling the party.  That prefetchw was pointle=
ss anyways=0A=
=0A=
-Vineet=0A=
