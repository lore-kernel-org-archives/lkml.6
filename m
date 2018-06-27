Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D017C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D9D26584
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D9D26584
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeF0Hbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:31:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbeF0Hbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:31:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED0CEAFFC;
        Wed, 27 Jun 2018 07:31:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 028BC1E3BFD; Wed, 27 Jun 2018 09:31:45 +0200 (CEST)
Date:   Wed, 27 Jun 2018 09:31:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: fsnotify: account fsnotify metadata to kmemcg
Message-ID: <20180627073145.yyviq53ntkdkfv3w@quack2.suse.cz>
References: <20180625230659.139822-1-shakeelb@google.com>
 <20180625230659.139822-2-shakeelb@google.com>
 <CAOQ4uxiV75+X3dMLS93iXqwmSU6eKPOUocdkXiR7MQZhEjotQg@mail.gmail.com>
 <CALvZod5ARMZL+eD8-mrxeBvxJcuVPXaCwWEgUyQw85xXWxHauA@mail.gmail.com>
 <20180626185724.GA3958@cmpxchg.org>
 <CALvZod5aEHcLs3j+AiuC1FppD-AakWhdZdQhzmTSSrktn2Gu0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5aEHcLs3j+AiuC1FppD-AakWhdZdQhzmTSSrktn2Gu0Q@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-06-18 12:07:57, Shakeel Butt wrote:
> On Tue, Jun 26, 2018 at 11:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Jun 26, 2018 at 11:00:53AM -0700, Shakeel Butt wrote:
> > > On Mon, Jun 25, 2018 at 10:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > ...
> > > >
> > > > The verb 'unuse' takes an argument memcg and 'uses' it - too weird.
> > > > You can use 'override'/'revert' verbs like override_creds or just call
> > > > memalloc_use_memcg(old_memcg) since there is no reference taken
> > > > anyway in use_memcg and no reference released in unuse_memcg.
> > > >
> > > > Otherwise looks good to me.
> > > >
> > >
> > > Thanks for your feedback. Just using memalloc_use_memcg(old_memcg) and
> > > ignoring the return seems more simple. I will wait for feedback from
> > > other before changing anything.
> >
> > We're not nesting calls to memalloc_use_memcg(), right? So we don't
> > have to return old_memcg and don't have to pass anything to unuse, it
> > can always set current->active_memcg to NULL.
> 
> For buffer_head, the allocation is done with GFP_NOFS. So, I think
> there is no chance of nesting. The fsnotify uses GFP_KERNEL but based
> on my limited understanding of fsnotify, there should not be any
> nesting i.e. the allocation triggering reclaim which trigger fsnotify
> events. Though I would like Amir or Jan to confirm there is no nesting
> possible.

You are correct. Fsnotify events are generated only as a result of some
syscall, not due to reclaim or stuff like that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
