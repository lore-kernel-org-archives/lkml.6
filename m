Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F7EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F73720846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="SDq+eh9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F73720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeFTPUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:20:20 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48592 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753853AbeFTPUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ODfGZfJ34dLcUmeJ0tXg09XWEsQZcPRgJ3EeQerPpTE=; b=SDq+eh9h8Nlh26PWdUiBzUB84E
        mNkefWmSe0TwXlEUJDjor4JDs9dF+dJ220eqbnl5lED4PeNd7nHe81YdsoZsZSVYa+/98sl2VoD9U
        M4pjOOpEMuKGUTLZklv9iYv6VkbI14zQoJ84MzoF60zp74xmZkBP8vy33Hdt4Uv7Fwyo=;
Date:   Wed, 20 Jun 2018 11:22:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/3] mm: memcg: remote memcg charging for kmem allocations
Message-ID: <20180620152235.GB2441@cmpxchg.org>
References: <20180619051327.149716-1-shakeelb@google.com>
 <20180619051327.149716-2-shakeelb@google.com>
 <20180619162429.GB27423@cmpxchg.org>
 <CALvZod7eq3WnMU8dzA+9CmbOuf-peaCyhLuMRW2n_VyOPqjZ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7eq3WnMU8dzA+9CmbOuf-peaCyhLuMRW2n_VyOPqjZ7A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:31:18PM -0700, Shakeel Butt wrote:
> On Tue, Jun 19, 2018 at 9:22 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Jun 18, 2018 at 10:13:25PM -0700, Shakeel Butt wrote:
> > > @@ -248,6 +248,30 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
> > >       current->flags = (current->flags & ~PF_MEMALLOC) | flags;
> > >  }
> > >
> > > +#ifdef CONFIG_MEMCG
> > > +static inline struct mem_cgroup *memalloc_memcg_save(struct mem_cgroup *memcg)
> > > +{
> > > +     struct mem_cgroup *old_memcg = current->target_memcg;
> > > +
> > > +     current->target_memcg = memcg;
> > > +     return old_memcg;
> > > +}
> > > +
> > > +static inline void memalloc_memcg_restore(struct mem_cgroup *memcg)
> > > +{
> > > +     current->target_memcg = memcg;
> > > +}
> >
> > The use_mm() and friends naming scheme would be better here:
> > memalloc_use_memcg(), memalloc_unuse_memcg(), current->active_memcg
> >
> 
> Ack. Though do you still think <linux/sched/mm.h> is the right place
> for these functions?

Yeah, since it has the memalloc_* prefix, we should keep it there.

If we did use_memcg(), unuse_memcg(), I'd put it into memcontrol.h,
but it seems a little terse; memalloc adds valuable context, IMO.

Thanks Shakeel!
