Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4FBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828B520883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828B520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeGJLBx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:01:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:42030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751418AbeGJLBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:01:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDE28AECD;
        Tue, 10 Jul 2018 11:01:50 +0000 (UTC)
Date:   Tue, 10 Jul 2018 13:01:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
Message-ID: <20180710100735.GF14284@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
 <20180705164621.0a4fe6ab3af27a1d387eecc9@linux-foundation.org>
 <alpine.DEB.2.21.1807061652430.71359@chino.kir.corp.google.com>
 <20180709123524.GK22049@dhcp22.suse.cz>
 <alpine.DEB.2.21.1807091323570.101462@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807091323570.101462@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-07-18 13:30:10, David Rientjes wrote:
> On Mon, 9 Jul 2018, Michal Hocko wrote:
> 
> > > Blockable mmu notifiers and mlocked memory is not the extent of the 
> > > problem, if a process has a lot of virtual memory we must wait until 
> > > free_pgtables() completes in exit_mmap() to prevent unnecessary oom 
> > > killing.  For implementations such as tcmalloc, which does not release 
> > > virtual memory, this is important because, well, it releases this only at 
> > > exit_mmap().  Of course we cannot do that with only the protection of 
> > > mm->mmap_sem for read.
> > 
> > And how exactly a timeout helps to prevent from "unnecessary killing" in
> > that case?
> 
> As my patch does, it becomes mandatory to move MMF_OOM_SKIP to after 
> free_pgtables() in exit_mmap() and then repurpose MMF_UNSTABLE to 
> indicate that the oom reaper should not operate on a given mm.  In the 
> event we cannot reach MMF_OOM_SKIP, we need to ensure forward progress and 
> that is possible with a timeout period in the very rare instance where 
> additional memory freeing is needed, and without unnecessary oom killing 
> when it is not needed.

But such a timeout doesn't really know how much to wait so it is more
a hack than anything else. The only reason why we set MMF_OOM_SKIP so
early in the exit path now is inability to reap mlocked memory. That
is something fundamentally solvable. In fact we can really postpone
MMF_OOM_SKIP to after free_pgtables. It would require to extend the
current handover between the oom reaper and the exit path but it is
doable AFAICS. Only the exit path can call free_pgtables but the oom
reaper doesn't have to set MMF_OOM_SKIP if it _knows_ that the exit_mmap
is already past any point of blocking.

Btw, I am quite surprise you are now worried about oom victims with
basically no memory mapped and a huge amount of memory in page tables.
We have never handled that case properly IIRC. So oom_reaper hasn't
added anything new here.

That being said, I haven't heard any bug reports for over eager oom
killer just because of the oom reaper except your rather non-specific
claims about millions of pointless oom invocations. So I am not really
convinced we have to rush into a solution. I would much rather work
on a proper and comprehensible solution than put one band aid over
another. This has been the case in the oom proper for many years and
we have ended up with a subtle code which is way too easy to break and
nightmare to maintain. Let's not repeat that again please.

So do not rush into first idea and let's do the proper development
here. This means the proper analysis of the problem, find a solution
space and chose one which is the most reasonable long term.
-- 
Michal Hocko
SUSE Labs
