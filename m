Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA63DC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ED120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ED120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLKVgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:36:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56529 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKVgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:36:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9EC6811D3;
        Tue, 11 Dec 2018 21:36:39 +0000 (UTC)
Received: from redhat.com (ovpn-124-191.rdu2.redhat.com [10.10.124.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B63915D70A;
        Tue, 11 Dec 2018 21:36:38 +0000 (UTC)
Date:   Tue, 11 Dec 2018 16:36:36 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: fix mmu_notifier_range_init warning
Message-ID: <20181211213636.GB6478@redhat.com>
References: <20181211200526.3868586-1-arnd@arndb.de>
 <20181211201909.GA6478@redhat.com>
 <alpine.DEB.2.21.1812111310320.87855@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1812111310320.87855@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 11 Dec 2018 21:36:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 01:12:54PM -0800, David Rientjes wrote:
> On Tue, 11 Dec 2018, Jerome Glisse wrote:
> 
> > On Tue, Dec 11, 2018 at 09:04:43PM +0100, Arnd Bergmann wrote:
> > > The macro version of mmu_notifier_range_init() for CONFIG_MMU_NOTIFIER=n
> > > does not evaluate all its arguments, leading to a warning in one case:
> > > 
> > > mm/migrate.c: In function 'migrate_vma_pages':
> > > mm/migrate.c:2711:20: error: unused variable 'mm' [-Werror=unused-variable]
> > >   struct mm_struct *mm = vma->vm_mm;
> > > 
> > > Pass down the 'mm' as into the inline function as well so gcc can
> > > see why the variable exists.
> > > 
> > > Fixes: 137d92bd73b1 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
> > 
> > What about changing migrate.c (i actualy tried to do that everywhere in
> > the patchset but i missed that spot) So we avoid one useless variable on
> > such configuration:
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index f02bb4b22c1a..883fce631f47 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2701,7 +2701,6 @@ static void migrate_vma_pages(struct migrate_vma *migrate)
> >  	const unsigned long npages = migrate->npages;
> >  	const unsigned long start = migrate->start;
> >  	struct vm_area_struct *vma = migrate->vma;
> > -	struct mm_struct *mm = vma->vm_mm;
> >  	struct mmu_notifier_range range;
> >  	unsigned long addr, i;
> >  	bool notified = false;
> > @@ -2724,8 +2723,8 @@ static void migrate_vma_pages(struct migrate_vma *migrate)
> >  			if (!notified) {
> >  				notified = true;
> >  
> > -				mmu_notifier_range_init(&range, mm, addr,
> > -							migrate->end,
> > +				mmu_notifier_range_init(&range, vma->vm_mm,
> > +							addr, migrate->end,
> >  							MMU_NOTIFY_CLEAR);
> >  				mmu_notifier_invalidate_range_start(&range);
> >  			}
> 
> Wouldn't it be better to just declare mmu_notifier_range_init() as a 
> static inline function rather than a #define to avoid this warning?

The define trick is use to drop the event parameter so that we do not
need to define the event value for CONFIG_MMU_NOTIFIER=n case.

Cheers,
Jérôme
