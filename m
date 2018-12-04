Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FD52081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FD52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeLDOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:49:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDOs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:48:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F654811DA;
        Tue,  4 Dec 2018 14:48:59 +0000 (UTC)
Received: from redhat.com (ovpn-123-203.rdu2.redhat.com [10.10.123.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E942769214;
        Tue,  4 Dec 2018 14:48:56 +0000 (UTC)
Date:   Tue, 4 Dec 2018 09:48:55 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] mm/mmu_notifier: contextual information for event
 triggering invalidation
Message-ID: <20181204144854.GB3917@redhat.com>
References: <20181203201817.10759-1-jglisse@redhat.com>
 <20181203201817.10759-4-jglisse@redhat.com>
 <20181204081746.GJ26700@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204081746.GJ26700@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 04 Dec 2018 14:48:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:17:48AM +0200, Mike Rapoport wrote:
> On Mon, Dec 03, 2018 at 03:18:17PM -0500, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>

[...]

> > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > index cbeece8e47d4..3077d487be8b 100644
> > --- a/include/linux/mmu_notifier.h
> > +++ b/include/linux/mmu_notifier.h
> > @@ -25,10 +25,43 @@ struct mmu_notifier_mm {
> >  	spinlock_t lock;
> >  };
> > 
> > +/*
> > + * What event is triggering the invalidation:
> 
> Can you please make it kernel-doc comment?

Sorry should have done that in the first place, Andrew i will post a v2
with that and fixing my one stupid bug.



> > + *
> > + * MMU_NOTIFY_UNMAP
> > + *    either munmap() that unmap the range or a mremap() that move the range
> > + *
> > + * MMU_NOTIFY_CLEAR
> > + *    clear page table entry (many reasons for this like madvise() or replacing
> > + *    a page by another one, ...).
> > + *
> > + * MMU_NOTIFY_PROTECTION_VMA
> > + *    update is due to protection change for the range ie using the vma access
> > + *    permission (vm_page_prot) to update the whole range is enough no need to
> > + *    inspect changes to the CPU page table (mprotect() syscall)
> > + *
> > + * MMU_NOTIFY_PROTECTION_PAGE
> > + *    update is due to change in read/write flag for pages in the range so to
> > + *    mirror those changes the user must inspect the CPU page table (from the
> > + *    end callback).
> > + *
> > + *
> > + * MMU_NOTIFY_SOFT_DIRTY
> > + *    soft dirty accounting (still same page and same access flags)
> > + */
> > +enum mmu_notifier_event {
> > +	MMU_NOTIFY_UNMAP = 0,
> > +	MMU_NOTIFY_CLEAR,
> > +	MMU_NOTIFY_PROTECTION_VMA,
> > +	MMU_NOTIFY_PROTECTION_PAGE,
> > +	MMU_NOTIFY_SOFT_DIRTY,
> > +};
