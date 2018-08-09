Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ACEC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ED521D19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ED521D19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeHINae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:30:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727768AbeHINae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8995040216E8;
        Thu,  9 Aug 2018 11:06:12 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BF4D215670D;
        Thu,  9 Aug 2018 11:06:09 +0000 (UTC)
Date:   Thu, 9 Aug 2018 13:06:07 +0200
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
Subject: Re: [PATCH v8 09/22] s390: vfio-ap: register matrix device with
 VFIO mdev framework
Message-ID: <20180809130607.32781b72.cohuck@redhat.com>
In-Reply-To: <1533739472-7172-10-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-10-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 11:06:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 11:06:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Aug 2018 10:44:19 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index d7e39ad..6a827f3 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -12,6 +12,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <asm/zcrypt.h>
>  #include "vfio_ap_private.h"
>  
>  #define VFIO_AP_ROOT_NAME "vfio_ap"
> @@ -68,6 +69,18 @@ static int vfio_ap_matrix_dev_create(void)
>  {
>  	int ret;
>  
> +	mutex_init(&matrix_dev.lock);
> +	INIT_LIST_HEAD(&matrix_dev.mdev_list);
> +
> +	/* Test if PQAP(QCI) instruction is available */
> +	if (test_facility(12)) {
> +		ret = ap_qci(&matrix_dev.info);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	atomic_set(&matrix_dev.available_instances, MAX_ZDEV_ENTRIES_EXT);
> +
>  	ret = misc_register(&matrix_dev.misc_dev);

OK, you are adding more stuff other than the miscdevice after all...
still, I don't think that this is a good idea.

I think I had already asked this for a previous version: Why has this
been turned into a miscdevice? (I think my reaction to the answer was
'meh'... but I think more and more that we should not do that.)

>  	if (ret)
>  		return ret;
