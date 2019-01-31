Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC74BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C776C2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548925815;
	bh=99u5P9hlgOJH5c8mwd6MHayR7X3qrh3knTyIoZEyHGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KZP3zvqVOF8Udol50wrP5Kd9xBAebWpD6A4ntNrMxUwc0xzQvVfMmXFCAcA0A0jrA
	 4OAsFU0Ud+r8EesHse2c2A6K8vGDha/wLclOza5Rh2eAwJwtdAtqzZRTLwRhyCgPdt
	 JyM+ONfmM+5bA5Vj5UXDBzyfEWbuMRXA5JFJfYtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfAaJKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:10:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:35310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbfAaJKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:10:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B6EFAE77;
        Thu, 31 Jan 2019 09:10:12 +0000 (UTC)
Date:   Thu, 31 Jan 2019 10:10:11 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chris Mason <clm@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached
 pages"
Message-ID: <20190131091011.GP18811@dhcp22.suse.cz>
References: <20190130041707.27750-1-david@fromorbit.com>
 <20190130041707.27750-2-david@fromorbit.com>
 <25EAF93D-BC63-4409-AF21-F45B2DDF5D66@fb.com>
 <20190131013403.GI4205@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131013403.GI4205@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-01-19 12:34:03, Dave Chinner wrote:
> On Wed, Jan 30, 2019 at 12:21:07PM +0000, Chris Mason wrote:
> > 
> > 
> > On 29 Jan 2019, at 23:17, Dave Chinner wrote:
> > 
> > > From: Dave Chinner <dchinner@redhat.com>
> > >
> > > This reverts commit a76cf1a474d7dbcd9336b5f5afb0162baa142cf0.
> > >
> > > This change causes serious changes to page cache and inode cache
> > > behaviour and balance, resulting in major performance regressions
> > > when combining worklaods such as large file copies and kernel
> > > compiles.
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=202441
> > 
> > I'm a little confused by the latest comment in the bz:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=202441#c24
> 
> Which says the first patch that changed the shrinker behaviour is
> the underlying cause of the regression.
> 
> > Are these reverts sufficient?
> 
> I think so.
> 
> > Roman beat me to suggesting Rik's followup.  We hit a different problem 
> > in prod with small slabs, and have a lot of instrumentation on Rik's 
> > code helping.
> 
> I think that's just another nasty, expedient hack that doesn't solve
> the underlying problem. Solving the underlying problem does not
> require changing core reclaim algorithms and upsetting a page
> reclaim/shrinker balance that has been stable and worked well for
> just about everyone for years.

I tend to agree with Dave here. Slab pressure balancing is quite subtle
and easy to get wrong. If we want to plug the problem with offline
memcgs then the fix should be targeted at that problem. So maybe we want
to emulate high pressure on offline memcgs only. There might be other
issues to resolve for small caches but let's start with something more
targeted first please.
-- 
Michal Hocko
SUSE Labs
