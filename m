Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F94BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B4820892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544169000;
	bh=6gu7dDw73jBCAyk3SC9eeIUE5hF31ZAaCXQi/wISiJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JwsRamLhKb/Vgpbq0tutQb+y3Yb3lt/EQ3xG/DMcrFl7hE1U38XHW9O44SzWEFb98
	 sH6nhcevkl2e5LfTnMsCRoWvp9o0s2s9zftDaXR7U4Xw31pLoi36yByqOFueABLDv5
	 3JNevS8MHG/cVdfHiWxVWmyac9rT1fJ7cLloxpYw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B4820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLGHt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:49:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbeLGHt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:49:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E74F9B007;
        Fri,  7 Dec 2018 07:49:55 +0000 (UTC)
Date:   Fri, 7 Dec 2018 08:49:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: MADV_HUGEPAGE vs. NUMA semantic (was: Re: [LKP] [mm] ac5b2c1891:
 vm-scalability.throughput -61.3% regression)
Message-ID: <20181207074954.GR1286@dhcp22.suse.cz>
References: <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <20181206091405.GD1286@dhcp22.suse.cz>
 <CAHk-=whCnERJt8bterD5yXABvoSmoJAx004Y76c82bBHCWbgDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCnERJt8bterD5yXABvoSmoJAx004Y76c82bBHCWbgDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-12-18 20:31:46, Linus Torvalds wrote:
> [ Oops. different thread for me due to edited subject, so I saw this
> after replying to the earlier email by David ]

Sorry about that but I really wanted to make the actual discussion about
semantic clearly distinguished because the thread just grown too large
with back and forth that didn't lead to anywhere.

> On Thu, Dec 6, 2018 at 1:14 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > MADV_HUGEPAGE changes the picture because the caller expressed a need
> > for THP and is willing to go extra mile to get it.
> 
> Actually, I think MADV_HUGEPAGE should just be
> "TRANSPARENT_HUGEPAGE_ALWAYS but only for this vma".

Yes, that is the case and I didn't want to make the description more
complicated than necessary so I've focused only on the current default.
But historically we have treated defrag=always and MADV_HUGEPAGE the
same.

[...]
> >I believe that something like the below would be sensible
> >         1) THP on a local node with compaction not giving up too early
> >         2) THP on a remote node in NOWAIT mode - so no direct
> >            compaction/reclaim (trigger kswapd/kcompactd only for
> >            defrag=defer+madvise)
> >         3) fallback to the base page allocation
> 
> That doesn't sound insane to me. That said, the numbers David quoted
> do fairly strongly imply that local small-pages are actually preferred
> to any remote THP pages.

As I and others pointed out elsewhere remote penalty is just a part of
the picture and on its own might be quite misleading. There are other
aspects (TLB pressure, page tables overhead etc) that might amortize the
access latency.

> But *that* in turn makes for other possible questions:
> 
>  - if the reason we couldn't get a local hugepage is that we're simply
> out of local memory (huge *or* small), then maybe a remote hugepage is
> better.
> 
>    Note that this now implies that the choice can be an issue of "did
> the hugepage allocation fail due to fragmentation, or due to the node
> being low of memory"

How exactly do you tell? Many systems are simply low on memory due to
caching. A clean pagecache is quite cheap to reclaim but it can be more
expensive to fault in. Do we consider it to be a viable target?

> 
> and there is the other question that I asked in the other thread
> (before subject edit):
> 
>  - how local is the load to begin with?
> 
>    Relatively shortlived processes - or processes that are explicitly
> bound to a node - might have different preferences than some
> long-lived process where the CPU bounces around, and might have
> different trade-offs for the local vs remote question too.

Agreed

> So just based on David's numbers, and some wild handwaving on my part,
> a slightly more complex, but still very sensible default might be
> something like
> 
>  1) try to do a cheap local node hugepage allocation
> 
>     Rationale: everybody agrees this is the best case.
> 
>     But if that fails:
> 
>  2) look at compacting and the local node, but not very hard.
> 
>     If there's lots of memory on the local node, but synchronous
> compaction doesn't do anything easily, just fall back to small pages.

Do we reclaim at this stage or this is mostly GFP_NOWAIT attempt?

>     Rationale: local memory is generally more important than THP.
> 
>     If that fails (ie local node is simply low on memory):
> 
>  3) Try to do remote THP allocation
> 
>      Rationale: Ok, we simply didn't have a lot of local memory, so
> it's not just a question of fragmentation. If it *had* been
> fragmentation, lots of small local pages would have been better than a
> remote THP page.
> 
>      Oops, remote THP allocation failed (possibly after synchronous
> remote compaction, but maybe this is where we do kcompactd).
> 
>  4) Just do any small page, and do reclaim etc. THP isn't happening,
> and it's not a priority when you're starting to feel memory pressure.

If 2) doesn't reclaim heavily (e.g. only try to reclaim clean page
cache) or even do NOWAIT (which would be even better) then I _think_
this sounds sane.

> In general, I really would want to avoid magic kernel command lines
> (or sysfs settings, or whatever) making a huge difference in behavior.
> So I really wish people would see the whole
> 'transparent_hugepage_flags' thing as a way for kernel developers to
> try different settings, not as a way for users to tune their loads.
> 
> Our default should work as sane defaults, we shouldn't have a "ok,
> let's have this sysfs tunable and let people make their own
> decisions". That's a cop-out.

Agreed. I cannot say I am happy with all the ways THP can be tuned. It
is quite confusing to say the least.

-- 
Michal Hocko
SUSE Labs
