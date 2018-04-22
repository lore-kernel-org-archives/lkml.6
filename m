Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeDVMvq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 08:51:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52059 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeDVMvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 08:51:45 -0400
Date: Sun, 22 Apr 2018 06:51:41 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chunyu Hu <chuhu@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [RFC] mm: kmemleak: replace __GFP_NOFAIL to GFP_NOWAIT in
 gfp_kmemleak_mask
Message-ID: <20180422125141.GF17484@dhcp22.suse.cz>
References: <1524243513-29118-1-git-send-email-chuhu@redhat.com>
 <20180420175023.3c4okuayrcul2bom@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420175023.3c4okuayrcul2bom@armageddon.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-04-18 18:50:24, Catalin Marinas wrote:
> On Sat, Apr 21, 2018 at 12:58:33AM +0800, Chunyu Hu wrote:
> > __GFP_NORETRY and  __GFP_NOFAIL are combined in gfp_kmemleak_mask now.
> > But it's a wrong combination. As __GFP_NOFAIL is blockable, but
> > __GFP_NORETY is not blockable, make it self-contradiction.
> > 
> > __GFP_NOFAIL means 'The VM implementation _must_ retry infinitely'. But
> > it's not the real intention, as kmemleak allow alloc failure happen in
> > memory pressure, in that case kmemleak just disables itself.
> 
> Good point. The __GFP_NOFAIL flag was added by commit d9570ee3bd1d
> ("kmemleak: allow to coexist with fault injection") to keep kmemleak
> usable under fault injection.
> 
> > commit 9a67f6488eca ("mm: consolidate GFP_NOFAIL checks in the allocator
> > slowpath") documented that what user wants here should use GFP_NOWAIT, and
> > the WARN in __alloc_pages_slowpath caught this weird usage.
> > 
> >  <snip>
> >  WARNING: CPU: 3 PID: 64 at mm/page_alloc.c:4261 __alloc_pages_slowpath+0x1cc3/0x2780
> [...]
> > Replace the __GFP_NOFAIL with GFP_NOWAIT in gfp_kmemleak_mask, __GFP_NORETRY
> > and GFP_NOWAIT are in the gfp_kmemleak_mask. So kmemleak object allocaion
> > is no blockable and no reclaim, making kmemleak less disruptive to user
> > processes in pressure.
> 
> It doesn't solve the fault injection problem for kmemleak (unless we
> change __should_failslab() somehow, not sure yet). An option would be to
> replace __GFP_NORETRY with __GFP_NOFAIL in kmemleak when fault injection
> is enabled.

Cannot we simply have a disable_fault_injection knob around the
allocation rather than playing this dirty tricks with gfp flags which do
not make any sense?

> BTW, does the combination of NOWAIT and NORETRY make kmemleak
> allocations more likely to fail?

NOWAIT + NORETRY simply doesn't make much sesne. It is equivalent to
NOWAIT.

-- 
Michal Hocko
SUSE Labs
