Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B934AC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F502206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F502206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbeJBUMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:12:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeJBUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:49 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A89C1C11;
        Tue,  2 Oct 2018 13:29:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+f84aa7209ccec829536f@syzkaller.appspotmail.com
Subject: [PATCH 4.18 148/228] USB: fix error handling in usb_driver_claim_interface()
Date:   Tue,  2 Oct 2018 06:24:05 -0700
Message-Id: <20181002132509.147511832@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Alan Stern <stern@rowland.harvard.edu>

commit bd729f9d67aa9a303d8925bb8c4f06af25f407d1 upstream.

The syzbot fuzzing project found a use-after-free bug in the USB
core.  The bug was caused by usbfs not unbinding from an interface
when the USB device file was closed, which led another process to
attempt the unbind later on, after the private data structure had been
deallocated.

The reason usbfs did not unbind the interface at the appropriate time
was because it thought the interface had never been claimed in the
first place.  This was caused by the fact that
usb_driver_claim_interface() does not clean up properly when
device_bind_driver() returns an error.  Although the error code gets
passed back to the caller, the iface->dev.driver pointer remains set
and iface->condition remains equal to USB_INTERFACE_BOUND.

This patch adds proper error handling to usb_driver_claim_interface().

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: syzbot+f84aa7209ccec829536f@syzkaller.appspotmail.com
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/driver.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -565,6 +565,21 @@ int usb_driver_claim_interface(struct us
 	if (!lpm_disable_error)
 		usb_unlocked_enable_lpm(udev);
 
+	if (retval) {
+		dev->driver = NULL;
+		usb_set_intfdata(iface, NULL);
+		iface->needs_remote_wakeup = 0;
+		iface->condition = USB_INTERFACE_UNBOUND;
+
+		/*
+		 * Unbound interfaces are always runtime-PM-disabled
+		 * and runtime-PM-suspended
+		 */
+		if (driver->supports_autosuspend)
+			pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+	}
+
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_driver_claim_interface);


