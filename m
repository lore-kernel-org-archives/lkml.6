Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0812C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A242089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A242089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJHX41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:56:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeJHX40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F4183097030;
        Mon,  8 Oct 2018 16:43:52 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C484C2008114;
        Mon,  8 Oct 2018 16:43:51 +0000 (UTC)
Date:   Mon, 8 Oct 2018 10:43:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        kvm@vger.kernel.org (open list:VFIO DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] drivers/vfio: Fix a redundant copy bug
Message-ID: <20181008104350.7776c729@w520.home>
In-Reply-To: <1538923466-29705-1-git-send-email-wang6495@umn.edu>
References: <1538923466-29705-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 08 Oct 2018 16:43:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun,  7 Oct 2018 09:44:25 -0500
Wenwen Wang <wang6495@umn.edu> wrote:

> In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_OP,
> the user-space buffer 'arg' is copied to the kernel object 'op' and the
> 'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
> error code EINVAL is returned. Otherwise, 'op.op' is further checked
> through a switch statement to invoke related handlers. If 'op.op' is
> VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied again
> to 'op' to obtain the err information. However, in the following execution
> of this case, the fields of 'op', except the field 'err', are actually not
> used. That is, the second copy has a redundant part. Therefore, for both
> performance and security reasons, the redundant part of the second copy
> should be removed.

Redundant, yes.  Performance-wise it's 12 bytes on a non-performance
path, so theoretically yes, but in practice maybe it's a simplicity
trade-off.  Security?  I don't see it, please explain.

> This patch removes such a part in the second copy. It only copies the 'err'
> information from the buffer 'arg'.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/vfio/vfio_spapr_eeh.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> index 38edeb4..5bc4b60 100644
> --- a/drivers/vfio/vfio_spapr_eeh.c
> +++ b/drivers/vfio/vfio_spapr_eeh.c
> @@ -86,10 +86,10 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>  			ret = eeh_pe_configure(pe);
>  			break;
>  		case VFIO_EEH_PE_INJECT_ERR:
> -			minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> -			if (op.argsz < minsz)
> +			if (op.argsz < sizeof(op))
>  				return -EINVAL;

The original code is written such that new operations can be added,
possibly with new entries in the struct vfio_eeh_pe_op union, which
might change sizeof(op) to be more than necessary for a
VFIO_EEH_PE_INJECT_ERR op.  Existing userspace suddenly wouldn't work
without effectively reverting this change.  This is a subtle dependency
that is not worth the above code change, imo.

> -			if (copy_from_user(&op, (void __user *)arg, minsz))
> +			if (copy_from_user(&op.err, (char __user *)arg +
> +						minsz, sizeof(op.err)))
>  				return -EFAULT;

Please rework with the assumption that the union in struct
vfio_eeh_pe_op can be expanded and must not break existing userspace.
Thanks,

Alex
