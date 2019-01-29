Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BFFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAFC20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548753206;
	bh=P3Ah/OFAzV1xmbVBbNeO6yQiMl2kYgL8rk4UmpR8PdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p84KmeuyeHvfnFTyqV7Tg2i/HuLCLKFKpGOYzUewB9wiwyfVpKwbMBR0jVx28q5Sd
	 xu0IPrbcjvnv1Vzy9xfESFMWQnRjJ0Li2x5bin+oH6OSzmbydRuHTEo87jlmZxgw9w
	 6/2SHEkt8XclYmH7FWxXdFHZoYM2yKJIDPt/dsmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfA2JNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:13:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:55248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfA2JNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:13:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFC79AE5E;
        Tue, 29 Jan 2019 09:13:22 +0000 (UTC)
Date:   Tue, 29 Jan 2019 10:13:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, memory_hotplug: test_pages_in_a_zone do not pass
 the end of zone
Message-ID: <20190129091321.GH18811@dhcp22.suse.cz>
References: <20190128144506.15603-1-mhocko@kernel.org>
 <20190128144506.15603-3-mhocko@kernel.org>
 <20190129090908.oms43oyjicozkvzu@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129090908.oms43oyjicozkvzu@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-01-19 10:09:08, Oscar Salvador wrote:
> On Mon, Jan 28, 2019 at 03:45:06PM +0100, Michal Hocko wrote:
> > From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > 
> > If memory end is not aligned with the sparse memory section boundary, the
> > mapping of such a section is only partly initialized. This may lead to
> > VM_BUG_ON due to uninitialized struct pages access from test_pages_in_a_zone()
> > function triggered by memory_hotplug sysfs handlers.
> > 
> > Here are the the panic examples:
> >  CONFIG_DEBUG_VM_PGFLAGS=y
> >  kernel parameter mem=2050M
> >  --------------------------
> >  page:000003d082008000 is uninitialized and poisoned
> >  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> >  Call Trace:
> >  ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
> >   [<00000000008f15c4>] show_valid_zones+0x5c/0x190
> >   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
> >   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
> >   [<00000000003e4194>] seq_read+0x204/0x480
> >   [<00000000003b53ea>] __vfs_read+0x32/0x178
> >   [<00000000003b55b2>] vfs_read+0x82/0x138
> >   [<00000000003b5be2>] ksys_read+0x5a/0xb0
> >   [<0000000000b86ba0>] system_call+0xdc/0x2d8
> >  Last Breaking-Event-Address:
> >   [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
> >  Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 
> > Fix this by checking whether the pfn to check is within the zone.
> > 
> > [mhocko@suse.com: separated this change from
> > http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com]
> > Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Looks good to me:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> > ---
> >  mm/memory_hotplug.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 07872789d778..7711d0e327b6 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1274,6 +1274,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
> >  				i++;
> >  			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
> >  				continue;
> > +			/* Check if we got outside of the zone */
> > +			if (zone && !zone_spans_pfn(zone, pfn + i))
> > +				return 0;
> >  			page = pfn_to_page(pfn + i);
> 
> Since we are already checking if the zone spans that pfn, is it safe to get
> rid of the below check? Or maybe not because we might have intersected zones?

Exactly. The new zone might start at the next pfn. Look for the cover
leter for such an example.
 
> >  			if (zone && page_zone(page) != zone)
> >  				return 0;
> 
> -- 
> Oscar Salvador
> SUSE L3

-- 
Michal Hocko
SUSE Labs
