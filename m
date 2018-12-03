Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A623C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B4D20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B4D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLCSPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:15:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:41594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeLCSPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:15:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 918ECAEB7;
        Mon,  3 Dec 2018 18:15:04 +0000 (UTC)
Date:   Mon, 3 Dec 2018 19:14:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, rientjes@google.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181203181456.GK31738@dhcp22.suse.cz>
References: <20181127062503.GH6163@shao2-debian>
 <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com>
 <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 10:01:18, Linus Torvalds wrote:
> On Wed, Nov 28, 2018 at 8:48 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Nov 27, 2018 at 7:20 PM Huang, Ying <ying.huang@intel.com> wrote:
> > >
> > > In general, memory allocation fairness among processes should be a good
> > > thing.  So I think the report should have been a "performance
> > > improvement" instead of "performance regression".
> >
> > Hey, when you put it that way...
> >
> > Let's ignore this issue for now, and see if it shows up in some real
> > workload and people complain.
> 
> Well, David Rientjes points out that it *does* cause real problems in
> real workloads, so it's not just this benchmark run that shows the
> issue.

The thing is that there is no universal win here. There are two
different types of workloads and we cannot satisfy both. This has been
discussed at lenght during the review process. David's workload makes
some assumptions about the MADV_HUGEPAGE numa placement. There are other
workalods like KVM setups which do not really require that and those are
ones which regressed.

The prevalent consensus was that a NUMA placement is not really implied
by MADV_HUGEPAGE because a) this has never been documented or intended
behavior and b) it is not a universal win (basically the same as
node/zone_reclaim which used to be on by default on some NUMA setups).

Reverting the patch would regress another class of workloads. As we
cannot satisfy both I believe we should make the API clear and in favor
of a more relaxed workloads. Those with special requirements should have
a proper API to reflect that (this is our general NUMA policy pattern
already).
-- 
Michal Hocko
SUSE Labs
