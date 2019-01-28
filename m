Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D6D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbfA1QbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:31:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:36976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfA1QbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:31:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 08:31:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="133802915"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2019 08:31:11 -0800
Message-ID: <8a28b7eafc81f693fa1a580c70a1f9465818eb86.camel@linux.intel.com>
Subject: Re: [RFC PATCH v2] async: Add cmdline option to specify drivers to
 be async probed
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 28 Jan 2019 08:31:11 -0800
In-Reply-To: <1548638416-96859-1-git-send-email-feng.tang@intel.com>
References: <1548638416-96859-1-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 09:20 +0800, Feng Tang wrote:
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
>  drivers/base/dd.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8ac10af..cfa704a 100644
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
> @@ -674,8 +678,27 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>  	return ret;
>  }
>  
> +static inline bool cmdline_requested_async_probing(const char *drv_name)
> +{
> +	return parse_option_str(async_probe_drv_names, drv_name);
> +}
> +
> +/* The format is like driver_async_probe=drv_name1,drv_name2,drv_name3 */
> +static int __init save_async_options(char *buf)
> +{
> +	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
> +		printk(KERN_WARNING "Too long list for async_probe_drv_names!");
> +
> +	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
> +	return 0;
> +}
> +__setup("driver_async_probe=", save_async_options);
> +
>  bool driver_allows_async_probing(struct device_driver *drv)
>  {
> +	if (cmdline_requested_async_probing(drv->name))
> +		return true;
> +

This piece still should be moved. Ideally it should be down in the
"default" case area we use to determine if the module parameter
async_probe was used or not. Where you currently have this will
overrride the driver behavior if it absolutely cannot use an
asynchronous probe.

>  	switch (drv->probe_type) {
>  	case PROBE_PREFER_ASYNCHRONOUS:
>  		return true;

