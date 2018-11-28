Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C89C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3670206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3670206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeK2FmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:42:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeK2FmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:42:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2A223084038;
        Wed, 28 Nov 2018 18:39:40 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9522422B;
        Wed, 28 Nov 2018 18:39:36 +0000 (UTC)
Date:   Wed, 28 Nov 2018 13:39:36 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ying.huang@intel.com, Michal Hocko <mhocko@suse.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, rientjes@google.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181128183936.GF20740@redhat.com>
References: <20181127062503.GH6163@shao2-debian>
 <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com>
 <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 28 Nov 2018 18:39:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 08:48:46AM -0800, Linus Torvalds wrote:
> On Tue, Nov 27, 2018 at 7:20 PM Huang, Ying <ying.huang@intel.com> wrote:
> >
> > From the above data, for the parent commit 3 processes exited within
> > 14s, another 3 exited within 100s.  For this commit, the first process
> > exited at 203s.  That is, this commit makes memory allocation more fair
> > among processes, so that processes proceeded at more similar speed.  But
> > this raises system memory footprint too, so triggered much more swap,
> > thus lower benchmark score.

Ok so it was the previous more unfair behavior that increased overall
performance. It was also unclear to me that this was a full swap storm
test.

> > In general, memory allocation fairness among processes should be a good
> > thing.  So I think the report should have been a "performance
> > improvement" instead of "performance regression".
> 
> Hey, when you put it that way...
> 
> Let's ignore this issue for now, and see if it shows up in some real
> workload and people complain.

Agreed.

With regard to the other question about 4.4 backports, 4.0 didn't have
__GFP_THISNODE, so this will still revert to the previous behavior and
it won't risk to land into uncharted territory. So there should be no
major concern for the backports.

We should still work on improving this area, for now the idea was to
apply a strict hotfix that would just revert to the previous behavior
without introducing new features and new APIs, that would also have
the side effect of diminishing THP utilization under MADV_HUGEPAGE.

Thanks!
Andrea
