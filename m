Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6ADECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E329120881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E329120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbeGXIdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:33:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388390AbeGXIdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:33:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64D23AE1E;
        Tue, 24 Jul 2018 07:28:34 +0000 (UTC)
Date:   Tue, 24 Jul 2018 09:28:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     jing.xia.mail@gmail.com, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        chunyan.zhang@unisoc.com, Cgroups <cgroups@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: memcg: fix use after free in mem_cgroup_iter()
Message-ID: <20180724072833.GC28386@dhcp22.suse.cz>
References: <1531994807-25639-1-git-send-email-jing.xia@unisoc.com>
 <20180719104345.GV7193@dhcp22.suse.cz>
 <CALvZod55Ku7U3soLtuYY_HL2_mMp5+OT-hngdZkPRGN9xm1a9Q@mail.gmail.com>
 <20180723064441.GA17905@dhcp22.suse.cz>
 <CALvZod5UwJp8cM3OcjCDadkjKgAnGHj8XVcgjFk5Thcst02MAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5UwJp8cM3OcjCDadkjKgAnGHj8XVcgjFk5Thcst02MAQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-07-18 09:17:28, Shakeel Butt wrote:
> On Sun, Jul 22, 2018 at 11:44 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 19-07-18 09:23:10, Shakeel Butt wrote:
> > > On Thu, Jul 19, 2018 at 3:43 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > [CC Andrew]
> > > >
> > > > On Thu 19-07-18 18:06:47, Jing Xia wrote:
> > > > > It was reported that a kernel crash happened in mem_cgroup_iter(),
> > > > > which can be triggered if the legacy cgroup-v1 non-hierarchical
> > > > > mode is used.
> > > > >
> > > > > Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b8f
> > > > > ......
> > > > > Call trace:
> > > > >   mem_cgroup_iter+0x2e0/0x6d4
> > > > >   shrink_zone+0x8c/0x324
> > > > >   balance_pgdat+0x450/0x640
> > > > >   kswapd+0x130/0x4b8
> > > > >   kthread+0xe8/0xfc
> > > > >   ret_from_fork+0x10/0x20
> > > > >
> > > > >   mem_cgroup_iter():
> > > > >       ......
> > > > >       if (css_tryget(css))    <-- crash here
> > > > >           break;
> > > > >       ......
> > > > >
> > > > > The crashing reason is that mem_cgroup_iter() uses the memcg object
> > > > > whose pointer is stored in iter->position, which has been freed before
> > > > > and filled with POISON_FREE(0x6b).
> > > > >
> > > > > And the root cause of the use-after-free issue is that
> > > > > invalidate_reclaim_iterators() fails to reset the value of
> > > > > iter->position to NULL when the css of the memcg is released in non-
> > > > > hierarchical mode.
> > > >
> > > > Well, spotted!
> > > >
> > > > I suspect
> > > > Fixes: 6df38689e0e9 ("mm: memcontrol: fix possible memcg leak due to interrupted reclaim")
> > > >
> > > > but maybe it goes further into past. I also suggest
> > > > Cc: stable
> > > >
> > > > even though the non-hierarchical mode is strongly discouraged.
> > >
> > > Why not set root_mem_cgroup's use_hierarchy to true by default on
> > > init? If someone wants non-hierarchical mode, they can explicitly set
> > > it to false.
> >
> > We do not change defaults under users feet usually.
> 
> Then how non-hierarchical mode is being discouraged currently? I don't
> see any comments in the docs.

css_create warns about non-hierarchical hierarchies. We've been running
with a similar warning in (even older) SLES kernels for years now and
quite some tools have been updated because they simply didn't know they
are doing something wrong.
-- 
Michal Hocko
SUSE Labs
