Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4677C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755DA20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755DA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbeGXMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:25:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:48744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388196AbeGXMZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:25:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86942ACBB;
        Tue, 24 Jul 2018 11:19:15 +0000 (UTC)
Date:   Tue, 24 Jul 2018 13:19:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v1 0/2] mm/kdump: exclude reserved pages in dumps
Message-ID: <20180724111913.GH28386@dhcp22.suse.cz>
References: <20180720123422.10127-1-david@redhat.com>
 <9f46f0ed-e34c-73be-60ca-c892fb19ed08@suse.cz>
 <20180723123043.GD31229@dhcp22.suse.cz>
 <dca091d3-4c3d-eff5-57f8-a9a45050198d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca091d3-4c3d-eff5-57f8-a9a45050198d@suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-07-18 11:47:02, Vlastimil Babka wrote:
> On 07/23/2018 02:30 PM, Michal Hocko wrote:
> > On Mon 23-07-18 13:45:18, Vlastimil Babka wrote:
> >> On 07/20/2018 02:34 PM, David Hildenbrand wrote:
> >>> Dumping tools (like makedumpfile) right now don't exclude reserved pages.
> >>> So reserved pages might be access by dump tools although nobody except
> >>> the owner should touch them.
> >>
> >> Are you sure about that? Or maybe I understand wrong. Maybe it changed
> >> recently, but IIRC pages that are backing memmap (struct pages) are also
> >> PG_reserved. And you definitely do want those in the dump.
> > 
> > You are right. reserve_bootmem_region will make all early bootmem
> > allocations (including those backing memmaps) PageReserved. I have asked
> > several times but I haven't seen a satisfactory answer yet. Why do we
> > even care for kdump about those. If they are reserved the nobody should
> > really look at those specific struct pages and manipulate them. Kdump
> > tools are using a kernel interface to read the content. If the specific
> > content is backed by a non-existing memory then they should simply not
> > return anything.
> 
> When creating a crashdump, I definitely need the pages containing memmap
> included in the dump, so I can inspect the struct pages. But this is a
> bit recursive issue, so I'll try making it clearer:
> 
> 1) there are kernel pages with data (e.g. slab) that I typically need in
> the dump, and are not PageReserved
> 2) there are struct pages for pages 1) in the memmap that physically
> hold the pageflags for 1), and these are PageReserved
> 3) there are struct pages for pages 2) somewhere else in the memmap,
> physically hold the pageflags for 2). They are probably also
> PageReserved themselves ? and self-referencing.
> 
> Excluding PageReserved from dump means there won't be cases 2) and 3) in
> the dump, which at least for case 2) is making such dump almost useless
> in many cases.

Yes, we cannot simply exclude all PageReserved pages. I was merely
suggesting to rule out new special PageReserved pages that are denoting 
offline pages. The same could be applied to HWPoison pages
-- 
Michal Hocko
SUSE Labs
