Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B02C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EFD2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfA3Xqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:46:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57465 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Xqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:46:51 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id c04a275bb1e7ccb6; Thu, 31 Jan 2019 00:46:48 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org
Subject: Re: [driver-core PATCH v10 6/9] driver core: Attach devices on CPU local to device node
Date:   Thu, 31 Jan 2019 00:45:42 +0100
Message-ID: <2520015.o9hhCCUgSl@aspire.rjw.lan>
In-Reply-To: <154818237710.18753.13303508368380513033.stgit@ahduyck-desk1.amr.corp.intel.com>
References: <154818223154.18753.12374915684623789884.stgit@ahduyck-desk1.amr.corp.intel.com> <154818237710.18753.13303508368380513033.stgit@ahduyck-desk1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 22, 2019 7:39:37 PM CET Alexander Duyck wrote:
> Call the asynchronous probe routines on a CPU local to the device node. By
> doing this we should be able to improve our initialization time
> significantly as we can avoid having to access the device from a remote
> node which may introduce higher latency.
> 
> For example, in the case of initializing memory for NVDIMM this can have a
> significant impact as initialing 3TB on remote node can take up to 39
> seconds while initialing it on a local node only takes 23 seconds. It is
> situations like this where we will see the biggest improvement.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/dd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 627ad05064e0..aa6a9c613595 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -829,7 +829,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>  			 */
>  			dev_dbg(dev, "scheduling asynchronous probe\n");
>  			get_device(dev);
> -			async_schedule(__device_attach_async_helper, dev);
> +			async_schedule_dev(__device_attach_async_helper, dev);
>  		} else {
>  			pm_request_idle(dev);
>  		}
> @@ -989,7 +989,7 @@ static int __driver_attach(struct device *dev, void *data)
>  		if (!dev->driver) {
>  			get_device(dev);
>  			dev->p->async_driver = drv;
> -			async_schedule(__driver_attach_async_helper, dev);
> +			async_schedule_dev(__driver_attach_async_helper, dev);
>  		}
>  		device_unlock(dev);
>  		return 0;
> 
> 


