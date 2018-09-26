Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B039C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD152082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD152082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIZTvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbeIZTvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:51:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7ABE2C05D3E1;
        Wed, 26 Sep 2018 13:38:44 +0000 (UTC)
Received: from gondolin (ovpn-116-210.ams2.redhat.com [10.36.116.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF4D960C59;
        Wed, 26 Sep 2018 13:38:34 +0000 (UTC)
Date:   Wed, 26 Sep 2018 15:38:31 +0200
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
Subject: Re: [PATCH v11 13/26] s390: vfio-ap: zeroize the AP queues
Message-ID: <20180926153831.195af1ce.cohuck@redhat.com>
In-Reply-To: <20180925231641.4954-14-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-14-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 26 Sep 2018 13:38:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 19:16:28 -0400
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
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 44 +++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index b4f67d547493..1943e47d7d78 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -816,6 +816,49 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
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

I'd still like to see a comment here:

/*
 * Regardless whether a queue turns out to be busy, or is not
 * operational, we need to continue resetting the remaining
 * queues.
 */

or so.

> +			if (ret)
> +				rc = ret;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  static int vfio_ap_mdev_open(struct mdev_device *mdev)
>  {
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> @@ -846,6 +889,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>  	if (matrix_mdev->kvm)
>  		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>  
> +	vfio_ap_mdev_reset_queues(mdev);
>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>  				 &matrix_mdev->group_notifier);
>  	matrix_mdev->kvm = NULL;

