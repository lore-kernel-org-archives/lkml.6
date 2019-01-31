Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E388BC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36CD218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioXCiIEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfAaC5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:57:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaC5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9rP+4Z3bu1HQ/xilvRi3Z94Tm2WtM+GDdtlvIVuzDMQ=; b=ioXCiIELgXELZIEcJq7wImFyu
        /aFCNJ4qZ9zPfGasoGJo6Kov46m7N2OTvTOhQ2W17RPJF0Lzc7dU5AR8//qJohu0VxkEA5WFln7EH
        TUbwSeLKtnSeuf5oH8a03EYjIH85+lVgRp+4mOUBQSXO0tsFgUjjyZqJ5UsX0EO5l0W9KHkOLUfFM
        WrQEqwQ0wfagQhUs1iP3CP7LUvmvZWx2kgfZckI0+LSUHa8r8nS2dYzxBqKfEbchwMb/Ymgu1yS/H
        23KeI13J2ZJq5j5noMM3OnRpGW02c9kl+twfXjnHD7asFdLc5HdagKOFsVCMj4vRtdNc3NJapR7/+
        +Pag8TuZw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gp2XO-0007nL-Ca; Thu, 31 Jan 2019 02:57:10 +0000
Subject: Re: [PATCH v4] async: Add cmdline option to specify drivers to be
 async probed
To:     Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <1548902630-5550-1-git-send-email-feng.tang@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <42751145-b630-7c04-7bba-ee58838449b9@infradead.org>
Date:   Wed, 30 Jan 2019 18:57:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1548902630-5550-1-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 6:43 PM, Feng Tang wrote:
> Asynchronous driver probing can help much on kernel fastboot, and
> this option can provide a flexible way to optimize and quickly verify
> async driver probe.
> 
> Also it will help in below cases:
> * Some driver actually covers several families of HWs, some of which
>   could use async probing while others don't. So we can't simply
>   turn on the PROBE_PREFER_ASYNCHRONOUS flag in driver, but use this
>   cmdline option, like igb driver async patch discussed at
>   https://www.spinics.net/lists/netdev/msg545986.html
> 
> * For SOC (System on Chip) with multiple spi or i2c controllers, most
>   of the slave spi/i2c devices will be assigned with fixed controller
>   number, while async probing may make those controllers get different
>   index for each boot, which prevents those controller drivers to be
>   async probed. For platforms not using these spi/i2c slave devices,
>   they can use this cmdline option to benefit from the async probing.
> 
> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
>   v4:
>      Add description to kernel-parameters.txt and refine the

The doc update looks good, but I don't really see the refinement of
the printk message.  It still contains the incorrect cmdline option name.


>      prink message, as suggested by Randy Dunlap 
> 
>   v3: 
>      move the cmdline_requested_async_probing() into "default:"
>      part to enforce the PROBE_FORCE_SYNCHRONOUS check, as suggested
>      by Alexander Duyck
>     
>   v2:
>     * change Alexander Duyck's email to alexander.h.duyck@linux.intel.com
>     * fix the parameter for strlcpy()
> 
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  drivers/base/dd.c                               | 24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b799bcf..a5b2112 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -910,6 +910,10 @@
>  			The filter can be disabled or changed to another
>  			driver later using sysfs.
>  
> +	driver_async_probe=  [KNL]
> +			List of driver names to be probed asynchronously.
> +			Format: <driver_name1>,<driver_name2>...
> +
>  	drm.edid_firmware=[<connector>:]<file>[,[<connector>:]<file>]
>  			Broken monitors, graphic adapters, KVMs and EDIDless
>  			panels may send no or incorrect EDID data sets.
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8ac10af..279204a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -57,6 +57,10 @@ static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>  static struct dentry *deferred_devices;
>  static bool initcalls_done;
>  
> +/* Save the async probe drivers' name from kernel cmdline */
> +#define ASYNC_DRV_NAMES_MAX_LEN	256
> +static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
> +
>  /*
>   * In some cases, like suspend to RAM or hibernation, It might be reasonable
>   * to prohibit probing of devices as it could be unsafe.
> @@ -674,6 +678,23 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>  	return ret;
>  }
>  
> +static inline bool cmdline_requested_async_probing(const char *drv_name)
> +{
> +	return parse_option_str(async_probe_drv_names, drv_name);
> +}
> +
> +/* The option format is "driver_async_probe=drv_name1,drv_name2,..." */
> +static int __init save_async_options(char *buf)
> +{
> +	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
> +		printk(KERN_WARNING
> +			"Too long list of driver names for 'async_probe_drv_names'!\n");

			should be 'driver_async_probe'

> +
> +	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
> +	return 0;
> +}
> +__setup("driver_async_probe=", save_async_options);
> +
>  bool driver_allows_async_probing(struct device_driver *drv)
>  {
>  	switch (drv->probe_type) {
> @@ -684,6 +705,9 @@ bool driver_allows_async_probing(struct device_driver *drv)
>  		return false;
>  
>  	default:
> +		if (cmdline_requested_async_probing(drv->name))
> +			return true;
> +
>  		if (module_requested_async_probing(drv->owner))
>  			return true;
>  
> 

thanks.
-- 
~Randy
