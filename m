Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CE4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F1C20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F1C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeLCKEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:04:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeLCKEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:04:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EB0A3082A23;
        Mon,  3 Dec 2018 10:04:33 +0000 (UTC)
Received: from gondolin (ovpn-116-122.ams2.redhat.com [10.36.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B08F60923;
        Mon,  3 Dec 2018 10:04:25 +0000 (UTC)
Date:   Mon, 3 Dec 2018 11:04:22 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v2 3/3] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
Message-ID: <20181203110422.4d069a8c.cohuck@redhat.com>
In-Reply-To: <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
        <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 03 Dec 2018 10:04:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 18:11:15 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> This is the implementation of the VFIO ioctl calls to handle
> the AQIC interception and use GISA to handle interrupts.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 1 deletion(-)
> 

> +static int vfio_ap_ioctl_setirq(struct mdev_device *mdev, unsigned long arg)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct vfio_ap_aqic parm;
> +	struct ap_qirq_ctrl aqic_gisa = {};
> +	struct kvm *kvm = matrix_mdev->kvm;
> +	struct kvm_s390_gisa *gisa = kvm->arch.gisa;
> +	struct ap_queue_status ap_status;
> +	unsigned long nib;
> +
> +	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
> +		return -EFAULT;
> +
> +	if (parm.isc > MAX_ISC)
> +		return -EINVAL;
> +
> +	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
> +		aqic_gisa.gf = 1;
> +
> +	nib = vfio_ap_get_nib(kvm, &parm);
> +	if (!nib)
> +		return -ENODEV;
> +
> +	aqic_gisa.gisc = parm.isc;
> +	aqic_gisa.isc = kvm_s390_gisc_register(kvm, parm.isc);

Oh, and as I just looked at the callers of these functions: You'll want
to check the return code here, even though the function should not fail
with the checking you did beforehand.

[I assume you'll have similar code even when using a different
interface.]

> +	aqic_gisa.ir = 1;
> +	aqic_gisa.gisa = gisa->next_alert >> 4;
> +
> +	ap_status = ap_aqic(parm.apqn, aqic_gisa, (void *)nib);
> +	parm.status = *(uint32_t *)(&ap_status);
> +
> +	if (copy_to_user((void __user *)arg, &parm, sizeof(parm))) {
> +		kvm_s390_gisc_unregister(kvm, parm.isc);
> +		return -EFAULT;
> +	}
> +
> +	if (ap_status.response_code) {
> +		kvm_s390_gisc_unregister(kvm, parm.isc);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_ioctl_clrirq(struct mdev_device *mdev, unsigned long arg)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct vfio_ap_aqic parm;
> +	struct ap_qirq_ctrl aqic_gisa = {};
> +	struct ap_queue_status ap_status;
> +	struct kvm *kvm = matrix_mdev->kvm;
> +
> +	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
> +		return -EFAULT;
> +
> +	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
> +		aqic_gisa.gf = 1;
> +	aqic_gisa.ir = 0;
> +
> +	ap_status = ap_aqic(parm.apqn, aqic_gisa, NULL);
> +	parm.status = *(uint32_t *)(&ap_status);
> +
> +	kvm_s390_gisc_unregister(kvm, parm.isc);

Here, you don't seem to verify the sanity of parm.isc beforehand...
luckily the function can deal with that :)

> +
> +	if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
> +		return -EFAULT;
> +
> +	return (ap_status.response_code) ? -EIO : 0;
> +}
> +
