Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1E2C4161B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF290214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CS7ZTfns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF290214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJJKJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:09:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44280 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeJJKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:09:23 -0400
Received: from garnet.amanokami.net (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D7A991C1D;
        Wed, 10 Oct 2018 04:49:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539139765;
        bh=IFgcyVHcjFLgyNIfLwBnAtX8aNSKPm6W8hUPJslYMg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CS7ZTfnsisL/GtZiY/WXTTXdnJX+0vNngeq6fZgmhH6KB4J2Lh423XGe4/W2tF52W
         xeA6dhTro/ZJhDWNuvrySUTSH42ymJtayo3EsDzoGYoFvw7mOWMp1ruRJOTfqUCOTd
         JEka7AdGphTE3aYAT/4g1Yt8+GMDlw8YmKqICVM0=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Subject: [PATCH 4/6] usb: gadget: add functions to signal udc driver to delay status stage
Date:   Tue,  9 Oct 2018 22:49:01 -0400
Message-Id: <20181010024903.1633-5-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181010024903.1633-1-paul.elder@ideasonboard.com>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A usb gadget function driver may or may not want to delay the status
stage of a control OUT request. An instance it might want to is to
asynchronously validate the data of a class-specific request.

Add a function usb_ep_delay_status to allow function drivers to choose
to delay the status stage in the request completion handler. The UDC
should then check the usb_ep->delayed_status flag and act accordingly to
delay the status stage.

Also add a function usb_ep_send_response as a wrapper for
usb_ep->ops->send_response, whose prototype is added as well. This
function should be called by function drivers to tell the UDC what to
reply in the status stage that it has requested to be delayed.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/usb/gadget/udc/core.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h    | 11 +++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index af88b48c1cea..1ec5ce6b43cd 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -443,6 +443,41 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
 
+/**
+ * usb_ep_ep_delay_status - set delay_status flag
+ * @ep: the endpoint whose delay_status flag is being set
+ *
+ * This function instructs the UDC to delay the status stage of a control
+ * request. It can only be called from the request completion handler of a
+ * control request.
+ */
+void usb_ep_delay_status(struct usb_ep *ep)
+{
+	ep->delayed_status = true;
+}
+EXPORT_SYMBOL_GPL(usb_ep_delay_status);
+
+/**
+ * usb_ep_send_response - reply to control OUT request
+ * @ep: the endpoint to send reply
+ * @stall: true for STALL, false for ACK
+ *
+ * Instruct the UDC to complete the status stage of a control request that was
+ * previously delayed with a call to usb_ep_delay_status().
+ */
+int usb_ep_send_response(struct usb_ep *ep, bool stall)
+{
+	if (!ep->ops->send_response)
+		return -ENOSYS;
+
+	if (!ep->delayed_status)
+		return -EINVAL;
+
+	ep->delayed_status = false;
+	return ep->ops->send_response(ep, stall);
+}
+EXPORT_SYMBOL_GPL(usb_ep_send_response);
+
 /* ------------------------------------------------------------------------- */
 
 /**
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e5cd84a0f84a..d39c221d4b68 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -144,6 +144,8 @@ struct usb_ep_ops {
 
 	int (*fifo_status) (struct usb_ep *ep);
 	void (*fifo_flush) (struct usb_ep *ep);
+
+	int (*send_response) (struct usb_ep *ep, bool stall);
 };
 
 /**
@@ -209,6 +211,8 @@ struct usb_ep_caps {
  *	enabled and remains valid until the endpoint is disabled.
  * @comp_desc: In case of SuperSpeed support, this is the endpoint companion
  *	descriptor that is used to configure the endpoint
+ * @delayed_status: True if status stage is being delayed. Valid only for
+ *	control endpoints.
  *
  * the bus controller driver lists all the general purpose endpoints in
  * gadget->ep_list.  the control endpoint (gadget->ep0) is not in that list,
@@ -232,6 +236,7 @@ struct usb_ep {
 	u8			address;
 	const struct usb_endpoint_descriptor	*desc;
 	const struct usb_ss_ep_comp_descriptor	*comp_desc;
+	bool			delayed_status;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -249,6 +254,8 @@ int usb_ep_clear_halt(struct usb_ep *ep);
 int usb_ep_set_wedge(struct usb_ep *ep);
 int usb_ep_fifo_status(struct usb_ep *ep);
 void usb_ep_fifo_flush(struct usb_ep *ep);
+void usb_ep_delay_status(struct usb_ep *ep);
+int usb_ep_send_response(struct usb_ep *ep, bool stall);
 #else
 static inline void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
 		unsigned maxpacket_limit)
@@ -278,6 +285,10 @@ static inline int usb_ep_fifo_status(struct usb_ep *ep)
 { return 0; }
 static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 { }
+static inline void usb_ep_delay_status(struct usb_ep *ep)
+{ }
+static inline int usb_ep_send_response(struct usb_ep *ep, bool stall)
+{ }
 #endif /* USB_GADGET */
 
 /*-------------------------------------------------------------------------*/
-- 
2.18.0

