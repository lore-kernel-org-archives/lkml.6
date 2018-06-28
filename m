Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE6AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CED726FDE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CED726FDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933718AbeF1G52 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:57:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752245AbeF1G51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B8A5BF569;
        Thu, 28 Jun 2018 06:57:26 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3917F11166F1;
        Thu, 28 Jun 2018 06:57:24 +0000 (UTC)
Date:   Thu, 28 Jun 2018 14:57:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 3/4] mm/sparse: Add a new parameter 'data_unit_size'
 for alloc_usemap_and_memmap
Message-ID: <20180628065722.GB32539@MiWiFi-R3L-srv>
References: <20180627013116.12411-1-bhe@redhat.com>
 <20180627013116.12411-4-bhe@redhat.com>
 <CAGM2reb=2fmgJQzfPGJ_bCG-317-dsFfoG8vSr9LuYit4AVsyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reb=2fmgJQzfPGJ_bCG-317-dsFfoG8vSr9LuYit4AVsyQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 06:57:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 06:57:26 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/18 at 11:14pm, Pavel Tatashin wrote:
> Honestly, I do not like this new agrument, but it will do for now. I
> could not think of a better way without rewriting everything.
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> However, I will submit a series of patches to cleanup sparse.c and
> completely remove large and confusing temporary buffers: map_map, and
> usemap_map. In those patches, I will remove alloc_usemap_and_memmap().

Great, look forward to seeing them, I can help review.

> On Tue, Jun 26, 2018 at 9:31 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > alloc_usemap_and_memmap() is passing in a "void *" that points to
> > usemap_map or memmap_map. In next patch we will change both of the
> > map allocation from taking 'NR_MEM_SECTIONS' as the length to taking
> > 'nr_present_sections' as the length. After that, the passed in 'void*'
> > needs to update as things get consumed. But, it knows only the
> > quantity of objects consumed and not the type.  This effectively
> > tells it enough about the type to let it update the pointer as
> > objects are consumed.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 71ad53da2cd1..b2848cc6e32a 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -489,10 +489,12 @@ void __weak __meminit vmemmap_populate_print_last(void)
> >  /**
> >   *  alloc_usemap_and_memmap - memory alloction for pageblock flags and vmemmap
> >   *  @map: usemap_map for pageblock flags or mmap_map for vmemmap
> > + *  @unit_size: size of map unit
> >   */
> >  static void __init alloc_usemap_and_memmap(void (*alloc_func)
> >                                         (void *, unsigned long, unsigned long,
> > -                                       unsigned long, int), void *data)
> > +                                       unsigned long, int), void *data,
> > +                                       int data_unit_size)
> >  {
> >         unsigned long pnum;
> >         unsigned long map_count;
> > @@ -569,7 +571,8 @@ void __init sparse_init(void)
> >         if (!usemap_map)
> >                 panic("can not allocate usemap_map\n");
> >         alloc_usemap_and_memmap(sparse_early_usemaps_alloc_node,
> > -                                                       (void *)usemap_map);
> > +                               (void *)usemap_map,
> > +                               sizeof(usemap_map[0]));
> >
> >  #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> >         size2 = sizeof(struct page *) * NR_MEM_SECTIONS;
> > @@ -577,7 +580,8 @@ void __init sparse_init(void)
> >         if (!map_map)
> >                 panic("can not allocate map_map\n");
> >         alloc_usemap_and_memmap(sparse_early_mem_maps_alloc_node,
> > -                                                       (void *)map_map);
> > +                               (void *)map_map,
> > +                               sizeof(map_map[0]));
> >  #endif
> >
> >         for_each_present_section_nr(0, pnum) {
> > --
> > 2.13.6
> >
