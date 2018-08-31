Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8FDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA6420839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a816QZGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA6420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHaErf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:47:35 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53212 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeHaErf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:47:35 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EDCF810C08CB;
        Thu, 30 Aug 2018 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535676167; bh=Z5akCYL009rl0wKCZtnI/FuePbdiBMBJ9B2dr0T4Its=;
        h=From:To:CC:Subject:Date:References:From;
        b=a816QZGFGIymIRqHQIMYL1yqWbW40PX5SgBtP4CAEZNuj2PuRsXVDyQl/D0te0nD1
         oleZzwAVhf93HIiXaxpUzwxUXn0hOjzXeJa/5Y36buZc0SjRO4s1gM32XxmlZxmi+i
         gVTDip+vEJKAf9UCGyVI+oEd1dCowai4whDzigIC2Ngsb8J/PV09fr5YENfNlmmIF/
         ikkFy8PB1CwQQS7uigMgZ2NFE8OtuOPYQ4xCpH2vP2LlJ3WVH6GnKWjIzM45FSoT8v
         2OJ7H7CP17PMhxBlBboMQI1+9G1gjzm+PehzcgIaz1pNQrTSwEGpamgHq7IyI/0DYD
         2KU69/10vJiLA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 80CAF59EA;
        Thu, 30 Aug 2018 17:42:47 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu, 30
 Aug 2018 17:42:47 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Topic: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Index: AQHUP8bWpY6ZRO7qfEeDcvF8FJVDUg==
Date:   Fri, 31 Aug 2018 00:42:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B091016@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
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

On 08/30/2018 02:51 AM, Will Deacon wrote:=0A=
> Yeah, the bit_spin_lock()/__bit_spin_unlock() race described in f75d48644=
c56a=0A=
> boils down to concurrent atomic_long_set_release() vs=0A=
> atomic_long_fetch_or_acquire(), which really needs to work.=0A=
=0A=
I don't see how: __clear_bit_unlock() reads @old, flips a bit and then call=
s=0A=
atomic_long_set_release() so the race is not just with set_release.=0A=
=0A=
    static inline int test_and_set_bit_lock(unsigned int nr, volatile unsig=
ned=0A=
long *p)=0A=
    {=0A=
      long old;=0A=
      unsigned long mask =3D (1UL << ((nr) % 32));=0A=
=0A=
      p +=3D ((nr) / 32);=0A=
      old =3D atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);=0A=
      return !!(old & mask);=0A=
    }=0A=
=0A=
    static inline void __clear_bit_unlock(unsigned int nr, volatile unsigne=
d long *p)=0A=
    {=0A=
       unsigned long old;=0A=
=0A=
     p +=3D ((nr) / 32);=0A=
    old =3D // soem typecheck magic on *p=0A=
    old &=3D ~(1UL << ((nr) % 32));=0A=
    atomic_long_set_release((atomic_long_t *)p, old);=0A=
  }=0A=
