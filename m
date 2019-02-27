Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7163AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283B420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551269212;
	bh=9el3wPasdaoJ1PORdGLKctRpOCQEGCjIghv8UjnaG8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RICPkqYWZoOnyst06JGykUUAQQ6bLoCSHA/Dd55FK6GrN+K93Wto/tN2Elwm8Ezp3
	 OEmDz8Z8sYkd6fbf5YYvBMedZOeBsdeHr3JYMitSYWcQu/CPZ2VkMAs+GveYgdmgCX
	 GDfb+mv1C66wVZTFHaR0jYUsqPgjfSlSVEPnR08U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfB0MGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbfB0MGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:06:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1422075B;
        Wed, 27 Feb 2019 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551269208;
        bh=9el3wPasdaoJ1PORdGLKctRpOCQEGCjIghv8UjnaG8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmt2iDIetrvsX5TjM/KW9LzQrZ0oDUWIt3nB8w7QbpAoR4rQ4tctM0APIFwgW6fFN
         yOY0JdFNoRl42lUJNpOOJFZ+NsUY2kiyPi0BZLn5TmUF37hynmL22NcIhyqEyI764g
         KwS59JA7bsBKhTMQK8Ch5OyPS4ilJmK0aOpKwa3s=
Date:   Wed, 27 Feb 2019 13:06:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
Message-ID: <20190227120645.GA15587@kroah.com>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
 <20190227092318.GK4747@localhost>
 <20190227093104.GA5354@kroah.com>
 <20190227094021.GL4747@localhost>
 <20190227095424.GA11387@kroah.com>
 <20190227105951.GM4747@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227105951.GM4747@localhost>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:59:51AM +0100, Johan Hovold wrote:
> On Wed, Feb 27, 2019 at 10:54:24AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 27, 2019 at 10:40:21AM +0100, Johan Hovold wrote:
> > > On Wed, Feb 27, 2019 at 10:31:04AM +0100, Greg Kroah-Hartman wrote:
> > > > On Wed, Feb 27, 2019 at 10:23:18AM +0100, Johan Hovold wrote:
> > > > > On Tue, Feb 26, 2019 at 03:41:07PM +0100, Greg Kroah-Hartman wrote:
> > > > > > The dev_links_info structure has 4 bytes of padding at the end of it
> > > > > > when embedded in struct device (which is the only place it lives).  To
> > > > > > help reduce the size of struct device pack this structure so we can take
> > > > > > advantage of the hole with later structure reorganizations.
> > > > > > 
> > > > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > ---
> > > > > >  include/linux/device.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > > > index 6cb4640b6160..b63165276a09 100644
> > > > > > --- a/include/linux/device.h
> > > > > > +++ b/include/linux/device.h
> > > > > > @@ -884,7 +884,7 @@ struct dev_links_info {
> > > > > >  	struct list_head suppliers;
> > > > > >  	struct list_head consumers;
> > > > > >  	enum dl_dev_state status;
> > > > > > -};
> > > > > > +} __packed;
> > > > > 
> > > > > This seems like a bad idea. You're changing the alignment of these
> > > > > fields to one byte, something which may cause the compiler to generate
> > > > > less efficient code to deal with unaligned accesses (even if they happen
> > > > > to currently be naturally aligned in struct device).
> > > > 
> > > > No, all this changes is the trailing "space" is gone.  The alignment of
> > > > the fields did not change at all as they are all naturally aligned
> > > > (list_head is just 2 pointers).
> > > 
> > > Yes, currently and in struct device, but given a pointer to a struct
> > > dev_links_info the compiler must assume it is unaligned and act
> > > accordingly for example.
> > 
> > Packing the structure doesn't mean that the addressing of it is not also
> > aligned, that should just depend on the location of the pointer in the
> > first place, right?
> 
> Packing a structure per definition means changing the alignment
> requirement of each field of the struct to 1-byte alignment.
> 
> Another example of unintended consequences would obviously be that if
> someone later adds a short field, say 1-byte, field before the
> dev_links_info struct, all its fields would be non-naturally aligned
> also in struct device.
> 
> Sure that can be avoided by inspection (and refusal to add new holes),
> but again, not obvious when the link structure is defined elsewhere.
> 
> > Surely compilers are not that foolish :)
> > 
> > And accessing this field should not be an issue of "slow", hopefully the
> > memory savings would offset any compiler mess.
> 
> There are other subtleties like atomicity that may come into play.
> 
> And even if any penalties are deemed acceptable in this case, you're
> also setting a precedent for others. Note that we do not seem to use
> __packed this way currently

