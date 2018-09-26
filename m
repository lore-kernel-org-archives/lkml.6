Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F41C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648D820843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648D820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeIZTXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIZTXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:23:22 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B33ACC01B14C;
        Wed, 26 Sep 2018 13:10:28 +0000 (UTC)
Received: from gondolin (ovpn-116-210.ams2.redhat.com [10.36.116.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 833C02010D60;
        Wed, 26 Sep 2018 13:10:22 +0000 (UTC)
Date:   Wed, 26 Sep 2018 15:10:19 +0200
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
Subject: Re: [PATCH v11 04/26] s390: vfio-ap: base implementation of VFIO AP
 device driver
Message-ID: <20180926151019.1c97475f.cohuck@redhat.com>
In-Reply-To: <20180925231641.4954-5-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-5-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 26 Sep 2018 13:10:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 19:16:19 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces a new AP device driver. This device driver
> is built on the VFIO mediated device framework. The framework
> provides sysfs interfaces that facilitate passthrough
> access by guests to devices installed on the linux host.
> 
> The VFIO AP device driver will serve two purposes:
> 
> 1. Provide the interfaces to reserve AP devices for exclusive
>    use by KVM guests. This is accomplished by unbinding the
>    devices to be reserved for guest usage from the zcrypt
>    device driver and binding them to the VFIO AP device driver.
> 
> 2. Implements the functions, callbacks and sysfs attribute
>    interfaces required to create one or more VFIO mediated
>    devices each of which will be used to configure the AP
>    matrix for a guest and serve as a file descriptor
>    for facilitating communication between QEMU and the
>    VFIO AP device driver.
> 
> When the VFIO AP device driver is initialized:
> 
> * It registers with the AP bus for control of type 10 (CEX4
>   and newer) AP queue devices. This limitation was imposed
>   due to:
> 
>   1. A desire to keep the code as simple as possible;
> 
>   2. Some older models are no longer supported by the kernel
>      and others are getting close to end of service.
> 
>   3. A lack of older systems on which to test older devices.
> 
>   The probe and remove callbacks will be provided to support
>   the binding/unbinding of AP queue devices to/from the VFIO
>   AP device driver.
> 
> * Creates a matrix device, /sys/devices/vfio_ap/matrix,
>   to serve as the parent of the mediated devices created, one
>   for each guest, and to hold the APQNs of the AP devices bound to
>   the VFIO AP device driver.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  MAINTAINERS                           |  10 ++
>  arch/s390/Kconfig                     |  11 ++
>  drivers/iommu/Kconfig                 |   8 ++
>  drivers/s390/crypto/Makefile          |   4 +
>  drivers/s390/crypto/vfio_ap_drv.c     | 138 ++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |  34 +++++++
>  6 files changed, 205 insertions(+)
>  create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>  create mode 100644 drivers/s390/crypto/vfio_ap_private.h

This already got my R-b for v10... here it is again:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
