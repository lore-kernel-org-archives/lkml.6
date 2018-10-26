Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E23DECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E1E20854
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E1E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeJZQJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:09:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:41732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbeJZQJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:09:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79C18ACC5;
        Fri, 26 Oct 2018 07:33:10 +0000 (UTC)
Date:   Fri, 26 Oct 2018 09:33:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Message-ID: <20181026073303.GW18839@dhcp22.suse.cz>
References: <20181023164302.20436-1-guro@fb.com>
 <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
 <20181025092352.GP18839@dhcp22.suse.cz>
 <20181025124442.5513d282273786369bbb7460@linux-foundation.org>
 <20181025202014.GA216405@sasha-vm>
 <20181025203240.GA2504@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025203240.GA2504@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-10-18 20:32:47, Roman Gushchin wrote:
> On Thu, Oct 25, 2018 at 04:20:14PM -0400, Sasha Levin wrote:
> > On Thu, Oct 25, 2018 at 12:44:42PM -0700, Andrew Morton wrote:
> > > On Thu, 25 Oct 2018 11:23:52 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > > On Wed 24-10-18 15:19:50, Andrew Morton wrote:
> > > > > On Tue, 23 Oct 2018 16:43:29 +0000 Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > > Spock reported that the commit 172b06c32b94 ("mm: slowly shrink slabs
> > > > > > with a relatively small number of objects") leads to a regression on
> > > > > > his setup: periodically the majority of the pagecache is evicted
> > > > > > without an obvious reason, while before the change the amount of free
> > > > > > memory was balancing around the watermark.
> > > > > >
> > > > > > The reason behind is that the mentioned above change created some
> > > > > > minimal background pressure on the inode cache. The problem is that
> > > > > > if an inode is considered to be reclaimed, all belonging pagecache
> > > > > > page are stripped, no matter how many of them are there. So, if a huge
> > > > > > multi-gigabyte file is cached in the memory, and the goal is to
> > > > > > reclaim only few slab objects (unused inodes), we still can eventually
> > > > > > evict all gigabytes of the pagecache at once.
> > > > > >
> > > > > > The workload described by Spock has few large non-mapped files in the
> > > > > > pagecache, so it's especially noticeable.
> > > > > >
> > > > > > To solve the problem let's postpone the reclaim of inodes, which have
> > > > > > more than 1 attached page. Let's wait until the pagecache pages will
> > > > > > be evicted naturally by scanning the corresponding LRU lists, and only
> > > > > > then reclaim the inode structure.
> > > > >
> > > > > Is this regression serious enough to warrant fixing 4.19.1?
> > > > 
> > > > Let's not forget about stable tree(s) which backported 172b06c32b94. I
> > > > would suggest reverting there.
> > > 
> > > Yup.  Sasha, can you please take care of this?
> > 
> > Sure, I'll revert it from current stable trees.
> > 
> > Should 172b06c32b94 and this commit be backported once Roman confirms
> > the issue is fixed? As far as I understand 172b06c32b94 addressed an
> > issue FB were seeing in their fleet and needed to be fixed.
> 
> The memcg leak was also independently reported by several companies,
> so it's not only about our fleet.

By memcg leak you mean a lot of dead memcgs with small amount of memory
which are staying behind and the global memory pressure removes them
only very slowly or almost not at all, right?

I have avague recollection that systemd can trigger a pattern which
makes this "leak" noticeable. Is that right? If yes what would be a
minimal and safe fix for the stable tree? "mm: don't miss the last page
because of round-off error" would sound like the candidate but I never
got around to review it properly.

> The memcg css leak is fixed by a series of commits (as in the mm tree):
>   37e521912118 math64: prevent double calculation of DIV64_U64_ROUND_UP() arguments
>   c6be4e82b1b3 mm: don't miss the last page because of round-off error
>   f2e821fc8c63 mm: drain memcg stocks on css offlining
>   03a971b56f18 mm: rework memcg kernel stack accounting

btw. none of these sha are refering to anything in my git tree. They all
seem to be in the next tree though.

>   172b06c32b94 mm: slowly shrink slabs with a relatively small number of objects
> 
> The last one by itself isn't enough, and it makes no sense to backport it
> without all other patches. So, I'd either backport them all (including
> 47036ad4032e ("mm: don't reclaim inodes with many attached pages"),
> either just revert 172b06c32b94.
> 
> Also 172b06c32b94 ("mm: slowly shrink slabs with a relatively small number of objects")
> by itself is fine, but it reveals an independent issue in inode reclaim code,
> which 47036ad4032e ("mm: don't reclaim inodes with many attached pages") aims to fix.

To me it sounds it needs much more time to settle before it can be
considered safe for the stable tree. Even if the patch itself is correct
it seems too subtle and reveal a behavior which was not anticipated and
that just proves it is far from straightforward.

-- 
Michal Hocko
SUSE Labs
