Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeENOkx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:40:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37444 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbeENOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:40:40 -0400
X-Google-Smtp-Source: AB8JxZqSzPY+56pUhoRnCELbWrkykXhkMUACq1W+7qtHJoZpbu97TIbyWxEPSmh8RRjxVc9kjBPJpQ==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc: konrad.wilk@oracle.com, andr2000@gmail.com, andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v3 2/2] Input: xen-kbdfront - allow better run-time configuration
Date: Mon, 14 May 2018 17:40:29 +0300
Message-Id: <20180514144029.16019-2-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514144029.16019-1-andr2000@gmail.com>
References: <20180514144029.16019-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

It is now only possible to control if multi-touch virtual device
is created or not (via the corresponding XenStore entries),
but keyboard and pointer devices are always created.
In some cases this is not desirable. For example, if virtual
keyboard device is exposed to Android then the latter won't
automatically show on-screen keyboard as it expects that a
physical keyboard device can be used for typing.

Utilize keyboard and pointer device XenStore feature fields to
configure which virtual devices are created:
 - set "feature-disable-keyboard" to 1 if no keyboard device
   needs to be created
 - set "feature-disable-pointer" to 1 if no pointer device
   needs to be created
Keep old behavior by default.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Suggested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
Tested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
---

Changes since v2:
- based on XenStore kbdif features to control which devices are
  exposed instead of module parameters.

 drivers/input/misc/xen-kbdfront.c | 172 ++++++++++++++++++------------
 1 file changed, 101 insertions(+), 71 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index d91f3b1c5375..0f166e11c421 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -63,6 +63,9 @@ static void xenkbd_disconnect_backend(struct xenkbd_info *);
 static void xenkbd_handle_motion_event(struct xenkbd_info *info,
 				       struct xenkbd_motion *motion)
 {
+	if (unlikely(!info->ptr))
+		return;
+
 	input_report_rel(info->ptr, REL_X, motion->rel_x);
 	input_report_rel(info->ptr, REL_Y, motion->rel_y);
 	if (motion->rel_z)
@@ -73,6 +76,9 @@ static void xenkbd_handle_motion_event(struct xenkbd_info *info,
 static void xenkbd_handle_position_event(struct xenkbd_info *info,
 					 struct xenkbd_position *pos)
 {
+	if (unlikely(!info->ptr))
+		return;
+
 	input_report_abs(info->ptr, ABS_X, pos->abs_x);
 	input_report_abs(info->ptr, ABS_Y, pos->abs_y);
 	if (pos->rel_z)
@@ -97,6 +103,9 @@ static void xenkbd_handle_key_event(struct xenkbd_info *info,
 		return;
 	}
 
+	if (unlikely(!dev))
+		return;
+
 	input_event(dev, EV_KEY, key->keycode, value);
 	input_sync(dev);
 }
@@ -192,7 +201,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
 				  const struct xenbus_device_id *id)
 {
 	int ret, i;
-	unsigned int abs, touch;
+	bool with_mtouch, with_kbd, with_ptr;
 	struct xenkbd_info *info;
 	struct input_dev *kbd, *ptr, *mtouch;
 
@@ -211,93 +220,114 @@ static int xenkbd_probe(struct xenbus_device *dev,
 	if (!info->page)
 		goto error_nomem;
 
-	/* Set input abs params to match backend screen res */
-	abs = xenbus_read_unsigned(dev->otherend,
-				   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
-	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
-						  XENKBD_FIELD_WIDTH,
-						  ptr_size[KPARAM_X]);
-	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
-						  XENKBD_FIELD_HEIGHT,
-						  ptr_size[KPARAM_Y]);
-	if (abs) {
-		ret = xenbus_write(XBT_NIL, dev->nodename,
-				   XENKBD_FIELD_REQ_ABS_POINTER, "1");
-		if (ret) {
-			pr_warn("xenkbd: can't request abs-pointer\n");
-			abs = 0;
-		}
-	}
+	/*
+	 * The below are reverse logic, e.g. if the feature is set, then
+	 * do not expose the corresponding virtual device.
+	 */
+	with_kbd = !xenbus_read_unsigned(dev->nodename,
+					 XENKBD_FIELD_FEAT_DSBL_KEYBRD, 0);
 
-	touch = xenbus_read_unsigned(dev->nodename,
-				     XENKBD_FIELD_FEAT_MTOUCH, 0);
-	if (touch) {
+	with_ptr = !xenbus_read_unsigned(dev->nodename,
+					 XENKBD_FIELD_FEAT_DSBL_POINTER, 0);
+
+	/* Direct logic: if set, then create multi-touch device. */
+	with_mtouch = xenbus_read_unsigned(dev->nodename,
+					   XENKBD_FIELD_FEAT_MTOUCH, 0);
+	if (with_mtouch) {
 		ret = xenbus_write(XBT_NIL, dev->nodename,
 				   XENKBD_FIELD_REQ_MTOUCH, "1");
 		if (ret) {
 			pr_warn("xenkbd: can't request multi-touch");
-			touch = 0;
+			with_mtouch = 0;
 		}
 	}
 
 	/* keyboard */
-	kbd = input_allocate_device();
-	if (!kbd)
-		goto error_nomem;
-	kbd->name = "Xen Virtual Keyboard";
-	kbd->phys = info->phys;
-	kbd->id.bustype = BUS_PCI;
-	kbd->id.vendor = 0x5853;
-	kbd->id.product = 0xffff;
-
-	__set_bit(EV_KEY, kbd->evbit);
-	for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
-		__set_bit(i, kbd->keybit);
-	for (i = KEY_OK; i < KEY_MAX; i++)
-		__set_bit(i, kbd->keybit);
-
-	ret = input_register_device(kbd);
-	if (ret) {
-		input_free_device(kbd);
-		xenbus_dev_fatal(dev, ret, "input_register_device(kbd)");
-		goto error;
+	if (with_kbd) {
+		kbd = input_allocate_device();
+		if (!kbd)
+			goto error_nomem;
+		kbd->name = "Xen Virtual Keyboard";
+		kbd->phys = info->phys;
+		kbd->id.bustype = BUS_PCI;
+		kbd->id.vendor = 0x5853;
+		kbd->id.product = 0xffff;
+
+		__set_bit(EV_KEY, kbd->evbit);
+		for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
+			__set_bit(i, kbd->keybit);
+		for (i = KEY_OK; i < KEY_MAX; i++)
+			__set_bit(i, kbd->keybit);
+
+		ret = input_register_device(kbd);
+		if (ret) {
+			input_free_device(kbd);
+			xenbus_dev_fatal(dev, ret,
+					 "input_register_device(kbd)");
+			goto error;
+		}
+		info->kbd = kbd;
 	}
-	info->kbd = kbd;
 
 	/* pointing device */
-	ptr = input_allocate_device();
-	if (!ptr)
-		goto error_nomem;
-	ptr->name = "Xen Virtual Pointer";
-	ptr->phys = info->phys;
-	ptr->id.bustype = BUS_PCI;
-	ptr->id.vendor = 0x5853;
-	ptr->id.product = 0xfffe;
-
-	if (abs) {
-		__set_bit(EV_ABS, ptr->evbit);
-		input_set_abs_params(ptr, ABS_X, 0, ptr_size[KPARAM_X], 0, 0);
-		input_set_abs_params(ptr, ABS_Y, 0, ptr_size[KPARAM_Y], 0, 0);
-	} else {
-		input_set_capability(ptr, EV_REL, REL_X);
-		input_set_capability(ptr, EV_REL, REL_Y);
-	}
-	input_set_capability(ptr, EV_REL, REL_WHEEL);
+	if (with_ptr) {
+		unsigned int abs;
+
+		/* Set input abs params to match backend screen res */
+		abs = xenbus_read_unsigned(dev->otherend,
+					   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
+		ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
+							  XENKBD_FIELD_WIDTH,
+							  ptr_size[KPARAM_X]);
+		ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
+							  XENKBD_FIELD_HEIGHT,
+							  ptr_size[KPARAM_Y]);
+		if (abs) {
+			ret = xenbus_write(XBT_NIL, dev->nodename,
+					   XENKBD_FIELD_REQ_ABS_POINTER, "1");
+			if (ret) {
+				pr_warn("xenkbd: can't request abs-pointer\n");
+				abs = 0;
+			}
+		}
 
-	__set_bit(EV_KEY, ptr->evbit);
-	for (i = BTN_LEFT; i <= BTN_TASK; i++)
-		__set_bit(i, ptr->keybit);
+		ptr = input_allocate_device();
+		if (!ptr)
+			goto error_nomem;
+		ptr->name = "Xen Virtual Pointer";
+		ptr->phys = info->phys;
+		ptr->id.bustype = BUS_PCI;
+		ptr->id.vendor = 0x5853;
+		ptr->id.product = 0xfffe;
+
+		if (abs) {
+			__set_bit(EV_ABS, ptr->evbit);
+			input_set_abs_params(ptr, ABS_X, 0,
+					     ptr_size[KPARAM_X], 0, 0);
+			input_set_abs_params(ptr, ABS_Y, 0,
+					     ptr_size[KPARAM_Y], 0, 0);
+		} else {
+			input_set_capability(ptr, EV_REL, REL_X);
+			input_set_capability(ptr, EV_REL, REL_Y);
+		}
+		input_set_capability(ptr, EV_REL, REL_WHEEL);
 
-	ret = input_register_device(ptr);
-	if (ret) {
-		input_free_device(ptr);
-		xenbus_dev_fatal(dev, ret, "input_register_device(ptr)");
-		goto error;
+		__set_bit(EV_KEY, ptr->evbit);
+		for (i = BTN_LEFT; i <= BTN_TASK; i++)
+			__set_bit(i, ptr->keybit);
+
+		ret = input_register_device(ptr);
+		if (ret) {
+			input_free_device(ptr);
+			xenbus_dev_fatal(dev, ret,
+					 "input_register_device(ptr)");
+			goto error;
+		}
+		info->ptr = ptr;
 	}
-	info->ptr = ptr;
 
 	/* multi-touch device */
-	if (touch) {
+	if (with_mtouch) {
 		int num_cont, width, height;
 
 		mtouch = input_allocate_device();
-- 
2.17.0
