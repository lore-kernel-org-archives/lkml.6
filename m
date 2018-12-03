Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7F9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3F2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD3F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLCTXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:23:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCTXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:23:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 867DB86678;
        Mon,  3 Dec 2018 19:23:47 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3814600C7;
        Mon,  3 Dec 2018 19:23:44 +0000 (UTC)
Date:   Mon, 3 Dec 2018 14:23:44 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181203192344.GA2986@redhat.com>
References: <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com>
 <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203185954.GM31738@dhcp22.suse.cz>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 03 Dec 2018 19:23:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 07:59:54PM +0100, Michal Hocko wrote:
> I have merely said that a better THP locality needs more work and during
> the review discussion I have even volunteered to work on that. There
> are other reclaim related fixes under work right now. All I am saying
> is that MADV_TRANSHUGE having numa locality implications cannot satisfy
> all the usecases and it is particurarly KVM that suffers from it.

I'd like to clarify it's not just KVM, we found with KVM because for
KVM it's fairly common to create VM that won't possibly fit in a
single node, while most other apps don't tend to allocate that much
memory.

It's trivial to reproduce the badness by running a memhog process that
allocates more than the RAM of 1 NUMA node, under defrag=always
setting (or by changing memhog to use MADV_HUGEPAGE) and it'll create
swap storms despite 75% of the RAM is completely free in a 4 node NUMA
(or 50% of RAM free in a 2 node NUMA) etc..

How can it be ok to push the system into gigabytes of swap by default
without any special capability despite 50% - 75% or more of the RAM is
free? That's the downside of the __GFP_THISNODE optimizaton.

__GFP_THISNODE helps increasing NUMA locality if your app can fit in a
single node which is the common David's workload. But if his workload
would more often than not fit in a single node, he would also run into
an unacceptable slowdown because of the __GFP_THISNODE.

I think there's lots of room for improvement for the future, but in my
view that __GFP_THISNODE as it was implemented was an incomplete hack,
that opened the door for bad VM corner cases that should not happen.

It also would be nice to have a reproducer for David's workload, the
software to run the binary on THP is not released either. We have lots
of reproducer for the corner case introduced by the __GFP_THISNODE
trick.

So this is basically a revert of the commit that made MADV_HUGEPAGE
with __GFP_THISNODE behave like a privileged (although not as static)
mbind.

I provided an alternative but we weren't sure if that was the best
long term solution that could satisfy everyone because it does have
some drawback too.

Thanks,
Andrea
