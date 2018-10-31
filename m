Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8213C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CA220657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CA220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeJaOsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:48:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42318 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbeJaOsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:48:54 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gHjQN-0001wI-JW; Wed, 31 Oct 2018 05:52:16 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] USB: Don't enable LPM if it's already enabled
Date:   Wed, 31 Oct 2018 13:52:09 +0800
Message-Id: <20181031055209.11031-1-kai.heng.feng@canonical.com>
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
v2:
 -  Check udev->usb2_hw_lpm_enabled before calling usb_port_resume().

 drivers/usb/core/hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c6077d582d29..02fa574e98ce 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3523,7 +3523,8 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 		hub_port_logical_disconnect(hub, port1);
 	} else  {
 		/* Try to enable USB2 hardware LPM */
-		if (udev->usb2_hw_lpm_capable == 1)
+		if (udev->usb2_hw_lpm_capable == 1 &&
+		    !udev->usb2_hw_lpm_enabled)
 			usb_set_usb2_hardware_lpm(udev, 1);
 
 		/* Try to enable USB3 LTM */
-- 
2.19.1

