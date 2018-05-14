Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpUwx2v25WUxOfuJRWKDkje0nDSFrujdaXy+fugpdf3UKsJr+/mqHgqwmbtcS4pQOZOISVF
ARC-Seal: i=1; a=rsa-sha256; t=1526281020; cv=none;
        d=google.com; s=arc-20160816;
        b=bFMsEwM4Vyd/jFGKTTebtab74jZF0S8VLqfUPgVob9WB/gOJBKgdpuUwdQQ+ihSqTp
         Iz5Yb1wDwa9sqVeJRe9YXJDIOka26R8VfHDwYPDPJVywyK2a3mbx3ZZNweHacwmKJPBr
         Uk69H8C5xZCI+OSSrq+ETqO5azXvAav0mjDTUfRWTGjjwzwwyfgk7zjvwuLc89e+zwJP
         S504LQ7Kcvn0DKH4M4MGJdYdNRC0sAjTgsCelSGR0MU0ZNkteCrgn9ZY4rBlc51s8i0G
         oBpDLVHxdpJX+x5eV3oi0xjxNclStjjCy4lRemF8a6cGk1xd/DUTT+E8MJq5P5s7MF9+
         PAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=hxtvYrdI3+cIWZUH4qfojUuTR+8ssw66YW10udvSZT8=;
        b=xbwpxpHA0pn7Z8cPEuZem7cDoRGcb5SOk7p9C/iXsiYJNAAGOfm+hGIv1oTddO+5WN
         itcQDBeCY2xk0zasyt5bMPr/7e/CWzlhd2wfk0LRsLQwgxRJcARPgTTqqQJ+nP4DCRfB
         8ZQVYT5h/36DfCnkYYNYKhqlJ3bWWGknli7HlgO6NrHRDTG0cwCYsely0xSvQOvywCCZ
         NBXiQl7nSdoPzeZY2/XYV7Q9fUiGmTg6Vl6eEt8Dtb60LjwJDQ9xf9a2uanl33ncWmdj
         kmpKacoSfhVFeYujfTsH9Q7cWMdoFtmbQibeyc6nfwStODsVDwZ6x5qO+wjRjDrq4I0/
         frHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OdZE4tmg;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OdZE4tmg;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeremy Cline <jcline@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 49/62] Bluetooth: btusb: Only check needs_reset_resume DMI table for QCA rome chipsets
Date: Mon, 14 May 2018 08:49:05 +0200
Message-Id: <20180514064819.213872386@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421647346638462?=
X-GMAIL-MSGID: =?utf-8?q?1600421647346638462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit fc54910280eb38bde923cdf0898e74687d8e6989 upstream.

Jeremy Cline correctly points out in rhbz#1514836 that a device where the
QCA rome chipset needs the USB_QUIRK_RESET_RESUME quirk, may also ship
with a different wifi/bt chipset in some configurations.

If that is the case then we are needlessly penalizing those other chipsets
with a reset-resume quirk, typically causing 0.4W extra power use because
this disables runtime-pm.

This commit moves the DMI table check to a btusb_check_needs_reset_resume()
helper (so that we can easily also call it for other chipsets) and calls
this new helper only for QCA_ROME chipsets for now.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Cc: stable@vger.kernel.org
Cc: Jeremy Cline <jcline@redhat.com>
Suggested-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2902,6 +2902,12 @@ static int btusb_config_oob_wake(struct
 }
 #endif
 
+static void btusb_check_needs_reset_resume(struct usb_interface *intf)
+{
+	if (dmi_check_system(btusb_needs_reset_resume_table))
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -3037,9 +3043,6 @@ static int btusb_probe(struct usb_interf
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
-	if (dmi_check_system(btusb_needs_reset_resume_table))
-		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
-
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
@@ -3177,6 +3180,7 @@ static int btusb_probe(struct usb_interf
 			hdev->setup = btusb_setup_csr;
 
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		btusb_check_needs_reset_resume(intf);
 	}
 
 	if (id->driver_info & BTUSB_SNIFFER) {
