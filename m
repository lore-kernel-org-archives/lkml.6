Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21575C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D923B20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D923B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLAKvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:51:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43599 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLAKvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:51:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so3519754plb.10;
        Fri, 30 Nov 2018 15:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhtcqDUtZnEt1PTKMMrCEMSGSWbtqD1Y6fazSQf4ytU=;
        b=AH7CT/A8DuBnfwgpS5fxEGMR3mPAOFGcoUaln4fBFiJjwrc3v4WIbLa4pYKf/unze3
         s6GDCJ5f6V1fcjCvMs1V0PMesh9afcwtajhzwZcPKu7c9CElbtNylJMOFlc13lGNjKuQ
         JXAdjCSK73UwtAkq1Srvmxlz1FUOLcM32Ojm+aHFB2+sk2xhQC4JJPnHoLkgroIh2wn5
         FRKsHP4CrKBqhWUX6d4nJBBRjVlVkG5kdxT2ZrTx7HpJK6Qj7dCO7I7GVTUePXDrmgFR
         O5hbQAgJZbG8QeoSLWKiITeakvU8Kuk154ehQFunHNqt6G67Ll3UFufyNryXkql5oM4R
         ENdA==
X-Gm-Message-State: AA+aEWZl2efubAJ+OmcQY3NSpq0HRBDSJO+X6z4jtfaXssivH+a67r3b
        tXbwRYGj157d4EQC+w4oNqs=
X-Google-Smtp-Source: AFSGD/WXJGHaYjTdmo1R74nMmXE46zh11EQic/5vaSKpDuQPDxEqHjKRrwBk1YZFBxlysoXnzb48gQ==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63-v6mr7547004plb.241.1543621241665;
        Fri, 30 Nov 2018 15:40:41 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id c4sm18132190pfm.151.2018.11.30.15.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:40:40 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 15:40:38 -0800
Date:   Fri, 30 Nov 2018 15:40:38 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        dmitry.torokhov@gmail.com, brendanhiggins@google.com
Subject: Re: [driver-core PATCH v7 2/9] driver core: Establish clear order of
 operations for deferred probe and remove
Message-ID: <20181130234038.GF28501@garbanzo.do-not-panic.com>
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:32:16PM -0800, Alexander Duyck wrote:
> Add an additional bit flag to the device struct named async_probe. This
> additional flag allows us to guarantee ordering between probe and remove
> operations.
> 
> This allows us to guarantee that if we execute a remove operation on a
> given interface it will not attempt to update the driver member
> asynchronously following the earlier operation. Previously this guarantee
> was not present and could result in us attempting to remove a driver from
> an interface only to have it attempt to attach the driver later when we
> finally complete the deferred asynchronous probe call.
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

This is the sort of corner case that is best if we had a test case for
it, as it is hard to reproduce and -- how do we know we won't regress
later? Not sure if it helps but we have lib/test_kmod.c and its
respective tools/testing/selftests/kmod/kmod.sh, a new enum kmod_test_case
might be in order for device emulation creeping up / disappearing
during a custom mock driver using async probe.

Yeah.. I know.. "yes this seems good but how about later"? While we're going
through the motions here and have your attention on this I think it
would be valuable for this now. This is the sort of code that won't
change often, but if modified *can* really break things badly.

  Luis

> ---
>  drivers/base/dd.c      |   16 ++++++++++++++++
>  include/linux/device.h |    3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 88713f182086..ef3f70a7cb5a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -774,6 +774,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>  
>  	device_lock(dev);
>  
> +	/* nothing to do if async_probe has been cleared */
> +	if (!dev->async_probe)
> +		goto out_unlock;
> +
>  	if (dev->parent)
>  		pm_runtime_get_sync(dev->parent);
>  
> @@ -785,6 +789,9 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>  	if (dev->parent)
>  		pm_runtime_put(dev->parent);
>  
> +	/* We made our attempt at an async_probe, clear the flag */
> +	dev->async_probe = false;
> +out_unlock:
>  	device_unlock(dev);
>  
>  	put_device(dev);
> @@ -829,6 +836,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>  			 */
>  			dev_dbg(dev, "scheduling asynchronous probe\n");
>  			get_device(dev);
> +			dev->async_probe = true;
>  			async_schedule(__device_attach_async_helper, dev);
>  		} else {
>  			pm_request_idle(dev);
> @@ -929,6 +937,14 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  {
>  	struct device_driver *drv;
>  
> +	/*
> +	 * In the event that we are asked to release the driver on an
> +	 * interface that is still waiting on a probe we can just terminate
> +	 * the probe by setting async_probe to false. When the async call
> +	 * is finally completed it will see this state and just exit.
> +	 */
> +	dev->async_probe = false;
> +
>  	drv = dev->driver;
>  	if (drv) {
>  		while (device_links_busy(dev)) {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1b25c7a43f4c..4d2eb2c74149 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -957,6 +957,8 @@ struct dev_links_info {
>   *              device.
>   * @dma_coherent: this particular device is dma coherent, even if the
>   *		architecture supports non-coherent devices.
> + * @async_probe: This device has an asynchronous probe event pending. Should
> + *		 only be updated while holding device lock.
>   *
>   * At the lowest level, every device in a Linux system is represented by an
>   * instance of struct device. The device structure contains the information
> @@ -1051,6 +1053,7 @@ struct device {
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>  	bool			dma_coherent:1;
>  #endif
> +	bool			async_probe:1;
>  };
>  
>  static inline struct device *kobj_to_dev(struct kobject *kobj)
> 
