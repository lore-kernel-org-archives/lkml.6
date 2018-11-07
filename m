Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25902086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25902086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeKGWhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:37:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:57616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbeKGWhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:37:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B366AE61;
        Wed,  7 Nov 2018 13:06:56 +0000 (UTC)
Date:   Wed, 7 Nov 2018 14:06:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <OSalvador@suse.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: check zone_movable in
 has_unmovable_pages
Message-ID: <20181107130655.GE27423@dhcp22.suse.cz>
References: <20181106095524.14629-1-mhocko@kernel.org>
 <20181106203518.GC9042@350D>
 <20181107073548.GU27423@dhcp22.suse.cz>
 <20181107125324.GD9042@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107125324.GD9042@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-11-18 23:53:24, Balbir Singh wrote:
> On Wed, Nov 07, 2018 at 08:35:48AM +0100, Michal Hocko wrote:
> > On Wed 07-11-18 07:35:18, Balbir Singh wrote:
[...]
> > > The check seems to be quite aggressive and in a loop that iterates
> > > pages, but has nothing to do with the page, did you mean to make
> > > the check
> > > 
> > > zone_idx(page_zone(page)) == ZONE_MOVABLE
> > 
> > Does it make any difference? Can we actually encounter a page from a
> > different zone here?
> > 
> 
> Just to avoid page state related issues, do we want to go ahead
> with the migration if zone_idx(page_zone(page)) != ZONE_MOVABLE.

Could you be more specific what kind of state related issues you have in
mind?

> > > it also skips all checks for pinned pages and other checks
> > 
> > Yes, this is intentional and the comment tries to explain why. I wish we
> > could be add a more specific checks for movable pages - e.g. detect long
> > term pins that would prevent migration - but we do not have any facility
> > for that. Please note that the worst case of a false positive is a
> > repeated migration failure and user has a way to break out of migration
> > by a signal.
> >
> 
> Basically isolate_pages() will fail as opposed to hotplug failing upfront.
> The basic assertion this patch makes is that all ZONE_MOVABLE pages that
> are not reserved are hotpluggable.

Yes, that is correct.

-- 
Michal Hocko
SUSE Labs
