Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18C32083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ag3Gi9hE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18C32083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbeGZSs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:48:29 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:35991 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388943AbeGZSs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:48:29 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B4A8724E099E;
        Thu, 26 Jul 2018 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532626241; bh=TxNEid0AFKmDem5SldxzomLOtFkM/sa8Tu6jMfesSqo=;
        h=From:To:CC:Subject:Date:References:From;
        b=Ag3Gi9hEqxutNmXxxSgz3+PBPZarA6uz5GYaU3VIw7W97bfwrgxUgSKQQPAbsrbnN
         KFhhjbsSNr6KSW612KpSSNVGGM7TpS0dnAgyKDoNWcKrlTxUhnATYlGPJ9MmvK8j5V
         prn4PRUlF0R9sWwGt8czIzFIXmrkFo976RMc3z1aZRk/5ZSVFOiYSZ2Yp45d5b3IHG
         EEgcT+D3sC3S/7FqQAKl/oTQ4XTxlwfrUMMkjrcZPmR9qCusit20rVaUMpz207Ikii
         n5gToT+CA7HsLCN5EYZhbHsuT7F2jkoX1WLa4rSjvwFmoS0Vc9KvPAgkrv1+88abSa
         EnrB+Tk2zOX/w==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9D7E65454;
        Thu, 26 Jul 2018 10:30:41 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 26 Jul 2018 10:30:41 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 2/2] ARC: add SMP_CACHE_BYTES value validate
Thread-Topic: [PATCH v2 2/2] ARC: add SMP_CACHE_BYTES value validate
Thread-Index: AQHUJOLHU42aJS7O/U622itMkljELg==
Date:   Thu, 26 Jul 2018 17:30:40 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08404E@us01wembx1.internal.synopsys.com>
References: <20180726131544.3780-1-Eugeniy.Paltsev@synopsys.com>
 <20180726131544.3780-2-Eugeniy.Paltsev@synopsys.com>
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

On 07/26/2018 06:15 AM, Eugeniy Paltsev wrote:=0A=
> Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger=0A=
> or equal to any cache line length by comparing it with values=0A=
> previously read from ARC cache BCR registers.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
> Changes v1->v2:=0A=
>  * None.=0A=
>=0A=
>  arch/arc/mm/cache.c | 10 ++++++++++=0A=
>  1 file changed, 10 insertions(+)=0A=
>=0A=
> diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c=0A=
> index 9dbe645ee127..b95365e1253a 100644=0A=
> --- a/arch/arc/mm/cache.c=0A=
> +++ b/arch/arc/mm/cache.c=0A=
> @@ -1246,6 +1246,16 @@ void __init arc_cache_init_master(void)=0A=
>  		}=0A=
>  	}=0A=
>  =0A=
> +	/*=0A=
> +	 * Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger=
=0A=
> +	 * or equal to any cache line length.=0A=
> +	 */=0A=
> +	BUILD_BUG_ON_MSG(L1_CACHE_BYTES > SMP_CACHE_BYTES,=0A=
> +			 "SMP_CACHE_BYTES must be >=3D any cache line length");=0A=
> +	if (is_isa_arcv2() && (l2_line_sz > SMP_CACHE_BYTES))=0A=
> +		panic("L2 Cache line [%d] > kernel Config [%d]\n",=0A=
> +		      l2_line_sz, SMP_CACHE_BYTES);=0A=
> +=0A=
>  	/* Note that SLC disable not formally supported till HS 3.0 */=0A=
>  	if (is_isa_arcv2() && l2_line_sz && !slc_enable)=0A=
>  		arc_slc_disable();=0A=
=0A=
LGTM. Both applied.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
