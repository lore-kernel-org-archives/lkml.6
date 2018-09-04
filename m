Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925F2C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F862077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F862077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeIDWdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:33:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbeIDWdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:33:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D35B3B0CA;
        Tue,  4 Sep 2018 18:07:08 +0000 (UTC)
Date:   Tue, 4 Sep 2018 20:07:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
Message-ID: <20180904180707.GS14951@dhcp22.suse.cz>
References: <20180831203450.2536-1-guro@fb.com>
 <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
 <20180831213138.GA9159@tower.DHCP.thefacebook.com>
 <20180903182956.GE15074@dhcp22.suse.cz>
 <20180903202803.GA6227@castle.DHCP.thefacebook.com>
 <20180904070005.GG14951@dhcp22.suse.cz>
 <20180904153445.GA22328@tower.DHCP.thefacebook.com>
 <20180904161431.GP14951@dhcp22.suse.cz>
 <20180904175243.GA4889@tower.DHCP.thefacebook.com>
 <20180904180631.GR14951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904180631.GR14951@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[now CC Vladimir for real]

On Tue 04-09-18 20:06:31, Michal Hocko wrote:
> On Tue 04-09-18 10:52:46, Roman Gushchin wrote:
> > On Tue, Sep 04, 2018 at 06:14:31PM +0200, Michal Hocko wrote:
> [...]
> > > I am not opposing your patch but I am trying to figure out whether that
> > > is the best approach.
> > 
> > I don't think the current logic does make sense. Why should cgroups
> > with less than 4k kernel objects be excluded from being scanned?
> 
> How is it any different from the the LRU reclaim? Maybe it is just not
> that visible because there usually more pages there. But in principle it
> is the same issue AFAICS.
> 
> > Reparenting of all pages is definitely an option to consider,
> > but it's not free in any case, so if there is no problem,
> > why should we? Let's keep it as a last measure. In my case,
> > the proposed patch works perfectly: the number of dying cgroups
> > jumps around 100, where it grew steadily to 2k and more before.
> 
> Let me emphasise that I am not opposing the patch. I just think that we
> have made some decisions which are not ideal but I would really like to
> prevent from building workarounds on top. If we have to reconsider some
> of those decisions then let's do it. Maybe the priority scaling is just
> too coarse and what seem to work work for normal LRUs doesn't work for
> shrinkers.
> 
> > I believe that reparenting of LRU lists is required to minimize
> > the number of LRU lists to scan, but I'm not sure.
> 
> Well, we do have more lists to scan for normal LRUs. It is true that
> shrinkers add multiplining factor to that but in principle I guess we
> really want to distinguish dead memcgs because we do want to reclaim
> those much more than the rest. Those objects are basically of no use
> just eating resources. The pagecache has some chance to be reused at
> least but I fail to see why we should keep kernel objects around. Sure,
> some of them might be harder to reclaim due to different life time and
> internal object management but this doesn't change the fact that we
> should try hard to reclaim those. So my gut feeling tells me that we
> should have a way to distinguish them.
> 
> Btw. I do not see Vladimir on the CC list. Added (the thread starts
> here http://lkml.kernel.org/r/20180831203450.2536-1-guro@fb.com)

-- 
Michal Hocko
SUSE Labs
