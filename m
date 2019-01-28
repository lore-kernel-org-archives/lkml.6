Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F919214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfA1UKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:10:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47326 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1UKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:10:31 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E475623FA;
        Mon, 28 Jan 2019 20:10:29 +0000 (UTC)
Date:   Mon, 28 Jan 2019 12:10:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Chris Mason <clm@fb.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm,slab,vmscan: accumulate gradual pressure on small
 slabs
Message-Id: <20190128121028.8ef4c19dd3fd1d60d2e3284c@linux-foundation.org>
In-Reply-To: <8ddf2ea674711f373062f4e056dd14fb81c5a2fe.camel@surriel.com>
References: <20190128143535.7767c397@imladris.surriel.com>
        <20190128115424.df3f4647023e9e43e75afe67@linux-foundation.org>
        <8ddf2ea674711f373062f4e056dd14fb81c5a2fe.camel@surriel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 15:03:28 -0500 Rik van Riel <riel@surriel.com> wrote:

> On Mon, 2019-01-28 at 11:54 -0800, Andrew Morton wrote:
> > On Mon, 28 Jan 2019 14:35:35 -0500 Rik van Riel <riel@surriel.com>
> > wrote:
> > 
> > >  	/*
> > >  	 * Make sure we apply some minimal pressure on default priority
> > > -	 * even on small cgroups. Stale objects are not only consuming
> > > memory
> > > +	 * even on small cgroups, by accumulating pressure across
> > > multiple
> > > +	 * slab shrinker runs. Stale objects are not only consuming
> > > memory
> > >  	 * by themselves, but can also hold a reference to a dying
> > > cgroup,
> > >  	 * preventing it from being reclaimed. A dying cgroup with all
> > >  	 * corresponding structures like per-cpu stats and kmem caches
> > >  	 * can be really big, so it may lead to a significant waste of
> > > memory.
> > >  	 */
> > > -	delta = max_t(unsigned long long, delta, min(freeable,
> > > batch_size));
> > > +	if (!delta) {
> > > +		shrinker->small_scan += freeable;
> > > +
> > > +		delta = shrinker->small_scan >> priority;
> > > +		shrinker->small_scan -= delta << priority;
> > > +
> > > +		delta *= 4;
> > > +		do_div(delta, shrinker->seeks);
> > 
> > What prevents shrinker->small_scan from over- or underflowing over
> > time?
> 
> We only go into this code path if
> delta >> DEF_PRIORITY is zero.
> 
> That is, freeable is smaller than 4096.
> 

I'm still not understanding.  If `freeable' always has a value of (say)
1, we'll eventually overflow shrinker->small_scan?  Or at least, it's
unobvious why this cannot happen.
