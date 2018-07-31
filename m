Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E7820862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E7820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeGaJRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:17:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41275 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:17:03 -0400
Received: from 1-161-146-33.dynamic-ip.hinet.net ([1.161.146.33] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fkPEH-00087e-V7; Tue, 31 Jul 2018 07:38:02 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     acelan.kao@canonical.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Bluetooth: btusb: Disable Bluetooth controller during S3
Date:   Tue, 31 Jul 2018 15:37:57 +0800
Message-Id: <20180731073757.14561-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've found there are several systems got woken up from S3 by Bluetooth
controller.

We do want the system to be able to be woken up by Bluetooth devices
from Suspend2Idle, but not from S3.

Unconditionally disables Bluetooth controller during S3 to avoid this
issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199451
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200039
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 572fd75fbcf6..60f2832c4ff2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3290,6 +3290,9 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		enable_irq(data->oob_wake_irq);
 	}
 
+	if (!PMSG_IS_AUTO(message) && pm_suspend_via_firmware())
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_DISCONNECT_SUSPEND;
+
 	return 0;
 }
 
@@ -3334,6 +3337,9 @@ static int btusb_resume(struct usb_interface *intf)
 	if (--data->suspend_count)
 		return 0;
 
+	if (pm_resume_via_firmware())
+		interface_to_usbdev(intf)->quirks &= ~USB_QUIRK_DISCONNECT_SUSPEND;
+
 	/* Disable only if not already disabled (keep it balanced) */
 	if (test_and_clear_bit(BTUSB_OOB_WAKE_ENABLED, &data->flags)) {
 		disable_irq(data->oob_wake_irq);
-- 
2.17.1

