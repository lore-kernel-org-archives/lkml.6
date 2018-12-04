Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F9520834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F9520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLDHZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:25:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:42172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbeLDHZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:25:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E869ACCF;
        Tue,  4 Dec 2018 07:25:09 +0000 (UTC)
Date:   Tue, 4 Dec 2018 08:25:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/vmscan: Enable kswapd to reclaim low-protected
 memory
Message-ID: <20181204072508.GU31738@dhcp22.suse.cz>
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
 <20181203080119.18989-2-xlpang@linux.alibaba.com>
 <20181203115646.GP31738@dhcp22.suse.cz>
 <54a3f0a6-6e7d-c620-97f2-ac567c057bc2@linux.alibaba.com>
 <20181203172007.GG31738@dhcp22.suse.cz>
 <a77ed2a6-ed9b-4c1b-e2e9-fb9a5108c1f9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a77ed2a6-ed9b-4c1b-e2e9-fb9a5108c1f9@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 10:40:29, Xunlei Pang wrote:
> On 2018/12/4 AM 1:22, Michal Hocko wrote:
> > On Mon 03-12-18 23:20:31, Xunlei Pang wrote:
> >> On 2018/12/3 下午7:56, Michal Hocko wrote:
> >>> On Mon 03-12-18 16:01:18, Xunlei Pang wrote:
> >>>> There may be cgroup memory overcommitment, it will become
> >>>> even common in the future.
> >>>>
> >>>> Let's enable kswapd to reclaim low-protected memory in case
> >>>> of memory pressure, to mitigate the global direct reclaim
> >>>> pressures which could cause jitters to the response time of
> >>>> lantency-sensitive groups.
> >>>
> >>> Please be more descriptive about the problem you are trying to handle
> >>> here. I haven't actually read the patch but let me emphasise that the
> >>> low limit protection is important isolation tool. And allowing kswapd to
> >>> reclaim protected memcgs is going to break the semantic as it has been
> >>> introduced and designed.
> >>
> >> We have two types of memcgs: online groups(important business)
> >> and offline groups(unimportant business). Online groups are
> >> all configured with MAX low protection, while offline groups
> >> are not at all protected(with default 0 low).
> >>
> >> When offline groups are overcommitted, the global memory pressure
> >> suffers. This will cause the memory allocations from online groups
> >> constantly go to the slow global direct reclaim in order to reclaim
> >> online's page caches, as kswap is not able to reclaim low-protection
> >> memory. low is not hard limit, it's reasonable to be reclaimed by
> >> kswapd if there's no other reclaimable memory.
> > 
> > I am sorry I still do not follow. What role do offline cgroups play.
> > Those are certainly not low mem protected because mem_cgroup_css_offline
> > will reset them to 0.
> > 
> 
> Oh, I meant "offline groups" to be "offline-business groups", memcgs
> refered to here are all "online state" from kernel's perspective.

What is offline-business group? Please try to explain the actual problem
in much more details and do not let us guess.

-- 
Michal Hocko
SUSE Labs
