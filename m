Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C9A20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C9A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeLIWYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:24:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35010 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbeLIVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:17 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002pp-IM; Sun, 09 Dec 2018 21:55:15 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003Rg-IE; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Mathieu OTHACEHE" <m.othacehe@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.89826192@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 167/328] USB: serial: ti_usb_3410_5052: use functions
 rather than macros
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu OTHACEHE <m.othacehe@gmail.com>

commit d8d841e8332779fae2b18420d39ef407ea3729da upstream.

Functions are preferable to macros resembling functions.

Signed-off-by: Mathieu OTHACEHE <m.othacehe@gmail.com>
[johan: drop inline keyword, move above calling function ]
Signed-off-by: Johan Hovold <johan@kernel.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -925,6 +925,15 @@ static void ti_break(struct tty_struct *
 		dev_dbg(&port->dev, "%s - error setting break, %d\n", __func__, status);
 }
 
+static int ti_get_port_from_code(unsigned char code)
+{
+	return (code >> 4) - 3;
+}
+
+static int ti_get_func_from_code(unsigned char code)
+{
+	return code & 0x0f;
+}
 
 static void ti_interrupt_callback(struct urb *urb)
 {
@@ -966,8 +975,8 @@ static void ti_interrupt_callback(struct
 		goto exit;
 	}
 
-	port_number = TI_GET_PORT_FROM_CODE(data[0]);
-	function = TI_GET_FUNC_FROM_CODE(data[0]);
+	port_number = ti_get_port_from_code(data[0]);
+	function = ti_get_func_from_code(data[0]);
 
 	dev_dbg(dev, "%s - port_number %d, function %d, data 0x%02X\n",
 		__func__, port_number, function, data[1]);
--- a/drivers/usb/serial/ti_usb_3410_5052.h
+++ b/drivers/usb/serial/ti_usb_3410_5052.h
@@ -227,8 +227,6 @@ struct ti_interrupt {
 } __attribute__((packed));
 
 /* Interrupt codes */
-#define TI_GET_PORT_FROM_CODE(c)	(((c) >> 4) - 3)
-#define TI_GET_FUNC_FROM_CODE(c)	((c) & 0x0f)
 #define TI_CODE_HARDWARE_ERROR		0xFF
 #define TI_CODE_DATA_ERROR		0x03
 #define TI_CODE_MODEM_STATUS		0x04

