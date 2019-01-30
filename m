Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD34C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59792084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NSgHBoYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbfA3Q7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:59:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51720 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfA3Q7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=biPdfHCjkM8Wb7MrNHX+rn/6pn6KlfFdOtgZDYIiBU4=; b=NSgHBoYULMwH7UEPluJGlY13+
        uABm1YRoRrpiBz3IRpjYqdje/RHWvFp03vs5CtOOd0yDGOyvuVyOTc6CGL2mqQQdkuLLR33sqTeSC
        noKno4MNgWPBiP89+gwSC+5V8X7Qz4znF58UFIZlyT7/Ar73jI+2SPFLuBuHE3qDJkEfKFVMqyX8u
        FZshosbi6KfDGOq4zhCdSZ8yzK8OMfelV7AkzbX41dgEhgA/QpATB5IagpMudnmhbI0swMINsjD1J
        rsT5//uBMVGEAGAg0iCLU1ZRf2TtFV4ma+b4A1Gp19Kju6L8JO4DHlWxk8d/KDCuQpFGCYuDOLhDQ
        BzM/T6+6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gotCY-0004sg-6R; Wed, 30 Jan 2019 16:59:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F23921408DC2; Wed, 30 Jan 2019 17:58:59 +0100 (CET)
Date:   Wed, 30 Jan 2019 17:58:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Message-ID: <20190130165859.GE2296@hirez.programming.kicks-ass.net>
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130130410.GG2278@hirez.programming.kicks-ass.net>
 <20190130130620.GB3103@hirez.programming.kicks-ass.net>
 <20190130132717.GC3103@hirez.programming.kicks-ass.net>
 <CAKfTPtBhOomgYONsdfaaVgZCENM+QhfPie2qpu0KyOsvMiog_g@mail.gmail.com>
 <20190130134023.GA2296@hirez.programming.kicks-ass.net>
 <CAKfTPtC1vRrvSH=JdQjOfeh809gRiwKGE7373zaF9jT862C1+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC1vRrvSH=JdQjOfeh809gRiwKGE7373zaF9jT862C1+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 04:48:47PM +0100, Vincent Guittot wrote:
> On Wed, 30 Jan 2019 at 14:40, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> 
> >
> >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > @@ -352,7 +354,12 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >         }
> >  }
> >
> > -/* Iterate through all leaf cfs_rq's on a runqueue: */
> > +static inline void assert_list_leaf_cfs_rq(struct rq *rq)
> > +{
> > +       SCHED_WARN_ON(rq->tmp_alone_branch != &rq->lead_cfs_rq_list);
> 
> small typo : s/lead_cfs_rq_list/leaf_cfs_rq_list/

D'0h, thanks!
