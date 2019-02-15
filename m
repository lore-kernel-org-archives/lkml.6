Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC58F21900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405314AbfBOMHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:07:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46406 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfBOMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:07:35 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 4d23098976f09112; Fri, 15 Feb 2019 13:07:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter imbalance
Date:   Fri, 15 Feb 2019 13:06:12 +0100
Message-ID: <23147304.zVnvcQtZVR@aspire.rjw.lan>
In-Reply-To: <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <9351473.C2nPJoyFsE@aspire.rjw.lan> <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 15, 2019 12:00:27 PM CET Jon Hunter wrote:
> Hi Rafael,
> 
> On 12/02/2019 12:08, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If a stateless device link to a certain supplier with
> > DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
> > consumer driver's probe callback, the supplier's PM-runtime usage
> > counter will be nonzero after that which effectively causes the
> > supplier to remain "always on" going forward.
> > 
> > Namely, device_link_add() called to add the link invokes
> > device_link_rpm_prepare() which notices that the consumer driver is
> > probing, so it increments the supplier's PM-runtime usage counter
> > with the assumption that the link will stay around until
> > pm_runtime_put_suppliers() is called by driver_probe_device(),
> > but if the link goes away before that point, the supplier's
> > PM-runtime usage counter will remain nonzero.
> > 
> > To prevent that from happening, first rework pm_runtime_get_suppliers()
> > and pm_runtime_put_suppliers() to use the rpm_active refounts of device
> > links and make the latter only drop rpm_active and the supplier's
> > PM-runtime usage counter for each link by one, unless rpm_active is
> > one already for it.  Next, modify device_link_add() to bump up the
> > new link's rpm_active refcount and the suppliers PM-runtime usage
> > counter by two, to prevent pm_runtime_put_suppliers(), if it is
> > called subsequently, from suspending the supplier prematurely (in
> > case its PM-runtime usage counter goes down to 0 in there).
> > 
> > Due to the way rpm_put_suppliers() works, this change does not
> > affect runtime suspend of the consumer ends of new device links (or,
> > generally, device links for which DL_FLAG_PM_RUNTIME has just been
> > set).
> > 
> > Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org> 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > Note that the issue had been there before commit e2f3cd831a28, but it was
> > overlooked by that commit and this change is a fix on top of it, so make
> > the Fixes: tag point to commit e2f3cd831a28 (instead of an earlier one
> > that the patch will not be applicable to).
> I noticed that yesterday's and today's -next were no longer booting on
> one of our Tegra boards (Tegra210 Jetson TX2) because networking is
> failing. The ethernet chip is a USB device and looking at the bootlogs I
> can see that the Tegra XHCI driver is failing ...
> 
>  tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
>  tegra-xusb 70090000.usb: HC died; cleaning up
> 
> The Tegra XHCI driver uses multiple power-domains and uses
> device_link_add() to attach them. So now I am wondering if there is
> something that we have got wrong in our implementation. However, I don't
> see the device being probed deferred on boot or anything like that.
> 
> The driver in question is drivers/usb/host/xhci-tegra.c and we add the
> links in the function tegra_xusb_powerdomain_init() which is before RPM
> is enabled. Let me know if you have any thoughts.

Please try the appended patch on top of the $subject one (provided that
reverting the $subject patch makes the problem go away).

---
 drivers/base/power/runtime.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1675,9 +1675,12 @@ void pm_runtime_put_suppliers(struct dev
 	idx = device_links_read_lock();
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
-		if (link->flags & DL_FLAG_PM_RUNTIME &&
-		    refcount_dec_not_one(&link->rpm_active))
-			pm_runtime_put(link->supplier);
+		if (link->flags & DL_FLAG_PM_RUNTIME) {
+			if (refcount_dec_not_one(&link->rpm_active))
+				pm_runtime_put(link->supplier);
+			else
+				pm_request_idle(link->supplier);
+		}
 
 	device_links_read_unlock(idx);
 }

