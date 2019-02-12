Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08963C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E8A218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549982429;
	bh=b3PRpREprRQISQwec9Pqte1OgjhZegCKSmwYieemvww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jGDJFK5mC4Rhvgnd3i215OhAxYPs6T+VjWx1ksxCG4nhVDvQb62Ad77jva9JnVvJB
	 C/pj0GnIZZehYRtEwWgahxbbzBSTXDHdCf2gSSSuCDx5lZwgImvWtmOleerT+hPVUP
	 Q3P1+L7hYAGYvxsoODFBw/hM6G4S/sXoqnQ+dgYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfBLOk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:40:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:42358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729427AbfBLOk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:40:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD1BBAF45;
        Tue, 12 Feb 2019 14:40:26 +0000 (UTC)
Date:   Tue, 12 Feb 2019 15:40:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Explicitly pass the head to
 isolate_huge_page
Message-ID: <20190212144026.GY15609@dhcp22.suse.cz>
References: <20190208090604.975-1-osalvador@suse.de>
 <20190212083329.GN15609@dhcp22.suse.cz>
 <20190212134546.gubfir6zzwrvmunr@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212134546.gubfir6zzwrvmunr@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 14:45:49, Oscar Salvador wrote:
> On Tue, Feb 12, 2019 at 09:33:29AM +0100, Michal Hocko wrote:
> > >  
> > >  		if (PageHuge(page)) {
> > >  			struct page *head = compound_head(page);
> > > -			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
> > >  			if (compound_order(head) > PFN_SECTION_SHIFT) {
> > >  				ret = -EBUSY;
> > >  				break;
> > >  			}
> > 
> > Why are we doing this, btw? 
> 
> I assume you are referring to:
> 
> > >                     if (compound_order(head) > PFN_SECTION_SHIFT) {
> > >                             ret = -EBUSY;
> > >                             break;
> > >                     }

yes.

> I thought it was in case we stumble upon a gigantic page, and commit
> (c8721bbbdd36 mm: memory-hotplug: enable memory hotplug to handle hugepage)
> confirms it.
> 
> But I am not really sure if the above condition would still hold on powerpc,
> I wanted to check it but it is a bit more tricky than it is in x86_64 because
> of the different hugetlb sizes.
> Could it be that the above condition is not true, but still the order of that
> hugetlb page goes beyond MAX_ORDER? It is something I have to check.

This check doesn't make much sense in principle. Why should we bail out
based on a section size? We are offlining a pfn range. All that we care
about is whether the hugetlb is migrateable.
-- 
Michal Hocko
SUSE Labs
