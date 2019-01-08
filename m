Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A25C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E744A2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975971;
	bh=o0HjUnW5S5f5z97u1DamOUotuwyxzIqU8pIPCXbIHxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2rC3vHCH9b0/rIZLkw3Q295tZ5PsSpUho8AhLYGx5hDbXSsvn5jBE2B9i0rkKNaWh
	 HSpzrk15VP0xvrYyql1FPT0afiWyeiPydUSnbAyNIXZ4NkMUsuldzjwcBKSPbNDwAl
	 8gwOFvJObhb4oDzAZ4MIbk3zkp7apSnUUFdM/lOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfAHTcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbfAHTcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5311B20665;
        Tue,  8 Jan 2019 19:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975965;
        bh=o0HjUnW5S5f5z97u1DamOUotuwyxzIqU8pIPCXbIHxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhmgxzeLCctyA208HfC5OOA58MOYB4QCg6c8qUaRPJsaAFw8X60cTeqogHWIgmA8T
         h5l4auorvGztE46DMYujHqnRZSSoIM/RClRbqutNZjxo5ngzajpjshVeuSjwafw6TW
         wKh36HDPN/+BHoEvC7Y6PC16Czxx2JU4Q2gP85qc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/53] usb: gadget: udc: renesas_usb3: add a safety connection way for forced_b_device
Date:   Tue,  8 Jan 2019 14:31:39 -0500
Message-Id: <20190108193222.123316-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
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
index ade0723787e5..e5355ede2c46 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -352,6 +352,7 @@ struct renesas_usb3 {
 	bool extcon_host;		/* check id and set EXTCON_USB_HOST */
 	bool extcon_usb;		/* check vbus and set EXTCON_USB */
 	bool forced_b_device;
+	bool start_to_connect;
 };
 
 #define gadget_to_renesas_usb3(_gadget)	\
@@ -470,7 +471,8 @@ static void usb3_init_axi_bridge(struct renesas_usb3 *usb3)
 static void usb3_init_epc_registers(struct renesas_usb3 *usb3)
 {
 	usb3_write(usb3, ~0, USB3_USB_INT_STA_1);
-	usb3_enable_irq_1(usb3, USB_INT_1_VBUS_CNG);
+	if (!usb3->workaround_for_vbus)
+		usb3_enable_irq_1(usb3, USB_INT_1_VBUS_CNG);
 }
 
 static bool usb3_wakeup_usb2_phy(struct renesas_usb3 *usb3)
@@ -676,8 +678,7 @@ static void usb3_mode_config(struct renesas_usb3 *usb3, bool host, bool a_dev)
 	usb3_set_mode(usb3, host);
 	usb3_vbus_out(usb3, a_dev);
 	/* for A-Peripheral or forced B-device mode */
-	if ((!host && a_dev) ||
-	    (usb3->workaround_for_vbus && usb3->forced_b_device))
+	if ((!host && a_dev) || usb3->start_to_connect)
 		usb3_connect(usb3);
 	spin_unlock_irqrestore(&usb3->lock, flags);
 }
@@ -2369,7 +2370,11 @@ static ssize_t renesas_usb3_b_device_write(struct file *file,
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
@@ -2377,7 +2382,7 @@ static ssize_t renesas_usb3_b_device_write(struct file *file,
 	if (usb3->workaround_for_vbus)
 		usb3_disconnect(usb3);
 
-	/* Let this driver call usb3_connect() anyway */
+	/* Let this driver call usb3_connect() if needed */
 	usb3_check_id(usb3);
 
 	return count;
-- 
2.19.1

