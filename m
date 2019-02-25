Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5F620842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131250;
	bh=WIEaqmLxiqAJA4yD7ynKO/JXp5Yd2NhnGiNRGWLIho0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AuP2bsMwR+jyQzW+tJXgK/0kdOq8JplGkExs3QmZaA3YiwEok2jxmEMxgFOomg9AP
	 xziGRx2ku1mLXnWIKc8D1dTr2ENPoUFtBoCqjbFhYDDMGoNkbSkqI8c1hFIX9qSgcT
	 3BL0EM6Jugz0jIMvtVVr1rQHYPMfPK0i2+UtEWzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfBYV1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731221AbfBYV13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51F22087C;
        Mon, 25 Feb 2019 21:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130048;
        bh=WIEaqmLxiqAJA4yD7ynKO/JXp5Yd2NhnGiNRGWLIho0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+uAlcl1ZaZegveBmjFsyJUllHOEMvK3j0NDW7GzIKmcR/pkogx6+C+8+kCpgTmQK
         sl/wMPQ0mj1F/QcCatiLHDE7L14cF720TurrlvdTJyN++WJUJgyLUimatHWANwOfXT
         LGwvBnpJHOPacswrA2udA1LQabvds1HVCU4LhXXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernie Thompson <bernie@plugable.com>
Subject: [PATCH 4.19 151/152] udlfb: handle unplug properly
Date:   Mon, 25 Feb 2019 22:12:23 +0100
Message-Id: <20190225195055.431849077@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 68a958a915ca912b8ce71b9eea7445996f6e681e upstream.

The udlfb driver maintained an open count and cleaned up itself when the
count reached zero. But the console is also counted in the reference count
- so, if the user unplugged the device, the open count would not drop to
zero and the driver stayed loaded with console attached. If the user
re-plugged the adapter, it would create a device /dev/fb1, show green
screen and the access to the console would be lost.

The framebuffer subsystem has reference counting on its own - in order to
fix the unplug bug, we rely the framebuffer reference counting. When the
user unplugs the adapter, we call unregister_framebuffer unconditionally.
unregister_framebuffer will unbind the console, wait until all users stop
using the framebuffer and then call the fb_destroy method. The fb_destroy
cleans up the USB driver.

This patch makes the following changes:
* Drop dlfb->kref and rely on implicit framebuffer reference counting
  instead.
* dlfb_usb_disconnect calls unregister_framebuffer, the rest of driver
  cleanup is done in the function dlfb_ops_destroy. dlfb_ops_destroy will
  be called by the framebuffer subsystem when no processes have the
  framebuffer open or mapped.
* We don't use workqueue during initialization, but initialize directly
  from dlfb_usb_probe. The workqueue could race with dlfb_usb_disconnect
  and this racing would produce various kinds of memory corruption.
* We use usb_get_dev and usb_put_dev to make sure that the USB subsystem
  doesn't free the device under us.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
