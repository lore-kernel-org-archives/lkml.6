Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB44C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D91E20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D91E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394754AbeKWXat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:30:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390833AbeKWXat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:30:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F275AEC0;
        Fri, 23 Nov 2018 12:46:44 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:46:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/3] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20181123124643.GK8625@dhcp22.suse.cz>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-3-daniel.vetter@ffwll.ch>
 <20181123111237.GE8625@dhcp22.suse.cz>
 <20181123123838.GL4266@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123123838.GL4266@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 13:38:38, Daniel Vetter wrote:
> On Fri, Nov 23, 2018 at 12:12:37PM +0100, Michal Hocko wrote:
> > On Thu 22-11-18 17:51:05, Daniel Vetter wrote:
> > > We need to make sure implementations don't cheat and don't have a
> > > possible schedule/blocking point deeply burried where review can't
> > > catch it.
> > > 
> > > I'm not sure whether this is the best way to make sure all the
> > > might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> > > But it gets the job done.
> > 
> > Yeah, it is quite ugly. Especially because it makes DEBUG config
> > bahavior much different. So is this really worth it? Has this already
> > discovered any existing bug?
> 
> Given that we need an oom trigger to hit this we're not hitting this in CI
> (oom is just way to unpredictable to even try). I'd kinda like to also add
> some debug interface so I can provoke an oom kill of a specially prepared
> process, to make sure we can reliably exercise this path without killing
> the kernel accidentally. We do similar tricks for our shrinker already.

Create a task with oom_score_adj = 1000 and trigger the oom killer via
sysrq and you should get a predictable oom invocation and execution.

[...]
> Wrt the behavior difference: I guess we could put another counter into the
> task struct, and change might_sleep() to check it. All under
> CONFIG_DEBUG_ATOMIC_SLEEP only ofc. That would avoid the preempt-disable
> sideeffect. My worry with that is that people will spot it, and abuse it
> in creative ways that do affect semantics. See horrors like
> drm_can_sleep() (and I'm sure gfx folks are not the only ones who
> seriously lacked taste here).
> 
> Up to the experts really how to best paint this shed I think.

Actually I like a way to say non_block_{begin,end} and might_sleep
firing inside that context.
-- 
Michal Hocko
SUSE Labs
