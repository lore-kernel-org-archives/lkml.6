Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41C5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916D520839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916D520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeHaU1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:27:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbeHaU1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:27:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0D9626362;
        Fri, 31 Aug 2018 16:19:37 +0000 (UTC)
Received: from redhat.com (ovpn-123-69.rdu2.redhat.com [10.10.123.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38FF32166B41;
        Fri, 31 Aug 2018 16:19:37 +0000 (UTC)
Date:   Fri, 31 Aug 2018 12:19:35 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/rmap: map_pte() was not handling private
 ZONE_DEVICE page properly v2
Message-ID: <20180831161935.GB4111@redhat.com>
References: <20180824192549.30844-3-jglisse@redhat.com>
 <20180830144156.7226-1-jglisse@redhat.com>
 <20180831092724.GD28695@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831092724.GD28695@350D>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 31 Aug 2018 16:19:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 31 Aug 2018 16:19:37 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 07:27:24PM +1000, Balbir Singh wrote:
> On Thu, Aug 30, 2018 at 10:41:56AM -0400, jglisse@redhat.com wrote:
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
> > Changes since v1:
> >     - properly lock pte directory in map_pte()
> > 
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Balbir Singh <bsingharora@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/page_vma_mapped.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index ae3c2a35d61b..bd67e23dce33 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -21,7 +21,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
> >  			if (!is_swap_pte(*pvmw->pte))
> >  				return false;
> >  		} else {
> > -			if (!pte_present(*pvmw->pte))
> > +			if (is_swap_pte(*pvmw->pte)) {
> > +				swp_entry_t entry;
> > +
> > +				/* Handle un-addressable ZONE_DEVICE memory */
> > +				entry = pte_to_swp_entry(*pvmw->pte);
> > +				if (!is_device_private_entry(entry))
> > +					return false;
> 
> OK, so we skip this pte from unmap since it's already unmapped? This prevents
> try_to_unmap from unmapping it and it gets restored with MIGRATE_PFN_MIGRATE
> flag cleared?
> 
> Sounds like the right thing, if I understand it correctly

Well not exactly we do not skip it, we replace it with a migration
pte see try_to_unmap_one() which get call with TTU_MIGRATION flag
set (which do not translate in PVMW_MIGRATION being set on contrary).

From migration point of view even if this is a swap pte, it is still
a valid mapping of the page and is counted as such for all intent and
purposes. The only thing we don't need is flushing CPU tlb or cache.

So this all happens when we are migrating something back to regular
memory either because of CPU fault or because the device driver want
to make room in its memory and decided to evict that page back to
regular memory.

Cheers,
Jérôme
