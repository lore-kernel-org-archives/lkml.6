Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsgNp0eYY3nQ7hWDBldHNcwGfbJn5uqmj25YwQLuUtiIzy6F1FB8zrP9aqCGaD0QfUnE89j
ARC-Seal: i=1; a=rsa-sha256; t=1521214468; cv=none;
        d=google.com; s=arc-20160816;
        b=TObZZUnbyhtpgNJROekGPAtlCHzdvvpljKUZKqLnAKZiRY3jd+jVfJ4LrA9Kt8KIUp
         RE/AZE1ZWTSWxLQbbLoXKjS87FdFrFQf4ky7LCCYnvVaESyaRz5g6ReIp5zuuAjeaMSM
         ePlKPhebbdF3tiJHCHLfSG8f2TYS2AAvoYZ4iIvWzRA1U76RRQFt35Q1z+I/x/Xcv2NR
         S5V4sxaLTiGp1BbUbFDM53ayHQ7EDtbKlUPjfB9rH7yqIRvZro0IcQyCZ6OASIdjxYzr
         s366/H83dwkkLoK+yIHfD7eig1+1KoSNFsClVZzh7URJcFyXVi0yujysJKNi+wGBpKUe
         4JRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=olBELvh8ioKfbZC3ytkMw7qCP4wTn5OToXi2snbO010=;
        b=hYDiXDA/doVU13mjviOovNcA5vctGoR31hL9+4rORi0L4yPziyHzTYAEzQ4XWJgiik
         nhisBkI3SVyZa81+Ixx5eRswzJR+9pMuD+2VdO7wKqaPrvM+r6pXXysTSvMr2TCWdQVQ
         N82ZmQvwVB8Es/z8PHK57Tp7JyxaqKW01vOEucJD5ie99u9+X6AkcAh1FH+H3LyUlz5G
         MLSssteZ3giYXhZwY/aot7D9fjAlaliTxUdldROuWYRk2xkX8drlnL38Tg6xDZXqtxEg
         d4+Deao+NbJZV99PmKsyFgbnNT7S6yqBViZ7v7bh/b4Cm7tUw0ND0C0gd2gOJTLDZaMb
         AQdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 4.14 018/109] usb: quirks: add control message delay for 1b1c:1b20
Date: Fri, 16 Mar 2018 16:22:47 +0100
Message-Id: <20180316152330.951548543@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108316565102090?=
X-GMAIL-MSGID: =?utf-8?q?1595108982678119810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <danilokrummrich@dk-develop.de>

commit cb88a0588717ba6c756cb5972d75766b273a6817 upstream.

Corsair Strafe RGB keyboard does not respond to usb control messages
sometimes and hence generates timeouts.

Commit de3af5bf259d ("usb: quirks: add delay init quirk for Corsair
Strafe RGB keyboard") tried to fix those timeouts by adding
USB_QUIRK_DELAY_INIT.

Unfortunately, even with this quirk timeouts of usb_control_msg()
can still be seen, but with a lower frequency (approx. 1 out of 15):

[   29.103520] usb 1-8: string descriptor 0 read error: -110
[   34.363097] usb 1-8: can't set config #1, error -110

Adding further delays to different locations where usb control
messages are issued just moves the timeouts to other locations,
e.g.:

[   35.400533] usbhid 1-8:1.0: can't add hid device: -110
[   35.401014] usbhid: probe of 1-8:1.0 failed with error -110

The only way to reliably avoid those issues is having a pause after
each usb control message. In approx. 200 boot cycles no more timeouts
were seen.

Addionaly, keep USB_QUIRK_DELAY_INIT as it turned out to be necessary
to have the delay in hub_port_connect() after hub_port_init().

The overall boot time seems not to be influenced by these additional
delays, even on fast machines and lightweight distributions.

Fixes: de3af5bf259d ("usb: quirks: add delay init quirk for Corsair Strafe RGB keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/message.c |    4 ++++
 drivers/usb/core/quirks.c  |    3 ++-
 include/linux/usb/quirks.h |    3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -150,6 +150,10 @@ int usb_control_msg(struct usb_device *d
 
 	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
 
+	/* Linger a bit, prior to the next control message. */
+	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+		msleep(200);
+
 	kfree(dr);
 
 	return ret;
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -229,7 +229,8 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* Corsair Strafe RGB */
-	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
 
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -57,4 +57,7 @@
  */
 #define USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL	BIT(11)
 
+/* Device needs a pause after every control message. */
+#define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
+
 #endif /* __LINUX_USB_QUIRKS_H */
