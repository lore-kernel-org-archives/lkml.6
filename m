Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4255DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DA820857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761950;
	bh=QeAZhtSnkVYUdln+Ehv55kCQVo3c2Cl2vQmsGSlQoyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z8ch3OxRYq4J2Sz40hirs96frTYDoUCpnSY24XnG5bL0PgNQNdv9wth0vCNAdI/QJ
	 WlIqlj8FZFM01SbLKOwNNagYI6YRnHjnphECqrvgag7oC3zhVz4l/tKfocYgoSYiMr
	 R7W75tmViMuyf/z8wqRwCynOfkP1QVrDcWkkKp3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfA2LjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729338AbfA2LjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E188120844;
        Tue, 29 Jan 2019 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761944;
        bh=QeAZhtSnkVYUdln+Ehv55kCQVo3c2Cl2vQmsGSlQoyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/p2ggUK2YQ6uX0ajUyjHOgrpTfNEiovy7c8Quus/bhovK+36dm/vY4PuMIB80nGm
         J8K/Z0sjujPbNJETb13AyPf2HIIzJvR+k5GjUxoNoa9mO3qNivKWhG082rJM21YGYG
         pHLp0fTi08MGbcVFwYJTPt4Fwar69KouSAGY2U68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karoly Pados <pados@pados.hu>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.20 028/117] USB: serial: ftdi_sio: fix GPIO not working in autosuspend
Date:   Tue, 29 Jan 2019 12:34:39 +0100
Message-Id: <20190129113209.046112613@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Karoly Pados <pados@pados.hu>

commit a8eda9fa1bd84065b75bfa81bf675a7af9055478 upstream.

There is a bug in the current GPIO code for ftdi_sio: it failed to take USB
autosuspend into account. If the device is in autosuspend, calls to
usb_control_msg() fail with -EHOSTUNREACH. Because the standard value for
autosuspend timeout is usually 2-5 seconds, this made it almost impossible
to use the GPIOs on machines that have USB autosuspend enabled. This patch
fixes the issue by acquiring a PM lock on the device for the duration of
the USB transfers. Tested on an FT231X device.

Signed-off-by: Karoly Pados <pados@pados.hu>
[ johan: simplify code somewhat ]
Fixes: ba93cc7da896 ("USB: serial: ftdi_sio: implement GPIO support for FT-X devices")
Cc: stable <stable@vger.kernel.org>	# 4.20
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1783,6 +1783,10 @@ static int ftdi_set_bitmode(struct usb_s
 	int result;
 	u16 val;
 
+	result = usb_autopm_get_interface(serial->interface);
+	if (result)
+		return result;
+
 	val = (mode << 8) | (priv->gpio_output << 4) | priv->gpio_value;
 	result = usb_control_msg(serial->dev,
 				 usb_sndctrlpipe(serial->dev, 0),
@@ -1795,6 +1799,8 @@ static int ftdi_set_bitmode(struct usb_s
 			val, result);
 	}
 
+	usb_autopm_put_interface(serial->interface);
+
 	return result;
 }
 
@@ -1846,9 +1852,15 @@ static int ftdi_read_cbus_pins(struct us
 	unsigned char *buf;
 	int result;
 
+	result = usb_autopm_get_interface(serial->interface);
+	if (result)
+		return result;
+
 	buf = kmalloc(1, GFP_KERNEL);
-	if (!buf)
+	if (!buf) {
+		usb_autopm_put_interface(serial->interface);
 		return -ENOMEM;
+	}
 
 	result = usb_control_msg(serial->dev,
 				 usb_rcvctrlpipe(serial->dev, 0),
@@ -1863,6 +1875,7 @@ static int ftdi_read_cbus_pins(struct us
 	}
 
 	kfree(buf);
+	usb_autopm_put_interface(serial->interface);
 
 	return result;
 }


