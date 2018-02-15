Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227KGec1cyl3zSSwX6MPB5Xv5DF5Z7Pw92Wb4SKzQHy064itpPDuv6laUpeecbWyf4iYiEQ6
ARC-Seal: i=1; a=rsa-sha256; t=1518708585; cv=none;
        d=google.com; s=arc-20160816;
        b=hpQAdsNYTLtG1Masfk9bMFOGPl80XK52/zCxRYxVRw3o/PGl+KfCk2Ik8NtaW24taJ
         ZXTCMEVj6yg+I7VgpIf3VSkHXR/Qf5Li3faD5dtXWBeyXAvN0t/hDn7ZJYbPOSUVB1N5
         YlyQ0uy8lFX+UppGBR+GQiIz7Y+o4dy4oXoLh+auidkWnKRMmkD+Fx0UK2aWfaIZawTG
         FUdX/TzcxXH00YlFaP59bmFOalXL4fa5mscRkf57pIsm0+M8PjnKLXzjPwI3Ki4U36d5
         G0LefQ4YV0FmQj9RJHF8xp9s6+X5t0xbi63Oj7Vv55q7qRJrDGcQXLppHPffPBh6pWCE
         YwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kxWFhIy55KQqovMdqoh8XqiEEKtL13Bq+4X/eiV7+wc=;
        b=dUDTxF7+8a9EiX3zw1W9KulgAYfALQI53qVWzqKBZGf1WPU7wbMG1Oku5B8LjUiLD5
         sGbpv768RvD+n9XXOus5XWyPKKoIiAkHYfwfRyHAiRDmzsr8rQQ22ve3Omvmdgy7E6xU
         GAOmhmXD/vcrS434TeXjsJ0Mz90bZCccOfKgn8uo/rGUBiqaAcGCDWLdNOVzF6VV/4n0
         +s3jF7gK6pALllA5t8zC6y1S1vn+EnKk0SLZHPG3go4T7WeuMd50dhuFMHEjdYBrsuFB
         yTPKeB4iEEN5sNWTw3HABr5sMI2Me1U30l6QVR8M4g5MkZuDvIQQcaPns2nWv0cYy261
         BYlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 66/88] HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working
Date: Thu, 15 Feb 2018 16:17:33 +0100
Message-Id: <20180215151231.719227548@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481099537609475?=
X-GMAIL-MSGID: =?utf-8?q?1592481374254392448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit edfc3722cfef4217c7fe92b272cbe0288ba1ff57 upstream.

The Toshiba Click Mini uses an i2c attached keyboard/touchpad combo
(single i2c_hid device for both) which has a vid:pid of 04F3:0401,
which is also used by a bunch of Elan touchpads which are handled by the
drivers/input/mouse/elan_i2c driver, but that driver deals with pure
touchpads and does not work for a combo device such as the one on the
Toshiba Click Mini.

The combo on the Mini has an ACPI id of ELAN0800, which is not claimed
by the elan_i2c driver, so check for that and if it is found do not ignore
the device. This fixes the keyboard/touchpad combo on the Mini not working
(although with the touchpad in mouse emulation mode).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2365,7 +2365,6 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
@@ -2635,6 +2634,17 @@ bool hid_ignore(struct hid_device *hdev)
 			strncmp(hdev->name, "www.masterkit.ru MA901", 22) == 0)
 			return true;
 		break;
+	case USB_VENDOR_ID_ELAN:
+		/*
+		 * Many Elan devices have a product id of 0x0401 and are handled
+		 * by the elan_i2c input driver. But the ACPI HID ELAN0800 dev
+		 * is not (and cannot be) handled by that driver ->
+		 * Ignore all 0x0401 devs except for the ELAN0800 dev.
+		 */
+		if (hdev->product == 0x0401 &&
+		    strncmp(hdev->name, "ELAN0800", 8) != 0)
+			return true;
+		break;
 	}
 
 	if (hdev->type == HID_TYPE_USBMOUSE &&
