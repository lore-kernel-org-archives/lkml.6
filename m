Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C666C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4732086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4732086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeK1FQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:16:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725740AbeK1FQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:16:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 771EDAFF6;
        Tue, 27 Nov 2018 18:17:29 +0000 (UTC)
Date:   Tue, 27 Nov 2018 19:17:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rong.a.chen@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, alex.williamson@redhat.com,
        mgorman@techsingularity.net, zi.yan@cs.rutgers.edu,
        Vlastimil Babka <vbabka@suse.cz>, rientjes@google.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181127181727.GD6923@dhcp22.suse.cz>
References: <20181127062503.GH6163@shao2-debian>
 <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-11-18 09:08:50, Linus Torvalds wrote:
> On Mon, Nov 26, 2018 at 10:24 PM kernel test robot
> <rong.a.chen@intel.com> wrote:
> >
> > FYI, we noticed a -61.3% regression of vm-scalability.throughput due
> > to commit ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
> > MADV_HUGEPAGE mappings")
> 
> Well, that's certainly noticeable and not good.
> 
> Andrea, I suspect it might be causing fights with auto numa migration..
> 
> Lots more system time, but also look at this:
> 
> >    1122389 ±  9%     +17.2%    1315380 ±  4%  proc-vmstat.numa_hit
> >     214722 ±  5%     +21.6%     261076 ±  3%  proc-vmstat.numa_huge_pte_updates
> >    1108142 ±  9%     +17.4%    1300857 ±  4%  proc-vmstat.numa_local
> >     145368 ± 48%     +63.1%     237050 ± 17%  proc-vmstat.numa_miss
> >     159615 ± 44%     +57.6%     251573 ± 16%  proc-vmstat.numa_other
> >     185.50 ± 81%   +8278.6%      15542 ± 40%  proc-vmstat.numa_pages_migrated
> 
> Should the commit be reverted? Or perhaps at least modified?

Well, the commit is trying to revert to the behavior before
5265047ac301 because there are real usecases that suffered from that
change and bug reports as a result of that.

will-it-scale is certainly worth considering but it is an artificial
testcase. A higher NUMA miss rate is an expected side effect of the
patch because the fallback to a different NUMA node is more likely. The
__GFP_THISNODE side effect is basically introducing node-reclaim
behavior for THPages. Another thing is that there is no good behavior
for everybody. Reclaim locally vs. THP on a remote node is hard to
tell by default. We have discussed that at length and there were some
conclusions. One of them is that we need a numa policy to tell whether
a expensive localility is preferred over remote allocation.  Also we
definitely need a better pro-active defragmentation to allow larger
pages on a local node. This is a work in progress and this patch is a
stop gap fix.

-- 
Michal Hocko
SUSE Labs
