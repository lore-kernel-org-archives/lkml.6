Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B66EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACEB20881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACEB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbeGXOMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:12:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388279AbeGXOMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:12:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D2A3AD1E;
        Tue, 24 Jul 2018 13:06:07 +0000 (UTC)
Date:   Tue, 24 Jul 2018 15:06:06 +0200
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
        Matthew Wilcox <willy@infradead.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v1 0/2] mm/kdump: exclude reserved pages in dumps
Message-ID: <20180724130606.GJ28386@dhcp22.suse.cz>
References: <20180720123422.10127-1-david@redhat.com>
 <9f46f0ed-e34c-73be-60ca-c892fb19ed08@suse.cz>
 <20180723123043.GD31229@dhcp22.suse.cz>
 <dca091d3-4c3d-eff5-57f8-a9a45050198d@suse.cz>
 <20180724111913.GH28386@dhcp22.suse.cz>
 <d14d7a45-91fd-63ef-ea57-513752af1f9e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14d7a45-91fd-63ef-ea57-513752af1f9e@suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-07-18 14:22:06, Vlastimil Babka wrote:
> On 07/24/2018 01:19 PM, Michal Hocko wrote:
> >> When creating a crashdump, I definitely need the pages containing memmap
> >> included in the dump, so I can inspect the struct pages. But this is a
> >> bit recursive issue, so I'll try making it clearer:
> >>
> >> 1) there are kernel pages with data (e.g. slab) that I typically need in
> >> the dump, and are not PageReserved
> >> 2) there are struct pages for pages 1) in the memmap that physically
> >> hold the pageflags for 1), and these are PageReserved
> >> 3) there are struct pages for pages 2) somewhere else in the memmap,
> >> physically hold the pageflags for 2). They are probably also
> >> PageReserved themselves ? and self-referencing.
> >>
> >> Excluding PageReserved from dump means there won't be cases 2) and 3) in
> >> the dump, which at least for case 2) is making such dump almost useless
> >> in many cases.
> > 
> > Yes, we cannot simply exclude all PageReserved pages. I was merely
> > suggesting to rule out new special PageReserved pages that are denoting 
> > offline pages. The same could be applied to HWPoison pages
> 
> So how about marking them with some "page type" that we got after
> Matthew's struct page reorg? I assume the pages we're talking about are
> in a state that they don't need the mapcount/mapping field or whatever
> unions with the page type... but I guess some care would be needed to
> not have false positives when the union field is actually used but
> happens to look like the new type.

The idea was to use PageReserved because those pages are generally
ignored by MM and then reuse some parts of the struct page. It belongs
to the owner of the page and nothing should be really used from it at
the time when you mark it offline. So pagetype or something else is
merely an implementation detail.

-- 
Michal Hocko
SUSE Labs
