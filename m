Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA16C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F415921A78
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F415921A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbeHIMgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:36:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728175AbeHIMgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEFC2402332F;
        Thu,  9 Aug 2018 10:12:10 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D390510B7CB5;
        Thu,  9 Aug 2018 10:12:05 +0000 (UTC)
Date:   Thu, 9 Aug 2018 12:12:03 +0200
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
Subject: Re: [PATCH v8 08/22] s390: vfio-ap: base implementation of VFIO AP
 device driver
Message-ID: <20180809121203.3961e314.cohuck@redhat.com>
In-Reply-To: <1533739472-7172-9-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 10:12:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 10:12:11 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Aug 2018 10:44:18 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> new file mode 100644
> index 0000000..d7e39ad
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VFIO based AP device driver
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *	      Halil Pasic <pasic@linux.ibm.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include "vfio_ap_private.h"
> +
> +#define VFIO_AP_ROOT_NAME "vfio_ap"
> +#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
> +#define VFIO_AP_DEV_NAME "vfio_ap"
> +
> +MODULE_AUTHOR("IBM Corporation");
> +MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
> +MODULE_LICENSE("GPL v2");
> +
> +static struct ap_driver vfio_ap_drv;
> +
> +static struct device_type vfio_ap_dev_type = {
> +	.name = VFIO_AP_DEV_TYPE_NAME,
> +};
> +
> +struct ap_matrix_dev matrix_dev = {
> +	/*
> +	 * We may add some fops later to implement a more program friendly
> +	 * management interface for vfio_ap_mdev devices.
> +	 */
> +	.misc_dev = {
> +		MISC_DYNAMIC_MINOR,
> +		VFIO_AP_DEV_NAME,
> +	}

Is there any reason why you embed a struct miscdevice and don't just
use it directly?

> +};
> +
> +/* Only type 10 adapters (CEX4 and later) are supported
> + * by the AP matrix device driver
> + */
> +static struct ap_device_id ap_queue_ids[] = {
> +	{ .dev_type = AP_DEVICE_TYPE_CEX4,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ .dev_type = AP_DEVICE_TYPE_CEX5,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ .dev_type = AP_DEVICE_TYPE_CEX6,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ /* end of sibling */ },
> +};
> +
> +MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
> +
> +static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
> +{
> +	return 0;
> +}
> +
> +static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
> +{
> +	/* Nothing to do yet */
> +}
> +
> +static int vfio_ap_matrix_dev_create(void)
> +{
> +	int ret;
> +
> +	ret = misc_register(&matrix_dev.misc_dev);
> +	if (ret)
> +		return ret;
> +
> +	to_device(&matrix_dev)->type = &vfio_ap_dev_type;
> +	to_device(&matrix_dev)->driver = &vfio_ap_drv.driver;

This looks strange. Why would you want to change the driver for a
miscdevice, and that after it already has been registered? This feels
like a miscdevice is not the right choice here.

> +
> +	return ret;
> +}
> +
> +static void vfio_ap_matrix_dev_destroy(void)
> +{
> +	misc_deregister(&matrix_dev.misc_dev);
> +}
> +
> +int __init vfio_ap_init(void)
> +{
> +	int ret;
> +
> +	ret = vfio_ap_matrix_dev_create();
> +	if (ret)
> +		return ret;
> +
> +	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
> +	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
> +	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
> +	vfio_ap_drv.ids = ap_queue_ids;
> +
> +	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
> +	if (ret) {
> +		vfio_ap_matrix_dev_destroy();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void __exit vfio_ap_exit(void)
> +{
> +	ap_driver_unregister(&vfio_ap_drv);
> +	vfio_ap_matrix_dev_destroy();
> +}
> +
> +module_init(vfio_ap_init);
> +module_exit(vfio_ap_exit);
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> new file mode 100644
> index 0000000..02c878c
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Private data and functions for adjunct processor VFIO matrix driver.
> + *
> + * Copyright IBM Corp. 2018
> + */
> +
> +#ifndef _VFIO_AP_PRIVATE_H_
> +#define _VFIO_AP_PRIVATE_H_
> +
> +#include <linux/types.h>
> +#include <linux/miscdevice.h>
> +
> +#include "ap_bus.h"
> +
> +#define VFIO_AP_MODULE_NAME "vfio_ap"
> +#define VFIO_AP_DRV_NAME "vfio_ap"
> +
> +struct ap_matrix_dev {
> +	struct miscdevice misc_dev;
> +};
> +
> +extern struct ap_matrix_dev matrix_dev;
> +
> +static inline struct device *to_device(struct ap_matrix_dev *matrix_dev)
> +{
> +	return matrix_dev->misc_dev.this_device;
> +}

Even if you keep it as a miscdevice, I don't like that function,
especially the naming. Frankly, I'd simply drop it.

> +
> +#endif /* _VFIO_AP_PRIVATE_H_ */

