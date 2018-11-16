Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E7A20811
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E7A20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390172AbeKQDVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:21:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728628AbeKQDVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:21:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AFF5B063;
        Fri, 16 Nov 2018 17:07:56 +0000 (UTC)
Date:   Fri, 16 Nov 2018 18:07:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     osalvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use managed_zone() for more exact check in zone
 iteration
Message-ID: <20181116170755.GN14706@dhcp22.suse.cz>
References: <20181114235040.36180-1-richard.weiyang@gmail.com>
 <20181115133735.bb0313ec9293c415d08be550@linux-foundation.org>
 <20181116095720.GE14706@dhcp22.suse.cz>
 <1542366304.3020.15.camel@suse.de>
 <20181116112603.GI14706@dhcp22.suse.cz>
 <20181116155828.strdglxqgqe4jqkr@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116155828.strdglxqgqe4jqkr@master>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-11-18 15:58:28, Wei Yang wrote:
> On Fri, Nov 16, 2018 at 12:26:03PM +0100, Michal Hocko wrote:
> >On Fri 16-11-18 12:05:04, osalvador wrote:
> >> On Fri, 2018-11-16 at 10:57 +0100, Michal Hocko wrote:
> >[...]
> >> > E.g. memory hotplug decreases both managed and present counters. I
> >> > am actually not sure that is 100% correct (put on my TODO list to
> >> > check). There is no consistency in that regards.
> >> 
> >> We can only offline non-reserved pages (so, managed pages).
> >
> >Yes
> >
> >> Since present pages holds reserved_pages + managed_pages, decreasing
> >> both should be fine unless I am mistaken.
> >
> >Well, present_pages is defined as "physical pages existing within the zone"
> >and those pages are still existing but they are offline. But as I've
> >said I have to think about it some more
> 
> I may not catch up with your discussions, while I'd like to share what I
> learnt.
> 
> online_pages()
>     online_pages_range()
>     zone->present_pages += onlined_pages;
> 
> __offline_pages()
>     adjust_managed_page_count()
>     zone->present_pages -= offlined_pages;
> 
> The two counters: present_pages & managed_pages would be adjusted during
> online/offline.
> 
> While I am not sure when *reserved_pages* would be adjusted. Will we add
> this hot-added memory into memblock.reserved? and allocate memory by
> memblock_alloc() after system bootup?

This is not really related to this patch. I have only mentioned the
memory hotplug as an example. I would rather focus on the change itself
so let's not get too off topic here.

-- 
Michal Hocko
SUSE Labs
