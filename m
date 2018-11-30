Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B57DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372FB20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NU7ztH+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372FB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeLABZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:25:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34924 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLABZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kKVArPGiJAdasASqHfnSK6yLwB9bkQsAgxigitCgIn0=; b=NU7ztH+NVriW2i/CvQ/h+RAxJ
        LUOeaNcfSB4N3ihX56aVMSCtCTxyZGHrBA2VkucJTgiQ8NUEQM5RuVOr1qIcA+tG7EXq04o9yW8Lm
        PeYslaNyOY2pvDwAqLr5ptRh64uakWxef5eHnXu+Oc1n+Bu3sszIfcTCMW8Aa5w3rfwDhNvcPChoe
        wfNetv1OXVDv4qZwUejZNqgUrEXdpxUQc1jpv+kdBIZ6VU7mTg59DkuN457/h+BjUNf543rZ4xQpk
        i/4s03jD3NegGzOMlwaSf24FsfpicxsGh2+/0nes/6hX8+W0e7cq+2z8X4nOYIccjGNDLq3wmV1sy
        db5mN6IRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSja5-0003xX-Mk; Fri, 30 Nov 2018 14:15:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65CCA2029FD58; Fri, 30 Nov 2018 15:15:44 +0100 (CET)
Date:   Fri, 30 Nov 2018 15:15:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liu,Qi(ACU-T1)" <liuqi16@baidu.com>
Cc:     Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Yongji Xie <elohimes@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xie,Yongji" <xieyongji@baidu.com>,
        "Zhang,Yu(ACU-T1)" <zhangyu31@baidu.com>,
        "Yuan,Linsi" <yuanlinsi01@baidu.com>, "Ni,Xun" <nixun@baidu.com>,
        "Li,Lin(ACU-T1)" <lilin24@baidu.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: =?utf-8?B?562U5aSNOiBbUkZDXSBsb2NraW5n?=
 =?utf-8?Q?=2Frwsem=3A_Avoi?= =?utf-8?Q?d?= issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181130141544.GK11632@hirez.programming.kicks-ass.net>
References: <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129183103.GA4952@arm.com>
 <f991af45-2131-ad75-94cd-2c8548266a9e@redhat.com>
 <20181129220544.GE11632@hirez.programming.kicks-ass.net>
 <c1c9d6b30d7745ea9ac5b752f9a506c3@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c9d6b30d7745ea9ac5b752f9a506c3@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:34:19AM +0000, Liu,Qi(ACU-T1) wrote:
> Is there a semantic divergence between x86 instruction "LOCK cmpxchg"
> and the macro cmpxchg defined in linux kernel? The former guarantee
> full barrier in any case, and the latter only imply barrier in case of
> success?

> So, we use 	
>     smp_mb__before_atomic()
> 	cmpxchg_relaxed()  // no barrier
> to get rid of the redundant barrier
>    smp_mb__before_atomic()
>    cmpxchg()          // imply a redundant barrier when successing  

No, it is all horribly more complicated :-)

On x86: cmpxchg_relaxed() == cmpxchg() == LOCK CMPXCHG, however
smp_mb__{before,after}_atomic() is a no-op.

On say arm OTOH: cmpxchg_relaxed() == LL/SC, but then
smp_mb__{before,after}_atomic() is smp_mb(), such that: cmpxchg() := {
smp_mb__before_atomic(); cmpxchg_relaxed(); smp_mb__after_atomic(); }

The difference is that on x86 atomic instructions unconditionally imply
memory ordering; whereas on ARM they do not.


