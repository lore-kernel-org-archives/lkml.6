Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E124CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FBF2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FBF2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeJ3OrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:47:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43899 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeJ3OrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:47:02 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gHMzQ-00031a-QQ; Tue, 30 Oct 2018 05:54:57 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] USB: Don't enable LPM if it's already enabled
Date:   Tue, 30 Oct 2018 13:54:52 +0800
Message-Id: <20181030055452.25969-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
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

So let's enable LPM for just once, as this solves the issue for the
device in question.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 53564386ed57..e11d2eac76b6 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1901,7 +1901,8 @@ int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
 	int ret = -EPERM;
 
-	if (enable && !udev->usb2_hw_lpm_allowed)
+	if (enable && !udev->usb2_hw_lpm_allowed ||
+	    udev->usb2_hw_lpm_enabled == enable)
 		return 0;
 
 	if (hcd->driver->set_usb2_hw_lpm) {
-- 
2.19.1

