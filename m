Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeECRAq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:00:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33325 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:00:44 -0400
X-Google-Smtp-Source: AB8JxZqVPFVqeMzeUGTXxWQ/3kVR4RL60V7iRY2ayJ4UQg2K/cVK+lbEmT04oEERfLOGmKNVqWktyA==
Date: Thu, 3 May 2018 11:00:40 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 03/27] coresight: Add helper device type
Message-ID: <20180503170040.GA11425@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-4-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-4-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:33AM +0100, Suzuki K Poulose wrote:
> Add a new coresight device type, which do not belong to any
> of the existing types, i.e, source, sink, link etc. A helper
> device could be connected to a coresight device, which could
> augment the functionality of the coresight device.
> 
> This is intended to cover Coresight Address Translation Unit (CATU)
> devices, which provide improved Scatter Gather mechanism for TMC
> ETR. The idea is that the helper device could be controlled by
> the driver of the device it is attached to (in this case ETR),
> transparent to the generic coresight driver (and paths).
> 
> The operations include enable(), disable(), both of which could
> accept a device specific "data" which the driving device and
> the helper device could share. Since they don't appear in the
> coresight "path" tracked by software, we have to ensure that
> they are powered up/down whenever the master device is turned
> on.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 46 ++++++++++++++++++++++++++++++---
>  include/linux/coresight.h               | 24 +++++++++++++++++
>  2 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 389c4ba..fd0251e 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -430,6 +430,43 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
>  	return dev ? to_coresight_device(dev) : NULL;
>  }
>  
> +/*
> + * coresight_prepare_device - Prepare this device and any of the helper
> + * devices connected to it for trace operation. Since the helper devices
> + * don't appear on the trace path, they should be handled along with the
> + * the master device.
> + */
> +static void coresight_prepare_device(struct coresight_device *csdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < csdev->nr_outport; i++) {
> +		struct coresight_device *child = csdev->conns[i].child_dev;
> +
> +		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
> +			pm_runtime_get_sync(child->dev.parent);
> +	}
> +
> +	pm_runtime_get_sync(csdev->dev.parent);
> +}
> +
> +/*
> + * coresight_release_device - Release this device and any of the helper
> + * devices connected to it for trace operation.
> + */
> +static void coresight_release_device(struct coresight_device *csdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < csdev->nr_outport; i++) {
> +		struct coresight_device *child = csdev->conns[i].child_dev;
> +
> +		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
> +			pm_runtime_put(child->dev.parent);
> +	}

There is a newline here in coresight_prepare_device().  Either add one (or not)
in both function but please be consistent. 

> +	pm_runtime_put(csdev->dev.parent);
> +}
> +
>  /**
>   * _coresight_build_path - recursively build a path from a @csdev to a sink.
>   * @csdev:	The device to start from.
> @@ -480,8 +517,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
>  
>  	node->csdev = csdev;
>  	list_add(&node->link, path);
> -	pm_runtime_get_sync(csdev->dev.parent);
> -
> +	coresight_prepare_device(csdev);

There was a newline between pm_runtime_get_sync() and the return statement in
the original code.

>  	return 0;
>  }
>  
> @@ -524,7 +560,7 @@ void coresight_release_path(struct list_head *path)
>  	list_for_each_entry_safe(nd, next, path, link) {
>  		csdev = nd->csdev;
>  
> -		pm_runtime_put_sync(csdev->dev.parent);
> +		coresight_release_device(csdev);
>  		list_del(&nd->link);
>  		kfree(nd);
>  	}
> @@ -775,6 +811,10 @@ static struct device_type coresight_dev_type[] = {
>  		.name = "source",
>  		.groups = coresight_source_groups,
>  	},
> +	{
> +		.name = "helper",
> +	},
> +

Extra newline.

>  };
>  
>  static void coresight_device_release(struct device *dev)
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 556fe59..5e926f7 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -47,6 +47,7 @@ enum coresight_dev_type {
>  	CORESIGHT_DEV_TYPE_LINK,
>  	CORESIGHT_DEV_TYPE_LINKSINK,
>  	CORESIGHT_DEV_TYPE_SOURCE,
> +	CORESIGHT_DEV_TYPE_HELPER,
>  };
>  
>  enum coresight_dev_subtype_sink {
> @@ -69,6 +70,10 @@ enum coresight_dev_subtype_source {
>  	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
>  };
>  
> +enum coresight_dev_subtype_helper {
> +	CORESIGHT_DEV_SUBTYPE_HELPER_NONE,
> +};
> +
>  /**
>   * union coresight_dev_subtype - further characterisation of a type
>   * @sink_subtype:	type of sink this component is, as defined
> @@ -77,6 +82,8 @@ enum coresight_dev_subtype_source {
>   *			by @coresight_dev_subtype_link.
>   * @source_subtype:	type of source this component is, as defined
>   *			by @coresight_dev_subtype_source.
> + * @helper_subtype:	type of helper this component is, as defined
> + *			by @coresight_dev_subtype_helper.
>   */
>  union coresight_dev_subtype {
>  	/* We have some devices which acts as LINK and SINK */
> @@ -85,6 +92,7 @@ union coresight_dev_subtype {
>  		enum coresight_dev_subtype_link link_subtype;
>  	};
>  	enum coresight_dev_subtype_source source_subtype;
> +	enum coresight_dev_subtype_helper helper_subtype;
>  };
>  
>  /**
> @@ -181,6 +189,7 @@ struct coresight_device {
>  #define source_ops(csdev)	csdev->ops->source_ops
>  #define sink_ops(csdev)		csdev->ops->sink_ops
>  #define link_ops(csdev)		csdev->ops->link_ops
> +#define helper_ops(csdev)	csdev->ops->helper_ops
>  
>  /**
>   * struct coresight_ops_sink - basic operations for a sink
> @@ -240,10 +249,25 @@ struct coresight_ops_source {
>  			struct perf_event *event);
>  };
>  
> +/**
> + * struct coresight_ops_helper - Operations for a helper device.
> + *
> + * All operations could pass in a device specific data, which could
> + * help the helper device to determine what to do.
> + *
> + * @enable	: Turn the device ON.
> + * @disable	: Turn the device OFF.

There is a discrepancy between the comment and the operations, i.e enabling a
device is not synonymous of turning it on.  Looking at patch 04/27 the ops is
called in tmc_etr_enable/disable_catu() so the comment propably needs to be
changed.

> + */
> +struct coresight_ops_helper {
> +	int (*enable)(struct coresight_device *csdev, void *data);
> +	int (*disable)(struct coresight_device *csdev, void *data);
> +};
> +
>  struct coresight_ops {
>  	const struct coresight_ops_sink *sink_ops;
>  	const struct coresight_ops_link *link_ops;
>  	const struct coresight_ops_source *source_ops;
> +	const struct coresight_ops_helper *helper_ops;
>  };
>  
>  #ifdef CONFIG_CORESIGHT
> -- 
> 2.7.4
> 
