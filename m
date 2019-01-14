Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B04DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AFF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="xMRgoE8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfANToF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:44:05 -0500
Received: from erza.pados.hu ([176.9.136.194]:51642 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfANToC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E3DykDoRItJGWP95SMpn3zjpN0T2PfwKB6AlfVZGFgY=; b=xMRgoE8cL4+9GcLz34G6RTmkBa
        0OCNFjlDll3ig746qlf/wjxJSXxS+6SULxCMbPi7iaKKCam8mHl3sbvkDNDV50k2OdEnBAhmWw4cP
        ka2KECJnEFcw2qHg5K2doVdBbM8qdcQaIkxpAcfTRV58PVgTeQBcChCInuLRtrzryjd4xUc1uLN4O
        4G/O6Lq0vq22BiULvjb6zRuaXauZeUeXo5IC1GDmWHf1SrQ8AJJKTdvV+SLYcYQqyNUOUFtjgvBl9
        f9bIymD+kRLfOdEXWgg+ImQB6D9E/MJcDlLkvLbQU1nnQrvCoIVLKinqH+zZSBvF83Z3OnRNaSO1e
        jDyciz+Q==;
Received: from 188-143-5-0.pool.digikabel.hu ([188.143.5.0] helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1gj89P-0000t9-Mp; Mon, 14 Jan 2019 20:44:00 +0100
From:   Karoly Pados <pados@pados.hu>
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH] USB: serial: cp210x: Fix GPIO in autosuspend
Date:   Mon, 14 Jan 2019 20:43:52 +0100
Message-Id: <20190114194352.4579-1-pados@pados.hu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Current GPIO code in cp210x fails to take USB autosuspend
   into account, making it practically impossible to use GPIOs with autosuspend
    enabled without user configuration. Fix this like for ftdi_sio in [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was
                             blocked.  See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: pados.hu]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  0.0 TVD_RCVD_IP            Message was received from an IP address
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current GPIO code in cp210x fails to take USB autosuspend into account,
making it practically impossible to use GPIOs with autosuspend enabled
without user configuration. Fix this like for ftdi_sio in a previous patch.
Tested on a CP2102N.

Signed-off-by: Karoly Pados <pados@pados.hu>
---
 drivers/usb/serial/cp210x.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c0777a374a88..8f974eabce63 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -598,9 +598,15 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
 	void *dmabuf;
 	int result;
 
+	result = usb_autopm_get_interface(serial->interface);
+	if (result)
+		return result;
+
 	dmabuf = kmalloc(bufsize, GFP_KERNEL);
-	if (!dmabuf)
+	if (!dmabuf) {
+		usb_autopm_put_interface(serial->interface);
 		return -ENOMEM;
+	}
 
 	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
 				 CP210X_VENDOR_SPECIFIC, type, val,
@@ -618,6 +624,7 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
 	}
 
 	kfree(dmabuf);
+	usb_autopm_put_interface(serial->interface);
 
 	return result;
 }
@@ -702,9 +709,15 @@ static int cp210x_write_vendor_block(struct usb_serial *serial, u8 type,
 	void *dmabuf;
 	int result;
 
+	result = usb_autopm_get_interface(serial->interface);
+	if (result)
+		return result;
+
 	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
-	if (!dmabuf)
+	if (!dmabuf) {
+		usb_autopm_put_interface(serial->interface);
 		return -ENOMEM;
+	}
 
 	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 				 CP210X_VENDOR_SPECIFIC, type, val,
@@ -712,6 +725,7 @@ static int cp210x_write_vendor_block(struct usb_serial *serial, u8 type,
 				 USB_CTRL_SET_TIMEOUT);
 
 	kfree(dmabuf);
+	usb_autopm_put_interface(serial->interface);
 
 	if (result == bufsize) {
 		result = 0;
@@ -1383,6 +1397,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	} else {
 		u16 wIndex = buf.state << 8 | buf.mask;
 
+		usb_autopm_get_interface(serial->interface);
 		result = usb_control_msg(serial->dev,
 					 usb_sndctrlpipe(serial->dev, 0),
 					 CP210X_VENDOR_SPECIFIC,
@@ -1390,6 +1405,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 					 CP210X_WRITE_LATCH,
 					 wIndex,
 					 NULL, 0, USB_CTRL_SET_TIMEOUT);
+		usb_autopm_put_interface(serial->interface);
 	}
 
 	if (result < 0) {
-- 
2.20.1

