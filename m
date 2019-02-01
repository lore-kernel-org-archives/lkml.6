Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6150DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412BA21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfBAXjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:39:09 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:47009 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfBAXjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:39:09 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 02 Feb 2019 10:09:06 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gpiOn-0004mk-3p; Sat, 02 Feb 2019 10:39:05 +1100
Date:   Sat, 2 Feb 2019 10:39:05 +1100
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
Message-ID: <20190201233905.GW6173@dastard>
References: <20190130041707.27750-1-david@fromorbit.com>
 <20190130041707.27750-2-david@fromorbit.com>
 <25EAF93D-BC63-4409-AF21-F45B2DDF5D66@fb.com>
 <20190131013403.GI4205@dastard>
 <E8895615-9DDA-4FC5-A3AB-1BE593138A89@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8895615-9DDA-4FC5-A3AB-1BE593138A89@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:48:11PM +0000, Chris Mason wrote:
> On 30 Jan 2019, at 20:34, Dave Chinner wrote:
> 
> > On Wed, Jan 30, 2019 at 12:21:07PM +0000, Chris Mason wrote:
> >>
> >>
> >> On 29 Jan 2019, at 23:17, Dave Chinner wrote:
> >>
> >>> From: Dave Chinner <dchinner@redhat.com>
> >>>
> >>> This reverts commit a76cf1a474d7dbcd9336b5f5afb0162baa142cf0.
> >>>
> >>> This change causes serious changes to page cache and inode cache
> >>> behaviour and balance, resulting in major performance regressions
> >>> when combining worklaods such as large file copies and kernel
> >>> compiles.
> >>>
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=202441
> >>
> >> I'm a little confused by the latest comment in the bz:
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=202441#c24
> >
> > Which says the first patch that changed the shrinker behaviour is
> > the underlying cause of the regression.
> >
> >> Are these reverts sufficient?
> >
> > I think so.
> 
> Based on the latest comment:
> 
> "If I had been less strict in my testing I probably would have 
> discovered that the problem was present earlier than 4.19.3. Mr Gushins 
> commit made it more visible.
> I'm going back to work after two days off, so I might not be able to 
> respond inside your working hours, but I'll keep checking in on this as 
> I get a chance."
> 
> I don't think the reverts are sufficient.

Roger has tested the two reverts more heavily against 5.0.0-rc3.
Without the reverts, the machine locks up hard. With the two reverts
applied, it runs along smoothly under extremely heavy load.

https://bugzilla.kernel.org/show_bug.cgi?id=202441#c26

So, yes, these changes need to be reverted.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
