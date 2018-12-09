Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4673C20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4673C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeLIWF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:05:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36998 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727664AbeLIWFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:05:49 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002io-1j; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003Vf-Fi; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>,
        "Alan Stern" <stern@rowland.harvard.edu>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.163798173@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 207/328] usb: Avoid use-after-free by flushing
 endpoints early in usb_set_interface()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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

Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/message.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1284,6 +1284,11 @@ void usb_enable_interface(struct usb_dev
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
@@ -1319,6 +1324,12 @@ int usb_set_interface(struct usb_device
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

