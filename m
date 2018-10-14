Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBEBC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBAE20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBAE20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeJNX23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:28:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37258 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbeJNX22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:28:28 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMF-0004cC-QQ; Sun, 14 Oct 2018 16:31:07 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000CS-Pl; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Zhengjun Xing" <zhengjun.xing@linux.intel.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.281237299@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 049/366] USB:fix USB3 devices behind USB3 hubs not
 resuming at hibernate thaw
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit 64627388b50158fd24d6ad88132525b95a5ef573 upstream.

USB3 hubs don't support global suspend.

USB3 specification 10.10, Enhanced SuperSpeed hubs only support selective
suspend and resume, they do not support global suspend/resume where the
hub downstream facing ports states are not affected.

When system enters hibernation it first enters freeze process where only
the root hub enters suspend, usb_port_suspend() is not called for other
devices, and suspend status flags are not set for them. Other devices are
expected to suspend globally. Some external USB3 hubs will suspend the
downstream facing port at global suspend. These devices won't be resumed
at thaw as the suspend status flag is not set.

A USB3 removable hard disk connected through a USB3 hub that won't resume
at thaw will fail to synchronize SCSI cache, return “cmd cmplt err -71”
error, and needs a 60 seconds timeout which causing system hang for 60s
before the USB host reset the port for the USB3 removable hard disk to
recover.

Fix this by always calling usb_port_suspend() during freeze for USB3
devices.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -208,8 +208,13 @@ static int generic_suspend(struct usb_de
 	if (!udev->parent)
 		rc = hcd_bus_suspend(udev, msg);
 
-	/* Non-root devices don't need to do anything for FREEZE or PRETHAW */
-	else if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_PRETHAW)
+	/*
+	 * Non-root USB2 devices don't need to do anything for FREEZE
+	 * or PRETHAW. USB3 devices don't support global suspend and
+	 * needs to be selectively suspended.
+	 */
+	else if ((msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_PRETHAW)
+		 && (udev->speed < USB_SPEED_SUPER))
 		rc = 0;
 	else
 		rc = usb_port_suspend(udev, msg);

