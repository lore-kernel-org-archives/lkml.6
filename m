Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAD7C282D8
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81682082F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfAaBeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:34:08 -0500
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:44497 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfAaBeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:34:07 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl6.internode.on.net with ESMTP; 31 Jan 2019 12:04:03 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gp1Ex-0001yb-4V; Thu, 31 Jan 2019 12:34:03 +1100
Date:   Thu, 31 Jan 2019 12:34:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Mason <clm@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached
 pages"
Message-ID: <20190131013403.GI4205@dastard>
References: <20190130041707.27750-1-david@fromorbit.com>
 <20190130041707.27750-2-david@fromorbit.com>
 <25EAF93D-BC63-4409-AF21-F45B2DDF5D66@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25EAF93D-BC63-4409-AF21-F45B2DDF5D66@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:21:07PM +0000, Chris Mason wrote:
> 
> 
> On 29 Jan 2019, at 23:17, Dave Chinner wrote:
> 
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > This reverts commit a76cf1a474d7dbcd9336b5f5afb0162baa142cf0.
> >
> > This change causes serious changes to page cache and inode cache
> > behaviour and balance, resulting in major performance regressions
> > when combining worklaods such as large file copies and kernel
> > compiles.
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=202441
> 
> I'm a little confused by the latest comment in the bz:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=202441#c24

Which says the first patch that changed the shrinker behaviour is
the underlying cause of the regression.

> Are these reverts sufficient?

I think so.

> Roman beat me to suggesting Rik's followup.  We hit a different problem 
> in prod with small slabs, and have a lot of instrumentation on Rik's 
> code helping.

I think that's just another nasty, expedient hack that doesn't solve
the underlying problem. Solving the underlying problem does not
require changing core reclaim algorithms and upsetting a page
reclaim/shrinker balance that has been stable and worked well for
just about everyone for years.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
