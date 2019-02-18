Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E81C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F17217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qURsQGmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfBRNC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:02:58 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14447 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfBRNC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:02:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6aad060000>; Mon, 18 Feb 2019 05:03:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 05:02:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 05:02:55 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 13:02:52 +0000
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter
 imbalance
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
 <775fe187-ae04-91ee-44d6-1603e670df06@nvidia.com>
 <CAJZ5v0gywb2jE-FRowxuosucNVqQ4iLLTCFte4hN_CELF9rHRA@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6ee66fc6-cba5-7aea-0e92-3380544c1a94@nvidia.com>
Date:   Mon, 18 Feb 2019 13:02:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gywb2jE-FRowxuosucNVqQ4iLLTCFte4hN_CELF9rHRA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550494982; bh=UWDK7EZYd+T/KAW+5eZGNIhb/CZr4iTaIy0V4km1O7Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qURsQGmR91tARKlua5kYiw5fCkuaj8cNEqAXm2iQ3HJ+8WNqPKZvNQBwysPJ/Rz4u
         cHPsm2YIuE0ebyjf5DXWKQZ7LbkNsfJyxOUlhDgf/8QlJuZivg3LqcLflfaAZV325f
         od9W1M42HzPfQbrA7jwX1EPkJ/UPfa87GXAwnNoQj4UWZC9V9QeBSngWxVTTtEaQA0
         3tAUroBmYQnTAsljoBbS9tpiDmPkaJhopbD0KEoVWlUkLzgy0E2qRR3dW8+Y9vgsjR
         iHqtPZZTsFuJjbMU9SJnKYRCYBpgladOjWbvb2ukYNqYduIOHJ7Gcz26kNzYfLGB5c
         e2Pfp2dDURjJQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/02/2019 12:12, Rafael J. Wysocki wrote:
