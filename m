Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C78EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD92083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BD92083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeGZKLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:11:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:52026 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbeGZKLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:11:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 01:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="scan'208";a="74658209"
Received: from taolv-mobl.ccr.corp.intel.com ([10.249.169.42])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2018 01:55:10 -0700
Message-ID: <1532595308.2358.45.camel@intel.com>
Subject: Re: [PATCH] drivers: thermal: do not clobber cooling dev state from
 userspace
From:   Zhang Rui <rui.zhang@intel.com>
To:     Lina Iyer <ilina@codeaurora.org>, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Date:   Thu, 26 Jul 2018 16:55:08 +0800
In-Reply-To: <20180507175505.2389-1-ilina@codeaurora.org>
References: <20180507175505.2389-1-ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2018-05-07 at 11:55 -0600, Lina Iyer wrote:
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> Let userspace be another voter for cooling device state instead of
> the
> overriding authority. It is possible that the thermal governor may
> find
> a higher cooling state desirable than what is recommended by the
> userspace. Separate out the current cooling device state from the
> userspace request and aggregate the userspace request with the
> governors' recommendation.
> 

hmmm, I don't understand this.
If the governor does not work well, we should either improve the
governor or use userspace governor instead.
do you have any examples that the kernel governor chooses improper
cooling state?

thanks,
rui

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/thermal/thermal_core.c    | 1 +
>  drivers/thermal/thermal_helpers.c | 2 +-
>  drivers/thermal/thermal_sysfs.c   | 8 +++++++-
>  include/linux/thermal.h           | 1 +
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 589925ac0994..c2e13e122934 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -970,6 +970,7 @@ __thermal_cooling_device_register(struct
> device_node *np,
>  	cdev->updated = false;
>  	cdev->device.class = &thermal_class;
>  	cdev->devdata = devdata;
> +	cdev->sysfs_req = 0;
>  	thermal_cooling_device_setup_sysfs(cdev);
>  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>  	result = device_register(&cdev->device);
> diff --git a/drivers/thermal/thermal_helpers.c
> b/drivers/thermal/thermal_helpers.c
> index 2ba756af76b7..f550fdee0f9b 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -166,7 +166,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  {
>  	struct thermal_instance *instance;
> -	unsigned long target = 0;
> +	unsigned long target = cdev->sysfs_req;
>  
>  	mutex_lock(&cdev->lock);
>  	/* cooling device is updated*/
> diff --git a/drivers/thermal/thermal_sysfs.c
> b/drivers/thermal/thermal_sysfs.c
> index 275ffee292bf..eddada715ad2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -719,7 +719,13 @@ thermal_cooling_device_cur_state_store(struct
> device *dev,
>  	result = cdev->ops->set_cur_state(cdev, state);
>  	if (result)
>  		return result;
> -	thermal_cooling_device_stats_update(cdev, state);
> +
> +	cdev->sysfs_req = state;
> +	mutex_lock(&cdev->lock);
> +	cdev->updated = false;
> +	mutex_unlock(&cdev->lock);
> +	thermal_cdev_update(cdev);
> +
>  	return count;
>  }
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5f4705f46c2f..7a133bd6ff86 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -139,6 +139,7 @@ struct thermal_cooling_device {
>  	struct mutex lock; /* protect thermal_instances list */
>  	struct list_head thermal_instances;
>  	struct list_head node;
> +	unsigned long sysfs_req;
>  };
>  
>  struct thermal_attr {
