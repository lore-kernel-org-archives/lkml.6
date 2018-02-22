Return-Path: <danilokrummrich@dk-develop.de>
X-Google-Smtp-Source: AH8x2245oLLsNsMWOgulGukVK7TeCxo640f7NEX/57Nu4u4P2PIQWMhCZWF8cApUnhHKQvuWLTiw
ARC-Seal: i=1; a=rsa-sha256; t=1519260383; cv=none;
        d=google.com; s=arc-20160816;
        b=ADJ5snoEB58kxxa4scqTe7/+qmHKZLR+jvexfp5Sa7GAgV3cmbDa5atWOseZmMl3jt
         6iqKTlNSN9fTq/DC4ZEVJtH6wryZkWnjJQcSzRNG/CMEi57gCIlFekY7XgFcyBJ8Yo6q
         ye8qoJlzGDjn2k9UUKS5GnG2ASClJTgINnxGtUznJ6GlFlM+5qzuKaFboDJ8568isXqn
         p/puNSZWHISMVbfjlCfkTFNp6XcbLLdDQBo9aEll0zbGn9yQe1b3lILJDthWlQEF2J+x
         9H8KFdvImMo5WMPNEDXjUeSf1c43ZfCy5HzdG4/xsYNPXdBz3c279eD0CCexg08ptUj0
         IYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=haMQbohAktrjzeke0oIcC3n2Ae82vBDcaAJZC5yEDFE=;
        b=CDBElFORgr2vmDxTVCUxEYdihgypDUqQZbB93Zx7ghHfSd6ktneUMI3xFx6P1DE44q
         +4+G/AKq/UYblgAdEejZMc6tTRIEbcT35s02SjkUBOgBMYhPx0pKNsapOK3zf1H4PcZo
         zjvMmXnnyV2jYa1dDX0RpW7IZGywOkGE4tirClJdpC8rGZtJTd5Xlu8jleNKinUK8dZQ
         dCK6vcRcSeb1XDDNhenZ6lzjMtawoSntPyW7e3IU8BbPtwFkc6JxfxLfAvsSWMx9F5ss
         sdTu9Jf2ypyYrHJPGeHMyYOOlpeLQudUfW7bEunDu1ZCFFsx6c/1R6MIF8jtRKQauvb8
         dx/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of danilokrummrich@dk-develop.de designates 213.136.71.231 as permitted sender) smtp.mailfrom=danilokrummrich@dk-develop.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of danilokrummrich@dk-develop.de designates 213.136.71.231 as permitted sender) smtp.mailfrom=danilokrummrich@dk-develop.de
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: gregkh@linuxfoundation.org,
	felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kai.heng.feng@canonical.com,
	Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH] usb: quirks: add control message delay for 1b1c:1b20
Date: Thu, 22 Feb 2018 01:46:18 +0100
Message-Id: <20180222004618.3854-1-danilokrummrich@dk-develop.de>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593059976085062981?=
X-GMAIL-MSGID: =?utf-8?q?1593059976085062981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
delays, even on fast machines.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 drivers/usb/core/message.c | 5 +++++
 drivers/usb/core/quirks.c  | 3 ++-
 include/linux/usb/quirks.h | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 77001bcfc504..cbab2a99ce16 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -150,6 +150,10 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 
 	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
 
+	/* Linger a bit, prior to the next control message. */
+	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+		msleep(200);
+
 	kfree(dr);
 
 	return ret;
@@ -642,6 +646,7 @@ int usb_get_descriptor(struct usb_device *dev, unsigned char type,
 				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
 				(type << 8) + index, 0, buf, size,
 				USB_CTRL_GET_TIMEOUT);
+
 		if (result <= 0 && result != -ETIMEDOUT)
 			continue;
 		if (result > 1 && ((u8 *)buf)[1] != type) {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 4024926c1d68..4450bec7f3af 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -227,7 +227,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
 	/* Corsair Strafe RGB */
-	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
 
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index f1fcec2fd5f8..b7a99ce56bc9 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -63,4 +63,7 @@
  */
 #define USB_QUIRK_DISCONNECT_SUSPEND		BIT(12)
 
+/* Device needs a pause after every control message. */
+#define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.14.1
