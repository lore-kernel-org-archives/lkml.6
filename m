Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BC52087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BC52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeKPDXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:23:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:40256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387839AbeKPDXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:23:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8A07AD98;
        Thu, 15 Nov 2018 17:14:22 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     nsaaenzjulienne@suse.de, linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: hub: add I/O error retry & reset routine
Date:   Thu, 15 Nov 2018 18:14:18 +0100
Message-Id: <20181115171418.23522-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An URB submission error in the HUB's endpoint completion function
renders the whole HUB device unresponsive. This patch introduces a
routine that retries the submission for 1s to then, as a last resort,
reset the whole device.

The implementation is based on usbhid/hid_core.c's, which implements the
same functionality. It was tested with the help of BCC's error injection
tool (inject.py).

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/core/hub.c | 43 +++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/core/hub.h |  3 +++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index d9bd7576786a..1447bdba59ec 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -607,6 +607,44 @@ static int hub_port_status(struct usb_hub *hub, int port1,
 				   status, change, NULL);
 }
 
+static void hub_io_error(struct usb_hub *hub)
+{
+	/*
+	 * If it has been a while since the last error, we'll assume
+	 * this a brand new error and reset the retry timeout.
+	 */
+	if (time_after(jiffies, hub->stop_retry + HZ/2))
+		hub->retry_delay = 0;
+
+	/* When an error occurs, retry at increasing intervals */
+	if (hub->retry_delay == 0) {
+		hub->retry_delay = 13;	/* Then 26, 52, 104, 104, ... */
+		hub->stop_retry = jiffies + msecs_to_jiffies(1000);
+	} else if (hub->retry_delay < 100)
+		hub->retry_delay *= 2;
+
+	if (time_after(jiffies, hub->stop_retry)) {
+		/* Retries failed, so do a port reset */
+		usb_queue_reset_device(to_usb_interface(hub->intfdev));
+		return;
+	}
+
+	mod_timer(&hub->io_retry,
+			jiffies + msecs_to_jiffies(hub->retry_delay));
+}
+
+static void hub_retry_timeout(struct timer_list *t)
+{
+	struct usb_hub *hub = from_timer(hub, t, io_retry);
+
+	if (hub->disconnected || hub->quiescing)
+		return;
+
+	dev_err(hub->intfdev, "retrying int urb\n");
+	if (usb_submit_urb(hub->urb, GFP_ATOMIC))
+		hub_io_error(hub);
+}
+
 static void kick_hub_wq(struct usb_hub *hub)
 {
 	struct usb_interface *intf;
@@ -713,8 +751,10 @@ static void hub_irq(struct urb *urb)
 		return;
 
 	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
-	if (status != 0 && status != -ENODEV && status != -EPERM)
+	if (status != 0 && status != -ENODEV && status != -EPERM) {
 		dev_err(hub->intfdev, "resubmit --> %d\n", status);
+		hub_io_error(hub);
+	}
 }
 
 /* USB 2.0 spec Section 11.24.2.3 */
@@ -1800,6 +1840,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
+	timer_setup(&hub->io_retry, hub_retry_timeout, 0);
 	usb_get_intf(intf);
 	usb_get_dev(hdev);
 
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 4accfb63f7dc..7dbd19c2c8d9 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -69,6 +69,9 @@ struct usb_hub {
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
 	struct work_struct      events;
+	struct timer_list	io_retry;
+	unsigned long		stop_retry;
+	unsigned int		retry_delay;
 	struct usb_port		**ports;
 };
 
-- 
2.19.1