Yeah, that is a good point, normally we use packed to keep padding from
the middle of the structure from happening.

I just don't like that 4 bytes sitting there doing nothing :)

> > > > So this allows us to save 4 bytes in struct device by putting something in that
> > > > trailing "hole" that can be aligned with it better (i.e. an integer or
> > > > something else).
> > > 
> > > I understand that, but I don't think it is worth to start using packed
> > > liked this for internal structures as it may have subtle and unintended
> > > consequences.
> > 
> > I'm not understanding what the consequences are here, sorry.  Does the
> > compiler output change given that the structure is still aligned
> > properly in the "parent" structure?  I can't see any output changed
> > here, but maybe I am not looking properly?
> 
> It's all arch dependent, and you won't see any difference on x86-64.
> 
> The following example produces additional instructions even on 32-bit
> arm here:
> 
> struct a1 {
> 	void *p;
> 	void *q;
> 	int i;
> } __attribute__((__packed__));
> 
> struct a2 {
> 	void *p;
> 	void *q;
> 	int i;
> };
> 
> int f(struct a1 *a)
> {
> 	return a->i;
> }
> 
> int g(struct a2 *a)
> {
> 	return a->i;
> }

Ok, fair enough, I'll leave this alone.

But, in thinking about this, there is no real reason that I can see that
this structure even is in struct device.  It should be able to be in the
private "internal" structure.

The patch below moves it out of struct device entirely.  Overall there
is no memory savings, but it could give us the chance to only create
this structure if we really need it later on, as very few things use
links at this point in time.

Rafael, there is one logic change below, the link structure is not
initialized until device_add() happens, instead of device_initialize().
Will that affect anything that you can think of?  Does anyone do
anything with links before device_add() is called?

I only test-built this patch, I didn't boot anything with it to see how
bad it explodes :)

thanks,

greg k-h


diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7a6235..5444941dd42c 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -53,6 +53,18 @@ struct driver_private {
 };
 #define to_driver(obj) container_of(obj, struct driver_private, kobj)
 
+/**
+ * struct dev_links_info - Device data related to device links.
+ * @suppliers: List of links to supplier devices.
+ * @consumers: List of links to consumer devices.
+ * @status: Driver status information.
+ */
+struct dev_links_info {
+	struct list_head suppliers;
+	struct list_head consumers;
+	enum dl_dev_state status;
+};
+
 /**
  * struct device_private - structure to hold the private to the driver core portions of the device structure.
  *
@@ -76,6 +88,7 @@ struct device_private {
 	struct klist_node knode_bus;
 	struct list_head deferred_probe;
 	struct device *device;
+	struct dev_links_info links;
 };
 #define to_device_private_parent(obj)	\
 	container_of(obj, struct device_private, knode_parent)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0073b09bb99f..5210428f621c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -113,7 +113,7 @@ static int device_is_dependent(struct device *dev, void *target)
 	if (ret)
 		return ret;
 
-	list_for_each_entry(link, &dev->links.consumers, s_node) {
+	list_for_each_entry(link, &dev->p->links.consumers, s_node) {
 		if (link->consumer == target)
 			return 1;
 
@@ -139,7 +139,7 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 		device_pm_move_last(dev);
 
 	device_for_each_child(dev, NULL, device_reorder_to_tail);
-	list_for_each_entry(link, &dev->links.consumers, s_node)
+	list_for_each_entry(link, &dev->p->links.consumers, s_node)
 		device_reorder_to_tail(link->consumer, NULL);
 
 	return 0;
@@ -217,7 +217,7 @@ struct device_link *device_link_add(struct device *consumer,
 		goto out;
 	}
 
-	list_for_each_entry(link, &supplier->links.consumers, s_node)
+	list_for_each_entry(link, &supplier->p->links.consumers, s_node)
 		if (link->consumer == consumer) {
 			kref_get(&link->kref);
 			goto out;
@@ -243,7 +243,7 @@ struct device_link *device_link_add(struct device *consumer,
 		 * time, balance the decrementation of the supplier's runtime PM
 		 * usage counter after consumer probe in driver_probe_device().
 		 */
