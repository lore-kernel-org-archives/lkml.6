Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BECC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B2F20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B2F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbeIMTQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:16:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbeIMTQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:16:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB48AD3A;
        Thu, 13 Sep 2018 14:06:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Munteanu <rombert@apache.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.18 196/197] HID: redragon: fix num lock and caps lock LEDs
Date:   Thu, 13 Sep 2018 15:32:25 +0200
Message-Id: <20180913131849.395774512@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Munteanu <rombert@apache.org>

commit dc9b8e85ed95cbe7e3ad0eabb5b48d617bbc365e upstream.

The redragon asura keyboard registers two input devices. The initial commit
85455dd906d5 ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")
considered this an error and prevented one of the devices from registering.
However, once this is done the num lock and caps lock leds no longer toggle on
and off, although the key functionality is not affected.

This commit removes the code that prevents the input device
registration and restores the num lock and caps lock LEDs.

Fixes: 85455dd906d5 ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")
Signed-off-by: Robert Munteanu <rombert@apache.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-redragon.c |   26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

--- a/drivers/hid/hid-redragon.c
+++ b/drivers/hid/hid-redragon.c
@@ -44,29 +44,6 @@ static __u8 *redragon_report_fixup(struc
 	return rdesc;
 }
 
-static int redragon_probe(struct hid_device *dev,
-	const struct hid_device_id *id)
-{
-	int ret;
-
-	ret = hid_parse(dev);
-	if (ret) {
-		hid_err(dev, "parse failed\n");
-		return ret;
-	}
-
-	/* do not register unused input device */
-	if (dev->maxapplication == 1)
-		return 0;
-
-	ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
-	if (ret) {
-		hid_err(dev, "hw start failed\n");
-		return ret;
-	}
-
-	return 0;
-}
 static const struct hid_device_id redragon_devices[] = {
 	{HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_REDRAGON_ASURA)},
 	{}
@@ -77,8 +54,7 @@ MODULE_DEVICE_TABLE(hid, redragon_device
 static struct hid_driver redragon_driver = {
 	.name = "redragon",
 	.id_table = redragon_devices,
-	.report_fixup = redragon_report_fixup,
-	.probe = redragon_probe
+	.report_fixup = redragon_report_fixup
 };
 
 module_hid_driver(redragon_driver);


