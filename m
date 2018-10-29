Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C06C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CE42082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CE42082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJ3GXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeJ3GXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:23:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A71C2601B;
        Mon, 29 Oct 2018 21:32:35 +0000 (UTC)
Received: from t450s.home (ovpn-116-133.phx2.redhat.com [10.3.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B2DF194AF;
        Mon, 29 Oct 2018 21:32:34 +0000 (UTC)
Date:   Mon, 29 Oct 2018 15:32:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, kvm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4] drivers/vfio: Fix a redundant copy bug
Message-ID: <20181029153234.36e67a6f@t450s.home>
In-Reply-To: <CAAa=b7dE=6obq4nABsyo84iA1CTOcLVCAuUxHDYfSCimzc12eA@mail.gmail.com>
References: <1539803924-3190-1-git-send-email-wang6495@umn.edu>
        <CAAa=b7dE=6obq4nABsyo84iA1CTOcLVCAuUxHDYfSCimzc12eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 29 Oct 2018 21:32:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 13:56:54 -0500
Wenwen Wang <wang6495@umn.edu> wrote:

> Hello,
> 
> Could you please apply this patch? Thanks!

I'd like to see testing and/or review from David or Alexey since I also
don't have an environment for spapr/eeh.  We're already late into the
v4.20 merge window so this is probably v4.21 material.  Thanks,

Alex

> On Wed, Oct 17, 2018 at 2:18 PM Wenwen Wang <wang6495@umn.edu> wrote:
> >
> > In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_OP,
> > the user-space buffer 'arg' is copied to the kernel object 'op' and the
> > 'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
> > error code EINVAL is returned. Otherwise, 'op.op' is further checked
> > through a switch statement to invoke related handlers. If 'op.op' is
> > VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied again
> > to 'op' to obtain the err information. However, in the following execution
> > of this case, the fields of 'op', except the field 'err', are actually not
> > used. That is, the second copy has a redundant part. Therefore, for
> > performance consideration, the redundant part of the second copy should be
> > removed.
> >
> > This patch removes such a part in the second copy. It only copies from
> > 'err.type' to 'err.mask', which is exactly required by the
> > VFIO_EEH_PE_INJECT_ERR op.
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> > index 38edeb4..66634c6 100644
> > --- a/drivers/vfio/vfio_spapr_eeh.c
> > +++ b/drivers/vfio/vfio_spapr_eeh.c
> > @@ -37,6 +37,7 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> >         struct eeh_pe *pe;
> >         struct vfio_eeh_pe_op op;
> >         unsigned long minsz;
> > +       unsigned long start, end;
> >         long ret = -EINVAL;
> >
> >         switch (cmd) {
> > @@ -86,10 +87,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> >                         ret = eeh_pe_configure(pe);
> >                         break;
> >                 case VFIO_EEH_PE_INJECT_ERR:
> > -                       minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > -                       if (op.argsz < minsz)
> > +                       start = offsetof(struct vfio_eeh_pe_op, err.type);
> > +                       end = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > +                       if (op.argsz < end)
> >                                 return -EINVAL;
> > -                       if (copy_from_user(&op, (void __user *)arg, minsz))
> > +                       if (copy_from_user(&op.err, (char __user *)arg +
> > +                                               start, end - start))
> >                                 return -EFAULT;
> >
> >                         ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
> > --
> > 2.7.4
> >  

