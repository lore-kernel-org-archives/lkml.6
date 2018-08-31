Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D3320835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Vhg/ULI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D3320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeHaEfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:35:37 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:52876 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725761AbeHaEfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:35:37 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B548210C08CB;
        Thu, 30 Aug 2018 17:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535675452; bh=X1t+NgmZcwZyxrPSWolMRySn9k6lt3z1i/z9X9jOAHs=;
        h=From:To:CC:Subject:Date:References:From;
        b=Vhg/ULI+zqeKQpBw59xURT2+7D7Nt/l2XzC18dHW1OVdyiajAiBqrCHWllx9QkNgN
         z4Bk3BM7Q4JYV3PXjC464dQHy/zTsFIMZ+1VBko1IsGQda4lC/+X1io78sKZqlvxaV
         8DcJEPq6A/+haGZg9Tu4+80bS4vIF3dEyTFUCG/q8knM+39j+MAnVy0ET8ZgB3S1a0
         I+82rSJBbPD8Fw6WAF+MLRowi/A7BGVJ2TJTywAuimL1qprTcT3UnMnGuyHp1ScigF
         6OHKCBOmYJlsKj0Simcv4b6u+UuwBt5egRvB8YwZwzKrU/HMxcpcdor3zTmiOcnPtY
         bFOW+s9EtqoYA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 95EE25580;
        Thu, 30 Aug 2018 17:30:51 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu, 30
 Aug 2018 17:30:51 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
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
Date:   Fri, 31 Aug 2018 00:30:50 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com> <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
 <20180830204515.GC24124@hirez.programming.kicks-ass.net>
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

On 08/30/2018 01:45 PM, Peter Zijlstra wrote:=0A=
>>=0A=
>> Indeed this is the mother of all issues, I tried and system is clearly h=
osed with=0A=
>> and works after.=0A=
>> What's amazing is the commit 4aef66c8ae9 which introduced it is from 201=
6 ;-)=0A=
>> Back then we had a retry branch with backoff stuff which I'd reverted fo=
r new=0A=
>> cores and the merge conflict somehow missed it.=0A=
>>=0A=
>> @PeterZ I'll create a patch with you as author ? do I need any formal si=
gn offs,=0A=
>> acks etc ?=0A=
> Well, Will spotted it, give authorship to him, you have my ack per the=0A=
> above.=0A=
=0A=
Oops, sorry for the mixup. I have him as author now and pushed to ARC for-c=
urr=0A=
(will trickle into linux-next eventually).=0A=
=0A=
> FWIW, also ACK on Will's patch to switch you over to asm-generic bitops=
=0A=
> entirely.=0A=
=0A=
Yeah I'll get it to that and your's after the clear_bit_lock stuff - sorry =
for=0A=
hijacking this thread to that topic now=0A=
=0A=
-Vineet=0A=
