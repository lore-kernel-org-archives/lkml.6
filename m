Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D83C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E281C222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391859AbfBMLZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:25:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbfBMLZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:25:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA702A78;
        Wed, 13 Feb 2019 03:25:26 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D3523F557;
        Wed, 13 Feb 2019 03:25:23 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:25:21 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <20190213112520.GB1912@brain-police>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111843.GA1912@brain-police>
 <20190213112141.GO9565@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213112141.GO9565@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:21:41AM +0000, Mel Gorman wrote:
> On Wed, Feb 13, 2019 at 11:18:44AM +0000, Will Deacon wrote:
> > On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> > > My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> > > Backtrace is not too verbose:
> > > (gdb) i threads
> > >   Id   Target Id         Frame
> > > * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
> > >     at arch/arm64/lib/delay.c:49
> > >   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
> > >   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
> > >   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> > > (gdb) bt
> > > #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> > > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > > 
> > > Reverting the patch
> > > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > > fragmentation event occurs") together with following patch
> > > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > > helps me to boot normally. 
> > > 
> > > Some system information is below, and config is attached.
> > 
> > FWIW, running with your command-line and .config under KVM with earlycon
> > leads to an early page allocation failure followed by a NULL dereference
> > during boot if only 1G is configured (log below). For the mm folks, it's
> > probably worth pointing out that you're using 64k pages.
> > 
> 
> Thanks Will.
> 
> While I agree that going OOM early is a problem and would explain why
> the boosting logic was hit at all, it's still the case that the boosting
> should not divide by zero. Even if the booting is broken due to a lack
> of memory, I'd still not prefer to crash due to 1c30844d2dfe272d58c.

Yup, sorry, our previous mails crossed paths. Your patch looks sensible in
its own right, I'm just left wondering why we're OOM so early during boot!

Will
