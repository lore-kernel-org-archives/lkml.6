Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6EEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7BC2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7BC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeK3Xy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:54:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:48412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbeK3Xy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:54:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFEC9ADDF;
        Fri, 30 Nov 2018 12:45:46 +0000 (UTC)
Date:   Fri, 30 Nov 2018 13:45:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-mm@kvack.org,
        lersek@redhat.com, alex.williamson@redhat.com, aarcange@redhat.com,
        rientjes@google.com, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: page_mapped: don't assume compound page is huge
 or THP
Message-ID: <20181130124546.GJ6923@dhcp22.suse.cz>
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
 <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
 <20181130121851.GI6923@dhcp22.suse.cz>
 <20181130123651.5qrdrw3i5ergbuzl@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130123651.5qrdrw3i5ergbuzl@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-11-18 15:36:51, Kirill A. Shutemov wrote:
> On Fri, Nov 30, 2018 at 01:18:51PM +0100, Michal Hocko wrote:
> > On Fri 30-11-18 13:06:57, Jan Stancek wrote:
> > > LTP proc01 testcase has been observed to rarely trigger crashes
> > > on arm64:
> > >     page_mapped+0x78/0xb4
> > >     stable_page_flags+0x27c/0x338
> > >     kpageflags_read+0xfc/0x164
> > >     proc_reg_read+0x7c/0xb8
> > >     __vfs_read+0x58/0x178
> > >     vfs_read+0x90/0x14c
> > >     SyS_read+0x60/0xc0
> > > 
> > > Issue is that page_mapped() assumes that if compound page is not
> > > huge, then it must be THP. But if this is 'normal' compound page
> > > (COMPOUND_PAGE_DTOR), then following loop can keep running
> > > (for HPAGE_PMD_NR iterations) until it tries to read from memory
> > > that isn't mapped and triggers a panic:
> > >         for (i = 0; i < hpage_nr_pages(page); i++) {
> > >                 if (atomic_read(&page[i]._mapcount) >= 0)
> > >                         return true;
> > > 	}
> > > 
> > > I could replicate this on x86 (v4.20-rc4-98-g60b548237fed) only
> > > with a custom kernel module [1] which:
> > > - allocates compound page (PAGEC) of order 1
> > > - allocates 2 normal pages (COPY), which are initialized to 0xff
> > >   (to satisfy _mapcount >= 0)
> > > - 2 PAGEC page structs are copied to address of first COPY page
> > > - second page of COPY is marked as not present
> > > - call to page_mapped(COPY) now triggers fault on access to 2nd
> > >   COPY page at offset 0x30 (_mapcount)
> > > 
> > > [1] https://github.com/jstancek/reproducers/blob/master/kernel/page_mapped_crash/repro.c
> > > 
> > > Fix the loop to iterate for "1 << compound_order" pages.
> > 
> > This is much less magic than the previous version. It is still not clear
> > to me how is mapping higher order pages to page tables other than THP
> > though. So a more detailed information about the source would bre really
> > welcome. Once we know that we can add a Fixes tag and also mark the
> > patch for stable because that sounds like a stable material.
> 
> IIRC, sound subsystem can producuce custom mapped compound pages.

Do I assume correctly that consecutive ptes simply point to subpages?

> The bug dates back to e1534ae95004.

Thanks for the pointer. I thought this was a new and creative usage of
the pte->page mapping but it really looks like your commit just changed
the underlying semantic.
 
> > > Debugged-by: Laszlo Ersek <lersek@redhat.com>
> > > Suggested-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > 
> > The patch looks sensible to me
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> -- 
>  Kirill A. Shutemov

-- 
Michal Hocko
SUSE Labs
