Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6537FC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8EE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/pr9Hed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8EE2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJIBtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbeJIBtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:49:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50B982064A;
        Mon,  8 Oct 2018 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023760;
        bh=iQed2jpXHaz2JILAoWfociJfzHOyMxmb48KFg4CDYzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/pr9HedR0twFmg776rFvs0wlFvqrt9zLInZRtjNfMs0/eutwfDSsp00N99iRQEvo
         cdwHlIW49Ds0igfllJsgvWZxLeXy+5/SK2hkN25g4kY0yeP4RBVR8SgSxDEYXqEZC6
         1KeDJO3xyb1T9JlGlU0ucMqCdSPqb36W9AK1sKpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+f84aa7209ccec829536f@syzkaller.appspotmail.com
Subject: [PATCH 4.4 050/113] USB: fix error handling in usb_driver_claim_interface()
Date:   Mon,  8 Oct 2018 20:30:51 +0200
Message-Id: <20181008175533.475911626@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -562,6 +562,21 @@ int usb_driver_claim_interface(struct us
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


