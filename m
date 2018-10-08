Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DCB21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DCB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeJICAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbeJICAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5932C034DF4;
        Mon,  8 Oct 2018 18:47:39 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 353575D784;
        Mon,  8 Oct 2018 18:47:38 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:47:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        kvm@vger.kernel.org (open list:VFIO DRIVER),
        linux-kernel@vger.kernel.org (open list), <aik@ozlabs.ru>
Subject: Re: [PATCH v2] drivers/vfio: Fix a redundant copy bug
Message-ID: <20181008124738.23a547d0@w520.home>
In-Reply-To: <1539021980-2412-1-git-send-email-wang6495@umn.edu>
References: <1539021980-2412-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 08 Oct 2018 18:47:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Oct 2018 13:06:20 -0500
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
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
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

We already have this in minsz, offsetofend(,op) == offsetof(,err.type).
That can't change without breaking userspace.

> +			end = offsetofend(struct vfio_eeh_pe_op, err.mask);
> +			if (op.argsz < end)
>  				return -EINVAL;
> -			if (copy_from_user(&op, (void __user *)arg, minsz))
> +			if (copy_from_user(&op.err, (char __user *)arg +
> +						start, end - start))

So we trade 12 bytes of redundant copy for an extra stack variable and
an arithmetic operation, not necessarily an obvious win, but more
correct I guess.

Alexey, I also notice that these 12 bytes means that the u64 fields in
struct vfio_eeh_pe_err are not 8-byte aligned which could lead to
compiler dependent packing interpretation issues with userspace.
Should there be a 4-byte reserved field in there to make it explicit
(so long as it matches the current interpretation)?  Thanks,

Alex
