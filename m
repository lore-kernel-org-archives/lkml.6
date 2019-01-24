Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA11FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D47218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358932;
	bh=+J7yFX+hkyxoeehimW7Xq5c5zY0r/LSTBvZDXqbSpxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RlXlud8l1nnPXV7b1qWiWkL3wT1WFC7qnv7EUrR0DJnveDECOnU4KdumrJNmoSr2d
	 pCxawcqIL2cKQd7tDLwfqRZ4sx9V4MWBlL8krc/OucqgyWOuK0Ve88QxMNeWFhLLiN
	 MPfKhvbI6yC/KMv4QWyJ9pR9SDyrmbVeAT3I4sto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfAXTmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:42:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733246AbfAXTmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:42:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526BE218A2;
        Thu, 24 Jan 2019 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358928;
        bh=+J7yFX+hkyxoeehimW7Xq5c5zY0r/LSTBvZDXqbSpxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yG9ogYyr14IFkxVdYkDBr7EyIcfjcZCCdYb61MOJZi/+ppUOoeAFHJfN1Q48FrDqx
         /geD9Edmxao7GPKMOI5fqJEpCgEKKLRi9VF6TFhkCACTl9xdk6kRMZCo10ZIZdcc5M
         01RABRZKHTtrt63La836CN9s0x3bAZoq4F9j918w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 041/127] usb: gadget: udc: renesas_usb3: add a safety connection way for forced_b_device
Date:   Thu, 24 Jan 2019 20:19:47 +0100
Message-Id: <20190124190214.028104617@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



