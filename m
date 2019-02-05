Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31047C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF49F20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfBEL1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:27:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55862 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfBEL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:27:35 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id f10b9bb3c639c18e; Tue, 5 Feb 2019 12:27:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add "consumer autoprobe" flag
Date:   Tue, 05 Feb 2019 12:26:20 +0100
Message-ID: <24600564.pMaimVIQbW@aspire.rjw.lan>
In-Reply-To: <CAPDyKFrq-r-rFDDB3yU=W4mOF2-A4xGGomqFqUba6MVWZugHmQ@mail.gmail.com>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com> <CAPDyKFrq-r-rFDDB3yU=W4mOF2-A4xGGomqFqUba6MVWZugHmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 5, 2019 9:15:49 AM CET Ulf Hansson wrote:
> On Mon, 4 Feb 2019 at 12:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Feb 4, 2019 at 12:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Fri, 1 Feb 2019 at 02:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > Hi Greg at al,
> > > > >
> > > > > This is a combination of the two device links series I have posted
> > > > > recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
> > > > > and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
> > > > > on top of your driver-core-next branch.
> > > > >
> > > > > Recently I have been looking at the device links code because of the
> > > > > recent discussion on possibly using them in the DRM subsystem (see for
> > > > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > > > found a few issues in that code which should be addressed by this patch
> > > > > series.  Please refer to the patch changelogs for details.
> > > > >
> > > > > None of the problems addressed here should be manifesting themselves in
> > > > > mainline kernel today, but if there are more device links users in the
> > > > > future, they most likely will be encountered sooner or later.  Also they
> > > > > need to be fixed for the DRM use case to be supported IMO.
> > > > >
> > > > > On top of this the series makes device links support the "composite device"
> > > > > use case in the DRM subsystem mentioned above (essentially, the last patch
> > > > > in the series is for that purpose).
> > > > >
> > > >
> > > > Rafael, Greg, I have reviewed patch 1 -> 7, they all look good to me.
> > > >
> > > > If not too late, feel free to add for the first 7 patches:
> > > >
> > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > Thanks!
> > >
> > > > Although, I want to point out one problem that I have found when using
> > > > device links. I believe it's already there, even before this series,
> > > > but just wanted to described it for your consideration.
> > > >
> > > > This is what happens:
> > > > I have a platform driver is being probed. During ->probe() the driver
> > > > adds a device link like this:
> > > >
> > > > link = device_link_add(consumer-dev, supplier-dev, DL_FLAG_STATELESS |
> > > > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> > > >
> > > > At some point later in ->probe(), the driver realizes that it must
> > > > remove the device link, either because it encountered an error or
> > > > simply because it doesn't need the device link to be there anymore.
> > > > Thus it calls:
> > > >
> > > > device_link_del(link);
> > > >
> > > > When probe finished of the driver, the runtime PM usage count for the
> > > > supplier-dev remains increased to 1 and thus it never becomes runtime
> > > > suspended.
> > >
> > > OK, so this is a tricky one.
> > >
> > > With this series applied, if the link actually goes away after the
> > > cleanup device_link_del(), device_link_free() should take care of
> > > dropping the PM-runtime count of the supplier.  If it doesn't do that,
> > > there is a mistake in the code that needs to be fixed.
> 
> Unless this is a of your "distracted part", then I think this is what
> happening and thus is a problem.
> 
> > >
> > > However, if the link doesn't go away after the cleanup
> > > device_link_del(), the supplier's PM-runtime count will not be
> > > dropped, because the core doesn't know whether or not the
> > > device_link_del() has been called by the same entity that caused the
> > > supplier's PM-runtime count to be incremented.  For example, if the
> > > consumer device is suspended after the device_link_add() that
> > > incremented the supplier's PM-runtime count and then suspended again,
> >
> > I was distracted while writing this, sorry for the confusion.
> >
> > So let me rephrase:
> >
> > For example, if the consumer device is suspended after the
> > device_link_add() that incremented the supplier's PM-runtime count and
> > then resumed again, the rpm_active refcount will be greater than one
> > because of the last resume and not because of the initial link
> > creation.  In that case, dropping the supplier's PM-runtime count on
> > link deletion may not work as expected.
> 
> I see what your are saying and I must admit, by looking at the code,
> that it has turned into being rather complicated. Assuming of good
> reasons, of course.
> 
> Anyway, I will play a little bit more with my tests to see what I can find out.
> 
> >
> > > Arguably, device_link_del() could be made automatically drop the
> > > supplier's PM-runtime count by one if the link's rpm_active refcount
> > > is not one, but there will be failing scenarios in that case too
> > > AFAICS.
> 
> Let's see.

So for the record, below is the (untested) patch I'm thinking about.

Having considered this for some time, I think that it would be better to
try to drop the supplier's PM-runtime usage counter on link removal even if
the link doesn't go away then.  That would be more consistent at least IMO.

Of course, the potentially failing case is when device_link_add() is called
for the same consumer-supplier pair a number of times in a row, sometimes
with DL_FLAG_RPM_ACTIVE set and sometimes without it, and the callers of it
try to delete the link in a different order.  However, if all of them remember
that the supplier is not guaranteed to be PM-runtime-activer after a call
to device_link_del(), they should be able to avoid any problems related to
that AFAICS.

---
 drivers/base/core.c    |   31 ++++++++++++++++++++++---------
 include/linux/device.h |    2 ++
 2 files changed, 24 insertions(+), 9 deletions(-)

Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -847,6 +847,7 @@ enum device_link_state {
  * @flags: Link flags.
  * @rpm_active: Whether or not the consumer device is runtime-PM-active.
  * @kref: Count repeated addition of the same link.
+ * @rpm_refs: Repeated addition of the same link with DL_FLAG_RPM_ACTIVE set.
  * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
  */
 struct device_link {
@@ -858,6 +859,7 @@ struct device_link {
 	u32 flags;
 	refcount_t rpm_active;
 	struct kref kref;
+	unsigned int rpm_refs;
 #ifdef CONFIG_SRCU
 	struct rcu_head rcu_head;
 #endif
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -178,6 +178,15 @@ static void device_link_rpm_prepare(stru
 		pm_runtime_get_noresume(supplier);
 }
 
+static void device_link_rpm_active(struct device_link *link, u32 flags)
+{
+	if (flags & DL_FLAG_RPM_ACTIVE) {
+		refcount_inc(&link->rpm_active);
+		if (flags & DL_FLAG_STATELESS)
+			link->rpm_refs++;
+	}
+}
+
 /**
  * device_link_add - Create a link between two devices.
  * @consumer: Consumer end of the link.
@@ -289,8 +298,7 @@ struct device_link *device_link_add(stru
 				device_link_rpm_prepare(consumer, supplier);
 				link->flags |= DL_FLAG_PM_RUNTIME;
 			}
-			if (flags & DL_FLAG_RPM_ACTIVE)
-				refcount_inc(&link->rpm_active);
+			device_link_rpm_active(link, flags);
 		}
 
 		if (flags & DL_FLAG_STATELESS) {
@@ -322,10 +330,8 @@ struct device_link *device_link_add(stru
 	refcount_set(&link->rpm_active, 1);
 
 	if (flags & DL_FLAG_PM_RUNTIME) {
-		if (flags & DL_FLAG_RPM_ACTIVE)
-			refcount_inc(&link->rpm_active);
-
 		device_link_rpm_prepare(consumer, supplier);
+		device_link_rpm_active(link, flags);
 	}
 
 	get_device(supplier);
@@ -463,10 +469,17 @@ static void __device_link_del(struct kre
 
 static void device_link_put_kref(struct device_link *link)
 {
-	if (link->flags & DL_FLAG_STATELESS)
-		kref_put(&link->kref, __device_link_del);
-	else
-		WARN(1, "Unable to drop a managed device link reference\n");
+	if (WARN(!(link->flags & DL_FLAG_STATELESS),
+		 "Unable to drop a managed device link reference\n"))
+		return;
+
+	if (link->rpm_refs) {
+		link->rpm_refs--;
+		if (refcount_dec_not_one(&link->rpm_active))
+			pm_runtime_put(link->supplier);
+	}
+
+	kref_put(&link->kref, __device_link_del);
 }
 
 /**

