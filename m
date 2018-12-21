Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD21C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A8621927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyEaJUCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbeLUVoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:44:39 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:33787 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388783AbeLUVoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:44:39 -0500
Received: by mail-qt1-f202.google.com with SMTP id k90so7356877qte.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3M95R2lYj1eiHAOwr1QaEJcZfmF9z6ovRwKgy9mSvwc=;
        b=PyEaJUCGwECfYVUpPhTcL6VqyTwmbLSeFy7KdlLJs3LlwEcjs8j7f1RPXA8xQDtK5M
         tFavruw+u9qOpBpkjEdOKhtbKV7qBVdqD1JfKyeUfQvLYUP8ilOI+Y9LvNh/V6S9ACKH
         1EddF5juwNy4DWV7Yaii9GkUu9xDx6KArHTdEe7uqtD2l8ZWtilIX0fpy+4VKyiCZWsc
         OBiC3aRd6j7nepVzsIeQ8t2LbuQoh2y5+GfEIqrtbrXnanEb/Z4rtOFt9O8eaJJxf//y
         5bVJ+kcqI+QqdEoHusKVeFt+2dU0iIKt3LbVyWtkTShvgo4UyxA0OC+dnwMo+euQ4VAs
         1NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3M95R2lYj1eiHAOwr1QaEJcZfmF9z6ovRwKgy9mSvwc=;
        b=NbU274Ubgtk/gF8npxcSlB3V5urNXlHae8SDGMPknk92YmY3LYZBNnQo3lKoGcHB2h
         amzUZbr88kgkfalvWv1cv5l3p34cq2A+9F8bYpi2XB5Mg6IdPU9UlBlVY+/4ekjbY9uz
         mm5+RCPMzi/MUmzMkemEGdeLT472TV5z4nuldjdJpjwuF3K4dWPcV5DsBmBD04wsvFp1
         ayntEE6v5cK1tpDL7kqvD4MkY2LVbDQDKFq+BNOYruZvy85+nNhGmNEUGHBSIQNTj/i2
         kiZQt/efPJPB/S3BDnw8SEw4hWqbPoj00n5wJ9IsxAq1h7ZJnVzHEpu6Ns2tqVtHG/dR
         65KA==
X-Gm-Message-State: AJcUukdATKA8piSVlZjGfqjv08KtZg70GLBZcN6iHeUxqf+5KQsmm4aP
        w1kne9IWBVIa1whhVfKunRyyBYuYuTL8ag==
X-Google-Smtp-Source: ALg8bN5acLn+CLiyArj42/fiMhnUMWAjKXnAH7f91Ga8ig/o6Sltt3RBLy1pAAfLplxsqrGqCFiCFfu1135B9g==
X-Received: by 2002:a37:12e1:: with SMTP id 94mr2738085qks.25.1545428677545;
 Fri, 21 Dec 2018 13:44:37 -0800 (PST)
Date:   Fri, 21 Dec 2018 13:44:33 -0800
In-Reply-To: <20181207222223.GA240898@google.com>
Message-Id: <20181221214433.256656-1-egranata@chromium.org>
Mime-Version: 1.0
References: <20181207222223.GA240898@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v2] mfd: cros_ec: Add support for MKBP more event flags
From:   <egranata@google.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@google.com>,
        Brian Norris <briannorris@google.com>,
        Enrico Granata <egranata@google.com>,
        Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

The ChromeOS EC has support for signaling to the host that
a single IRQ can serve multiple MKBP events.

Doing this serves an optimization purpose, as it minimizes the
number of round-trips into the interrupt handling machinery, and
it proves beneficial to sensor timestamping as it keeps the desired
synchronization of event times between the two processors.

This patch adds kernel support for this EC feature, allowing the
ec_irq to loop until all events have been served.

ChangeLog:
  - Cleanup incorrect comment in cros_ec.h

Signed-off-by: Enrico Granata <egranata@chromium.org>
---
 drivers/mfd/cros_ec.c                   | 20 +++++++++++++--
 drivers/platform/chrome/cros_ec_proto.c | 33 +++++++++++--------------
 include/linux/mfd/cros_ec.h             |  7 ++++--
 include/linux/mfd/cros_ec_commands.h    | 15 +++++++++++
 4 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index fe6f83766144f..17903a378aa1a 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -51,13 +51,16 @@ static const struct mfd_cell ec_pd_cell = {
 	.pdata_size = sizeof(pd_p),
 };
 
