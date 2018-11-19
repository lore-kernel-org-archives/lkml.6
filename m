Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0002DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBDF2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBDF2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeKTA0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:26:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:53000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728258AbeKTA0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:26:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD453AF4D;
        Mon, 19 Nov 2018 14:02:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     oneukum@suse.com, stern@rowland.harvard.edu
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2] usb: hub: add retry routine after intr URB sumbit error
Date:   Mon, 19 Nov 2018 15:02:08 +0100
Message-Id: <20181119140208.11590-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hub sends hot-plug events to the host trough it's interrupt URB. The
driver takes care of completing the URB and re-submitting it. Completion
errors are handled in the hub_event() work, yet submission errors are
ignored, rendering the device unresponsive. All further events are lost.

It is fairly hard to find this issue in the wild, since you have to time
the USB hot-plug event with the URB submission failure. For instance it
could be the system running out of memory or some malfunction in the USB
controller driver. Nevertheless, it's pretty reasonable to think it'll
happen sometime. One can trigger this issue using eBPF's function
override feature (see BCC's inject.py script).

This patch adds a retry routine to the event of a submission error. The
HUB driver will try to re-submit the URB once every second until it's
successful or the HUB is disconnected.

As some USB subsystems already take care of this issue, the
implementation was inspired from usbhid/hid_core.c's.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

v2: as per Alan's and Oliver's comments:
  - Rename timer
  - Delete the timer on disconnect
  - Don't reset HUB nor exponential slowdown the timer, 1s fixed retry
    period
  - Check for -ESHUTDOWN prior kicking the timer

 drivers/usb/core/hub.c | 24 +++++++++++++++++++++++-
 drivers/usb/core/hub.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c6077d582d29..937ece45ea1f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -607,6 +607,22 @@ static int hub_port_status(struct usb_hub *hub, int port1,
 				   status, change, NULL);
 }
 
+static void hub_retry_irq_urb(struct timer_list *t)
+{
+	struct usb_hub *hub = from_timer(hub, t, irq_urb_retry);
+	int status;
+
+	if (hub->disconnected || hub->quiescing)
+		return;
+
+	dev_err(hub->intfdev, "retrying int urb\n");
+	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
+	if (status && status != -ENODEV && status != -EPERM &&
+	    status != -ESHUTDOWN)
+		mod_timer(&hub->irq_urb_retry,
+			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));
+}
+
 static void kick_hub_wq(struct usb_hub *hub)
 {
 	struct usb_interface *intf;
@@ -713,8 +729,12 @@ static void hub_irq(struct urb *urb)
 		return;
 
 	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
-	if (status != 0 && status != -ENODEV && status != -EPERM)
+	if (status != 0 && status != -ENODEV && status != -EPERM &&
+	    status != -ESHUTDOWN) {
 		dev_err(hub->intfdev, "resubmit --> %d\n", status);
+		mod_timer(&hub->irq_urb_retry,
+			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));
+	}
 }
 
 /* USB 2.0 spec Section 11.24.2.3 */
@@ -1268,6 +1288,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 	}
 
 	/* Stop hub_wq and related activity */
+	del_timer_sync(&hub->irq_urb_retry);
 	usb_kill_urb(hub->urb);
 	if (hub->has_indicators)
 		cancel_delayed_work_sync(&hub->leds);
@@ -1800,6 +1821,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
+	timer_setup(&hub->irq_urb_retry, hub_retry_irq_urb, 0);
 	usb_get_intf(intf);
 	usb_get_dev(hdev);
 
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 4accfb63f7dc..b0740cf5ef19 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -69,6 +69,7 @@ struct usb_hub {
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
 	struct work_struct      events;
+	struct timer_list	irq_urb_retry;
 	struct usb_port		**ports;
 };
 
-- 
2.19.1

