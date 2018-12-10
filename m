Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24658C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16712082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16712082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeLJUJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:09:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeLJUJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:09:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05AB4C04958E;
        Mon, 10 Dec 2018 20:09:29 +0000 (UTC)
Received: from sky.random (ovpn-120-40.rdu2.redhat.com [10.10.120.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CB26101962B;
        Mon, 10 Dec 2018 20:09:26 +0000 (UTC)
Date:   Mon, 10 Dec 2018 15:09:25 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] userfaultfd: clear flag if remap event not enabled
Message-ID: <20181210200925.GA14751@redhat.com>
References: <20181210065121.14984-1-peterx@redhat.com>
 <20181210175115.GB6380@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210175115.GB6380@rapoport-lnx>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Dec 2018 20:09:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 10, 2018 at 07:51:16PM +0200, Mike Rapoport wrote:
> On Mon, Dec 10, 2018 at 02:51:21PM +0800, Peter Xu wrote:
> > When the process being tracked do mremap() without
> > UFFD_FEATURE_EVENT_REMAP on the corresponding tracking uffd file
> > handle, we should not generate the remap event, and at the same
> > time we should clear all the uffd flags on the new VMA.  Without
> > this patch, we can still have the VM_UFFD_MISSING|VM_UFFD_WP
> > flags on the new VMA even the fault handling process does not
> > even know the existance of the VMA.
> > 
> > CC: Andrea Arcangeli <aarcange@redhat.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > CC: Kirill A. Shutemov <kirill@shutemov.name>
> > CC: Hugh Dickins <hughd@google.com>
> > CC: Pavel Emelyanov <xemul@virtuozzo.com>
> > CC: Pravin Shedge <pravin.shedge4linux@gmail.com>
> > CC: linux-mm@kvack.org
> > CC: linux-kernel@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/userfaultfd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index cd58939dc977..798ae8a438ff 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -740,6 +740,9 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
> >  		vm_ctx->ctx = ctx;
> >  		userfaultfd_ctx_get(ctx);
> >  		WRITE_ONCE(ctx->mmap_changing, true);
> > +	} else if (ctx) {
> > +		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > +		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);

Great catch Peter!

> 
> My preference would be 
> 
> 	if (!ctx)
> 		return;
> 	
> 	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
> 		...
> 	} else {
> 		...
> 	}
> 
> but I don't feel strongly about it.

Yes, it'd look nicer to run a single "ctx not null" check.

> 
> I'd appreciate a comment in the code and with it 
> 
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> 

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
