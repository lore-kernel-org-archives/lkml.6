Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DC0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7FE20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fnWRH2/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7FE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJCPMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:12:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeJCPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SnWEvdhXLuHyn7bx+aOzCtE9nI5o/0sU6npKfkVNb9A=; b=fnWRH2/qize75CEw5QTRTVaMn
        nPcnLvE96OzPb81P/LLYWYScNCSoRMa0nJbqVDGGTO0N20fw3vbPuthR/xlUwkCFAiU6asX5QZeyA
        KwvsczI9k3TTNFmBOHBmRA+ikzfVOmAbcdMsSdcfiyOy/FIxKBBk6Pfqo9bLsT6y7dlYiaV1Lo9Mz
        f89eA6pVKhWw9QvIJnZChcEx67ozJ9tP+uhNTMGqMxPRdcaCySjoYARQspBBROGrC/dZ0x3qdFuNz
        eG8Mm6h932U0GdjNk/kwNRNR0bP70sNgIX6CqLPNk2V3jf6KAtVkpKX7jgcadAzjc3aLlRRPsg0I1
        Rc3O/ZAPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7cSk-0007vm-ER; Wed, 03 Oct 2018 08:24:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F6C4202C1A1E; Wed,  3 Oct 2018 10:24:52 +0200 (CEST)
Date:   Wed, 3 Oct 2018 10:24:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] locking/lockdep: Make class->ops a percpu counter
Message-ID: <20181003082452.GM26858@hirez.programming.kicks-ass.net>
References: <1538511560-10090-1-git-send-email-longman@redhat.com>
 <1538511560-10090-5-git-send-email-longman@redhat.com>
 <20181003074809.GJ26858@hirez.programming.kicks-ass.net>
 <20181003075446.GA3183@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003075446.GA3183@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 09:54:46AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Oct 02, 2018 at 04:19:19PM -0400, Waiman Long wrote:
> > > +DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
> > 
> > > @@ -179,9 +181,30 @@ DECLARE_PER_CPU(struct lockdep_stats, lockdep_stats);
> > >  	}								\
> > >  	__total;							\
> > >  })
> > > +
> > > +static inline void debug_class_ops_inc(struct lock_class *class)
> > > +{
> > > +	int idx;
> > > +
> > > +	idx = class - lock_classes;
> > > +	__this_cpu_inc(lock_class_ops[idx]);
> > > +}
> > > +
> > > +static inline unsigned long debug_class_ops_read(struct lock_class *class)
> > > +{
> > > +	int idx, cpu;
> > > +	unsigned long ops = 0;
> > > +
> > > +	idx = class - lock_classes;
> > > +	for_each_possible_cpu(cpu)
> > > +		ops += per_cpu(lock_class_ops[idx], cpu);
> > > +	return ops;
> > > +}
> > 
> > Would it make sense to stick that in struct lockdep_stats ?
> > 
> > A little something like:
> > 
> > struct lockdep_stats {
> > 	/* ... */
> > 	int	lock_class_ops[MAX_LOCKDEP_KEYS];
> > };
> 
> Did you shrink the 'long' to 'int' intentionally?

nah, was because all of lockdep_stats is int and I didn't pay much
attention.
