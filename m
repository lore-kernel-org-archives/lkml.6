Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A49C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D183220672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D183220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeLKFQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:16:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbeLKFQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:16:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4B7A3082E51;
        Tue, 11 Dec 2018 05:16:31 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B8C15DD6B;
        Tue, 11 Dec 2018 05:16:27 +0000 (UTC)
Date:   Tue, 11 Dec 2018 13:16:25 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] userfaultfd: clear flag if remap event not enabled
Message-ID: <20181211051625.GB3260@xz-x1>
References: <20181210065121.14984-1-peterx@redhat.com>
 <20181210175115.GB6380@rapoport-lnx>
 <20181210200925.GA14751@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181210200925.GA14751@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 11 Dec 2018 05:16:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 03:09:25PM -0500, Andrea Arcangeli wrote:
> Hello,
> 
> On Mon, Dec 10, 2018 at 07:51:16PM +0200, Mike Rapoport wrote:
> > On Mon, Dec 10, 2018 at 02:51:21PM +0800, Peter Xu wrote:
> > > When the process being tracked do mremap() without
> > > UFFD_FEATURE_EVENT_REMAP on the corresponding tracking uffd file
> > > handle, we should not generate the remap event, and at the same
> > > time we should clear all the uffd flags on the new VMA.  Without
> > > this patch, we can still have the VM_UFFD_MISSING|VM_UFFD_WP
> > > flags on the new VMA even the fault handling process does not
> > > even know the existance of the VMA.
> > > 
> > > CC: Andrea Arcangeli <aarcange@redhat.com>
> > > CC: Andrew Morton <akpm@linux-foundation.org>
> > > CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > CC: Kirill A. Shutemov <kirill@shutemov.name>
> > > CC: Hugh Dickins <hughd@google.com>
> > > CC: Pavel Emelyanov <xemul@virtuozzo.com>
> > > CC: Pravin Shedge <pravin.shedge4linux@gmail.com>
> > > CC: linux-mm@kvack.org
> > > CC: linux-kernel@vger.kernel.org
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  fs/userfaultfd.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index cd58939dc977..798ae8a438ff 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -740,6 +740,9 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
> > >  		vm_ctx->ctx = ctx;
> > >  		userfaultfd_ctx_get(ctx);
> > >  		WRITE_ONCE(ctx->mmap_changing, true);
> > > +	} else if (ctx) {
> > > +		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > > +		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
> 
> Great catch Peter!
> 
> > 
> > My preference would be 
> > 
> > 	if (!ctx)
> > 		return;
> > 	
> > 	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
> > 		...
> > 	} else {
> > 		...
> > 	}
> > 
> > but I don't feel strongly about it.
> 
> Yes, it'd look nicer to run a single "ctx not null" check.

I agree.

> 
> > 
> > I'd appreciate a comment in the code and with it 
> > 
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> 
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Thanks to both!  I'll repost soon.

Regards,

-- 
Peter Xu
