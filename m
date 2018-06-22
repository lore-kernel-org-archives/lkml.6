Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A57CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B958023DF4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B958023DF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeFVG4v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:56:51 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:44607 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeFVG4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:56:49 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w5M6uAfN010285
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 15:56:10 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w5M6uADr024145;
        Fri, 22 Jun 2018 15:56:10 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w5M6sWGJ023134;
        Fri, 22 Jun 2018 15:56:10 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-1433288; Fri, 22 Jun 2018 15:55:12 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Fri,
 22 Jun 2018 15:55:11 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v1] mm: initialize struct page for reserved pages in
 ZONE_DEVICE
Thread-Topic: [PATCH v1] mm: initialize struct page for reserved pages in
 ZONE_DEVICE
Thread-Index: AQHUCe9ppoUKM60PFEWzXuUH6W023KRrNR+AgAAMD4A=
Date:   Fri, 22 Jun 2018 06:55:11 +0000
Message-ID: <20180622065510.GA13556@hori1.linux.bs1.fc.nec.co.jp>
References: <1529647683-14531-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <CAPcyv4hpdvGRi+=psT47ePB6QigJW2JEq-zhbVXsTHb14pWfUQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hpdvGRi+=psT47ePB6QigJW2JEq-zhbVXsTHb14pWfUQ@mail.gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.81]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <3065B67A7F2BDE49ABD9AFB3204317DD@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:12:01PM -0700, Dan Williams wrote:
> On Thu, Jun 21, 2018 at 11:08 PM, Naoya Horiguchi
> <n-horiguchi@ah.jp.nec.com> wrote:
> > Reading /proc/kpageflags for pfns allocated by pmem namespace triggers
> > kernel panic with a message like "BUG: unable to handle kernel paging
> > request at fffffffffffffffe".
> >
> > The first few pages (controlled by altmap passed to memmap_init_zone())
> > in the ZONE_DEVICE can skip struct page initialization, which causes
> > the reported issue.
> >
> > This patch simply adds some initialization code for them.
> >
> > Fixes: 4b94ffdc4163 ("x86, mm: introduce vmem_altmap to augment vmemmap_populate()")
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > ---
> >  mm/page_alloc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
> > index 1772513..0b36afe 100644
> > --- v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c
> > +++ v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
> > @@ -5574,8 +5574,16 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >          * Honor reservation requested by the driver for this ZONE_DEVICE
> >          * memory
> >          */
> > -       if (altmap && start_pfn == altmap->base_pfn)
> > +       if (altmap && start_pfn == altmap->base_pfn) {
> > +               unsigned long i;
> > +
> > +               for (i = 0; i < altmap->reserve; i++) {
> > +                       page = pfn_to_page(start_pfn + i);
> > +                       __init_single_page(page, start_pfn + i, zone, nid);
> > +                       SetPageReserved(page);
> > +               }
> >                 start_pfn += altmap->reserve;
> > +       }
> 
> No, unfortunately this will clobber metadata that lives in that
> reserved area, see __nvdimm_setup_pfn().

Hi Dan,

This patch doesn't touch the reserved region itself, but only
struct pages on the region. I'm still not sure why it's necessary
to leave these struct pages uninitialized for pmem operation?

My another related concern is about memory_failure_dev_pagemap().
If a memory error happens on the reserved pfn range, this function
seems to try to access to the uninitialized struct page and maybe
trigger oops. So do we need something to prevent this?

Thanks,
Naoya Horiguchi
