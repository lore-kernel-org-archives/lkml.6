Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1373FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEFF21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEFF21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbeKPCtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:49:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:36184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387839AbeKPCtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:49:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFF09AF09;
        Thu, 15 Nov 2018 16:40:57 +0000 (UTC)
Date:   Thu, 15 Nov 2018 17:40:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-ID: <20181115164052.GW23831@dhcp22.suse.cz>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <20181114150742.GZ23419@dhcp22.suse.cz>
 <9e8218eb-80bf-fc02-ae56-42ccfddb572e@linux.intel.com>
 <20181115081006.GC23831@dhcp22.suse.cz>
 <b4a4d2ca-da7a-b8cd-bf0f-a119ebd67da8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a4d2ca-da7a-b8cd-bf0f-a119ebd67da8@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 08:02:33, Alexander Duyck wrote:
> On 11/15/2018 12:10 AM, Michal Hocko wrote:
> > On Wed 14-11-18 16:50:23, Alexander Duyck wrote:
[...]
> > > I plan to remove it, but don't think I can get to it in this patch set.
> > 
> > What I am trying to argue is that we should simply drop the
> > __SetPageReserved as an independent patch prior to this whole series.
> > As I've mentioned earlier, I have added this just to be sure and part of
> > that was that __add_section has set the reserved bit. This is no longer
> > the case since d0dc12e86b31 ("mm/memory_hotplug: optimize memory
> > hotplug").
> > 
> > Nobody should really depend on that because struct pages are in
> > undefined state after __add_pages and they should get fully initialized
> > after move_pfn_range_to_zone.
> > 
> > If you really insist on setting the reserved bit then it really has to
> > happen much sooner than it is right now. So I do not really see any
> > point in doing so. Sure there are some pfn walkers that really need to
> > do pfn_to_online_page because pfn_valid is not sufficient but that is
> > largely independent on any optimization work in this area.
> > 
> > I am sorry if I haven't been clear about that before. Does it make more
> > sense to you now?
> 
> I get what you are saying I just don't agree with the ordering. I have had
> these patches in the works for a couple months now. You are essentially
> telling me to defer these in favor of taking care of the reserved bit first.

General development is to fix correctness and/or cleanup stale code
first and optimize on top. I really do not see why this should be
any different. Especially when page reserved bit is a part of your
optimization work.

There is some review feedback to address from this version so you can
add a patch to remove the reserved bit to the series - feel free to
reuse my explanation as the justification. I really do not think you
have to change other call sites because they would be broken in the same
way as when the bit is set (late).

> The only spot where I think we disagree is that I would prefer to get these
> in first, and then focus on the reserved bit. I'm not saying we shouldn't do
> the work, but I would rather take care of the immediate issue, and then
> "clean house" as it were. I've done that sort of thing in the past where I
> start deferring patches and then by the end of things I have a 60 patch set
> I am trying to push because one fix gets ahead of another and another.

This is nothing exceptional and it happened to me as well.

> My big concern is that dropping the reserved bit is going to be much more
> error prone than the work I have done in this patch set since it is much
> more likely that somebody somewhere has made a false reliance on it being
> set. If you have any tests you usually run for memory hotplug it would be
> useful if you could point me in that direction. Then I can move forward with
> the upcoming patch set with a bit more confidence.

There is nothing except for exercising hotplug and do random stuff to
it. We simply do not know about all the pfn walkers so we have to count
on a reasonable model to justify changes. I hope I have clarified why
the reserved bit doesn't act the purpose it has been added for.

I understand that you want to push your optimization work ASAP but I _do_
care about longterm maintainability much more than having performance
gain _right_ now.

That being said, I am not nacking your series so if others really think
that I am asking too much I can live with that. I was overruled the last
time when the first optimization pile went in. I still hope we can get
the result cleaned up as promised, though.
-- 
Michal Hocko
SUSE Labs
