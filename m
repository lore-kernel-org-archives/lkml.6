Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D203FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A6F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zz9BCtXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBKKob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:44:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfBKKoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TdpNJzBJScidoXbvDlxAdk2zf/+STDvdb2VvSTfzMjY=; b=Zz9BCtXJG6rZZ5ywanNMjYcFd
        KpSGuZTJjKgsqWWER+u4EyzQuD9OaQcT9h1tmNfnTW6rLrTHyGgTQEWpLsNTL3+3iBgquQHt6M0ol
        U3pBzUQcmGgymrM9DrYAU0UqHkQo1PCR/kC+aax48NKCoT6UArHMd/rJX9dXwJNKno1EvRXxSfZn7
        I1xmjdo0X4U8rB8AMyCYNS37QtRru5D5V37ovVlXN5VXh9F2NIgZSikYWPjXEgs5ReD+zrbPUedOZ
        /tGas14N6XPUV7s7kbnJHg7RVP+m6z7V846m47YgkZvgYZ6HyNn30Zj+0YJsyDj/tQnjeH0V7yF2P
        aRnnIPiNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt94f-0002T7-GS; Mon, 11 Feb 2019 10:44:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9B4520D0E3CC; Mon, 11 Feb 2019 11:44:27 +0100 (CET)
Date:   Mon, 11 Feb 2019 11:44:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Improve the for loop in
 select_idle_core()
Message-ID: <20190211104427.GX32511@hirez.programming.kicks-ass.net>
References: <f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org>
 <6b165676325a47d67e667582a7b78da85c5c118a.1549536337.git.viresh.kumar@linaro.org>
 <20190211093014.GS32511@hirez.programming.kicks-ass.net>
 <20190211102659.wihncqtchczlj3j7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211102659.wihncqtchczlj3j7@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:56:59PM +0530, Viresh Kumar wrote:
> On 11-02-19, 10:30, Peter Zijlstra wrote:
> > On Thu, Feb 07, 2019 at 04:16:06PM +0530, Viresh Kumar wrote:
> > > @@ -6081,10 +6082,14 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> > >  	for_each_cpu_wrap(core, cpus, target) {
> > >  		bool idle = true;
> > >  
> > > -		for_each_cpu(cpu, cpu_smt_mask(core)) {
> > > -			cpumask_clear_cpu(cpu, cpus);
> > > -			if (!available_idle_cpu(cpu))
> > > +		smt = cpu_smt_mask(core);
> > > +		cpumask_andnot(cpus, cpus, smt);
> > 
> > So where the previous code was like 1-2 stores, you just added 16.
> 
> Is the max number of possible threads per core just 2? That's what I
> read just now and I wasn't aware of that earlier. This commit doesn't
> improve anything then. Sorry for the noise.

We've got up to SMT8 in the tree (Sparc64, Power8 and some MIPS IIRC),
but that's still less than having to touch the entire bitmap.

Also, Power9 went back to SMT4 and I think the majory of SMT deployments
is that or less.
