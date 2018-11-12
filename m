Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F38C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16AA22503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XoDMSQ0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16AA22503
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeKMCFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:05:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44990 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbeKMCFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:05:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wACGAAbD106963;
        Mon, 12 Nov 2018 10:10:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542039010;
        bh=hsacxEV7gV1I+hq2/3gYzVn2UKx46GiCTm5zjjB2MSw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XoDMSQ0BgtDRWFH3x2VpKcxt7WMr3/QK6Jkw0zFIrdkph5D2T7PlBmYoBiWzsobre
         sRGEqSTQHGt8e27NqytRE16XlXjPJu6S10KCSP7H1riORUQoNoFl9ZikF3Wct7Y3A9
         kVUuOB1LiaV3gNX2BkJKqzzjjRXmuQt50IplR0aY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wACGA9TJ081832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 10:10:09 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 12
 Nov 2018 10:10:09 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 12 Nov 2018 10:10:09 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wACGA4EU006195;
        Mon, 12 Nov 2018 10:10:05 -0600
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        <linux-omap@vger.kernel.org>, Darren Hart <dvhart@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Grant Likely <grant.likely@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com>
Date:   Mon, 12 Nov 2018 18:11:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018-11-10 20:10, Andy Shevchenko wrote:
> Consider the following scenario.
> 
> There are two independent devices coupled together by functional dependencies:
>  - USB OTG (dwc3-pci)
>  - extcon (tested with extcon-intel-mrfld, not yet in upstream)
> 
> Each of the driver services a corresponding device is built as a module. In the
> Buildroot environment the modules are probed by alphabetical ordering of their
> modaliases. The latter comes to the case when USB OTG driver will be probed
> first followed by extcon one.
> 
> So, if the platform anticipates extcon device to be appeared, in the above case
> we will get deferred probe of USB OTG, because of ordering.
> 
> Now, a cherry on top of the cake, the deferred probing list contains
> the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
> values in the local_trigger_count and deferred_trigger_count are not the same,
> and thus provokes deferred probe triggering again and again.
> 
> ...
> [   20.678332] platform dwc3.0.auto: Retrying from deferred list
> [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.701254] platform dwc3.0.auto: Added to deferred list
> [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
> [   20.713732] platform dwc3.0.auto: Retrying from deferred list
> [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.736540] platform dwc3.0.auto: Added to deferred list
> [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
> [   20.748991] platform dwc3.0.auto: Retrying from deferred list
> [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.771914] platform dwc3.0.auto: Added to deferred list
> [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
> ...
> 
> Deeper investigation shows the culprit commit 58b116bce136
> ("drivercore: deferral race condition fix") which was dedicated to fix some
> other issue while bringing a regression.
> 
> This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
> we will have better solution.

if we revert the commit then the original issue will re-surfaces. afaik
it was not only audio which hit the 'last driver to be probed from the
deferred list would never probe, unless we provoke the kernel to load
additional module, or remove/reload the module' issue.

Do I understand correctly that in your case you have two modules
(dwc3-pci and extcon-intel-mrfld) in a deferred probe loop, iow both of
the drivers returns -EPROBE_DEFER and they just spin?

If both is deferring, how this supposed to work?

If we revert 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835, then you might be
hitting the very same issue as described by the commit:
s/davinci_evm sound.3/dwc3-pci
s/davinci-mcasp 4803c000.mcasp/extcon-intel-mrfld

Am I missing something?

> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/dd.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..9a966e45fda5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -53,7 +53,6 @@
>  static DEFINE_MUTEX(deferred_probe_mutex);
>  static LIST_HEAD(deferred_probe_pending_list);
>  static LIST_HEAD(deferred_probe_active_list);
> -static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>  static struct dentry *deferred_devices;
>  static bool initcalls_done;
>  
> @@ -143,17 +142,6 @@ static bool driver_deferred_probe_enable = false;
>   * This functions moves all devices from the pending list to the active
>   * list and schedules the deferred probe workqueue to process them.  It
>   * should be called anytime a driver is successfully bound to a device.
> - *
> - * Note, there is a race condition in multi-threaded probe. In the case where
> - * more than one device is probing at the same time, it is possible for one
> - * probe to complete successfully while another is about to defer. If the second
> - * depends on the first, then it will get put on the pending list after the
> - * trigger event has already occurred and will be stuck there.
> - *
> - * The atomic 'deferred_trigger_count' is used to determine if a successful
> - * trigger has occurred in the midst of probing a driver. If the trigger count
> - * changes in the midst of a probe, then deferred processing should be triggered
> - * again.
>   */
>  static void driver_deferred_probe_trigger(void)
>  {
> @@ -166,7 +154,6 @@ static void driver_deferred_probe_trigger(void)
>  	 * into the active list so they can be retried by the workqueue
>  	 */
>  	mutex_lock(&deferred_probe_mutex);
> -	atomic_inc(&deferred_trigger_count);
>  	list_splice_tail_init(&deferred_probe_pending_list,
>  			      &deferred_probe_active_list);
>  	mutex_unlock(&deferred_probe_mutex);
> @@ -434,19 +421,9 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
>  static atomic_t probe_count = ATOMIC_INIT(0);
>  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>  
> -static void driver_deferred_probe_add_trigger(struct device *dev,
> -					      int local_trigger_count)
> -{
> -	driver_deferred_probe_add(dev);
> -	/* Did a trigger occur while probing? Need to re-trigger if yes */
> -	if (local_trigger_count != atomic_read(&deferred_trigger_count))
> -		driver_deferred_probe_trigger();
> -}
> -
>  static int really_probe(struct device *dev, struct device_driver *drv)
>  {
>  	int ret = -EPROBE_DEFER;
> -	int local_trigger_count = atomic_read(&deferred_trigger_count);
>  	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>  			   !drv->suppress_bind_attrs;
>  
> @@ -463,7 +440,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  
>  	ret = device_links_check_suppliers(dev);
>  	if (ret == -EPROBE_DEFER)
> -		driver_deferred_probe_add_trigger(dev, local_trigger_count);
> +		driver_deferred_probe_add(dev);
>  	if (ret)
>  		return ret;
>  
> @@ -559,7 +536,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	case -EPROBE_DEFER:
>  		/* Driver requested deferred probing */
>  		dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
> -		driver_deferred_probe_add_trigger(dev, local_trigger_count);
> +		driver_deferred_probe_add(dev);
>  		break;
>  	case -ENODEV:
>  	case -ENXIO:
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
