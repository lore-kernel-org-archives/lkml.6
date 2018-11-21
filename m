Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D5AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E862148E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VD4DzED7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E862148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeKUSwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:52:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ck0nBe7SIfr2e/1NwtWF4vvTe1CuwhL7eBNFzrtrILk=; b=VD4DzED71Ikyyu4uXe0AKlHtF
        SeepMZQn0060GwZyfbEeDF2F+XanEKMepM/SQcvKMraleXA86EiVvVoJIafx6FtOvckmBPbbWPU2d
        FW1WPa633KhXddvO3Nk8doIxf4FbOXaoef8FVBiB3uJTppm+TqpBYfDfN04ol3bQLop9I2DhLHHPT
        LRORWGpJxuCb/oNRhRqPQILZpqa0q6UnGxU6qt+pa2eQQPbLx08mHQgJhNsdfa4LcEVdM+o5k9xEF
        gJb8k45TuDPBCsP4wHWKun9Xtx9Gy3kqk9Y9yMSpgW7CemWOf9HoocJ1k8GYQiJAyC+1lBTqR+NOV
        5VMIvAdBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPNiH-0004OC-26; Wed, 21 Nov 2018 08:18:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90F082029FD58; Wed, 21 Nov 2018 09:18:19 +0100 (CET)
Date:   Wed, 21 Nov 2018 09:18:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 20/25] sched/kcpustat: Introduce vtime-aware kcpustat
 accessor
Message-ID: <20181121081819.GG2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-21-git-send-email-frederic@kernel.org>
 <20181120142306.GX2131@hirez.programming.kicks-ass.net>
 <20181120224021.GB22332@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120224021.GB22332@lerouge>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:40:22PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 20, 2018 at 03:23:06PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 14, 2018 at 03:46:04AM +0100, Frederic Weisbecker wrote:
> > 
> > > +void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
> > > +		      u64 *user, u64 *nice, u64 *system,
> > > +		      u64 *guest, u64 *guest_nice)
> > > +{
> > > +	struct task_struct *curr;
> > > +	struct vtime *vtime;
> > > +	int err;
> > > +
> > > +	if (!vtime_accounting_enabled()) {
> > > +		kcpustat_cputime_raw(kcpustat, user, nice,
> > > +				     system, guest, guest_nice);
> > > +		return;
> > > +	}
> > > +
> > > +	rcu_read_lock();
> > > +
> > > +	do {
> > > +		curr = rcu_dereference(kcpustat->curr);
> > 
> > Like I explained earlier; I don't think the above is correct.
> > task_struct is itself not RCU protected.
> 
> But there is at least one put_task_struct() that is enqueued as an RCU callback
> on release_task(). That patchset (try to) make sure that kcpustat->curr can't
> be assigned beyond that point.
> 
> Or did I misunderstand something?

Yeah; release_task() is not the normal exit path. Oleg can probably
remember how all that works, because I always get lost there :-/

In any case, have a look at task_rcu_dereference(), but that still does
not explain the rcu_assign_pointer() stuff you use to set
kcpustat->curr.
