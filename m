Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC17C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418AB208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418AB208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeIXRiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbeIXRiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3F90308421A;
        Mon, 24 Sep 2018 11:36:23 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C482A9CBC;
        Mon, 24 Sep 2018 11:36:13 +0000 (UTC)
Date:   Mon, 24 Sep 2018 13:36:11 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 13/26] s390: vfio-ap: zeroize the AP queues
Message-ID: <20180924133611.01fef50e.cohuck@redhat.com>
In-Reply-To: <1536781396-13601-14-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-14-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 24 Sep 2018 11:36:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 15:43:03 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Let's call PAPQ(ZAPQ) to zeroize a queue for each queue configured
> for a mediated matrix device when it is released.
> 
> Zeroizing a queue resets the queue, clears all pending
> messages for the queue entries and disables adapter interruptions
> associated with the queue.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |   44 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index f8b276a..48b1b78 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -829,6 +829,49 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> +				    unsigned int retry)
> +{
> +	struct ap_queue_status status;
> +
> +	do {
> +		status = ap_zapq(AP_MKQID(apid, apqi));
> +		switch (status.response_code) {
> +		case AP_RESPONSE_NORMAL:
> +			return 0;
> +		case AP_RESPONSE_RESET_IN_PROGRESS:
> +		case AP_RESPONSE_BUSY:
> +			msleep(20);
> +			break;
> +		default:
> +			/* things are really broken, give up */
> +			return -EIO;
> +		}
> +	} while (retry--);
> +
> +	return -EBUSY;

So, this function may either return 0, -EIO (things are really broken),
or -EBUSY (still busy after multiple tries)...

> +}
> +
> +static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> +{
> +	int ret;
> +	int rc = 0;
> +	unsigned long apid, apqi;
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
> +			     matrix_mdev->matrix.apm_max + 1) {
> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
> +				     matrix_mdev->matrix.aqm_max + 1) {
> +			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
> +			if (ret)
> +				rc = ret;

...and here, we return the last error of any of the resets. Two
questions:

- Does it make sense to continue if we get -EIO? IOW, does "really
  broken" only refer to a certain tuple and other tuples still can/need
  to be reset?
- Is the return code useful in any way, as we don't know which tuple it
  refers to?

> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  static int vfio_ap_mdev_open(struct mdev_device *mdev)
>  {
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> @@ -859,6 +902,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>  	if (matrix_mdev->kvm)
>  		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>  
> +	vfio_ap_mdev_reset_queues(mdev);
>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>  				 &matrix_mdev->group_notifier);
>  	matrix_mdev->kvm = NULL;

