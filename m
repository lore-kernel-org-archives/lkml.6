Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E55C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE8B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544454124;
	bh=sQqDkja3twgfEEx1waWkgLGaLfqVGtFF5Zt55VMgxeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lV1nRfMZ51iQD/42qWfXYPbP7ZBgutyYAQUYWxXJ2PqLrpDValMo9aB6cXM1X32HK
	 hOQJgliMujLEe3cLeulriYhjNX+0Ks6FMcPFsCUGN/baCVJ4AgGguQi55dXw5OvyES
	 EBjX+xiKZFEPljbBcMxxBqxA3c+WcPE+w/1Xl+x8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE8B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbeLJPCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:02:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:48348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbeLJPCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:02:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D235CAFD4;
        Mon, 10 Dec 2018 15:02:00 +0000 (UTC)
Date:   Mon, 10 Dec 2018 16:01:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/4] kernel.h: Add non_block_start/end()
Message-ID: <20181210150159.GR1286@dhcp22.suse.cz>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
 <20181210103641.31259-3-daniel.vetter@ffwll.ch>
 <20181210141337.GQ1286@dhcp22.suse.cz>
 <20181210144711.GN5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210144711.GN5289@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-12-18 15:47:11, Peter Zijlstra wrote:
> On Mon, Dec 10, 2018 at 03:13:37PM +0100, Michal Hocko wrote:
> > I do not see any scheduler guys Cced and it would be really great to get
> > their opinion here.
> > 
> > On Mon 10-12-18 11:36:39, Daniel Vetter wrote:
> > > In some special cases we must not block, but there's not a
> > > spinlock, preempt-off, irqs-off or similar critical section already
> > > that arms the might_sleep() debug checks. Add a non_block_start/end()
> > > pair to annotate these.
> > > 
> > > This will be used in the oom paths of mmu-notifiers, where blocking is
> > > not allowed to make sure there's forward progress.
> > 
> > Considering the only alternative would be to abuse
> > preempt_{disable,enable}, and that really has a different semantic, I
> > think this makes some sense. The cotext is preemptible but we do not
> > want notifier to sleep on any locks, WQ etc.
> 
> I'm confused... what is this supposed to do?
> 
> And what does 'block' mean here? Without preempt_disable/IRQ-off we're
> subject to regular preemption and execution can stall for arbitrary
> amounts of time.

The notifier is called from quite a restricted context - oom_reaper - 
which shouldn't depend on any locks or sleepable conditionals. The code
should be swift as well but we mostly do care about it to make a forward
progress. Checking for sleepable context is the best thing we could come
up with that would describe these demands at least partially.

-- 
Michal Hocko
SUSE Labs
