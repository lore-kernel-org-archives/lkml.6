Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AF7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D4220675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gbux4EPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeLQGDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:03:12 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53890 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbeLQGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:02:56 -0500
Received: from localhost.localdomain (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CCDC578;
        Mon, 17 Dec 2018 07:02:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545026574;
        bh=n+f4q5XHTOoWjr3QnVUQ3VZNJ+w78Rl3ArG2h481Qn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbux4EPiXEba3BtUOXV/IRJVo0jMFElUG3zAZEBg+0vuwNffz4RHuy0sguwrzFGwb
         wcq+ThG9dY0wE0NNpvkg0yM4f/s1SzQFuV69ECmfE8XCUD7qqfUxvWtObBcOCq8XsM
         wX5fpzGu35aJutzWwJyWb31Z3/3C+agC7AfdTubw=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] usb: gadget: add mechanism to specify an explicit status stage
Date:   Mon, 17 Dec 2018 01:02:14 -0500
Message-Id: <20181217060216.26368-5-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217060216.26368-1-paul.elder@ideasonboard.com>
References: <20181217060216.26368-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A usb gadget function driver may or may not want to delay the status
stage of a control OUT request. An instance it might want to is to
asynchronously validate the data of a class-specific request.

A function driver that wants an explicit status stage should set the
newly added explicit_status flag of the usb_request corresponding to the
data stage. Later on the function driver can explicitly complete the
status stage by enqueueing a usb_request also with the explicit_status
flag set, and with the zero flag set to 1 for ACK, or 0 for STALL.

To support both explicit and implicit status stages, a UDC driver must
call the newly added usb_gadget_control_complete function right after
calling usb_gadget_giveback_request. To support the explicit status
stage, it might then check what stage the usb_request was queued in, or
the explicit_status flag, and the zero flag for what status to send.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes from v1:

Complete change of API. Now we use a flag that should be set in the
usb_request that is queued for the data stage to signal to the UDC that
we want to delay the status stage (as opposed to setting a flag in the
UDC itself, that persists across all requests). We now also provide a
function for UDC drivers to very easily allow implicit status stages, to
mitigate the need to convert all function drivers to this new API at
once, and to make it easier for UDC drivers to convert.

 drivers/usb/gadget/udc/core.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h    | 10 ++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index af88b48c1cea..e99481ef9147 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -894,6 +894,39 @@ EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
 
 /* ------------------------------------------------------------------------- */
 
+/**
+ * usb_gadget_control_complete - complete the status stage of a control
+ *	request, or delay it
+ * Context: in_interrupt()
+ *
+ * @gadget: gadget whose control request's status stage should be completed
+ * @explicit_status: true to delay status stage, false to complete here
+ *
+ * This is called by device controller drivers after returning the completed
+ * request back to the gadget layer, to either complete or delay the status
+ * stage.
+ */
+void usb_gadget_control_complete(struct usb_gadget *gadget,
+		unsigned int explicit_status)
+{
+	struct usb_request *req;
+
+	if (explicit_status)
+		return;
+
+	/* Send an implicit status-stage request for ep0 */
+	req = usb_ep_alloc_request(gadget->ep0, GFP_ATOMIC);
+	if (req) {
+		req->length = 0;
+		req->explicit_status = 0;
+		req->complete = usb_ep_free_request;
+		usb_ep_queue(gadget->ep0, req, GFP_ATOMIC);
+	}
+}
+EXPORT_SYMBOL_GPL(usb_gadget_control_complete);
+
+/* ------------------------------------------------------------------------- */
+
 /**
  * gadget_find_ep_by_name - returns ep whose name is the same as sting passed
  *	in second parameter or NULL if searched endpoint not found
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e5cd84a0f84a..7a5283a224c7 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -73,6 +73,7 @@ struct usb_ep;
  *	Note that for writes (IN transfers) some data bytes may still
  *	reside in a device-side FIFO when the request is reported as
  *	complete.
+ * @explicit_status: If true, delays the status stage
  *
  * These are allocated/freed through the endpoint they're used with.  The
  * hardware's driver can add extra per-request data to the memory it returns,
@@ -114,6 +115,8 @@ struct usb_request {
 
 	int			status;
 	unsigned		actual;
+
+	unsigned		explicit_status:1;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -850,6 +853,13 @@ extern void usb_gadget_giveback_request(struct usb_ep *ep,
 
 /*-------------------------------------------------------------------------*/
 
+/* utility to complete or delay status stage */
+
+void usb_gadget_control_complete(struct usb_gadget *gadget,
+		unsigned int explicit_status);
+
+/*-------------------------------------------------------------------------*/
+
 /* utility to find endpoint by name */
 
 extern struct usb_ep *gadget_find_ep_by_name(struct usb_gadget *g,
-- 
2.19.2

