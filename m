Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEFFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6902C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfBSJWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:22:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfBSJWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:22:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC17B9D43D;
        Tue, 19 Feb 2019 09:22:11 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDB45102495F;
        Tue, 19 Feb 2019 09:22:06 +0000 (UTC)
Date:   Tue, 19 Feb 2019 10:22:04 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Message-ID: <20190219102204.5e050b76.cohuck@redhat.com>
In-Reply-To: <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
        <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 19 Feb 2019 09:22:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 19:08:48 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Libudev relies on having a subsystem link for non-root devices. To
> avoid libudev (and potentially other userspace tools) choking on the
> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
> bus subsytem, and make the matrix device reside within it.
> 
> Doing this we need to suppress the forced link from the matrix device to
> the vfio_ap driver and we suppress the device_type we do not need

s/suppress/remove/ ?

> anymore.
> 
> Since the associated matrix driver is not the vfio_ap driver any more,
> we have to change the search for the devices on the vfio_ap driver in
> the function vfio_ap_verify_queue_reserved.
> 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 48 +++++++++++++++++++++++++++++------
>  drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
>  drivers/s390/crypto/vfio_ap_private.h |  1 +
>  3 files changed, 43 insertions(+), 10 deletions(-)

(...)

> @@ -62,6 +58,27 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>  	kfree(matrix_dev);
>  }
>  
> +static int matrix_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	return 1;
> +}
> +
> +static struct bus_type matrix_bus = {
> +	.name = "vfio_ap",
> +	.match = &matrix_bus_match,
> +};
> +
> +static int matrix_probe(struct device *dev)
> +{
> +	return 0;
> +}

I don't think you need this (the important function is the match
function of the bus).

> +
> +static struct device_driver matrix_driver = {
> +	.name = "vfio_ap",
> +	.bus = &matrix_bus,
> +	.probe = matrix_probe,
> +};
> +
>  static int vfio_ap_matrix_dev_create(void)
>  {
>  	int ret;

It's a bit annoying that we need to introduce a bus that basically does
nothing, but I think this looks sane.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
