Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361C0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98421B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbfBKT2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:28:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbfBKT2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:28:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A055C05001B;
        Mon, 11 Feb 2019 19:28:05 +0000 (UTC)
Received: from redhat.com (ovpn-123-21.rdu2.redhat.com [10.10.123.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 402F760A9A;
        Mon, 11 Feb 2019 19:27:58 +0000 (UTC)
Date:   Mon, 11 Feb 2019 14:27:56 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] uprobes: use set_pte_at() not set_pte_at_notify()
Message-ID: <20190211192755.GC3908@redhat.com>
References: <20190131183706.20980-1-jglisse@redhat.com>
 <20190131183706.20980-2-jglisse@redhat.com>
 <20190202005022.GC12463@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190202005022.GC12463@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 11 Feb 2019 19:28:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background we are discussing __replace_page() in:
    kernel/events/uprobes.c

and wether this can be call on page that can be written too through
its virtual address mapping.

On Fri, Feb 01, 2019 at 07:50:22PM -0500, Andrea Arcangeli wrote:
> On Thu, Jan 31, 2019 at 01:37:03PM -0500, Jerome Glisse wrote:
> > @@ -207,8 +207,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
> >  
> >  	flush_cache_page(vma, addr, pte_pfn(*pvmw.pte));
> >  	ptep_clear_flush_notify(vma, addr, pvmw.pte);
> > -	set_pte_at_notify(mm, addr, pvmw.pte,
> > -			mk_pte(new_page, vma->vm_page_prot));
> > +	set_pte_at(mm, addr, pvmw.pte, mk_pte(new_page, vma->vm_page_prot));
> >  
> >  	page_remove_rmap(old_page, false);
> >  	if (!page_mapped(old_page))
> 
> This seems racy by design in the way it copies the page, if the vma
> mapping isn't readonly to begin with (in which case it'd be ok to
> change the pfn with change_pte too, it'd be a from read-only to
> read-only change which is ok).
> 
> If the code copies a writable page there's no much issue if coherency
> is lost by other means too.

I am not sure the race exist but i am not familiar with the uprobe
code so maybe the page is already write protected and thus the copy
is fine and in fact that is likely the case but there is not check
for that. Maybe there should be a check ?

Maybe someone familiar with this code can chime in.

> 
> Said that this isn't a worthwhile optimization for uprobes so because
> of the lack of explicit read-only enforcement, I agree it's simpler to
> skip change_pte above.
> 
> It's orthogonal, but in this function the
> mmu_notifier_invalidate_range_end(&range); can be optimized to
> mmu_notifier_invalidate_range_only_end(&range); otherwise there's no
> point to retain the _notify in ptep_clear_flush_notify.

We need to keep the _notify for IOMMU otherwise it would break IOMMU.
IOMMU can walk the page table at any time and thus we need to first
clear the table then notify the IOMMU to flush TLB on all the devices
that might have a TLB entry. Only then can we set the new pte.

But yes the mmu_notifier_invalidate_range_end can be optimized to
only end. I will do a separate patch for this. As it is orthogonal as
you pointed out :)

Cheers,
Jérôme
