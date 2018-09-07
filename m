Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B23C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4554F2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WWV42tSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4554F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeIGVVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:21:44 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2302 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeIGVVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:21:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b92a9d30000>; Fri, 07 Sep 2018 09:39:47 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Sep 2018 09:39:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Sep 2018 09:39:59 -0700
Received: from [10.110.39.62] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Sep
 2018 16:39:59 +0000
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <mingo@kernel.org>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>
References: <20180906093655.GA9653@andrea>
 <Pine.LNX.4.44L0.1809071145260.1547-100000@iolanthe.rowland.org>
 <20180907160950.GH12788@arm.com>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20990a3f-1507-c98b-f14e-2f5241319d8c@nvidia.com>
Date:   Fri, 7 Sep 2018 09:39:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907160950.GH12788@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com;
        s=n1._domainkey.nvidia.com; t=1536338387;
        bh=a38sZjk6vmkjACrOgknRiHv4gEl6hj71+aXYKenYtIQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WWV42tSGieG4YF9ZVrfotYaB3SUlO1NbZo/TZCBMK11yBI0AgyffKRBMTW87bpee4
         V1uHTiflr6Zf7hFt0wBOezAnRiAedlPm9B5p8WCsS/yPqixnMg18W3Tkd1RjBK/wQc
         ucCnToQudryubwEmLmuG76jW6m03jfq/CJ7ra5jOpiyIjfYF0ytyrV0U4Jldkgdft2
         OYx7HYvTyq90lj1ad8oLJb2+PQ9daoN2lydtUL2PBd7g+3bvwvlc/olUtvolpy6dGe
         p2hgxW2H+THr8F9eT4m8jqvYNAPr7VvpbtPAsh4+h0LutOdkt3Erm4qvUvewuzd3oD
         KFquKTGkHyQXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2018 9:09 AM, Will Deacon wrote:
> On Fri, Sep 07, 2018 at 12:00:19PM -0400, Alan Stern wrote:
>> On Thu, 6 Sep 2018, Andrea Parri wrote:
>>
>>>> Have you noticed any part of the generic code that relies on ordinary 
>>>> acquire-release (rather than atomic RMW acquire-release) in order to 
>>>> implement locking constructs?
>>>
>>> There are several places in code where the "lock-acquire" seems to be
>>> provided by an atomic_cond_read_acquire/smp_cond_load_acquire: I have
>>> mentioned one in qspinlock in this thread; qrwlock and mcs_spinlock
>>> provide other examples (grep for the primitives...).
>>>
>>> As long as we don't consider these primitive as RMW (which would seem
>>> odd...) or as acquire for which "most people expect strong ordering"
>>> (see above), these provides other examples for the _gap_ I mentioned.
>>
>> Okay, now I understand your objection.  It does appear that on RISC-V,
>> if nowhere else, the current implementations of qspinlock, qrwlock,
>> etc. will not provide "RCtso" ordering.
>>
>> The discussions surrounding this topic have been so lengthy and 
>> confusing that I have lost track of any comments Palmer or Daniel may 
>> have made concerning this potential problem.
>>
>> One possible resolution would be to define smp_cond_load_acquire() 
>> specially on RISC-V so that it provided the same ordering guarantees as 
>> RMW-acquire.  (Plus adding a comment in the asm-generic/barrier.h 
>> pointing out the necessity for the stronger guarantee on all 
>> architectures.)
>>
>> Another would be to replace the usages of atomic/smp_cond_load_acquire 
>> in the locking constructs with a new function that would otherwise be 
>> the same but would provide the ordering guarantee we want.
>>
>> Do you think either of these would be an adequate fix?
> 
> I didn't think RISC-V used qspinlock or qrwlock, so I'm not sure there's
> actually anything to fix, is there?
> 
> Will

I've also lost track of whether the current preference is or is not for
RCtso, or in which subset of cases RCtso is currently preferred.  For
whichever cases do in fact need to be RCtso, the RISC-V approach would
still be the same as what I've written in the past, as far as I can
tell [1].

In a nutshell, if a data structure uses only atomics with .aq/.rl,
RISC-V provides RCtso already anyway.  If a data structure uses fences,
or mixes fences and atomics, we can replace a "fence r,rw" or a
"fence rw,w" with a "fence.tso" (== fence r,rw + fence rw,w) as
necessary, at the cost of some amount of performance.

I suppose the answer to the question of whether smp_cond_load_acquire()
needs to change depends on where exactly RCtso is needed, and which
data structures actually use that vs. some other macro. 

Does that answer your question Alan?  Does it make sense?

[1] https://lore.kernel.org/lkml/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com/

Dan
