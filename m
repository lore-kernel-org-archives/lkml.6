Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE84CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C3827CF3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C3827CF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934753AbeF2JwU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934570AbeF2JwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:52:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 626B9ACF3;
        Fri, 29 Jun 2018 09:52:01 +0000 (UTC)
Date:   Fri, 29 Jun 2018 11:52:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20180629095200.GF13860@dhcp22.suse.cz>
References: <20180627191250.209150-1-shakeelb@google.com>
 <20180627191250.209150-2-shakeelb@google.com>
 <20180628100253.jscxkw2d6vfhnbo5@quack2.suse.cz>
 <CALvZod5Fy7cUnqMvCqw8M52wm8+wBtGD-bhUibN=Uwdzb+5Kyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5Fy7cUnqMvCqw8M52wm8+wBtGD-bhUibN=Uwdzb+5Kyw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
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
> want to targeted/remote memcg charging.

Agreed. If you had an implicit SLAB_ACCOUNT then you could get
inconsistencies when some allocations would get charged to the current
task while others would not.
-- 
Michal Hocko
SUSE Labs
