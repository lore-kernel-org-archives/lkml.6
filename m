Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3410C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EE92085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EE92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389832AbeKGDAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:00:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42558 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbeKGDAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:00:25 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gK5Et-0003UO-H8; Tue, 06 Nov 2018 17:34:08 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] USB: Disable USB2 LPM at shutdown
Date:   Wed,  7 Nov 2018 01:34:01 +0800
Message-Id: <20181106173401.32001-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCA Rome USB Bluetooth controller has several issues once LPM gets
enabled:
- Fails to get enumerated in coldboot. [1]
- Drains more power (~ 0.2W) when the system is in S5. [2]
- Disappears after a warmboot. [2]

The issue happens because the device lingers at LPM L1 in S5, so device
can't get enumerated even after a reboot.

Disalbe LPM at shutdown can solve the issue.

[1] https://bugs.launchpad.net/bugs/1757218
[2] https://patchwork.kernel.org/patch/10607097/

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/port.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 1a06a4b5fbb1..15f6924a4d84 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -285,6 +285,15 @@ static int usb_port_runtime_suspend(struct device *dev)
 }
 #endif
 
+static void usb_port_shutdown(struct device *dev)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	if (port_dev->child)
+		usb_set_usb2_hardware_lpm(port_dev->child, 0);
+
+}
+
 static const struct dev_pm_ops usb_port_pm_ops = {
 #ifdef CONFIG_PM
 	.runtime_suspend =	usb_port_runtime_suspend,
@@ -301,6 +310,7 @@ struct device_type usb_port_device_type = {
 static struct device_driver usb_port_driver = {
 	.name = "usb",
 	.owner = THIS_MODULE,
+	.shutdown = usb_port_shutdown,
 };
 
 static int link_peers(struct usb_port *left, struct usb_port *right)
-- 
2.19.1

