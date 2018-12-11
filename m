Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210CFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE6B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE6B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbeLKEsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 23:48:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeLKEsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 23:48:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6589C049581;
        Tue, 11 Dec 2018 04:48:31 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B94A419C7F;
        Tue, 11 Dec 2018 04:48:27 +0000 (UTC)
Date:   Tue, 11 Dec 2018 12:48:25 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, dave.jiang@intel.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        jrdr.linux@gmail.com,
        =?utf-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: thp: fix soft dirty for migration when split
Message-ID: <20181211044825.GA3260@xz-x1>
References: <20181206084604.17167-1-peterx@redhat.com>
 <20181207033407.GB10726@xz-x1>
 <CALYGNiMjWDL6XaOFgfrM1WR6_GnmxfLBXwJ=YYGVNfEKNX0MfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALYGNiMjWDL6XaOFgfrM1WR6_GnmxfLBXwJ=YYGVNfEKNX0MfQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 11 Dec 2018 04:48:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 07:50:52PM +0300, Konstantin Khlebnikov wrote:
> On Fri, Dec 7, 2018 at 6:34 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Dec 06, 2018 at 04:46:04PM +0800, Peter Xu wrote:
> > > When splitting a huge migrating PMD, we'll transfer the soft dirty bit
> > > from the huge page to the small pages.  However we're possibly using a
> > > wrong data since when fetching the bit we're using pmd_soft_dirty()
> > > upon a migration entry.  Fix it up.
> >
> > Note that if my understanding is correct about the problem then if
> > without the patch there is chance to lose some of the dirty bits in
> > the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> > of swap offset instead of bit 2) and it could potentially corrupt the
> > memory of an userspace program which depends on the dirty bit.
> 
> It seems this code is broken in case of pmd_migraion:
> 
> old_pmd = pmdp_invalidate(vma, haddr, pmd);
> 
> #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> pmd_migration = is_pmd_migration_entry(old_pmd);
> if (pmd_migration) {
> swp_entry_t entry;
> 
> entry = pmd_to_swp_entry(old_pmd);
> page = pfn_to_page(swp_offset(entry));
> } else
> #endif
> page = pmd_page(old_pmd);
> VM_BUG_ON_PAGE(!page_count(page), page);
> page_ref_add(page, HPAGE_PMD_NR - 1);
> if (pmd_dirty(old_pmd))
> SetPageDirty(page);
> write = pmd_write(old_pmd);
> young = pmd_young(old_pmd);
> soft_dirty = pmd_soft_dirty(old_pmd);
> 
> Not just soft_dirt - all bits (dirty, write, young) have diffrent encoding
> or not present at all for migration entry.

Hi, Konstantin,

Actually I noticed it but I thought it didn't hurt since both
write/young flags are not used at all when applying to the small pages
when pmd_migration==true.  But indeed there's at least an unexpected
side effect of an extra call to SetPageDirty() that I missed.

I'll repost soon.  Thanks!

-- 
Peter Xu
