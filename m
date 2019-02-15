Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3080C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D4021A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="htOXUgJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393685AbfBOLAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:00:35 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12897 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfBOLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:00:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c669bd50001>; Fri, 15 Feb 2019 03:00:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 15 Feb 2019 03:00:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 15 Feb 2019 03:00:32 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Feb
 2019 11:00:29 +0000
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter
 imbalance
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
Date:   Fri, 15 Feb 2019 11:00:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9351473.C2nPJoyFsE@aspire.rjw.lan>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550228437; bh=4LRVG+p/BayEahjiKUItR8XDJZbQ8zqnIZoOsf0G9j0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=htOXUgJkIvtY+JfltpqNrmURhPl/4mUxnXZZr1SGiZM5QXPGGl2lfyzoMzCrrfQpU
         ESmc5yx0ApxBYhlBGOKoOOAVRx/+dzi2Yl+7usTQEv/xdE6nsN6t9dMWRQl9jtUSbo
         y23G9Q9L/xZBrWFlbOH1ES/zubW8vvfbGW3hjDDjQm2B6o2tGCEVV7gpFpCVURzL2b
         UKFWjXl/Aufn0DG6P1VISn3Q8y6SxDmOParIrZe7MHo8PsmzqbtWjJQVhCEG0z29CX
         oEXuzKxLOHzqDwhs5HopRP7JN0YKfYiVJU9n09vsSQBJE+QNPkj26MIT9MdB45CWis
         ZRoCimGB6xHiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 12/02/2019 12:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a stateless device link to a certain supplier with
> DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
> consumer driver's probe callback, the supplier's PM-runtime usage
> counter will be nonzero after that which effectively causes the
> supplier to remain "always on" going forward.
> 
> Namely, device_link_add() called to add the link invokes
> device_link_rpm_prepare() which notices that the consumer driver is
> probing, so it increments the supplier's PM-runtime usage counter
> with the assumption that the link will stay around until
> pm_runtime_put_suppliers() is called by driver_probe_device(),
> but if the link goes away before that point, the supplier's
> PM-runtime usage counter will remain nonzero.
> 
> To prevent that from happening, first rework pm_runtime_get_suppliers()
> and pm_runtime_put_suppliers() to use the rpm_active refounts of device
> links and make the latter only drop rpm_active and the supplier's
> PM-runtime usage counter for each link by one, unless rpm_active is
> one already for it.  Next, modify device_link_add() to bump up the
> new link's rpm_active refcount and the suppliers PM-runtime usage
> counter by two, to prevent pm_runtime_put_suppliers(), if it is
> called subsequently, from suspending the supplier prematurely (in
> case its PM-runtime usage counter goes down to 0 in there).
> 
> Due to the way rpm_put_suppliers() works, this change does not
> affect runtime suspend of the consumer ends of new device links (or,
> generally, device links for which DL_FLAG_PM_RUNTIME has just been
> set).
> 
> Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Note that the issue had been there before commit e2f3cd831a28, but it was
> overlooked by that commit and this change is a fix on top of it, so make
> the Fixes: tag point to commit e2f3cd831a28 (instead of an earlier one
> that the patch will not be applicable to).
I noticed that yesterday's and today's -next were no longer booting on
one of our Tegra boards (Tegra210 Jetson TX2) because networking is
failing. The ethernet chip is a USB device and looking at the bootlogs I
can see that the Tegra XHCI driver is failing ...

 tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
 tegra-xusb 70090000.usb: HC died; cleaning up

The Tegra XHCI driver uses multiple power-domains and uses
device_link_add() to attach them. So now I am wondering if there is
something that we have got wrong in our implementation. However, I don't
see the device being probed deferred on boot or anything like that.

The driver in question is drivers/usb/host/xhci-tegra.c and we add the
links in the function tegra_xusb_powerdomain_init() which is before RPM
is enabled. Let me know if you have any thoughts.

Cheers
Jon

-- 
nvpublic
