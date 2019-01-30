Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8DBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IiFOUicY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfA3Q16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:27:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfA3Q15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GP4veJbR/d4zCc4CwvjvsDCj9ysdKGcY28xfpoDweuM=; b=IiFOUicYM1HCSIB/D7JORAZvR
        j+PjU52YlZg0UQY2PewG7yXbVZkebxrBvsx/4+LR8gYDIXEApQM7heLdKxCJ99x+OEd7e8F8KvnW9
        YcNlX2XnOj+1hgQzGbTMpjq9OQGwGWM9XEw00VLS7wN2I6kel4DEm4U7NbKir5wngEejdNIHTzTDx
        YxoFK8VU6HI7sW5e7eoRvKjd04DMFWw7sVoDzGCKtvpBXgmUL62MptM1l0d4AQDG0ucsvTD1FZl46
        GEJL5ff8DGPd5cQKQhZJlqFPfPpzaYRqEbSp8kp9x1YEWcWur9kP5xuDK6tvXWjR2WYVMQTREV5XQ
        E5KoaleYQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gosiS-0007KW-EJ; Wed, 30 Jan 2019 16:27:56 +0000
Subject: Re: [PATCH v3] async: Add cmdline option to specify drivers to be
 async probed
To:     Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <1548832991-31718-1-git-send-email-feng.tang@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <83b02a21-2415-4b22-9e46-b94a69f6ddf5@infradead.org>
Date:   Wed, 30 Jan 2019 08:27:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1548832991-31718-1-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 11:23 PM, Feng Tang wrote:
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
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
>   v3: 
>      move the cmdline_requested_async_probing() into "default:"
>      part to enforce the PROBE_FORCE_SYNCHRONOUS check, as suggested
>      by Alexander Duyck
>     
>   v2:
>     * change Alexander Duyck's email to alexander.h.duyck@linux.intel.com
>     * fix the parameter for strlcpy()
> 
>  drivers/base/dd.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8ac10af..e99d781 100644
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
> @@ -674,6 +678,22 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>  	return ret;
>  }
>  
> +static inline bool cmdline_requested_async_probing(const char *drv_name)
> +{
> +	return parse_option_str(async_probe_drv_names, drv_name);
> +}
> +
> +/* The format is like driver_async_probe=drv_name1,drv_name2,drv_name3 */

Please document this boot option in Documentation/admin-guide/kernel-parameters.txt.

> +static int __init save_async_options(char *buf)
> +{
> +	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
> +		printk(KERN_WARNING "Too long list for async_probe_drv_names!\n");

use the correct cmdline option name here.  E.g.:
		printk(KERN_WARNING "Too long list of driver names for 'driver_async_probe'\n");

> +
> +	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
> +	return 0;
> +}
> +__setup("driver_async_probe=", save_async_options);
> +
>  bool driver_allows_async_probing(struct device_driver *drv)
>  {
>  	switch (drv->probe_type) {
> @@ -684,6 +704,9 @@ bool driver_allows_async_probing(struct device_driver *drv)
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


-- 
~Randy
