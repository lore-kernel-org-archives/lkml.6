Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CD8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D744620821
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391813AbfBMLVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:21:46 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:52797 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728454AbfBMLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:21:45 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 7860FB872B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:21:43 +0000 (GMT)
Received: (qmail 5961 invoked from network); 13 Feb 2019 11:21:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2019 11:21:43 -0000
Date:   Wed, 13 Feb 2019 11:21:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213112141.GO9565@techsingularity.net>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111843.GA1912@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190213111843.GA1912@brain-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:18:44AM +0000, Will Deacon wrote:
> Hi Yury,
> 
> On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> > My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> > Backtrace is not too verbose:
> > (gdb) i threads
> >   Id   Target Id         Frame
> > * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
> >     at arch/arm64/lib/delay.c:49
> >   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
> >   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
> >   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> > (gdb) bt
> > #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > 
> > Reverting the patch
> > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > fragmentation event occurs") together with following patch
> > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > helps me to boot normally. 
> > 
> > Some system information is below, and config is attached.
> 
> FWIW, running with your command-line and .config under KVM with earlycon
> leads to an early page allocation failure followed by a NULL dereference
> during boot if only 1G is configured (log below). For the mm folks, it's
> probably worth pointing out that you're using 64k pages.
> 

Thanks Will.

While I agree that going OOM early is a problem and would explain why
the boosting logic was hit at all, it's still the case that the boosting
should not divide by zero. Even if the booting is broken due to a lack
of memory, I'd still not prefer to crash due to 1c30844d2dfe272d58c.

-- 
Mel Gorman
SUSE Labs
