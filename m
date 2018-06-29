Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C5C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D91921568
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D91921568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbeF2RoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:44:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755232AbeF2RoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:44:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68073AD97;
        Fri, 29 Jun 2018 17:44:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 735F01E3C1A; Fri, 29 Jun 2018 19:44:15 +0200 (CEST)
Date:   Fri, 29 Jun 2018 19:44:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] fs: fsnotify: account fsnotify metadata to kmemcg
Message-ID: <20180629174415.edjickzrvascp43d@quack2.suse.cz>
References: <20180627191250.209150-1-shakeelb@google.com>
 <20180627191250.209150-2-shakeelb@google.com>
 <20180628100253.jscxkw2d6vfhnbo5@quack2.suse.cz>
 <CALvZod5Fy7cUnqMvCqw8M52wm8+wBtGD-bhUibN=Uwdzb+5Kyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5Fy7cUnqMvCqw8M52wm8+wBtGD-bhUibN=Uwdzb+5Kyw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-06-18 12:21:26, Shakeel Butt wrote:
> On Thu, Jun 28, 2018 at 12:03 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 27-06-18 12:12:49, Shakeel Butt wrote:
> > > A lot of memory can be consumed by the events generated for the huge or
> > > unlimited queues if there is either no or slow listener.  This can cause
> > > system level memory pressure or OOMs.  So, it's better to account the
> > > fsnotify kmem caches to the memcg of the listener.
> > >
> > > However the listener can be in a different memcg than the memcg of the
> > > producer and these allocations happen in the context of the event
> > > producer. This patch introduces remote memcg charging API which the
> > > producer can use to charge the allocations to the memcg of the listener.
> > >
> > > There are seven fsnotify kmem caches and among them allocations from
> > > dnotify_struct_cache, dnotify_mark_cache, fanotify_mark_cache and
> > > inotify_inode_mark_cachep happens in the context of syscall from the
> > > listener.  So, SLAB_ACCOUNT is enough for these caches.
> > >
> > > The objects from fsnotify_mark_connector_cachep are not accounted as they
> > > are small compared to the notification mark or events and it is unclear
> > > whom to account connector to since it is shared by all events attached to
> > > the inode.
> > >
> > > The allocations from the event caches happen in the context of the event
> > > producer.  For such caches we will need to remote charge the allocations
> > > to the listener's memcg.  Thus we save the memcg reference in the
> > > fsnotify_group structure of the listener.
> > >
> > > This patch has also moved the members of fsnotify_group to keep the size
> > > same, at least for 64 bit build, even with additional member by filling
> > > the holes.
> >
> > ...
> >
> > >  static int __init fanotify_user_setup(void)
> > >  {
> > > -     fanotify_mark_cache = KMEM_CACHE(fsnotify_mark, SLAB_PANIC);
> > > +     fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
> > > +                                      SLAB_PANIC|SLAB_ACCOUNT);
> > >       fanotify_event_cachep = KMEM_CACHE(fanotify_event_info, SLAB_PANIC);
> > >       if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
> > >               fanotify_perm_event_cachep =
> >
> > Why don't you setup also fanotify_event_cachep and
> > fanotify_perm_event_cachep caches with SLAB_ACCOUNT and instead specify
> > __GFP_ACCOUNT manually? Otherwise the patch looks good to me.
> >
> 
> Hi Jan, IMHO having a visible __GFP_ACCOUNT along with
> memalloc_use_memcg() makes the code more explicit and readable that we
> want to targeted/remote memcg charging. However if you think
> otherwise, I will replace __GFP_ACCOUNT with SLAB_ACCOUNT.

OK, fair enough.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
