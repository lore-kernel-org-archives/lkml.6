Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvWP4MOukh5229dhnSop3F999KZ/SWH1Ggr5dofNxftDYz/MQy6uDNVDyPgtOkvihjZdV2g
ARC-Seal: i=1; a=rsa-sha256; t=1521213833; cv=none;
        d=google.com; s=arc-20160816;
        b=yGTWlDN5a6AtMZYOZP3whzCEfTAguSZNe4z7+U5L+j8p9IRf2BmrgIBRKeT0PdYm2q
         g89Vv2rvErcJeZrZA/4F5fX6fD5MNtUN5reB8syMPdtYbSjMTs1GagkWePYY9qvpk6HY
         +l3VhDMnDQJzKIciWCGQptWcqpgADHe704RiFB19mBfi7lJMcOoxVyTzRQULuSL6IWaT
         Jsey/91JPJIeD0ydwLeXUM3+F5cmcN5HYs3ZNnatmcryonke5Rzl0xEgpYp3c3ikxbzB
         mQMAB9RLKQY0aGKo8LT7DDv3R5B2omRNDzusB0uc9nQSaMTl2wSYAzV308uehLwFF7eC
         dVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RzCT8kyb21WzMRdU8QzJ1H7hcij8dS1IY1F6RQAurJg=;
        b=kWj73Wm8w0DinnUEmJ89nHqnUwkqMaSHpU26V5YFHpL4HV+2z3JMsviedOF3NRdN59
         OQFNwEVw4fQMERW1DvUZjFPzDyUoUNTfU4Ww37ODqEfBTjsTohNbkZ1gZ+3B9kuRU/IZ
         Jv7ykaS/pgpwwqLN5HMlxChY9Wcg7xuvK4Lkw7jtJ7/NgQ+IDYGSzePxkXiJP1yeEYfn
         ghLN7KSD2CEJwNdwdWvcCbEvAqIEUa3a/1mwqTtF3ncwyYsm5v9onU/P+3e1FhTR+Lg5
         acpuZtk6ZabLnHhlI7hs1NYcLh22qzsGgw1hGG08kNYrKFPUW8oiTnlKNgI6keyfGD6q
         qWKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 3.18 21/25] usb: quirks: add control message delay for 1b1c:1b20
Date: Fri, 16 Mar 2018 16:23:08 +0100
Message-Id: <20180316152233.607744351@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108316565102090?=
X-GMAIL-MSGID: =?utf-8?q?1595108316565102090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -147,6 +147,10 @@ int usb_control_msg(struct usb_device *d
 
 	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
 
+	/* Linger a bit, prior to the next control message. */
+	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+		msleep(200);
+
 	kfree(dr);
 
 	return ret;
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -219,7 +219,8 @@ static const struct usb_device_id usb_qu
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
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
