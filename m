Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AFB2499E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AFB2499E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeF0W7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:59:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751668AbeF0W7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:59:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C2CA4075647;
        Wed, 27 Jun 2018 22:59:50 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50DE62156880;
        Wed, 27 Jun 2018 22:59:48 +0000 (UTC)
Date:   Thu, 28 Jun 2018 06:59:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 2/4] mm/sparsemem: Defer the ms->section_mem_map
 clearing
Message-ID: <20180627225945.GD8970@localhost.localdomain>
References: <20180627013116.12411-1-bhe@redhat.com>
 <20180627013116.12411-3-bhe@redhat.com>
 <20180627095439.GA5924@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627095439.GA5924@techadventures.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 27 Jun 2018 22:59:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 27 Jun 2018 22:59:50 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/18 at 11:54am, Oscar Salvador wrote:
> On Wed, Jun 27, 2018 at 09:31:14AM +0800, Baoquan He wrote:
> > In sparse_init(), if CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y, system
> > will allocate one continuous memory chunk for mem maps on one node and
> > populate the relevant page tables to map memory section one by one. If
> > fail to populate for a certain mem section, print warning and its
> > ->section_mem_map will be cleared to cancel the marking of being present.
> > Like this, the number of mem sections marked as present could become
> > less during sparse_init() execution.
> > 
> > Here just defer the ms->section_mem_map clearing if failed to populate
> > its page tables until the last for_each_present_section_nr() loop. This
> > is in preparation for later optimizing the mem map allocation.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse-vmemmap.c |  1 -
> >  mm/sparse.c         | 12 ++++++++----
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index bd0276d5f66b..640e68f8324b 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -303,7 +303,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
> >  		ms = __nr_to_section(pnum);
> >  		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
> >  		       __func__);
> > -		ms->section_mem_map = 0;
> 
> Since we are deferring the clearing of section_mem_map, I guess we do not need
> 
> struct mem_section *ms;
> ms = __nr_to_section(pnum);
> 
> anymore, right?

Right, good catch, thanks.

I will post a new round to fix this.

> 
> >  	}
> >  
> >  	if (vmemmap_buf_start) {
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 6314303130b0..71ad53da2cd1 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -451,7 +451,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
> >  		ms = __nr_to_section(pnum);
> >  		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
> >  		       __func__);
> > -		ms->section_mem_map = 0;
> 
> The same goes here.
> 
> 
> 
> -- 
> Oscar Salvador
> SUSE L3
