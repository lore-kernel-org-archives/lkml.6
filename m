Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1523C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79465218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBHVZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:25:35 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:2288 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727176AbfBHVZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:25:35 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 09 Feb 2019 07:55:31 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gsDeN-0006PR-2l; Sat, 09 Feb 2019 08:25:31 +1100
Date:   Sat, 9 Feb 2019 08:25:31 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>, Chris Mason <clm@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached
 pages"
Message-ID: <20190208212531.GN14116@dastard>
References: <20190130041707.27750-1-david@fromorbit.com>
 <20190130041707.27750-2-david@fromorbit.com>
 <25EAF93D-BC63-4409-AF21-F45B2DDF5D66@fb.com>
 <20190131013403.GI4205@dastard>
 <20190131091011.GP18811@dhcp22.suse.cz>
 <20190131185704.GA8755@castle.DHCP.thefacebook.com>
 <20190131221904.GL4205@dastard>
 <20190207102750.GA4570@quack2.suse.cz>
 <20190207213727.a791db810341cec2c013ba93@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207213727.a791db810341cec2c013ba93@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:37:27PM -0800, Andrew Morton wrote:
> On Thu, 7 Feb 2019 11:27:50 +0100 Jan Kara <jack@suse.cz> wrote:
> 
> > On Fri 01-02-19 09:19:04, Dave Chinner wrote:
> > > Maybe for memcgs, but that's exactly the oppose of what we want to
> > > do for global caches (e.g. filesystem metadata caches). We need to
> > > make sure that a single, heavily pressured cache doesn't evict small
> > > caches that lower pressure but are equally important for
> > > performance.
> > > 
> > > e.g. I've noticed recently a significant increase in RMW cycles in
> > > XFS inode cache writeback during various benchmarks. It hasn't
> > > affected performance because the machine has IO and CPU to burn, but
> > > on slower machines and storage, it will have a major impact.
> > 
> > Just as a data point, our performance testing infrastructure has bisected
> > down to the commits discussed in this thread as the cause of about 40%
> > regression in XFS file delete performance in bonnie++ benchmark.
> > 
> 
> Has anyone done significant testing with Rik's maybe-fix?

Apart from pointing out all the bugs and incorrect algorithmic
assumptions it makes, no.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