>  On Fri, Feb 15, 2019 at 5:44 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 15/02/2019 14:37, Ulf Hansson wrote:
>>> On Fri, 15 Feb 2019 at 12:00, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> On 12/02/2019 12:08, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> If a stateless device link to a certain supplier with
>>>>> DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
>>>>> consumer driver's probe callback, the supplier's PM-runtime usage
>>>>> counter will be nonzero after that which effectively causes the
>>>>> supplier to remain "always on" going forward.
>>>>>
>>>>> Namely, device_link_add() called to add the link invokes
>>>>> device_link_rpm_prepare() which notices that the consumer driver is
>>>>> probing, so it increments the supplier's PM-runtime usage counter
>>>>> with the assumption that the link will stay around until
>>>>> pm_runtime_put_suppliers() is called by driver_probe_device(),
>>>>> but if the link goes away before that point, the supplier's
>>>>> PM-runtime usage counter will remain nonzero.
>>>>>
>>>>> To prevent that from happening, first rework pm_runtime_get_suppliers()
>>>>> and pm_runtime_put_suppliers() to use the rpm_active refounts of device
>>>>> links and make the latter only drop rpm_active and the supplier's
>>>>> PM-runtime usage counter for each link by one, unless rpm_active is
>>>>> one already for it.  Next, modify device_link_add() to bump up the
>>>>> new link's rpm_active refcount and the suppliers PM-runtime usage
>>>>> counter by two, to prevent pm_runtime_put_suppliers(), if it is
>>>>> called subsequently, from suspending the supplier prematurely (in
>>>>> case its PM-runtime usage counter goes down to 0 in there).
>>>>>
>>>>> Due to the way rpm_put_suppliers() works, this change does not
>>>>> affect runtime suspend of the consumer ends of new device links (or,
>>>>> generally, device links for which DL_FLAG_PM_RUNTIME has just been
>>>>> set).
>>>>>
>>>>> Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
>>>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>
>>>>> Note that the issue had been there before commit e2f3cd831a28, but it was
>>>>> overlooked by that commit and this change is a fix on top of it, so make
>>>>> the Fixes: tag point to commit e2f3cd831a28 (instead of an earlier one
>>>>> that the patch will not be applicable to).
>>>> I noticed that yesterday's and today's -next were no longer booting on
>>>> one of our Tegra boards (Tegra210 Jetson TX2) because networking is
>>>> failing. The ethernet chip is a USB device and looking at the bootlogs I
>>>> can see that the Tegra XHCI driver is failing ...
>>>>
>>>>  tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
>>>>  tegra-xusb 70090000.usb: HC died; cleaning up
>>>>
>>>> The Tegra XHCI driver uses multiple power-domains and uses
>>>> device_link_add() to attach them. So now I am wondering if there is
>>>> something that we have got wrong in our implementation. However, I don't
>>>> see the device being probed deferred on boot or anything like that.
>>>>
>>>> The driver in question is drivers/usb/host/xhci-tegra.c and we add the
>>>> links in the function tegra_xusb_powerdomain_init() which is before RPM
>>>> is enabled. Let me know if you have any thoughts.
>>>
>>> If you are willing to help debugging then I am offering my assistance.
>>>
>>> I would start by enabling CONFIG_PM_ADVANCED_DEBUG, which gives you
>>> some more information about the runtime PM state of the device, like
>>> the usage count for example.
>>> I would also add a couple of prints in
>>> tegra_xusb_runtime_suspend|resume() and in the ->power_on|off()
>>> callbacks for the corresponding genpds, to see when those gets called.
>>
>> From the bootlog I see ...
>>
>> [    4.445827] tegra_xusb_runtime_resume-788
>> [    4.508799] tegra-xusb 70090000.usb: Firmware timestamp: 2015-08-10 09:47:54 UTC
> 
> This message comes from tegra_xusb_load_firmware() in
> tegra_xusb_probe() which is after the pm_runtime_get_sync().
> 
> If the device was PM-runtime-suspended before, the
> pm_runtime_get_sync() will runtime-resume and reference-count the
> suppliers in addition to resuming the device.  In that case
> pm_runtime_put_suppliers() will suspend the suppliers, so there is a
> bug in there.
> 
> What happens is that the links are new when pm_runtime_get_sync() runs
> and so their rpm_active refcounts are one.  After the
> pm_runtime_get_sync() they are two and pm_runtime_put_suppliers() will
> drop them by one and drop the PM-runtime usage counter of each of them
> by one, so they will become zero and the suppliers will suspend.
> 
> Passing DL_FLAG_RPM_ACTIVE to device_link_add() should help, but IMO
> things should also work without that.

I can confirm that DL_FLAG_RPM_ACTIVE does indeed work. I assume though
this would prevent the suppliers from ever being suspended, which maybe
we will want to do eventually.

>> [    4.516223] tegra-xusb 70090000.usb: xHCI Host Controller
>> [    4.521622] tegra-xusb 70090000.usb: new USB bus registered, assigned bus number 1
> 
> This comes from usb_add_hcd()
> 
>> [    4.530087] tegra-xusb 70090000.usb: hcc params 0x0184f525 hci version 0x100 quirks 0x0000000000010010
>> [    4.539398] tegra-xusb 70090000.usb: irq 69, io mem 0x70090000
>> [    4.553671] tegra-xusb 70090000.usb: xHCI Host Controller
>> [    4.559064] tegra-xusb 70090000.usb: new USB bus registered, assigned bus number 2
> 
> Like this.
> 
>> [    4.566622] tegra-xusb 70090000.usb: Host supports USB 3.0  SuperSpeed
> 
> And this if from xhci_gen_setup(), so probe returns around this point.
> 
>> [    4.595393] tegra-pmc: tegra_genpd_power_off-673: xusbc
>> [    4.600672] tegra-pmc: tegra_genpd_power_off-673: xusba
> 
> And this appears to be done by pm_runtime_put_suppliers().
> 
> Hmm, I need to think how to fix this.  Maybe we'll need to revert
> $subject patch and do something else, we'll see (later today).

OK, thanks. Let me know if there is anything else I can test.

Cheers
Jon

-- 
nvpublic
