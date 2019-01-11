Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3422F2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbfAKTyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:54:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388791AbfAKTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:54:37 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gi2t0-0005vJ-Qu; Fri, 11 Jan 2019 19:54:35 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] USB: Consolidate LPM checks to avoid enabling LPM twice
Date:   Sat, 12 Jan 2019 03:54:25 +0800
Message-Id: <20190111195425.11925-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190111195425.11925-1-kai.heng.feng@canonical.com>
References: <20190111195425.11925-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
after S3:
[ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
[ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)

After some experiments, I found that disabling LPM can workaround the
issue.

On some platforms, the USB power is cut during S3, so the driver uses
reset-resume to resume the device. During port resume, LPM gets enabled
twice, by usb_reset_and_verify_device() and usb_port_resume().

Consolidate all checks into new LPM helpers to make sure LPM only gets
enabled once.

Fixes: de68bab4fa96 ("usb: Don't enable USB 2.0 Link PM by default.”)
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/driver.c  | 11 ++++++++---
 drivers/usb/core/hub.c     | 12 ++++--------
 drivers/usb/core/message.c |  3 +--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index c276ffc5561f..8987cec9549d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1901,9 +1901,6 @@ static int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
 	int ret = -EPERM;
 
-	if (enable && !udev->usb2_hw_lpm_allowed)
-		return 0;
-
 	if (hcd->driver->set_usb2_hw_lpm) {
 		ret = hcd->driver->set_usb2_hw_lpm(hcd, udev, enable);
 		if (!ret)
@@ -1915,11 +1912,19 @@ static int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
 
 int usb_enable_usb2_hardware_lpm(struct usb_device *udev)
 {
+	if (!udev->usb2_hw_lpm_capable ||
+	    !udev->usb2_hw_lpm_allowed ||
+	    udev->usb2_hw_lpm_enabled)
+		return 0;
+
 	return usb_set_usb2_hardware_lpm(udev, 1);
 }
 
 int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
 {
+	if (!udev->usb2_hw_lpm_enabled)
+		return 0;
+
 	return usb_set_usb2_hardware_lpm(udev, 0);
 }
 
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ca38ff8124a7..55c87be5764c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3220,8 +3220,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 	}
 
 	/* disable USB2 hardware LPM */
-	if (udev->usb2_hw_lpm_enabled == 1)
-		usb_disable_usb2_hardware_lpm(udev);
+	usb_disable_usb2_hardware_lpm(udev);
 
 	if (usb_disable_ltm(udev)) {
 		dev_err(&udev->dev, "Failed to disable LTM before suspend\n");
@@ -3259,8 +3258,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		usb_enable_ltm(udev);
  err_ltm:
 		/* Try to enable USB2 hardware LPM again */
-		if (udev->usb2_hw_lpm_capable == 1)
-			usb_enable_usb2_hardware_lpm(udev);
+		usb_enable_usb2_hardware_lpm(udev);
 
 		if (udev->do_remote_wakeup)
 			(void) usb_disable_remote_wakeup(udev);
@@ -3543,8 +3541,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 		hub_port_logical_disconnect(hub, port1);
 	} else  {
 		/* Try to enable USB2 hardware LPM */
-		if (udev->usb2_hw_lpm_capable == 1)
-			usb_enable_usb2_hardware_lpm(udev);
+		usb_enable_usb2_hardware_lpm(udev);
 
 		/* Try to enable USB3 LTM */
 		usb_enable_ltm(udev);
@@ -5649,8 +5646,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	/* Disable USB2 hardware LPM.
 	 * It will be re-enabled by the enumeration process.
 	 */
-	if (udev->usb2_hw_lpm_enabled == 1)
-		usb_disable_usb2_hardware_lpm(udev);
+	usb_disable_usb2_hardware_lpm(udev);
 
 	/* Disable LPM while we reset the device and reinstall the alt settings.
 	 * Device-initiated LPM, and system exit latency settings are cleared
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 35951aea7f50..4f33eb632a88 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1243,8 +1243,7 @@ void usb_disable_device(struct usb_device *dev, int skip_ep0)
 			dev->actconfig->interface[i] = NULL;
 		}
 
-		if (dev->usb2_hw_lpm_enabled == 1)
-			usb_disable_usb2_hardware_lpm(dev);
+		usb_disable_usb2_hardware_lpm(dev);
 		usb_unlocked_disable_lpm(dev);
 		usb_disable_ltm(dev);
 
-- 
2.17.1

