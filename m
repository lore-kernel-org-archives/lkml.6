Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D781DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D0E2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D0E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeGQQ3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:29:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55935 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbeGQQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:29:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffSL0-0003xo-Fj; Tue, 17 Jul 2018 17:56:30 +0200
Date:   Tue, 17 Jul 2018 17:56:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/6] bdi: Use refcount_t for reference counting instead
 atomic_t
Message-ID: <20180717155630.5propcebpubol6x3@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
 <20180703200141.28415-4-bigeasy@linutronix.de>
 <20180716155716.1f7ac43d211133a8cb476637@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716155716.1f7ac43d211133a8cb476637@linux-foundation.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-16 15:57:16 [-0700], Andrew Morton wrote:
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -438,10 +438,10 @@ wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp)
> >  	if (new_congested) {
> >  		/* !found and storage for new one already allocated, insert */
> >  		congested = new_congested;
> > -		new_congested = NULL;
> >  		rb_link_node(&congested->rb_node, parent, node);
> >  		rb_insert_color(&congested->rb_node, &bdi->cgwb_congested_tree);
> > -		goto found;
> > +		spin_unlock_irqrestore(&cgwb_lock, flags);
> > +		return congested;
> >  	}
> >  
> >  	spin_unlock_irqrestore(&cgwb_lock, flags);
> > @@ -451,13 +451,13 @@ wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp)
> >  	if (!new_congested)
> >  		return NULL;
> >  
> > -	atomic_set(&new_congested->refcnt, 0);
> > +	refcount_set(&new_congested->refcnt, 1);
> >  	new_congested->__bdi = bdi;
> >  	new_congested->blkcg_id = blkcg_id;
> >  	goto retry;
> >  
> >  found:
> > -	atomic_inc(&congested->refcnt);
> > +	refcount_inc(&congested->refcnt);
> >  	spin_unlock_irqrestore(&cgwb_lock, flags);
> >  	kfree(new_congested);
> >  	return congested;
> >
> > ...
> >
> 
> I'm not sure that the restructuring of wb_congested_get_create() was
> desirable and it does make the patch harder to review.  But it looks
> OK to me.

By `restructuring' you mean the addition of return statement instead
using the goto label in the first hunk? If so, then you would have

	refcount_set(&new_congested->refcnt, 0);
	refcount_inc(&congested->refcnt);

which is a 0 -> 1 transition and is forbidden by refcount_t. So I had to
avoid this one.

Thank you applying the patches!

You applied the bdi and userns switch from atomic_t to refcount_t.
There were also the patches
  [PATCH 4/6] bdi: Use irqsave variant of refcount_dec_and_lock()
  [PATCH 6/6] userns: Use irqsave variant of refcount_dec_and_lock()

in the series which make use the irqsave version of
refcount_dec_and_lock(). Did you miss them by chance or skipped them on
purpose?

Sebastian
