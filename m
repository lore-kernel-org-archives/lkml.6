Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC0F3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6316F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6316F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeFLOZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:25:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44098 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeFLOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:25:05 -0400
Received: from 79.184.255.56.ipv4.supernova.orange.pl (79.184.255.56) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 2b835535a2a4a0d5; Tue, 12 Jun 2018 16:25:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
Date:   Tue, 12 Jun 2018 16:24:01 +0200
Message-ID: <1692795.7GA92aXxMT@aspire.rjw.lan>
In-Reply-To: <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com> <10125310.W3e2TP0641@aspire.rjw.lan> <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 12, 2018 2:44:23 PM CEST Marek Szyprowski wrote:
> Hi Rafael,

Hi,

> On 2018-06-12 13:00, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a device link is added via device_link_add() by the driver of the
> > link's consumer device, the supplier's runtime PM usage counter is
> > going to be dropped by the pm_runtime_put_suppliers() call in
> > driver_probe_device().  However, in that case it is not incremented
> > unless the supplier driver is already present and the link is not
> > stateless.  That leads to a runtime PM usage counter imbalance for
> > the supplier device in a few cases.
> >
> > To prevent that from happening, bump up the supplier runtime
> > PM usage counter in device_link_add() for all links with the
> > DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
> > time.  Use pm_runtime_get_noresume() for that as the callers of
> > device_link_add() who want the supplier to be resumed by it should
> > pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
> >
> > Fixes: 21d5c57b3726 (PM / runtime: Use device links)
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
> > reference counting of device link suppliers at probe) that is going
> > to be reverted.
> 
> Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.

Thanks for testing! :-)

> Let's get back to my IOMMU and codec case, mentioned here:
> https://marc.info/?l=linux-pm&m=152878741527962&w=2
> 
> Now, after applying your patch, when IOMMU creates a link with
> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
> being probed), it is not IOMMU is not runtime resumed anymore (that's
> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
> This means that until jpeg driver enables runtime pm for its device and
> finally performs runtime pm suspends/resume cycle, the supplier won't be
> resumed. On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
> creation, the supplier is properly resumed, but then, once the jpeg
> device probe finishes, the supplier is still in runtime active state
> until a next runtime suspend/resume cycle of jpeg device.

That additional suspend-resume cycle should not be necessary in theory
unless I'm missing something.

The pm_request_idle() call in driver_probe_device() should trigger a
suspend of the jpeg device after probe (unless blocked by something)
and that should drop the RPM usage counter of the IOMMU.  Next, the
pm_runtime_put_suppliers() in there should actually suspend it.

It looks like the pm_request_idle() doesn't work as expected.

> If I understand right, the DL_FLAG_RPM_ACTIVE flag should be there from the
> beginning, but that time it runtime pm part of links worked in a bit
> different way than now.

Right, and evidently there are callers depending on the existing behavior.
 
> Is there any way to keep old behavior?

Yes, there is, please test the appended v2 of the $subject patch.

That said, I'd like to remove the extra supplier resume from there going
forward as there may be callers who actually don't want that to happen and
DL_FLAG_RPM_ACTIVE is there for a purpose.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] PM / core: Fix supplier device runtime PM usage counter imbalance

If a device link is added via device_link_add() by the driver of the
link's consumer device, the supplier's runtime PM usage counter is
going to be dropped by the pm_runtime_put_suppliers() call in
driver_probe_device().  However, in that case it is not incremented
unless the supplier driver is already present and the link is not
stateless.  That leads to a runtime PM usage counter imbalance for
the supplier device in a few cases.

To prevent that from happening, bump up the supplier runtime
PM usage counter in device_link_add() for all links with the
DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
time.  Use pm_runtime_get_noresume() for that as the callers of
device_link_add() who want the supplier to be resumed by it are
expected to pass DL_FLAG_RPM_ACTIVE in flags to it anyway, but
additionally resume the supplier if the link is added during
consumer driver probe to retain the existing behavior for the
callers depending on it.

Fixes: 21d5c57b3726 (PM / runtime: Use device links)
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -216,6 +216,13 @@ struct device_link *device_link_add(stru
 			link->rpm_active = true;
 		}
 		pm_runtime_new_link(consumer);
+		/*
+		 * If the link is being added by the consumer driver at probe
+		 * time, balance the decrementation of the supplier's runtime PM
+		 * usage counter after consumer probe in driver_probe_device().
+		 */
+		if (consumer->links.status == DL_DEV_PROBING)
+			pm_runtime_get_noresume(supplier);
 	}
 	get_device(supplier);
 	link->supplier = supplier;
@@ -235,12 +242,12 @@ struct device_link *device_link_add(stru
 			switch (consumer->links.status) {
 			case DL_DEV_PROBING:
 				/*
-				 * Balance the decrementation of the supplier's
-				 * runtime PM usage counter after consumer probe
-				 * in driver_probe_device().
+				 * Some callers expect the link creation during
+				 * consumer driver probe to resume the supplier
+				 * even without DL_FLAG_RPM_ACTIVE.
 				 */
 				if (flags & DL_FLAG_PM_RUNTIME)
-					pm_runtime_get_sync(supplier);
+					pm_runtime_resume(supplier);
 
 				link->status = DL_STATE_CONSUMER_PROBE;
 				break;

