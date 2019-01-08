Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92451C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624272173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975654;
	bh=vViSs6Xpq7LPIGKTAhZ6Hhj484SUf+9UMhIaTpU090E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gkfc0faX6VHU5N6X3ZN9Wwt6AD9RmHCtKfBZdyab4f0RizCcHVhzTROVKO8/9rUvc
	 bKzmnRLxZkeQvJaGTrlHSKOe/Ttm7qYrLmM0NagWoSRaQYetzILzvD/da9Ytnc0jF6
	 cEi+tbGraeiYE+Guz4h45tk1t9SOYrTZ1Yt+VoCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfAHT1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbfAHT10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FD020883;
        Tue,  8 Jan 2019 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975645;
        bh=vViSs6Xpq7LPIGKTAhZ6Hhj484SUf+9UMhIaTpU090E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxVnB2bJbcs7uAGbXv5SjWlEMkXh9YuMGuGVqr5kLIsRKjFLWCiPfC3lV57GRr2IB
         S7j2NPhY+DLc7ycDxzzNjLqsJjodF6bSqgF2NEJs1suWrvgBxbI7YOR8SEWMOMQvPT
         gaQtrfcTKaIgrfb0Nq94c1pGto8vT6EE5FdODxUA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 030/117] usb: gadget: udc: renesas_usb3: add a safety connection way for forced_b_device
Date:   Tue,  8 Jan 2019 14:24:58 -0500
Message-Id: <20190108192628.121270-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit ceb94bc52c437463f0903e61060a94a2226fb672 ]

This patch adds a safety connection way for "forced_b_device" with
"workaround_for_vbus" like below:

< Example for R-Car E3 Ebisu >
 # modprobe <any usb gadget driver>
 # echo 1 > /sys/kernel/debug/ee020000.usb/b_device
 (connect a usb cable to host side.)
 # echo 2 > /sys/kernel/debug/ee020000.usb/b_device

Previous code should have connected a usb cable before the "b_device"
is set to 1 on the Ebisu board. However, if xHCI driver on the board
is probed, it causes some troubles:
 - Conflicts USB VBUS/signals between the board and another host.
 - "Cannot enable. Maybe the USB cable is bad?" might happen on
   both the board and another host with a usb hub.
 - Cannot enumerate a usb gadget correctly because an interruption
   of VBUS change happens unexpectedly.

Reported-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index cdffbd1e0316..6e34f9594159 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -358,6 +358,7 @@ struct renesas_usb3 {
 	bool extcon_host;		/* check id and set EXTCON_USB_HOST */
 	bool extcon_usb;		/* check vbus and set EXTCON_USB */
 	bool forced_b_device;
+	bool start_to_connect;
 };
 
 #define gadget_to_renesas_usb3(_gadget)	\
@@ -476,7 +477,8 @@ static void usb3_init_axi_bridge(struct renesas_usb3 *usb3)
 static void usb3_init_epc_registers(struct renesas_usb3 *usb3)
 {
 	usb3_write(usb3, ~0, USB3_USB_INT_STA_1);
-	usb3_enable_irq_1(usb3, USB_INT_1_VBUS_CNG);
+	if (!usb3->workaround_for_vbus)
+		usb3_enable_irq_1(usb3, USB_INT_1_VBUS_CNG);
 }
 
 static bool usb3_wakeup_usb2_phy(struct renesas_usb3 *usb3)
@@ -700,8 +702,7 @@ static void usb3_mode_config(struct renesas_usb3 *usb3, bool host, bool a_dev)
 	usb3_set_mode_by_role_sw(usb3, host);
 	usb3_vbus_out(usb3, a_dev);
 	/* for A-Peripheral or forced B-device mode */
-	if ((!host && a_dev) ||
-	    (usb3->workaround_for_vbus && usb3->forced_b_device))
+	if ((!host && a_dev) || usb3->start_to_connect)
 		usb3_connect(usb3);
 	spin_unlock_irqrestore(&usb3->lock, flags);
 }
@@ -2432,7 +2433,11 @@ static ssize_t renesas_usb3_b_device_write(struct file *file,
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
 
-	if (!strncmp(buf, "1", 1))
+	usb3->start_to_connect = false;
+	if (usb3->workaround_for_vbus && usb3->forced_b_device &&
+	    !strncmp(buf, "2", 1))
+		usb3->start_to_connect = true;
+	else if (!strncmp(buf, "1", 1))
 		usb3->forced_b_device = true;
 	else
 		usb3->forced_b_device = false;
@@ -2440,7 +2445,7 @@ static ssize_t renesas_usb3_b_device_write(struct file *file,
 	if (usb3->workaround_for_vbus)
 		usb3_disconnect(usb3);
 
-	/* Let this driver call usb3_connect() anyway */
+	/* Let this driver call usb3_connect() if needed */
 	usb3_check_id(usb3);
 
 	return count;
-- 
2.19.1

