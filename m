Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCECEC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5212E2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VnwRTPy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5212E2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbeHNQ3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:29:38 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:45039 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732699AbeHNQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:29:37 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 292E810C0D27;
        Tue, 14 Aug 2018 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534254144; bh=ruFBvMSfW2dLZHPf0zYvmApSiBhx7ZIiOeH815YKU9U=;
        h=From:To:CC:Subject:Date:References:From;
        b=VnwRTPy4jAVcYUdEcxYDyXeLV7KJ17Z0g4VJs7qjGfhK065xcIo6b3FThjJg2I9Kh
         mdwQZpF7/uzhHCllCNEK/UTFg5mB1CTEmk4jqhTq7R0P6mxXTBSw614N3xB2hwPmQG
         tNK9/wZMC3DN1cRyw5JQE1GgEw7eXRTmWjg6n94awYJ4mVs6zkl7vvcRbRxLWTxor4
         yQ0uZYAzZt4yo284liiBd6cdrRi5YerYu35WZ0HbfpydcosnTCruN7FR73xR4G/w6K
         +dzmCPfUiJ/qUsGuABFo6rEMJ0+L7dXqFeoNxeAl0/6P7cwObVkPeBshXbT5Gvn71v
         e6OcpvyANWiMg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0D14C536C;
        Tue, 14 Aug 2018 06:42:24 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue, 14
 Aug 2018 06:42:23 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Will Deacon" <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] ARC: atomic64: fix atomic64_add_unless function
Thread-Topic: [PATCH] ARC: atomic64: fix atomic64_add_unless function
Thread-Index: AQHUMY2jvyJle0DCLEGtK0ktniYvNg==
Date:   Tue, 14 Aug 2018 13:42:23 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08CB78@us01wembx1.internal.synopsys.com>
References: <20180811160856.24936-1-Eugeniy.Paltsev@synopsys.com>
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

On 08/11/2018 09:09 AM, Eugeniy Paltsev wrote:=0A=
> Current implementation of 'atomic64_add_unless' function=0A=
> (and hence 'atomic64_inc_not_zero') return incorrect value=0A=
> if lover 32 bits of compared 64-bit number are equal and=0A=
> higher 32 bits aren't.=0A=
>=0A=
> For in following example atomic64_add_unless must return '1'=0A=
> but it actually returns '0':=0A=
> --------->8---------=0A=
> atomic64_t val =3D ATOMIC64_INIT(0x4444000000000000LL);=0A=
> int ret =3D atomic64_add_unless(&val, 1LL, 0LL)=0A=
> --------->8---------=0A=
>=0A=
> This happens because we write '0' to returned variable regardless=0A=
> of higher 32 bits comparison result.=0A=
>=0A=
> So fix it.=0A=
>=0A=
> NOTE:=0A=
>  this change was tested with atomic64_test.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
LGTM. Curious, was this from code review or did u actually run into this ?=
=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
> ---=0A=
>  arch/arc/include/asm/atomic.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.=
h=0A=
> index 11859287c52a..e840cb1763b2 100644=0A=
> --- a/arch/arc/include/asm/atomic.h=0A=
> +++ b/arch/arc/include/asm/atomic.h=0A=
> @@ -578,11 +578,11 @@ static inline int atomic64_add_unless(atomic64_t *v=
, long long a, long long u)=0A=
>  =0A=
>  	__asm__ __volatile__(=0A=
>  	"1:	llockd  %0, [%2]	\n"=0A=
> -	"	mov	%1, 1		\n"=0A=
>  	"	brne	%L0, %L4, 2f	# continue to add since v !=3D u \n"=0A=
>  	"	breq.d	%H0, %H4, 3f	# return since v =3D=3D u \n"=0A=
>  	"	mov	%1, 0		\n"=0A=
>  	"2:				\n"=0A=
> +	"	mov	%1, 1		\n"=0A=
>  	"	add.f   %L0, %L0, %L3	\n"=0A=
>  	"	adc     %H0, %H0, %H3	\n"=0A=
>  	"	scondd  %0, [%2]	\n"=0A=
=0A=
