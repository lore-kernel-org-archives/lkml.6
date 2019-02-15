Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C8221B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oqhlmqkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfBOQo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:44:57 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2988 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbfBOQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:44:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c66ec890000>; Fri, 15 Feb 2019 08:44:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 15 Feb 2019 08:44:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 15 Feb 2019 08:44:54 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Feb
 2019 16:44:50 +0000
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter
 imbalance
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <5510642.nRbR3bcduN@aspire.rjw.lan>
 <9351473.C2nPJoyFsE@aspire.rjw.lan>
 <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
 <CAPDyKFoAtviRYuFxJLNrD_J0bGbMTca3O8EN8THg6+d3BNq3vQ@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <775fe187-ae04-91ee-44d6-1603e670df06@nvidia.com>
Date:   Fri, 15 Feb 2019 16:44:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoAtviRYuFxJLNrD_J0bGbMTca3O8EN8THg6+d3BNq3vQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550249097; bh=3SFs/mR70Kmg8/4H0OqYUzA4PVr1KSoZsi5iH94G8AY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oqhlmqktlvKDOIMGpRoMHKwJKJV8RU0NLRSfnFl6JUfi6QJXYmptVNKCfGptAwpxC
         7Ie+fvBogQSVgSnCentLvC3kW6MgS0TXFvnZLnSADFc6PIep3ZAFFretEQOlwHxj3x
         NUXXEZ9OjQTPUtqpcHHxtBfFPfaMgRUovVNQ1u2ONihPdLR/8Hk2hJsj3wiClRfCoo
         oJdRMSY/LYYZVy73zlJv5ujt2qyYrLKhENu8zkjvivG6CYyvux8eY4APrwE9J/Ti9l
         7uTQGNz2f/o+6m2b9lX07DEEcsIXQLv+XubEXTwFYFn6ZJClR1O4FpVwp3hzOVKxHG
         H7ms3gIWrvrDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/02/2019 14:37, Ulf Hansson wrote:
> On Fri, 15 Feb 2019 at 12:00, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> Hi Rafael,
>>
>> On 12/02/2019 12:08, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> If a stateless device link to a certain supplier with
>>> DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
>>> consumer driver's probe callback, the supplier's PM-runtime usage
>>> counter will be nonzero after that which effectively causes the
>>> supplier to remain "always on" going forward.
>>>
>>> Namely, device_link_add() called to add the link invokes
>>> device_link_rpm_prepare() which notices that the consumer driver is
>>> probing, so it increments the supplier's PM-runtime usage counter
>>> with the assumption that the link will stay around until
>>> pm_runtime_put_suppliers() is called by driver_probe_device(),
>>> but if the link goes away before that point, the supplier's
>>> PM-runtime usage counter will remain nonzero.
>>>
>>> To prevent that from happening, first rework pm_runtime_get_suppliers()
>>> and pm_runtime_put_suppliers() to use the rpm_active refounts of device
>>> links and make the latter only drop rpm_active and the supplier's
>>> PM-runtime usage counter for each link by one, unless rpm_active is
>>> one already for it.  Next, modify device_link_add() to bump up the
>>> new link's rpm_active refcount and the suppliers PM-runtime usage
>>> counter by two, to prevent pm_runtime_put_suppliers(), if it is
>>> called subsequently, from suspending the supplier prematurely (in
>>> case its PM-runtime usage counter goes down to 0 in there).
>>>
>>> Due to the way rpm_put_suppliers() works, this change does not
>>> affect runtime suspend of the consumer ends of new device links (or,
>>> generally, device links for which DL_FLAG_PM_RUNTIME has just been
>>> set).
>>>
>>> Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> Note that the issue had been there before commit e2f3cd831a28, but it was
>>> overlooked by that commit and this change is a fix on top of it, so make
>>> the Fixes: tag point to commit e2f3cd831a28 (instead of an earlier one
>>> that the patch will not be applicable to).
>> I noticed that yesterday's and today's -next were no longer booting on
>> one of our Tegra boards (Tegra210 Jetson TX2) because networking is
>> failing. The ethernet chip is a USB device and looking at the bootlogs I
>> can see that the Tegra XHCI driver is failing ...
>>
>>  tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
>>  tegra-xusb 70090000.usb: HC died; cleaning up
>>
>> The Tegra XHCI driver uses multiple power-domains and uses
>> device_link_add() to attach them. So now I am wondering if there is
>> something that we have got wrong in our implementation. However, I don't
>> see the device being probed deferred on boot or anything like that.
>>
>> The driver in question is drivers/usb/host/xhci-tegra.c and we add the
>> links in the function tegra_xusb_powerdomain_init() which is before RPM
>> is enabled. Let me know if you have any thoughts.
> 
> If you are willing to help debugging then I am offering my assistance.
> 
> I would start by enabling CONFIG_PM_ADVANCED_DEBUG, which gives you
> some more information about the runtime PM state of the device, like
> the usage count for example.
> I would also add a couple of prints in
> tegra_xusb_runtime_suspend|resume() and in the ->power_on|off()
> callbacks for the corresponding genpds, to see when those gets called.

From the bootlog I see ...

[    4.445827] tegra_xusb_runtime_resume-788
[    4.508799] tegra-xusb 70090000.usb: Firmware timestamp: 2015-08-10 09:47:54 UTC
[    4.516223] tegra-xusb 70090000.usb: xHCI Host Controller
[    4.521622] tegra-xusb 70090000.usb: new USB bus registered, assigned bus number 1
[    4.530087] tegra-xusb 70090000.usb: hcc params 0x0184f525 hci version 0x100 quirks 0x0000000000010010
[    4.539398] tegra-xusb 70090000.usb: irq 69, io mem 0x70090000
[    4.553671] tegra-xusb 70090000.usb: xHCI Host Controller
[    4.559064] tegra-xusb 70090000.usb: new USB bus registered, assigned bus number 2
[    4.566622] tegra-xusb 70090000.usb: Host supports USB 3.0  SuperSpeed
[    4.595393] tegra-pmc: tegra_genpd_power_off-673: xusbc
[    4.600672] tegra-pmc: tegra_genpd_power_off-673: xusba
[    4.657346] tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
[    4.665157] tegra-xusb 70090000.usb: HC died; cleaning up

This shows the xusb controller is runtime resumed during probe but
then after probe the pm-domains, xusba and xusbc, are turned off
without it being runtime suspended. We never suspend it until it
is removed currently. 

Following boot the xusb device appears to still be active ... 

$ cat /sys/devices/platform/70090000.usb/power/runtime_status 
active

... but the status reported by the pm_genpd summary disagrees ...

$ sudo cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
vic                             off-0           
    /devices/platform/50000000.host1x/54340000.vic      suspended
xusbc                           off-0           
    /devices/genpd:0:70090000.usb                       suspended
xusbb                           off-0           
xusba                           off-0           
    /devices/genpd:1:70090000.usb                       suspended
sor                             on              
    /devices/platform/700e3000.mipi                     unsupported
    /devices/platform/50000000.host1x/54300000.dsi      active
    /devices/platform/50000000.host1x/54040000.dpaux    active
    /devices/platform/50000000.host1x/54580000.sor      suspended
aud                             off-0           

... and ...

$ cat /sys/devices/platform/70090000.usb/power/runtime_suppliers 
genpd:0:70090000.usb 1
genpd:1:70090000.usb 1

Let me know if you have any thoughts.

Cheers
Jon

-- 
nvpublic
