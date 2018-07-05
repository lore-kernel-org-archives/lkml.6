Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F26C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237FD240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NP1OKQKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237FD240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeGEV0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:26:20 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:49568 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbeGEV0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:26:19 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 22CCD24E21CD;
        Thu,  5 Jul 2018 14:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530825978; bh=elJgra7HEAd7nFMrWJg0r4ZJsAObF7a0IRRkRo9SwlI=;
        h=From:To:CC:Subject:Date:References:From;
        b=NP1OKQKyS5euPkm6jC/prTuMxOwuHrItFds80gDWT6jyC0KUwAJ8Hs5WipGVvj0+Y
         rPCBoYj1tp/sS6JRgmodjhuhBeMkP8p2GWJMZJRAuOTl7E53mt6uPhcwrIkX3n6uKz
         Uro2am3X3b0OU/P92wcs82GGN1x8nwMM9aBiW7axmTvm0RdaG5IAg/c9VWlMVu8vCB
         eTTZ5P8hywy0IEH7Tr/HiWyl+zYKHI5AWAkLXTC+w5DCwSgR3IrPScflLBq6vkVbBW
         0wepnLXaNmxUuw/3p7VdxX4UbDaCRzbIQHxGjvbr4Kei4DwsxenfnDDs+AupG8PpKQ
         SAyQLKPXBAgPg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 93D2E57B6;
        Thu,  5 Jul 2018 14:26:16 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.147]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 5 Jul 2018 14:26:16 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@ZenIV.linux.org.uk" <viro@ZenIV.linux.org.uk>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: prevent showing irrelevant exception info in
 signal message
Thread-Topic: [PATCH] ARC: prevent showing irrelevant exception info in
 signal message
Thread-Index: AQHUD+DbGZyRM5SR9EWnMTtnbGM7UQ==
Date:   Thu, 5 Jul 2018 21:26:15 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750110F64810@us01wembx1.internal.synopsys.com>
References: <20180629193907.17227-1-Eugeniy.Paltsev@synopsys.com>
 <924308fe-efb3-45f7-b5cb-45d876021f32@synopsys.com>
 <1530615475.30574.52.camel@synopsys.com>
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

On 07/03/2018 03:57 AM, Eugeniy Paltsev wrote:=0A=
> On Mon, 2018-07-02 at 10:57 -0700, Vineet Gupta wrote:=0A=
>> +CC Al=0A=
>>=0A=
>> On 06/29/2018 12:39 PM, Eugeniy Paltsev wrote:=0A=
>>> We process signals in the end of syscall/exception handler.=0A=
>>> It the signal is fatal we print register's content using=0A=
>>> show_regs function. show_regs() also prints information about=0A=
>>> last exception happened.=0A=
>>>=0A=
>>> In case of multicore system we can catch the situation when we=0A=
>>> will print wrong information about exception. See the example:=0A=
>>> ______________________________=0A=
>>> CPU-0: started to handle page fault=0A=
>>> CPU-1: sent signal to process, which is executed on CPU-0=0A=
>>> CPU-0: ended page fault handle. Started to process signal before=0A=
>>>        returnig to userspace. Process signal, which is send from=0A=
>>>        CPU-0. As th signal is fatal we call show_regs().=0A=
>>>        show_regs() will show information about last exception=0A=
>>>        which is *page fault* (instead of "trap" which is used for=0A=
>>>        signals and happened on CPU-0)=0A=
>>>=0A=
>>> So we will get message like this:=0A=
>>>     /home/waitpid02=0A=
>>>   potentially unexpected fatal signal 8.=0A=
>>>   Path: /home/waitpid02=0A=
>>>   CPU: 0 PID: 100 Comm: waitpid02 Not tainted 4.10.0-rc4 #2=0A=
>>>   task: 9f11c200 task.stack: 9f3ae000=0A=
>>>=0A=
>>>   [ECR   ]: 0x00050200 =3D> Invalid Write @ 0x00000000 by insn @ 0x0001=
23ec=0A=
>>>   [EFA   ]: 0x00000000=0A=
>>>   [BLINK ]: 0x123ea=0A=
>>>   [ERET  ]: 0x123ec=0A=
>>>     @off 0x123ec in [/home/waitpid02]=0A=
>>>     VMA: 0x00010000 to 0x00016000=0A=
>>>   [STAT32]: 0x80080882 : IE U=0A=
>>>   BTA: 0x000123ea  SP: 0x5ffd3db0  FP: 0x00000000=0A=
>>>   LPS: 0x20031684 LPE: 0x2003169a LPC: 0x00000006=0A=
>>>   [-----other-info-----]=0A=
>>>=0A=
>>> This message is confusing because it show information about page fault=
=0A=
>>> ( [ECR   ]: 0x00050200 =3D> Invalid Write ) which is absolutely irrelev=
ant=0A=
>>> to signal.=0A=
>> Agreed this is misleading. @Al, is there a way to identify process termi=
nation=0A=
>> from signals because it did something wrong vs. say unhandled signal. Fo=
r former,=0A=
>> we want to dump additional info in show_regs() such as PC / Fault addres=
 etc and=0A=
