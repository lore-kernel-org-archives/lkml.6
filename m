Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E2EC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4F3214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J09R1/mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfAJOGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:06:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38838 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfAJOGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:06:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so11517182wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AWhpHOEy3v6G0eytnKzs/Yz2CF/vG//hg8bPK7OjwSM=;
        b=J09R1/mntx7M829pVJt7Wzoavzq4OgUPB5qIoY5etbUsIz6AYtldFTO2PWOTnxtx0q
         ajrrPwHTFy0bI+sbc8Gz0a6FAfjjvSAxTNIoO/mHYWUUcTpqLyzB+jA5MmGsAet3W7rO
         9VN7MDOSQCaoD6b9dE2S8WWxvPQRseh6ZwDd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AWhpHOEy3v6G0eytnKzs/Yz2CF/vG//hg8bPK7OjwSM=;
        b=fiKtsfj4UoW23Mkk/Zt9uxaS1nQE4filvKdZhwWNu7NIwzSAwiQ/y06/qjRc2hega3
         9Vjnw5jtGJTt3L0gdrxxSa+PlIiavL9kb3sXzMMnkHutoa2zrYetFG3zwYhGXoJFMPHq
         KlJ+lVGuyIeZMJr2MP2hSCcSY5qs94ww1hOARBtxzEXKw8PcuxG6cvT9FZYjS4JVd+Tl
         q9DkBl+/SfOZ8MpopXGPqKQ7t5H1Z2oJ0NFH+ocoqx/mF3Q4ARxrBxj1DdJlXriFHyr5
         oigIVsU5Bf+eN5vjdVTh7AQ61zzqLrAW2RHz6GRcxXMRreu5O1OXmvrrbSVGiNw19DO+
         B/Qg==
X-Gm-Message-State: AJcUukcKW8w7lYjJrSVoREx7uMMBUE1A8Xk+rLWFkLz3wicFEZ0lulwy
        qlU7vVT/vvl7w16lpqMczInK9Q==
X-Google-Smtp-Source: ALg8bN7gUOyxcngaMkwxQhi/7f1OwiDAoyJchyu5CP4G4W5XSFobqmigVgizHpkVxDswNnKS+EbHKQ==
X-Received: by 2002:adf:b102:: with SMTP id l2mr9087309wra.296.1547129193264;
        Thu, 10 Jan 2019 06:06:33 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n5sm61098599wrr.94.2019.01.10.06.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:06:32 -0800 (PST)
Date:   Thu, 10 Jan 2019 14:06:30 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, jens.wiklander@linaro.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v2 1/4] tee: add bus driver framework for TEE based
 devices
Message-ID: <20190110140630.js7mrhu6nfnjsfhx@holly.lan>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547123097-16431-2-git-send-email-sumit.garg@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:54:54PM +0530, Sumit Garg wrote:
> Introduce a generic TEE bus driver concept for TEE based kernel drivers
> which would like to communicate with TEE based devices/services.
> 
> In this TEE bus concept, devices/services are identified via Universally
> Unique Identifier (UUID) and drivers register a table of device UUIDs
> which they can support.
> 
> So this TEE bus framework registers a match() callback function which
> iterates over the driver UUID table to find a corresponding match for
> device UUID. If a match is found, then this particular device is probed
> via corresponding probe api registered by the driver. This process
> happens whenever a device or a driver is registered with TEE bus.
> 
> Also this framework allows for device enumeration to be specific to
> corresponding TEE implementation like OP-TEE etc.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_core.c  | 41 ++++++++++++++++++++++++++++++++++++++---
>  include/linux/tee_drv.h | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 7b2bb4c..9ddb89e 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -15,7 +15,6 @@
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
>  #include <linux/cdev.h>
> -#include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
>  #include <linux/module.h>
> @@ -1027,6 +1026,30 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  }
>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>  
> +static int tee_client_device_match(struct device *dev,
> +				   struct device_driver *drv)
> +{
> +	struct tee_client_device *tee_device;
> +	const struct tee_client_device_id *id_table;
> +
> +	tee_device = to_tee_client_device(dev);
> +	id_table = to_tee_client_driver(drv)->id_table;
> +
> +	while (!uuid_is_null(&id_table->uuid)) {
> +		if (uuid_equal(&tee_device->id.uuid, &id_table->uuid))
> +			return 1;
> +		id_table++;
> +	}
> +
> +	return 0;
> +}
> +
> +struct bus_type tee_bus_type = {
> +	.name		= "tee",
> +	.match		= tee_client_device_match,
> +};
> +EXPORT_SYMBOL_GPL(tee_bus_type);
> +
>  static int __init tee_init(void)
>  {
>  	int rc;
> @@ -1040,10 +1063,21 @@ static int __init tee_init(void)
>  	rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
>  	if (rc) {
>  		pr_err("failed to allocate char dev region\n");
> -		class_destroy(tee_class);
> -		tee_class = NULL;
> +		goto class_err;
>  	}
>  
> +	rc = bus_register(&tee_bus_type);
> +	if (rc) {
> +		pr_err("failed to register tee bus\n");
> +		goto class_err;

There is an unregister_chrdev_region() in tee_exit(). Why isn't it
needed on this error path?


> +	}
> +
> +	return 0;
> +
> +class_err:
> +	class_destroy(tee_class);
> +	tee_class = NULL;
> +
>  	return rc;
>  }
>  
> @@ -1052,6 +1086,7 @@ static void __exit tee_exit(void)
>  	class_destroy(tee_class);
>  	tee_class = NULL;
>  	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> +	bus_unregister(&tee_bus_type);
>  }
>  
>  subsys_initcall(tee_init);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6cfe058..ed16bf1 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -20,6 +20,8 @@
>  #include <linux/kref.h>
>  #include <linux/list.h>
>  #include <linux/tee.h>
> +#include <linux/device.h>
> +#include <linux/uuid.h>
>  
>  /*
>   * The file describes the API provided by the generic TEE driver to the
> @@ -538,4 +540,38 @@ static inline bool tee_param_is_memref(struct tee_param *param)
>  	}
>  }
>  
> +extern struct bus_type tee_bus_type;
> +
> +/**
> + * struct tee_client_device_id - tee based device identifier
> + * @uuid:		For TEE based client devices we use the device uuid
> + *			as the identifier.
> + */
> +struct tee_client_device_id {
> +	uuid_t uuid;
> +};
> +
> +/**
> + * struct tee_client_device - tee based device
> + * @id:			device identifier
> + * @dev:		device structure
> + */
> +struct tee_client_device {
> +	struct tee_client_device_id id;
> +	struct device dev;
> +};
> +#define to_tee_client_device(d) container_of(d, struct tee_client_device, dev)
> +
> +/**
> + * struct tee_client_driver - tee client driver
> + * @id_table:		device id table supported by this driver
> + * @driver:		driver structure
> + */
> +struct tee_client_driver {
> +	const struct tee_client_device_id *id_table;
> +	struct device_driver driver;
> +};
> +#define to_tee_client_driver(d) \
> +		container_of(d, struct tee_client_driver, driver)
> +
>  #endif /*__TEE_DRV_H*/
> -- 
> 2.7.4
> 
