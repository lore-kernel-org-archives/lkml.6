Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC902ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C016721528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C016721528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJQXlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbeJQXlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:41:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D7389D411;
        Wed, 17 Oct 2018 15:45:08 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A11219E14;
        Wed, 17 Oct 2018 15:45:07 +0000 (UTC)
Date:   Wed, 17 Oct 2018 09:45:06 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        kvm@vger.kernel.org (open list:VFIO DRIVER),
        linux-kernel@vger.kernel.org (open list), <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] drivers/vfio: Fix a redundant copy bug
Message-ID: <20181017094506.1b09eb64@w520.home>
In-Reply-To: <1539786725-1812-1-git-send-email-wang6495@umn.edu>
References: <1539786725-1812-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 17 Oct 2018 15:45:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 09:32:04 -0500
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
> performance consideration, the redundant part of the second copy should be
> removed.
> 
> This patch removes such a part in the second copy. It only copies from
> 'err.type' to 'err.mask', which is exactly required by the
> VFIO_EEH_PE_INJECT_ERR op.
> 
> This patch also adds a 4-byte reserved field in the structure
> vfio_eeh_pe_op to make sure that the u64 fields in the structure
> vfio_eeh_pe_err are 8-byte aligned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
>  include/uapi/linux/vfio.h     | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> index 38edeb4..66634c6 100644
> --- a/drivers/vfio/vfio_spapr_eeh.c
> +++ b/drivers/vfio/vfio_spapr_eeh.c
> @@ -37,6 +37,7 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>  	struct eeh_pe *pe;
>  	struct vfio_eeh_pe_op op;
>  	unsigned long minsz;
> +	unsigned long start, end;
>  	long ret = -EINVAL;
>  
>  	switch (cmd) {
> @@ -86,10 +87,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>  			ret = eeh_pe_configure(pe);
>  			break;
>  		case VFIO_EEH_PE_INJECT_ERR:
> -			minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> -			if (op.argsz < minsz)
> +			start = offsetof(struct vfio_eeh_pe_op, err.type);

I noted in the previous version that we already have this in minsz, so
you're fixing a redundant copy with a redundant operation.

> +			end = offsetofend(struct vfio_eeh_pe_op, err.mask);
> +			if (op.argsz < end)
>  				return -EINVAL;
> -			if (copy_from_user(&op, (void __user *)arg, minsz))
> +			if (copy_from_user(&op.err, (char __user *)arg +
> +						start, end - start))
>  				return -EFAULT;
>  
>  			ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82..d904c42 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -729,6 +729,7 @@ struct vfio_eeh_pe_op {
>  	__u32 argsz;
>  	__u32 flags;
>  	__u32 op;
> +	__u32 __resv;
>  	union {
>  		struct vfio_eeh_pe_err err;
>  	};

Please don't include two separate issues in the same patch.  Am I also
correct in assuming that this is untested?  Thanks,

Alex