-static irqreturn_t ec_irq_thread(int irq, void *data)
+static bool ec_handle_event(struct cros_ec_device *ec_dev)
 {
-	struct cros_ec_device *ec_dev = data;
 	bool wake_event = true;
 	int ret;
+	bool ec_has_more_events = false;
 
 	ret = cros_ec_get_next_event(ec_dev, &wake_event);
+	if (ret > 0)
+		ec_has_more_events =
+			ec_dev->event_data.event_type & EC_MKBP_HAS_MORE_EVENTS;
 
 	/*
 	 * Signal only if wake host events or any interrupt if
@@ -70,6 +73,19 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
 	if (ret > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     0, ec_dev);
+
+	return ec_has_more_events;
+}
+
+static irqreturn_t ec_irq_thread(int irq, void *data)
+{
+	struct cros_ec_device *ec_dev = data;
+	bool ec_has_more_events;
+
+	do {
+		ec_has_more_events = ec_handle_event(ec_dev);
+	} while (ec_has_more_events);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b6fd4838f60f3..bb126d95b2fd4 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -420,10 +420,14 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
 						    EC_CMD_GET_NEXT_EVENT,
 						    &ver_mask);
-	if (ret < 0 || ver_mask == 0)
+	if (ret < 0 || ver_mask == 0) {
 		ec_dev->mkbp_event_supported = 0;
-	else
-		ec_dev->mkbp_event_supported = 1;
+		dev_info(ec_dev->dev, "MKBP not supported\n");
+	} else {
+		ec_dev->mkbp_event_supported = fls(ver_mask);
+		dev_info(ec_dev->dev, "MKBP support version %u\n",
+			ec_dev->mkbp_event_supported - 1);
+	}
 
 	/*
 	 * Get host event wake mask, assume all events are wake events
@@ -530,28 +534,19 @@ static int get_next_event(struct cros_ec_device *ec_dev)
 {
 	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
 	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
-	static int cmd_version = 1;
-	int ret;
+	const int cmd_version = ec_dev->mkbp_event_supported - 1;
 
 	if (ec_dev->suspended) {
 		dev_dbg(ec_dev->dev, "Device suspended.\n");
 		return -EHOSTDOWN;
 	}
 
-	if (cmd_version == 1) {
-		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
-				sizeof(struct ec_response_get_next_event_v1));
-		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
-			return ret;
-
-		/* Fallback to version 0 for future send attempts */
-		cmd_version = 0;
-	}
-
-	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
+	if (cmd_version == 0)
+		return get_next_event_xfer(ec_dev, msg, 0,
 				  sizeof(struct ec_response_get_next_event));
 
-	return ret;
+	return get_next_event_xfer(ec_dev, msg, cmd_version,
+				sizeof(struct ec_response_get_next_event_v1));
 }
 
 static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
@@ -607,11 +602,13 @@ EXPORT_SYMBOL(cros_ec_get_next_event);
 
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 {
+	u32 event_type =
+		ec_dev->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
 	u32 host_event;
 
 	BUG_ON(!ec_dev->mkbp_event_supported);
 
-	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
+	if (event_type != EC_MKBP_EVENT_HOST_EVENT)
 		return 0;
 
 	if (ec_dev->event_size != sizeof(host_event)) {
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index e44e3ec8a9c7d..cb07ee95a6eb8 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -119,7 +119,9 @@ struct cros_ec_command {
  *            code.
  * @pkt_xfer: Send packet to EC and get response.
  * @lock: One transaction at a time.
- * @mkbp_event_supported: True if this EC supports the MKBP event protocol.
+ * @mkbp_event_supported: 0 if MKBP not supported. Otherwise its value is
+ *                        the maximum supported version of the MKBP host event
+ *                        command + 1.
  * @event_notifier: Interrupt event notifier for transport devices.
  * @event_data: Raw payload transferred with the MKBP event.
  * @event_size: Size in bytes of the event data.
@@ -152,7 +154,8 @@ struct cros_ec_device {
 	int (*pkt_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
 	struct mutex lock;
-	bool mkbp_event_supported;
+	/* 0 == not supported, otherwise it supports version x - 1 */
+	u8 mkbp_event_supported;
 	struct blocking_notifier_head event_notifier;
 
 	struct ec_response_get_next_event_v1 event_data;
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 9a9631f0559e2..3f013593d0107 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2146,6 +2146,14 @@ struct ec_result_keyscan_seq_ctrl {
  */
 #define EC_CMD_GET_NEXT_EVENT 0x67
 
+#define EC_MKBP_HAS_MORE_EVENTS_SHIFT 7
+
+/* EC can provide more MKBP events to host */
+#define EC_MKBP_HAS_MORE_EVENTS (1 << EC_MKBP_HAS_MORE_EVENTS_SHIFT)
+
+/* The mask to apply to get the raw event type */
+#define EC_MKBP_EVENT_TYPE_MASK ((1 << EC_MKBP_HAS_MORE_EVENTS_SHIFT) - 1)
+
 enum ec_mkbp_event {
 	/* Keyboard matrix changed. The event data is the new matrix state. */
 	EC_MKBP_EVENT_KEY_MATRIX = 0,
@@ -2173,6 +2181,13 @@ enum ec_mkbp_event {
 
 	/* Number of MKBP events */
 	EC_MKBP_EVENT_COUNT,
+
+	/*
+	 * Maximum possible event type
+	 * The most significant bit of event type is used to indicate that
+	 * the EC has multiple events for the AP to serve
+	 */
+	EC_MKBP_EVENT_MAX_TYPE = EC_MKBP_EVENT_TYPE_MASK,
 };
 
 union ec_response_get_next_data {
-- 
2.20.1.415.g653613c723-goog

