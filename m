Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD67C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2F920837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2F920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeH3Sgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:36:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729129AbeH3Sgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB69B87A81;
        Thu, 30 Aug 2018 14:34:20 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C7063A50;
        Thu, 30 Aug 2018 14:34:20 +0000 (UTC)
Date:   Thu, 30 Aug 2018 10:34:19 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/rmap: map_pte() was not handling private
 ZONE_DEVICE page properly
Message-ID: <20180830143418.GC3529@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-3-jglisse@redhat.com>
 <20180830140538.GA28695@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830140538.GA28695@350D>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 14:34:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 14:34:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:05:38AM +1000, Balbir Singh wrote:
> On Fri, Aug 24, 2018 at 03:25:44PM -0400, jglisse@redhat.com wrote:
> > From: Ralph Campbell <rcampbell@nvidia.com>
> > 
> > Private ZONE_DEVICE pages use a special pte entry and thus are not
> > present. Properly handle this case in map_pte(), it is already handled
> > in check_pte(), the map_pte() part was lost in some rebase most probably.
> > 
> > Without this patch the slow migration path can not migrate back private
> > ZONE_DEVICE memory to regular memory. This was found after stress
> > testing migration back to system memory. This ultimatly can lead the
> > CPU to an infinite page fault loop on the special swap entry.
> > 
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/page_vma_mapped.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index ae3c2a35d61b..1cf5b9bfb559 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -21,6 +21,15 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
> >  			if (!is_swap_pte(*pvmw->pte))
> >  				return false;
> >  		} else {
> > +			if (is_swap_pte(*pvmw->pte)) {
> > +				swp_entry_t entry;
> > +
> > +				/* Handle un-addressable ZONE_DEVICE memory */
> > +				entry = pte_to_swp_entry(*pvmw->pte);
> > +				if (is_device_private_entry(entry))
> > +					return true;
> > +			}
> > +
> 
> This happens just for !PVMW_SYNC && PVMW_MIGRATION? I presume this
> is triggered via the remove_migration_pte() code path? Doesn't
> returning true here imply that we've taken the ptl lock for the
> pvmw?

This happens through try_to_unmap() from migrate_vma_unmap() and thus
has !PVMW_SYNC and !PVMW_MIGRATION

But you are right about the ptl lock, so looking at code we were just
doing pte modification without holding the pte lock but the
page_vma_mapped_walk() would not try to unlock as pvmw->ptl == NULL
so this never triggered any warning.

I am gonna post a v2 shortly which address that.

Cheers,
Jérôme