-		if (consumer->links.status == DL_DEV_PROBING)
+		if (consumer->p->links.status == DL_DEV_PROBING)
 			pm_runtime_get_noresume(supplier);
 	}
 	get_device(supplier);
@@ -259,9 +259,9 @@ struct device_link *device_link_add(struct device *consumer,
 	if (flags & DL_FLAG_STATELESS) {
 		link->status = DL_STATE_NONE;
 	} else {
-		switch (supplier->links.status) {
+		switch (supplier->p->links.status) {
 		case DL_DEV_DRIVER_BOUND:
-			switch (consumer->links.status) {
+			switch (consumer->p->links.status) {
 			case DL_DEV_PROBING:
 				/*
 				 * Some callers expect the link creation during
@@ -299,8 +299,8 @@ struct device_link *device_link_add(struct device *consumer,
 	 */
 	device_reorder_to_tail(consumer, NULL);
 
-	list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
-	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
+	list_add_tail_rcu(&link->s_node, &supplier->p->links.consumers);
+	list_add_tail_rcu(&link->c_node, &consumer->p->links.suppliers);
 
 	dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
 
@@ -392,7 +392,7 @@ void device_link_remove(void *consumer, struct device *supplier)
 	device_links_write_lock();
 	device_pm_lock();
 
-	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+	list_for_each_entry(link, &supplier->p->links.consumers, s_node) {
 		if (link->consumer == consumer) {
 			kref_put(&link->kref, __device_link_del);
 			break;
@@ -408,7 +408,7 @@ static void device_links_missing_supplier(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry(link, &dev->links.suppliers, c_node)
+	list_for_each_entry(link, &dev->p->links.suppliers, c_node)
 		if (link->status == DL_STATE_CONSUMER_PROBE)
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 }
@@ -436,7 +436,7 @@ int device_links_check_suppliers(struct device *dev)
 
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry(link, &dev->p->links.suppliers, c_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -447,7 +447,7 @@ int device_links_check_suppliers(struct device *dev)
 		}
 		WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
 	}
-	dev->links.status = DL_DEV_PROBING;
+	dev->p->links.status = DL_DEV_PROBING;
 
 	device_links_write_unlock();
 	return ret;
@@ -470,7 +470,7 @@ void device_links_driver_bound(struct device *dev)
 
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.consumers, s_node) {
+	list_for_each_entry(link, &dev->p->links.consumers, s_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -478,7 +478,7 @@ void device_links_driver_bound(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 	}
 
-	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry(link, &dev->p->links.suppliers, c_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -486,7 +486,7 @@ void device_links_driver_bound(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
 	}
 
-	dev->links.status = DL_DEV_DRIVER_BOUND;
+	dev->p->links.status = DL_DEV_DRIVER_BOUND;
 
 	device_links_write_unlock();
 }
@@ -507,7 +507,7 @@ static void __device_links_no_driver(struct device *dev)
 {
 	struct device_link *link, *ln;
 
-	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers, c_node) {
+	list_for_each_entry_safe_reverse(link, ln, &dev->p->links.suppliers, c_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -517,7 +517,7 @@ static void __device_links_no_driver(struct device *dev)
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 	}
 
-	dev->links.status = DL_DEV_NO_DRIVER;
+	dev->p->links.status = DL_DEV_NO_DRIVER;
 }
 
 void device_links_no_driver(struct device *dev)
@@ -543,7 +543,7 @@ void device_links_driver_cleanup(struct device *dev)
 
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.consumers, s_node) {
+	list_for_each_entry(link, &dev->p->links.consumers, s_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -588,7 +588,7 @@ bool device_links_busy(struct device *dev)
 
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.consumers, s_node) {
+	list_for_each_entry(link, &dev->p->links.consumers, s_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -600,7 +600,7 @@ bool device_links_busy(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND);
 	}
 
-	dev->links.status = DL_DEV_UNBINDING;
+	dev->p->links.status = DL_DEV_UNBINDING;
 
 	device_links_write_unlock();
 	return ret;
@@ -628,7 +628,7 @@ void device_links_unbind_consumers(struct device *dev)
  start:
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.consumers, s_node) {
+	list_for_each_entry(link, &dev->p->links.consumers, s_node) {
 		enum device_link_state status;
 
 		if (link->flags & DL_FLAG_STATELESS)
@@ -673,12 +673,12 @@ static void device_links_purge(struct device *dev)
 	 */
 	device_links_write_lock();
 
-	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers, c_node) {
+	list_for_each_entry_safe_reverse(link, ln, &dev->p->links.suppliers, c_node) {
 		WARN_ON(link->status == DL_STATE_ACTIVE);
 		__device_link_del(&link->kref);
 	}
 
-	list_for_each_entry_safe_reverse(link, ln, &dev->links.consumers, s_node) {
+	list_for_each_entry_safe_reverse(link, ln, &dev->p->links.consumers, s_node) {
 		WARN_ON(link->status != DL_STATE_DORMANT &&
 			link->status != DL_STATE_NONE);
 		__device_link_del(&link->kref);
@@ -1526,9 +1526,6 @@ void device_initialize(struct device *dev)
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
-	INIT_LIST_HEAD(&dev->links.consumers);
-	INIT_LIST_HEAD(&dev->links.suppliers);
-	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
@@ -1830,6 +1827,9 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	INIT_LIST_HEAD(&dev->p->links.consumers);
+	INIT_LIST_HEAD(&dev->p->links.suppliers);
+	dev->p->links.status = DL_DEV_NO_DRIVER;
 	return 0;
 }
 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 0992e67e862b..9739bb5764f9 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -259,7 +259,7 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 	 * callbacks freeing the link objects for the links in the list we're
 	 * walking.
 	 */
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->p->links.suppliers, c_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->supplier, async);
 
@@ -288,7 +288,7 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
 	 * continue instead of trying to continue in parallel with its
 	 * unregistration).
 	 */
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+	list_for_each_entry_rcu(link, &dev->p->links.consumers, s_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->consumer, async);
 
@@ -1214,7 +1214,7 @@ static void dpm_superior_set_must_resume(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->p->links.suppliers, c_node)
 		link->supplier->power.must_resume = true;
 
 	device_links_read_unlock(idx);
@@ -1688,7 +1688,7 @@ static void dpm_clear_superiors_direct_complete(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->p->links.suppliers, c_node) {
 		spin_lock_irq(&link->supplier->power.lock);
 		link->supplier->power.direct_complete = false;
 		spin_unlock_irq(&link->supplier->power.lock);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ccd296dbb95c..54c30ed3f384 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -256,7 +256,7 @@ static int rpm_get_suppliers(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->p->links.suppliers, c_node) {
 		int retval;
 
 		if (!(link->flags & DL_FLAG_PM_RUNTIME))
@@ -281,7 +281,7 @@ static void rpm_put_suppliers(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->p->links.suppliers, c_node)
 		if (link->rpm_active &&
 		    READ_ONCE(link->status) != DL_STATE_SUPPLIER_UNBIND) {
 			pm_runtime_put(link->supplier);
@@ -1557,7 +1557,7 @@ void pm_runtime_clean_up_links(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
+	list_for_each_entry_rcu(link, &dev->p->links.consumers, s_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -1581,7 +1581,7 @@ void pm_runtime_get_suppliers(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->p->links.suppliers, c_node)
 		if (link->flags & DL_FLAG_PM_RUNTIME)
 			pm_runtime_get_sync(link->supplier);
 
@@ -1599,7 +1599,7 @@ void pm_runtime_put_suppliers(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->p->links.suppliers, c_node)
 		if (link->flags & DL_FLAG_PM_RUNTIME)
 			pm_runtime_put(link->supplier);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..701be4385102 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -874,18 +874,6 @@ enum dl_dev_state {
 	DL_DEV_UNBINDING,
 };
 
-/**
- * struct dev_links_info - Device data related to device links.
- * @suppliers: List of links to supplier devices.
- * @consumers: List of links to consumer devices.
- * @status: Driver status information.
- */
-struct dev_links_info {
-	struct list_head suppliers;
-	struct list_head consumers;
-	enum dl_dev_state status;
-};
-
 /**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
@@ -986,7 +974,6 @@ struct device {
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
 					   dev_set/get_drvdata */
-	struct dev_links_info	links;
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
