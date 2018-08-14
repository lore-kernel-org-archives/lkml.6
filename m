Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01000C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A423621735
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A423621735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbeHNOGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:06:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730923AbeHNOGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C63B840203F2;
        Tue, 14 Aug 2018 11:19:35 +0000 (UTC)
Received: from gondolin (ovpn-117-136.ams2.redhat.com [10.36.117.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 444842026D7E;
        Tue, 14 Aug 2018 11:19:32 +0000 (UTC)
Date:   Tue, 14 Aug 2018 13:19:29 +0200
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
Subject: Re: [PATCH v9 09/22] s390: vfio-ap: register matrix device with
 VFIO mdev framework
Message-ID: <20180814131929.37d4b530.cohuck@redhat.com>
In-Reply-To: <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 11:19:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 11:19:35 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 17:48:06 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Registers the matrix device created by the VFIO AP device
> driver with the VFIO mediated device framework.
> Registering the matrix device will create the sysfs
> structures needed to create mediated matrix devices
> each of which will be used to configure the AP matrix
> for a guest and connect it to the VFIO AP device driver.
> 
> Registering the matrix device with the VFIO mediated device
> framework will create the following sysfs structures:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ create
> 
> To create a mediated device for the AP matrix device, write a UUID
> to the create file:
> 
> 	uuidgen > create
> 
> A symbolic link to the mediated device's directory will be created in the
> devices subdirectory named after the generated $uuid:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ............... [$uuid]
> 
> A symbolic link to the mediated device will also be created
> in the vfio_ap matrix's directory:
> 
> /sys/devices/vfio_ap/matrix/[$uuid]
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  MAINTAINERS                           |    1 +
>  drivers/s390/crypto/Makefile          |    2 +-
>  drivers/s390/crypto/vfio_ap_drv.c     |   23 ++++++
>  drivers/s390/crypto/vfio_ap_ops.c     |  124 +++++++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |   45 ++++++++++++
>  include/uapi/linux/vfio.h             |    1 +
>  6 files changed, 195 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
> 


> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> new file mode 100644
> index 0000000..8018c2d
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Adjunct processor matrix VFIO device driver callbacks.
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *	      Halil Pasic <pasic@linux.ibm.com>
> + *	      Pierre Morel <pmorel@linux.ibm.com>
> + */
> +#include <linux/string.h>
> +#include <linux/vfio.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/ctype.h>
> +
> +#include "vfio_ap_private.h"
> +
> +#define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
> +#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
> +
> +static void vfio_ap_matrix_init(struct ap_config_info *info,
> +				struct ap_matrix *matrix)
> +{
> +	matrix->apm_max = info->apxa ? info->Na : 63;
> +	matrix->aqm_max = info->apxa ? info->Nd : 15;
> +	matrix->adm_max = info->apxa ? info->Nd : 15;
> +}
> +
> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
> +	if (!matrix_mdev)
> +		return -ENOMEM;
> +
> +	matrix_mdev->name = dev_name(mdev_dev(mdev));
> +	vfio_ap_matrix_init(&matrix_dev.info, &matrix_mdev->matrix);
> +	mdev_set_drvdata(mdev, matrix_mdev);
> +
> +	if (atomic_dec_if_positive(&matrix_dev.available_instances) < 0) {
> +		kfree(matrix_mdev);
> +		return -EPERM;
> +	}

Maybe move this check to the top of the function?

> +
> +	mutex_lock(&matrix_dev.lock);
> +	list_add(&matrix_mdev->list, &matrix_dev.mdev_list);
> +	mutex_unlock(&matrix_dev.lock);
> +
> +	return 0;
> +}
