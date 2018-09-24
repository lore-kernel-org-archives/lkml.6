Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE099C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36262083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36262083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbeIXSkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:40:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387792AbeIXSkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:40:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D25681097;
        Mon, 24 Sep 2018 12:38:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.18 123/235] usb: Avoid use-after-free by flushing endpoints early in usb_set_interface()
Date:   Mon, 24 Sep 2018 13:51:49 +0200
Message-Id: <20180924113118.409699898@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit f9a5b4f58b280c1d26255376713c132f93837621 upstream.

The steps taken by usb core to set a new interface is very different from
what is done on the xHC host side.

xHC hardware will do everything in one go. One command is used to set up
new endpoints, free old endpoints, check bandwidth, and run the new
endpoints.

All this is done by xHC when usb core asks the hcd to check for
available bandwidth. At this point usb core has not yet flushed the old
endpoints, which will cause use-after-free issues in xhci driver as
queued URBs are cancelled on a re-allocated endpoint.

To resolve this add a call to usb_disable_interface() which will flush
the endpoints before calling usb_hcd_alloc_bandwidth()

Additional checks in xhci driver will also be implemented to gracefully
handle stale URB cancel on freed and re-allocated endpoints

Cc: <stable@vger.kernel.org>
Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/message.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1340,6 +1340,11 @@ void usb_enable_interface(struct usb_dev
  * is submitted that needs that bandwidth.  Some other operating systems
  * allocate bandwidth early, when a configuration is chosen.
  *
+ * xHCI reserves bandwidth and configures the alternate setting in
+ * usb_hcd_alloc_bandwidth(). If it fails the original interface altsetting
+ * may be disabled. Drivers cannot rely on any particular alternate
+ * setting being in effect after a failure.
+ *
  * This call is synchronous, and may not be used in an interrupt context.
  * Also, drivers must not change altsettings while urbs are scheduled for
  * endpoints in that interface; all such urbs must first be completed
@@ -1375,6 +1380,12 @@ int usb_set_interface(struct usb_device
 			 alternate);
 		return -EINVAL;
 	}
+	/*
+	 * usb3 hosts configure the interface in usb_hcd_alloc_bandwidth,
+	 * including freeing dropped endpoint ring buffers.
+	 * Make sure the interface endpoints are flushed before that
+	 */
+	usb_disable_interface(dev, iface, false);
 
 	/* Make sure we have enough bandwidth for this alternate interface.
 	 * Remove the current alt setting and add the new alt setting.


