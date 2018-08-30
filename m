Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275DEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44F320834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AHqFVS2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44F320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeHaAf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:35:56 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43882 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaAf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:35:56 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id ED6A424E0553;
        Thu, 30 Aug 2018 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535661120; bh=sZ92BYkyVOGJbTspFGUzg1ZjV4IGjtU2ZbU2KfFVR64=;
        h=From:To:CC:Subject:Date:References:From;
        b=AHqFVS2YGlEAG3IpKQstQTXJZ/G45HniVSEvHa7OPGZOExyAhZrLtaGxR1CgHbfxA
         gUj6ufTVn030ikB538Q7o4jV12mN3cYCYSwpASJfFOiUnWLeIo9y3v+WoZpCwfCNrg
         gkOamr+TdiIJlEkAb7UU/5tSGQrvnltnyKHkZSE6HGpSf0hwejXaXTfECSAHOFGTck
         57GMZhZTtTN8UBs4SSdKOHG1Fcc//Qbz/E4OeCq8TP1lKNnnUck4teLqCrfS+Y4/1q
         3T/Z2tK103WgcdBPJWzUmUrMoS153FXnjZX0W6z24RSX/h444iDzHplOYXOOCvGChI
         jX72o9wSJXsKg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id A54B637C7;
        Thu, 30 Aug 2018 13:31:59 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu, 30
 Aug 2018 13:31:59 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Topic: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Index: AQHUP8bWpY6ZRO7qfEeDcvF8FJVDUg==
Date:   Thu, 30 Aug 2018 20:31:59 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com> <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
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

On 08/30/2018 07:29 AM, Peter Zijlstra wrote:=0A=
> On Thu, Aug 30, 2018 at 03:23:55PM +0100, Will Deacon wrote:=0A=
>=0A=
>> Yes, that would be worth trying. However, I also just noticed that the=
=0A=
>> fetch-ops (which are now used to implement test_and_set_bit_lock()) seem=
=0A=
>> to be missing the backwards branch in the LL/SC case. Yet another diff=
=0A=
>> below.=0A=
>>=0A=
>> Will=0A=
>>=0A=
>> --->8=0A=
>>=0A=
>> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic=
.h=0A=
>> index 4e0072730241..f06c5ed672b3 100644=0A=
>> --- a/arch/arc/include/asm/atomic.h=0A=
>> +++ b/arch/arc/include/asm/atomic.h=0A=
>> @@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v=
)			\=0A=
>>  	"1:	llock   %[orig], [%[ctr]]		\n"		\=0A=
>>  	"	" #asm_op " %[val], %[orig], %[i]	\n"		\=0A=
>>  	"	scond   %[val], [%[ctr]]		\n"		\=0A=
>> -	"						\n"		\=0A=
>> +	"	bnz	1b				\n"		\=0A=
>>  	: [val]	"=3D&r"	(val),						\=0A=
>>  	  [orig] "=3D&r" (orig)						\=0A=
>>  	: [ctr]	"r"	(&v->counter),					\=0A=
> ACK!! sorry about that, no idea how I messed that up.=0A=
>=0A=
> Also, once it all works, they should look at switching to _relaxed=0A=
> atomics for LL/SC.=0A=
=0A=
Indeed this is the mother of all issues, I tried and system is clearly hose=
d with=0A=
and works after.=0A=
What's amazing is the commit 4aef66c8ae9 which introduced it is from 2016 ;=
-)=0A=
Back then we had a retry branch with backoff stuff which I'd reverted for n=
ew=0A=
cores and the merge conflict somehow missed it.=0A=
=0A=
@PeterZ I'll create a patch with you as author ? do I need any formal sign =
offs,=0A=
acks etc ?=0A=
=0A=
So after this there are 2 other things to be addresses / looked at still wh=
ile we=0A=
are still here.=0A=
=0A=
1. After 84c6591103db __clear_bit_lock() implementation will be broken (or =
atleast=0A=
not consistent with what we had after), do we need to reinstate it.=0A=
2. Will's proposed change to remove the underlying issue, but the issue in =
#1=0A=
remains ?=0A=
=0A=
-Vineet=0A=