cc: Dave Airlie <airlied@redhat.com>
Cc: Bernie Thompson <bernie@plugable.com>,
Cc: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/udlfb.c |  141 +++++++++++---------------------------------
 include/video/udlfb.h       |    3 
 2 files changed, 37 insertions(+), 107 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -916,8 +916,6 @@ static int dlfb_ops_open(struct fb_info
 
 	dlfb->fb_count++;
 
-	kref_get(&dlfb->kref);
-
 	if (fb_defio && (info->fbdefio == NULL)) {
 		/* enable defio at last moment if not disabled by client */
 
@@ -940,14 +938,17 @@ static int dlfb_ops_open(struct fb_info
 	return 0;
 }
 
-/*
- * Called when all client interfaces to start transactions have been disabled,
- * and all references to our device instance (dlfb_data) are released.
- * Every transaction must have a reference, so we know are fully spun down
- */
-static void dlfb_free(struct kref *kref)
+static void dlfb_ops_destroy(struct fb_info *info)
 {
-	struct dlfb_data *dlfb = container_of(kref, struct dlfb_data, kref);
+	struct dlfb_data *dlfb = info->par;
+
+	if (info->cmap.len != 0)
+		fb_dealloc_cmap(&info->cmap);
+	if (info->monspecs.modedb)
+		fb_destroy_modedb(info->monspecs.modedb);
+	vfree(info->screen_base);
+
+	fb_destroy_modelist(&info->modelist);
 
 	while (!list_empty(&dlfb->deferred_free)) {
 		struct dlfb_deferred_free *d = list_entry(dlfb->deferred_free.next, struct dlfb_deferred_free, list);
@@ -957,40 +958,13 @@ static void dlfb_free(struct kref *kref)
 	}
 	vfree(dlfb->backing_buffer);
 	kfree(dlfb->edid);
+	usb_put_dev(dlfb->udev);
 	kfree(dlfb);
-}
-
-static void dlfb_free_framebuffer(struct dlfb_data *dlfb)
-{
-	struct fb_info *info = dlfb->info;
-
-	if (info) {
-		unregister_framebuffer(info);
-
-		if (info->cmap.len != 0)
-			fb_dealloc_cmap(&info->cmap);
-		if (info->monspecs.modedb)
-			fb_destroy_modedb(info->monspecs.modedb);
-		vfree(info->screen_base);
-
-		fb_destroy_modelist(&info->modelist);
-
-		dlfb->info = NULL;
-
-		/* Assume info structure is freed after this point */
-		framebuffer_release(info);
-	}
 
-	/* ref taken in probe() as part of registering framebfufer */
-	kref_put(&dlfb->kref, dlfb_free);
+	/* Assume info structure is freed after this point */
+	framebuffer_release(info);
 }
 
-static void dlfb_free_framebuffer_work(struct work_struct *work)
-{
-	struct dlfb_data *dlfb = container_of(work, struct dlfb_data,
-					     free_framebuffer_work.work);
-	dlfb_free_framebuffer(dlfb);
-}
 /*
  * Assumes caller is holding info->lock mutex (for open and release at least)
  */
@@ -1000,10 +974,6 @@ static int dlfb_ops_release(struct fb_in
 
 	dlfb->fb_count--;
 
-	/* We can't free fb_info here - fbmem will touch it when we return */
-	if (dlfb->virtualized && (dlfb->fb_count == 0))
-		schedule_delayed_work(&dlfb->free_framebuffer_work, HZ);
-
 	if ((dlfb->fb_count == 0) && (info->fbdefio)) {
 		fb_deferred_io_cleanup(info);
 		kfree(info->fbdefio);
@@ -1013,8 +983,6 @@ static int dlfb_ops_release(struct fb_in
 
 	dev_dbg(info->dev, "release, user=%d count=%d\n", user, dlfb->fb_count);
 
-	kref_put(&dlfb->kref, dlfb_free);
-
 	return 0;
 }
 
@@ -1172,6 +1140,7 @@ static struct fb_ops dlfb_ops = {
 	.fb_blank = dlfb_ops_blank,
 	.fb_check_var = dlfb_ops_check_var,
 	.fb_set_par = dlfb_ops_set_par,
+	.fb_destroy = dlfb_ops_destroy,
 };
 
 
@@ -1615,12 +1584,13 @@ success:
 	return true;
 }
 
-static void dlfb_init_framebuffer_work(struct work_struct *work);
-
 static int dlfb_usb_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
 {
+	int i;
+	const struct device_attribute *attr;
 	struct dlfb_data *dlfb;
+	struct fb_info *info;
 	int retval = -ENOMEM;
 	struct usb_device *usbdev = interface_to_usbdev(intf);
 
@@ -1631,10 +1601,9 @@ static int dlfb_usb_probe(struct usb_int
 		goto error;
 	}
 
-	kref_init(&dlfb->kref); /* matching kref_put in usb .disconnect fn */
 	INIT_LIST_HEAD(&dlfb->deferred_free);
 
-	dlfb->udev = usbdev;
+	dlfb->udev = usb_get_dev(usbdev);
 	usb_set_intfdata(intf, dlfb);
 
 	dev_dbg(&intf->dev, "console enable=%d\n", console);
@@ -1657,42 +1626,6 @@ static int dlfb_usb_probe(struct usb_int
 	}
 
 
-	if (!dlfb_alloc_urb_list(dlfb, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
-		retval = -ENOMEM;
-		dev_err(&intf->dev, "unable to allocate urb list\n");
-		goto error;
-	}
-
-	kref_get(&dlfb->kref); /* matching kref_put in free_framebuffer_work */
-
-	/* We don't register a new USB class. Our client interface is dlfbev */
-
-	/* Workitem keep things fast & simple during USB enumeration */
-	INIT_DELAYED_WORK(&dlfb->init_framebuffer_work,
-			  dlfb_init_framebuffer_work);
-	schedule_delayed_work(&dlfb->init_framebuffer_work, 0);
-
-	return 0;
-
-error:
-	if (dlfb) {
-
-		kref_put(&dlfb->kref, dlfb_free); /* last ref from kref_init */
-
-		/* dev has been deallocated. Do not dereference */
-	}
-
-	return retval;
-}
-
-static void dlfb_init_framebuffer_work(struct work_struct *work)
-{
-	int i, retval;
-	struct fb_info *info;
-	const struct device_attribute *attr;
-	struct dlfb_data *dlfb = container_of(work, struct dlfb_data,
-					     init_framebuffer_work.work);
-
 	/* allocates framebuffer driver structure, not framebuffer memory */
 	info = framebuffer_alloc(0, &dlfb->udev->dev);
 	if (!info) {
@@ -1706,17 +1639,22 @@ static void dlfb_init_framebuffer_work(s
 	dlfb->ops = dlfb_ops;
 	info->fbops = &dlfb->ops;
 
+	INIT_LIST_HEAD(&info->modelist);
+
+	if (!dlfb_alloc_urb_list(dlfb, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
+		retval = -ENOMEM;
+		dev_err(&intf->dev, "unable to allocate urb list\n");
+		goto error;
+	}
+
+	/* We don't register a new USB class. Our client interface is dlfbev */
+
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0) {
 		dev_err(info->device, "cmap allocation failed: %d\n", retval);
 		goto error;
 	}
 
-	INIT_DELAYED_WORK(&dlfb->free_framebuffer_work,
-			  dlfb_free_framebuffer_work);
-
-	INIT_LIST_HEAD(&info->modelist);
-
 	retval = dlfb_setup_modes(dlfb, info, NULL, 0);
 	if (retval != 0) {
 		dev_err(info->device,
@@ -1760,10 +1698,16 @@ static void dlfb_init_framebuffer_work(s
 		 dev_name(info->dev), info->var.xres, info->var.yres,
 		 ((dlfb->backing_buffer) ?
 		 info->fix.smem_len * 2 : info->fix.smem_len) >> 10);
-	return;
+	return 0;
 
 error:
-	dlfb_free_framebuffer(dlfb);
+	if (dlfb->info) {
+		dlfb_ops_destroy(dlfb->info);
+	} else if (dlfb) {
+		usb_put_dev(dlfb->udev);
+		kfree(dlfb);
+	}
+	return retval;
 }
 
 static void dlfb_usb_disconnect(struct usb_interface *intf)
@@ -1791,20 +1735,9 @@ static void dlfb_usb_disconnect(struct u
 		for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
 			device_remove_file(info->dev, &fb_device_attrs[i]);
 		device_remove_bin_file(info->dev, &edid_attr);
-		unlink_framebuffer(info);
 	}
 
-	usb_set_intfdata(intf, NULL);
-	dlfb->udev = NULL;
-
-	/* if clients still have us open, will be freed on last close */
-	if (dlfb->fb_count == 0)
-		schedule_delayed_work(&dlfb->free_framebuffer_work, 0);
-
-	/* release reference taken by kref_init in probe() */
-	kref_put(&dlfb->kref, dlfb_free);
-
-	/* consider dlfb_data freed */
+	unregister_framebuffer(info);
 }
 
 static struct usb_driver dlfb_driver = {
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -36,12 +36,9 @@ struct dlfb_data {
 	struct usb_device *udev;
 	struct fb_info *info;
 	struct urb_list urbs;
-	struct kref kref;
 	char *backing_buffer;
 	int fb_count;
 	bool virtualized; /* true when physical usb device not present */
-	struct delayed_work init_framebuffer_work;
-	struct delayed_work free_framebuffer_work;
 	atomic_t usb_active; /* 0 = update virtual buffer, but no usb traffic */
 	atomic_t lost_pixels; /* 1 = a render op failed. Need screen refresh */
 	char *edid; /* null until we read edid from hw or get from sysfs */


