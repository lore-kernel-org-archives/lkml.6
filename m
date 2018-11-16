Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2039C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9D22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9D22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbeKPVeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:34:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:35238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727638AbeKPVeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:34:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42E18AF6D;
        Fri, 16 Nov 2018 11:22:19 +0000 (UTC)
Date:   Fri, 16 Nov 2018 12:22:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] mm, memory_hotplug: be more verbose for memory
 offline failures
Message-ID: <20181116112218.GH14706@dhcp22.suse.cz>
References: <20181116083020.20260-1-mhocko@kernel.org>
 <20181116083020.20260-6-mhocko@kernel.org>
 <1542365221.3020.9.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542365221.3020.9.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-11-18 11:47:01, osalvador wrote:
> On Fri, 2018-11-16 at 09:30 +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a919ba5cb3c8..ec2c7916dc2d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7845,6 +7845,7 @@ bool has_unmovable_pages(struct zone *zone,
> > struct page *page, int count,
> >  	return false;
> >  unmovable:
> >  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> > +	dump_page(pfn_to_page(pfn+iter), "unmovable page");
> 
> Would not be enough to just do:
> 
> dump_page(page, "unmovable page".
> 
> Unless I am missing something, page should already have the
> right pfn?

What if pfn_valid_within fails? You could have a pointer to the previous
page.

> 
> <---
> unsigned long check = pfn + iter;
> page = pfn_to_page(check);
> --->
> 
> The rest looks good to me
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

-- 
Michal Hocko
SUSE Labs
