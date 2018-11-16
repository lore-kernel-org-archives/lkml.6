Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD09C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289B52087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289B52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbeKQE6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:48174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbeKQE6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:58:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FFB6AEC6;
        Fri, 16 Nov 2018 18:44:59 +0000 (UTC)
Date:   Fri, 16 Nov 2018 19:44:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Lameter <clameter@sgi.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 3.18 8/9] mm/vmstat.c: assert that vmstat_text is
 in sync with stat_items_size
Message-ID: <20181116184457.GA11906@dhcp22.suse.cz>
References: <20181113055252.79406-1-sashal@kernel.org>
 <20181113055252.79406-8-sashal@kernel.org>
 <20181115140810.e3292c83467544f6a1d82686@linux-foundation.org>
 <20181115223718.GB1706@sasha-vm>
 <20181115144719.d26dc7a2d47fade8d41a83d5@linux-foundation.org>
 <20181115230118.GC1706@sasha-vm>
 <20181116085525.GC14706@dhcp22.suse.cz>
 <20181116181904.GH1706@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116181904.GH1706@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-11-18 13:19:04, Sasha Levin wrote:
> On Fri, Nov 16, 2018 at 09:55:25AM +0100, Michal Hocko wrote:
[...]
> > > Race condition with memory hotplug due to missing locks:
> > > 
> > > 	https://marc.info/?l=linux-mm&m=154211934011188&w=2
> > 
> > Memory hotplug locking is dubious at best and this patch doesn't really
> > fix it. It fixes a theoretical problem. I am not aware anybody would be
> > hitting in practice. We need to rework the locking quite extensively.
> 
> The word "theoretical" used in the stable rules file does not mean
> that we need to have actual reports of users hitting bugs before we
> start backporting the relevant patch, it simply suggests that there
> needs to be a reasonable explanation of how this issue can be hit.
> 
> For this memory hotplug patch in particular, I use the hv_balloon driver
> at this very moment (running a linux guest on windows, with "dynamic
> memory" enabled). Should I wait for it to crash before I can fix it?
> 
> Is the upstream code perfect? No, but that doesn't mean that it's not
> working at all, and if there are users they expect to see fixes going in
> and not just sitting idly waiting for a big rewrite that will come in a
> few years.
> 
> Memory hotplug fixes are not something you think should go to stable?
> Andrew sent a few of them to stable, so that can't be the case.

I am not arguing about hotplug fixes in general. I was arguing that this
particular one is a theoretical one and hotplug locking is quite subtle.
E.g. 381eab4a6ee mm/memory_hotplug: fix online/offline_pages called w.o. mem_hotplug_lock
http://lkml.kernel.org/r/20181114070909.GB2653@MiWiFi-R3L-srv
So in general unless the issue is really triggered easily I am rather
conservative.

> > > Raising an OOM event that causes issues in userspace when no OOM has
> > > actually occured:
> > > 
> > > 	https://marc.info/?l=linux-mm&m=154211939811582&w=2
> > 
> > The patch makes sense I just do not think this is a stable material. The
> > semantic of the event was and still is suboptimal.
> 
> I really fail to understand your reasoning about -stable here. This
> patch is something people actually hit in the field, spent time on
> triaging and analysing it, and submitting a fix which looks reasonably
> straightforward.
> 
> That fix was acked by quite a few folks (including yourself) and merged
> in. And as far as we can tell, it actually fixed the problem.
> 
> Why is it not stable material?

Because the semantic of the OOM event is quite tricky itself. We have
discussed this patch and concluded that the updated one is more
sensible. But it is not yet clear whether this is actually what other
users expect as well. That to me does sound quite risky for a stable
kernel.

> My understanding is that you're concerned with the patch itself being
> "suboptimal", but in that case - why did you ack it?
> 
> > > I think that all 3 cases represent a "real" bug users can hit, and I
> > > honestly don't know why they were not tagged for stable.
> > 
> > It would be much better to ask in the respective email thread rather
> > than spamming mailing with AUTOSEL patches which rarely get any
> > attention.
> 
> I actually tried it, but the comments I got is that it gets in the way
> and people preferred something they can filter.

which means that AUTOSEL just goes to /dev/null...

> > We have been through this discussion several times already and I thought
> > we have agreed that those subsystems which are seriously considering stable
> > are opted out from the AUTOSEL automagic. Has anything changed in that
> > regards.
> 
> I checked in with Andrew to get his input on this, he suggested that
> these patches should be sent to linux-mm and he'll give it a close look.

If Andrew is happy to get AUTOSEL patches then I will not object of
course but let's not merge these patches without and expclicit OK.

-- 
Michal Hocko
SUSE Labs
