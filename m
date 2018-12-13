Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AD1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D2B2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D2B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeLMPj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:39:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbeLMPj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:39:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FF893091749;
        Thu, 13 Dec 2018 15:39:57 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BEEA607C8;
        Thu, 13 Dec 2018 15:39:55 +0000 (UTC)
Date:   Thu, 13 Dec 2018 16:39:53 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     pasic@linux.vnet.ibm.com, farman@linux.ibm.com,
        alifm@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] vfio: ccw: serialize the write system calls
Message-ID: <20181213163953.5b534e6b.cohuck@redhat.com>
In-Reply-To: <1543408867-16465-7-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
        <1543408867-16465-7-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Dec 2018 15:39:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 13:41:07 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> When the user program is QEMU we rely on the QEMU lock to serialize
> the calls to the driver.
> 
> In the general case we need to make sure that two data transfer are
> not started at the same time.
> It would in the current implementation resul in a overwriting of the
> IO region.
> 
> We also need to make sure a clear or a halt started after a data
> transfer do not win the race agains the data transfer.
> Which would result in the data transfer being started after the
> halt/clear.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_ops.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index eb5b49d..b316966 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -267,22 +267,31 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>  {
>  	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
>  	struct vfio_ccw_private *private;
> +	static atomic_t serialize  = ATOMIC_INIT(0);
> +	int ret = -EINVAL;
> +
> +	if (!atomic_add_unless(&serialize, 1, 1))
> +		return -EBUSY;

I think that hammer is far too big: This serializes _all_ write
operations across _all_ devices.

There are various cases of simultaneous writes that may happen
(assuming any userspace; QEMU locking will prevent some of them from
happening):

- One thread does a write for one mdev, another thread does a write for
  another mdev. For example, if two vcpus issue an I/O instruction on
  two different devices. This should be fine.
- One thread does a write for one mdev, another thread does a write for
  the same mdev. Maybe a guest has confused/no locking and is trying to
  do ssch on the same device from different vcpus. There, we want to
  exclude simultaneous writes; the desired outcome may be that one ssch
  gets forwarded to the hardware, and the second one either gets
  forwarded after processing for the first one has finished, or
  userspace gets an error immediately (hopefully resulting in a
  appropriate condition code for that second ssch in any case). Both
  handing the second ssch to the hardware or signaling device busy
  immediately are probably sane in that case.
- If those writes for the same device involve hsch/csch, things get
  more complicated. First, we have two different regions, and allowing
  simultaneous writes to the I/O region and to the async region should
  not really be a problem, so I don't think fencing should be done in
  the generic write handler. Second, the semantics for device busy are
  different: a hsch immediately after a ssch should not give device
  busy, and csch cannot return device busy at all.

I don't think we'll be able to get around some kind of "let's retry
sending this" logic for hsch/csch; maybe we should already do that for
ssch. (Like the -EINVAL logic I described in the other thread.)


>  
>  	private = dev_get_drvdata(mdev_parent_dev(mdev));
>  
>  	if (index >= VFIO_CCW_NUM_REGIONS + private->num_regions)
> -		return -EINVAL;
> +		goto end;
>  
>  	switch (index) {
>  	case VFIO_CCW_CONFIG_REGION_INDEX:
> -		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
> +		ret = vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
> +		break;
>  	default:
>  		index -= VFIO_CCW_NUM_REGIONS;
> -		return private->region[index].ops->write(private, buf, count,
> +		ret = private->region[index].ops->write(private, buf, count,
>  							 ppos);
> +		break;
>  	}
>  
> -	return -EINVAL;
> +end:
> +	atomic_dec(&serialize);
> +	return ret;
>  }
>  
>  static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info,

