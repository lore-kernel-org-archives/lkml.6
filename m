Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF60C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D589420832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D589420832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeK1RbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:31:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:55112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbeK1RbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:31:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC5E9B08A;
        Wed, 28 Nov 2018 06:30:43 +0000 (UTC)
Date:   Wed, 28 Nov 2018 07:30:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, rong.a.chen@intel.com,
        s.priebe@profihost.ag, alex.williamson@redhat.com,
        mgorman@techsingularity.net, zi.yan@cs.rutgers.edu,
        Vlastimil Babka <vbabka@suse.cz>, rientjes@google.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181128063040.GF6923@dhcp22.suse.cz>
References: <20181127062503.GH6163@shao2-debian>
 <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com>
 <CAHk-=wiEUPBzAOPkH1aHypnxW6+vVtmCw_vsOPgNZtOvQnrG8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEUPBzAOPkH1aHypnxW6+vVtmCw_vsOPgNZtOvQnrG8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-11-18 14:50:05, Linus Torvalds wrote:
> On Tue, Nov 27, 2018 at 12:57 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > This difference can only happen with defrag=always, and that's not the
> > current upstream default.
> 
> Ok, thanks. That makes it a bit less critical.
> 
> > That MADV_HUGEPAGE causes flights with NUMA balancing is not great
> > indeed, qemu needs NUMA locality too, but then the badness caused by
> > __GFP_THISNODE was a larger regression in the worst case for qemu.
> [...]
> > So the short term alternative again would be the alternate patch that
> > does __GFP_THISNODE|GFP_ONLY_COMPACT appended below.
> 
> Sounds like we should probably do this. Particularly since Vlastimil
> pointed out that we'd otherwise have issues with the back-port for 4.4
> where that "defrag=always" was the default.
> 
> The patch doesn't look horrible, and it directly addresses this
> particular issue.
> 
> Is there some reason we wouldn't want to do it?

We have discussed it previously and the biggest concern was that it
introduces a new GFP flag with a very weird and one-off semantic.
Anytime we have done that in the past it basically kicked back because
people have started to use such a flag and any further changes were
really hard to do. So I would really prefer some more systematic
solution. And I believe we can do that here. MADV_HUGEPAGE (resp. THP
always enabled) has gained a local memory policy with the patch which
got effectively reverted. I do believe that conflating "I want THP" with
"I want them local" is just wrong from the API point of view. There are
different classes of usecases which obviously disagree on the later.

So I believe that a long term solution should introduce a
MPOL_NODE_RECLAIM kind of policy. It would effectively reclaim local
nodes (within NODE_RECLAIM distance) before falling to other nodes.

Apart from that we need a less disruptive reclaim driven by compaction
and Mel is already working on that AFAIK.
-- 
Michal Hocko
SUSE Labs