>> not in other scenario.=0A=
>>=0A=
>>> This situation was reproduced with waitpid02 LTP test.=0A=
>>> _____________________________=0A=
>>>=0A=
>>> So remove printing information about exceptions from show_regs()=0A=
>>> to avoid confusing messages. Print information about exceptions=0A=
>>> only in required places instead of show_regs()=0A=
>>>=0A=
>>> Now we don't print information about exceptions if signal is simply=0A=
>>> send by another userspace app. So in case of waitpid02 we will print=0A=
>>> next message:=0A=
>>> _____________________________=0A=
>>>     ./waitpid02=0A=
>>>   potentially unexpected fatal signal 8.=0A=
>>>   [STAT32]: 0x80080082 : IE U=0A=
>>>   BTA: 0x20000fc4	 SP: 0x5ff8bd64	 FP: 0x00000000=0A=
>>>   LPS: 0x200524a0	LPE: 0x200524b6	LPC: 0x00000006=0A=
>>>   [-----other-info-----]=0A=
>>> _____________________________=0A=
>> The prints I'm seeing now, for a segv from NULL pointer access is even m=
ore=0A=
>> confusing !=0A=
>> There's a mixup of prints....=0A=
>>=0A=
>> -------------------->8--------------------=0A=
>> Path: /segv=0A=
>> CPU: 0 PID: 70 Comm: segv Not tainted 4.17.0+ #412=0A=
>>=0A=
>> [ECR   ]: 0x00050200 =3D> Invalid Write @ 0x00000000 by insn @ 0x000103a=
c=0A=
>> [EFA   ]: 0x00000000=0A=
>> [BLINK ]: 0x20047bb0=0A=
>> [ERET  ]: 0x103ac=0A=
>>     @off 0x103ac in [/segv]=0A=
>>     VMA: 0x00010000 to 0x00012000=0A=
>>=0A=
>> potentially unexpected fatal signal 11.=0A=
>> [STAT32]: 0x80080882 : IE U    =0A=
>> BTA: 0x00010398     SP: 0x5fc95e1c     FP: 0x5fc95e20=0A=
>> LPS: 0x20039ffc    LPE: 0x2003a000    LPC: 0x00000000=0A=
>> r00: 0x00000001    r01: 0x5fc95e94    r02: 0x00000000   =0A=
>> r03: 0x00000064    r04: 0x80808080    r05: 0x2f2f2f2f   =0A=
>> ...=0A=
>> -------------------->8--------------------=0A=
>>=0A=
>> and for the process killed by signal 8, we get below.=0A=
>>=0A=
>> -------------------->8--------------------=0A=
>> [ARCLinux]# kill -8 71=0A=
>> [ARCLinux]# potentially unexpected fatal signal 8.=0A=
>> [STAT32]: 0x80080882 : IE U    =0A=
>> BTA: 0x20020660     SP: 0x5fbcddec     FP: 0x5fbcde1c=0A=
>> LPS: 0x20039ffc    LPE: 0x2003a000    LPC: 0x00000000=0A=
>> r00: 0xfffffdfc    r01: 0x5fbcddf0    r02: 0x00000000   =0A=
>> r03: 0x00000008    r04: 0x80808080    r05: 0x2f2f2f2f   =0A=
>> r06: 0x7a2f5f4a    r07: 0x00000000    r08: 0x00000065   =0A=
>> ...=0A=
>>=0A=
>>=0A=
>> [1]+  Floating point exception   ./sleep=0A=
>> -------------------->8--------------------=0A=
>> I'm not sure whats the improvement here vs. the status quo.=0A=
> Why do you think this is confusing?=0A=
> The main change is that we don't print exception registers for signal bas=
ed kill.=0A=
=0A=
For the pure signal based termination, what is the point of printing the re=
st of=0A=
registers. If you say "it is to give a feel of what the userspace was doing=
 at the=0A=
time...." then we are lacking the most crucial piece which is the PC at the=
 time=0A=
(i.e. ERET placeholder).=0A=
=0A=
> Moreover, new behavior is more like x86-64 behavior. See the example:=0A=
=0A=
For a null pointer based termination, we now have a ugly looking "potential=
ly=0A=
unexpected..." print in the middle of reg file dump, that is not what x86 d=
oes.=0A=
Anyways, that print It is undesirable, but not a deal breaker.  The issue i=
s point=0A=
above, can we remedy it.=0A=
=0A=
BTW in your original patch, for a null pointer access, the printing code no=
w=0A=
allocates 2 pages, in each of show_xxx routines and the one in show_regs() =
is now=0A=
pointless, as it is not used there at all there - so please fix that as wel=
l.=0A=
=0A=
-Vineet=0A=
