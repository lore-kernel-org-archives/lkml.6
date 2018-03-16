Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvNcactxXaCdh19rvtvfsVj5gYClR4aoZT9u9B3lTWHXkGyLKHqPtmt8QBlTfmauoAfgPZS
ARC-Seal: i=1; a=rsa-sha256; t=1521214403; cv=none;
        d=google.com; s=arc-20160816;
        b=MgQKvuW63Q2QRKE+NzZrjoJ/9T184g/9iFUSwhWeJr2nGBwrfcz1n21ZB7VCfcKw44
         pdu9b2Wb3tmOa3DZ+B2P0q6avPDNNCpZtZNOpM90Br15wl+/H7VDcNppBoJ75SvKAFnj
         ywhI/SCIq/k9f5Q2YEQfsif8+ZAzNXOJxy1OUFqTXnWDU2gUeAh6mwIwCHQklUNnsPDc
         8uMczmhWgz7/YacJxU7Xm3i+mmHmYo3vr8VVd7MUGhbSBv7oz+cXjWDqAiTzWNYMarAx
         aOC3OW7R4RRNAJ5cFQ6kJJ2KM9lwOg/dH+o1AblvaBqvWXfmUmB76HmMU9bUpRrJHDZt
         JQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CXEctz/8VTrlOA7KBLYixiMJ2nK5cQN8hpJ6545syuY=;
        b=svIGu7m+D3qAEm15Wk4ERIIfg2QXpzwkn5LFoGLxfzr1BMTqtshvNWoo0BF2ivhWbV
         14ye8F5nZybcjgwy775K47oQ9dHkb5WhK3MLe4csJAaj4+5ca9bC59RmZPiN3vMY0aRL
         gphfRjkiep9t5Io0Vhp/LbZHh6oMRlD4XL341rNE4Rn0pOA9XvOeRY07aINUvN4ZH2Y5
         eG3K4SV73x90WQOAkX/VP+XCrSF0prHATvl4ovBgwJ4KE8HwkQh1VyHcA4W6Fpf/xuAw
         AJfB/LTQVeGQxSdqv5+VgtnkjWMblc6Tq9ueqEooqvVK2D91kA23DVdVLbPT7W0uWfo8
         ruZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 4.9 80/86] usb: quirks: add control message delay for 1b1c:1b20
Date: Fri, 16 Mar 2018 16:23:43 +0100
Message-Id: <20180316152322.735110508@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108316565102090?=
X-GMAIL-MSGID: =?utf-8?q?1595108914598907745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -148,6 +148,10 @@ int usb_control_msg(struct usb_device *d
 
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
@@ -56,4 +56,7 @@
  */
 #define USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL	BIT(11)
 
+/* Device needs a pause after every control message. */
+#define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
+
 #endif /* __LINUX_USB_QUIRKS_H */
