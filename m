Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448BDC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0E320645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0E320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeJWBu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:50:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51219 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbeJWBu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:50:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gEe2b-0005fF-SJ; Mon, 22 Oct 2018 11:30:57 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gEe2M-0003aC-Dd; Mon, 22 Oct 2018 11:30:57 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        davidtgoldblatt@gmail.com, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
References: <20181020161049.GA13756@linux.ibm.com>
        <Pine.LNX.4.44L0.1810201612530.28059-100000@netrider.rowland.org>
        <20181020210413.GB2674@linux.ibm.com>
Date:   Mon, 22 Oct 2018 12:30:20 -0500
In-Reply-To: <20181020210413.GB2674@linux.ibm.com> (Paul E. McKenney's message
        of "Sat, 20 Oct 2018 14:04:13 -0700")
Message-ID: <87ftwx3n4j.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gEe2M-0003aC-Dd;;;mid=<87ftwx3n4j.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+IdbSmVJfAU5zgVjTwwlwhZq9+18E93b0=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@linux.ibm.com> writes:

> On Sat, Oct 20, 2018 at 04:18:37PM -0400, Alan Stern wrote:
>> On Sat, 20 Oct 2018, Paul E. McKenney wrote:
>> 
>> > The second (informal) litmus test has a more interesting Linux-kernel
>> > counterpart:
>> > 
>> > 	void t1_interrupt(void)
>> > 	{
>> > 		r0 = READ_ONCE(y);
>> > 		smp_store_release(&x, 1);
>> > 	}
>> > 
>> > 	void t1(void)
>> > 	{
>> > 		smp_store_release(&y, 1);
>> > 	}
>> > 
>> > 	void t2(void)
>> > 	{
>> > 		r1 = smp_load_acquire(&x);
>> > 		r2 = smp_load_acquire(&y);
>> > 	}
>> > 
>> > On store-reordering architectures that implement smp_store_release()
>> > as a memory-barrier instruction followed by a store, the interrupt could
>> > arrive betweentimes in t1(), so that there would be no ordering between
>> > t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
>> > in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.
>> 
>> This is disconcerting only if we assume that t1_interrupt() has to be
>> executed by the same CPU as t1().  If the interrupt could be fielded by
>> a different CPU then the paranoid outcome is perfectly understandable,
>> even in an SC context.
>> 
>> So the question really should be limited to situations where a handler 
>> is forced to execute in the context of a particular thread.  While 
>> POSIX does allow such restrictions for user programs, I'm not aware of 
>> any similar mechanism in the kernel.

> Good point, and I was in fact assuming that t1() and t1_interrupt()
> were executing on the same CPU.
>
> This sort of thing happens naturally in the kernel when both t1()
> and t1_interrupt() are accessing per-CPU variables.

Interrupts have a cpumask of the cpus they may be dlievered on.

I believe networking does in fact have places where percpu actions
happen as well as interrupts pinned to a single cpu.  And yes I agree
percpu variables mean that you do not need to pin an interrupt to a
single cpu to cause this to happen.

Eric
