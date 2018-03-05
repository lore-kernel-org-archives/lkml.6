Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeCEWZK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:25:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37822 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753664AbeCEWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:25:08 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 32/38] drm/rockchip: Disable PSR on input events
Date: Mon,  5 Mar 2018 23:23:24 +0100
Message-Id: <20180305222324.5872-33-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kristian H. Kristensen" <hoegsberg@google.com>

To improve PSR exit latency, we speculatively start exiting when we
receive input events. Occasionally, this may lead to false positives,
but most of the time we get a head start on coming out of PSR. Depending
on how userspace takes to produce a new frame in response to the event,
this can completely hide the exit latency. In case of Chrome OS, we
typically get the input notifier 50ms or more before the dirty_fb
triggered exit.

Signed-off-by: Kristian H. Kristensen <hoegsberg@google.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 134 ++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 9376f4396b6b..a107845ba97c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -12,6 +12,8 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/input.h>
+
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 
@@ -35,6 +37,9 @@ struct psr_drv {
 	enum psr_state		state;
 
 	struct delayed_work	flush_work;
+	struct work_struct	disable_work;
+
+	struct input_handler    input_handler;
 
 	int (*set)(struct drm_encoder *encoder, bool enable);
 };
@@ -133,6 +138,18 @@ static void psr_flush_handler(struct work_struct *work)
 	mutex_unlock(&psr->lock);
 }
 
+static void psr_disable_handler(struct work_struct *work)
+{
+	struct psr_drv *psr = container_of(work, struct psr_drv, disable_work);
+
+	/* If the state has changed since we initiated the flush, do nothing */
+	mutex_lock(&psr->lock);
+	if (psr->state == PSR_ENABLE)
+		psr_set_state_locked(psr, PSR_FLUSH);
+	mutex_unlock(&psr->lock);
+	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
+}
+
 /**
  * rockchip_drm_psr_activate - activate PSR on the given pipe
  * @encoder: encoder to obtain the PSR encoder
@@ -173,6 +190,7 @@ int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
 	psr->active = false;
 	mutex_unlock(&psr->lock);
 	cancel_delayed_work_sync(&psr->flush_work);
+	cancel_work_sync(&psr->disable_work);
 
 	return 0;
 }
@@ -226,6 +244,95 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev)
 }
 EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
 
+static void psr_input_event(struct input_handle *handle,
+			    unsigned int type, unsigned int code,
+			    int value)
+{
+	struct psr_drv *psr = handle->handler->private;
+
+	schedule_work(&psr->disable_work);
+}
+
+static int psr_input_connect(struct input_handler *handler,
+			     struct input_dev *dev,
+			     const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = "rockchip-psr";
+
+	error = input_register_handle(handle);
+	if (error)
+		goto err2;
+
+	error = input_open_device(handle);
+	if (error)
+		goto err1;
+
+	return 0;
+
+err1:
+	input_unregister_handle(handle);
+err2:
+	kfree(handle);
+	return error;
+}
+
+static void psr_input_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+/* Same device ids as cpu-boost */
+static const struct input_device_id psr_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+			 INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT_MASK(EV_ABS) },
+		.absbit = { [BIT_WORD(ABS_MT_POSITION_X)] =
+			    BIT_MASK(ABS_MT_POSITION_X) |
+			    BIT_MASK(ABS_MT_POSITION_Y) },
+	}, /* multi-touch touchscreen */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_ABS) },
+		.absbit = { [BIT_WORD(ABS_X)] = BIT_MASK(ABS_X) }
+
+	}, /* stylus or joystick device */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(BTN_LEFT)] = BIT_MASK(BTN_LEFT) },
+	}, /* pointer (e.g. trackpad, mouse) */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(KEY_ESC)] = BIT_MASK(KEY_ESC) },
+	}, /* keyboard */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = {[BIT_WORD(BTN_JOYSTICK)] = BIT_MASK(BTN_JOYSTICK) },
+	}, /* joysticks not caught by ABS_X above */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(BTN_GAMEPAD)] = BIT_MASK(BTN_GAMEPAD) },
+	}, /* gamepad */
+	{ },
+};
+
 /**
  * rockchip_drm_psr_register - register encoder to psr driver
  * @encoder: encoder that obtain the PSR function
@@ -239,6 +346,7 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr;
+	int error;
 
 	if (!encoder || !psr_set)
 		return -EINVAL;
@@ -248,6 +356,7 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 		return -ENOMEM;
 
 	INIT_DELAYED_WORK(&psr->flush_work, psr_flush_handler);
+	INIT_WORK(&psr->disable_work, psr_disable_handler);
 	mutex_init(&psr->lock);
 
 	psr->active = true;
@@ -255,11 +364,33 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 	psr->encoder = encoder;
 	psr->set = psr_set;
 
+	psr->input_handler.event = psr_input_event;
+	psr->input_handler.connect = psr_input_connect;
+	psr->input_handler.disconnect = psr_input_disconnect;
+	psr->input_handler.name =
+		kasprintf(GFP_KERNEL, "rockchip-psr-%s", encoder->name);
+	if (!psr->input_handler.name) {
+		error = -ENOMEM;
+		goto err2;
+	}
+	psr->input_handler.id_table = psr_ids;
+	psr->input_handler.private = psr;
+
+	error = input_register_handler(&psr->input_handler);
+	if (error)
+		goto err1;
+
 	mutex_lock(&drm_drv->psr_list_lock);
 	list_add_tail(&psr->list, &drm_drv->psr_list);
 	mutex_unlock(&drm_drv->psr_list_lock);
 
 	return 0;
+
+ err1:
+	kfree(psr->input_handler.name);
+ err2:
+	kfree(psr);
+	return error;
 }
 EXPORT_SYMBOL(rockchip_drm_psr_register);
 
@@ -279,8 +410,11 @@ void rockchip_drm_psr_unregister(struct drm_encoder *encoder)
 	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry_safe(psr, n, &drm_drv->psr_list, list) {
 		if (psr->encoder == encoder) {
+			input_unregister_handler(&psr->input_handler);
 			cancel_delayed_work_sync(&psr->flush_work);
+			cancel_work_sync(&psr->disable_work);
 			list_del(&psr->list);
+			kfree(psr->input_handler.name);
 			kfree(psr);
 		}
 	}
-- 
2.16.1
