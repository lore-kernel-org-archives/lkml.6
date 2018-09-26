Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274DFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACE720666
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v1PZciB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACE720666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeI0AFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:05:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55938 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeI0AFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8G3h0F79W0AN8AUgvnTarDYNgmvvq+g0X4IgF9XuL4s=; b=v1PZciB/d/xVpqiCUTQMx5qnm
        nwIKgsWKOG/fFDKBqZACtT7zu4UNvrMl21RsZbnFUdD0X+s3dq3CGloAYLVVcQeI77mjhBcyPZteo
        Q9vQT+3aZoW1kD/eu/hZLzS3fiVnXBHAt98l2KU3EdwjMXUadV0bns71LlPJRcmBDhRW+0D/RR9zA
        m8zJoMHj/VhZpFhy8sepgNwNEw2wNPWpXNIHdgGqDd/YOFD61cPO//3vW4urkTV8DNHT2ExEr1OHS
        txYQ/aAyv+JNTdewrxEwG20lhphCHssjBkONaqb3bdj4g36KGWLi03N1cuROwX89CuQbsSQds/hkz
        3AFcU575Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5Dy1-0001vC-Hz; Wed, 26 Sep 2018 17:51:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D873E205A76D5; Wed, 26 Sep 2018 19:51:12 +0200 (CEST)
Date:   Wed, 26 Sep 2018 19:51:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 0/3] locking/qspinlock: Improve determinism for x86
Message-ID: <20180926175112.GA5254@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <2c284b6d-99c1-2686-b8c0-fce8987e747f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c284b6d-99c1-2686-b8c0-fce8987e747f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:20:09PM -0400, Waiman Long wrote:
> On 09/26/2018 07:01 AM, Peter Zijlstra wrote:
> > Back when Will did his qspinlock determinism patches, we were left with one
> > cmpxchg loop on x86 due to the use of atomic_fetch_or(). Will proposed a nifty
> > trick:
> >
> >   http://lkml.kernel.org/r/20180409145409.GA9661@arm.com
> >
> > But at the time we didn't pursue it. This series implements that and argues for
> > its correctness. In particular it places an smp_mb__after_atomic() in
> > between the two operations, which forces the load to come after the
> > store (which is free on x86 anyway).
> >
> > In particular this ordering ensures a concurrent unlock cannot trigger
> > the uncontended handoff. Also it ensures that if the xchg() happens
> > after a (successful) trylock, we must observe that LOCKED bit.
> 
> When you said "concurrent unlock cannot trigger the uncontended
> handoff", are you saying the current code has this uncontended handoff
> problem or just when comparing to doing a load first followed by xchg()?

In particular I'm talking about this:

locked:
	/*
	 * claim the lock:
	 *
	 * n,0,0 -> 0,0,1 : lock, uncontended
	 * *,0,0 -> *,0,1 : lock, contended
	 *
	 * If the queue head is the only one in the queue (lock value == tail)
	 * and nobody is pending, clear the tail code and grab the lock.
	 * Otherwise, we only need to grab the lock.
	 */
	/*
	 * In the PV case we might already have _Q_LOCKED_VAL set, because
	 * of lock stealing; therefore we must also allow:
	 *
	 * n,0,1 -> 0,0,1
	 *
	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
	 *       above wait condition, therefore any concurrent setting of
	 *       PENDING will make the uncontended transition fail.
	 */
	if ((val & _Q_TAIL_MASK) == tail) {
		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
			goto release; /* No contention */
	}


Here queue head acquires the lock and we take the "uncontended" path. If
we set PENDING prior to this, the cmpxchg above will fail, and the later
load will observe the tail.


