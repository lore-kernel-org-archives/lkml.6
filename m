Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B59C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0AE20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OwGLqYC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0AE20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeHaEeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:34:14 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:51812 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725761AbeHaEeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:34:14 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AB80B24E0551;
        Thu, 30 Aug 2018 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535675369; bh=fXnYiqI42LOGye18rcxjZqniCwIgik+6X74NVaaTfQ0=;
        h=From:To:CC:Subject:Date:References:From;
        b=OwGLqYC5EhnzR4MeQVEY+NiA0VR1Mnu8VkQ6PiWRB/IAbSOp9cphGIkdd8ajZJUoA
         nN/yeNRtjoXKDr/iiIoGrhjsfQasjILwWpEDRYD2hnsFF3R5JBlagb74bHc+VaOYdm
         o6woFJwVOsjXiJ8oj7ak0HUK5lbNSmW0239pEECrJLe+rXsPXYeVB2N7FKlqu9klri
         OdxmfTA9QSZZ7V/pnu2A8cShvftGkBwt4e5z3ucRvwAnrlY4QrHzh1HnY1MHFKnUFs
         8kgeStpGRrfhLjYwTsmRVRojhajDlFWqYel9oJT88XL1SziI40Ukf/lD79/pso0nvC
         kByaC2StuVLCQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 674FD39B2;
        Thu, 30 Aug 2018 17:29:28 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0361.001; Thu, 30 Aug 2018 17:29:28 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: __clear_bit_lock to use atomic clear_bit (was Re: Patch
 "asm-generic/bitops/lock.h)
Thread-Topic: __clear_bit_lock to use atomic clear_bit (was Re: Patch
 "asm-generic/bitops/lock.h)
Thread-Index: AQHUQMGso+PkNISfNEiGPCaoPY7i3g==
Date:   Fri, 31 Aug 2018 00:29:27 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090FE0@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
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

On 08/30/2018 02:44 AM, Peter Zijlstra wrote:=0A=
>> Back in 2016, Peter had fixed this file due to a problem I reported on A=
RC. See=0A=
>> commit f75d48644c56a ("bitops: Do not default to __clear_bit() for=0A=
>> __clear_bit_unlock()")=0A=
>> That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic=
=0A=
>> __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unl=
ock() same.=0A=
>>=0A=
>> This patch undoes that which could explain the issues you see. @Peter, @=
Will ?=0A=
> Right, so the thinking is that on platforms that suffer that issue,=0A=
> atomic_set*() should DTRT. And if you look at your spinlock based atomic=
=0A=
> implementation, you'll note that atomic_set() does indeed do the right=0A=
> thing.=0A=
>=0A=
> arch/arc/include/asm/atomic.h:108=0A=
=0A=
For !LLSC atomics, ARC has always had atomic_set() DTRT even in the git rev=
ision=0A=
of 2016. The problem was not in atomics, but the asymmetric way slub bit lo=
ck etc=0A=
worked (haven't checked if this changed), i.e.=0A=
=0A=
     slab_lock() -> bit_spin_lock() -> test_and_set_bit()    # atomic=0A=
     slab_unlock() -> __bit_spin_unlock() -> __clear_bit()    # non-atomic=
=0A=
=0A=
And with v4.19-rc1, we have essentially reverted f75d48644c56a due to 84c65=
91103db=0A=
("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*(=
)")=0A=
=0A=
So what we have with 4.19-rc1 is=0A=
=0A=
   static inline void __clear_bit_unlock(unsigned int nr, volatile unsigned=
 long *p)=0A=
   {=0A=
     unsigned long old;=0A=
     p +=3D ((nr) / 32);=0A=
     old =3D // some typecheck magic on *p=0A=
     old &=3D ~(1UL << ((nr) % 32));=0A=
     atomic_long_set_release((atomic_long_t *)p, old);=0A=
   }=0A=
=0A=
So @p is being r-m-w non atomically. The lock variant uses atomic op...=0A=
=0A=
   int test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)=0A=
   { =0A=
      ...=0A=
      old =3D atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);=0A=
      ....=0A=
   }=0A=
=0A=
Now I don't know why we don't see the issue with LLSC atomics, perhaps race=
 window=0A=
reduces due to less verbose code itself etc..=0A=
=0A=
Am I missing something still ?=0A=
=0A=
-Vineet=0A=
