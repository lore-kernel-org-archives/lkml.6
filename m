Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11854C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918B521477
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918B521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbeHOTBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:01:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729347AbeHOTBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:01:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9B434021FC2;
        Wed, 15 Aug 2018 16:08:19 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FE452026D7E;
        Wed, 15 Aug 2018 16:08:16 +0000 (UTC)
Date:   Wed, 15 Aug 2018 18:08:14 +0200
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
Subject: Re: [PATCH v9 15/22] s390: vfio-ap: implement mediated device open
 callback
Message-ID: <20180815180814.5985e3f0.cohuck@redhat.com>
In-Reply-To: <1534196899-16987-16-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 15 Aug 2018 16:08:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 15 Aug 2018 16:08:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 17:48:12 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Implements the open callback on the mediated matrix device.
> The function registers a group notifier to receive notification
> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
> the vfio_ap device driver will get access to the guest's
> kvm structure. The open callback must ensure that only one
> mediated device shall be opened per guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     |  174 ++++++++++++++++++++++++++++++++-
>  drivers/s390/crypto/vfio_ap_private.h |    2 +
>  2 files changed, 175 insertions(+), 1 deletions(-)

> @@ -602,7 +633,6 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>  }
>  DEVICE_ATTR_RO(matrix);
>  
> -

Nit: whitespace change

>  static struct attribute *vfio_ap_mdev_attrs[] = {
>  	&dev_attr_assign_adapter.attr,
>  	&dev_attr_unassign_adapter.attr,

(...)

> +/**
> + * vfio_ap_mdev_open_once
> + *
> + * @matrix_mdev: a mediated matrix device
> + *
> + * Return 0 if no other mediated matrix device has been opened for the
> + * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
> + */
> +static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
> +				  struct kvm *kvm)

You're passing kvm in here, but do not use it.

> +{
> +	struct ap_matrix_mdev *m;
> +
> +	mutex_lock(&matrix_dev.lock);
> +
> +	list_for_each_entry(m, &matrix_dev.mdev_list, list) {
> +		if ((m != matrix_mdev) && (m->kvm == matrix_mdev->kvm)) {

If you used it here instead of matrix_mdev->kvm...

> +			mutex_unlock(&matrix_dev.lock);
> +			return -EPERM;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev.lock);
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	int ret;
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
> +		return NOTIFY_OK;
> +
> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
> +
> +	matrix_mdev->kvm = data;
> +	if (data == NULL)
> +		return NOTIFY_OK;
> +
> +	ret = vfio_ap_mdev_open_once(matrix_mdev, data);

...you could move this up to before overwriting matrix_mdev->kvm and
bailing out when the check failed, which makes more sense to me.

> +	if (ret)
> +		return ret;
> +
> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
> +	if (ret)
> +		return ret;

It probably makes more sense to return NOTIFY_DONE in the error case
(NOTIFY_BAD does not sound like a good idea as it would stop processing
the notifier chain).

> +
> +	vfio_ap_mdev_copy_masks(matrix_mdev);
> +
> +	return NOTIFY_OK;
> +}

Otherwise, looks sane.
