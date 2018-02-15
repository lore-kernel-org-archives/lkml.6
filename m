Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224HR22Z9UuirpxYie18WK65h09S8nxf5EcFhrL1y1n5vNdjhXsrY69Dw7QE3SNdRLbzTqZy
ARC-Seal: i=1; a=rsa-sha256; t=1518709007; cv=none;
        d=google.com; s=arc-20160816;
        b=fyHCtFJRGJpWYa04sIGhIey2qxjDLdRetRF8qsiGJD/gMpONcMj8y9AFL34dka4n+G
         HPsaUrac42WeLgJWd21Rwl8mFJ0oDew9X0C5XQberwnBXD5PH5WOklXG27a2vWnoEclI
         B3FwP9fVwcsm9ohJTGZRKFrMLUgTZw8lHkAUh0mmEJ9pJ4DMcnPkV7FYJcFuUBsB2wpy
         EW257HEed9f+3h1XVe41uORchNxLI/L38qdVvm3d/uVRwmYqrP4tADbHxcoP7uK+Td9c
         hZ8qMxIIC60hV7KK6/BpG3GdplJ+PquKvXsHMLUcdXjNhShMCWI/xkl3ec6dF4u3RXGL
         oGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UJqSpKwBV1mxW9645cwrpRC53BsNIUAvIttwrF91Y2E=;
        b=dp9x8qhd7MICWzN6iWWfGANlpz1kQs8U640iMcck4llxSPlMRXYaTy22N18ufyuhmR
         tZQ9DEHvb/bKZ1qdVe9euUmWPpEoU5TVgrGvwHml6CfE5CF/F9e3dbBVEoUokrgcCjEu
         LNToBhX2v1sBlbB9vVWiBVIg5sakdFnMgSnJJ2uSSL4Nkv9fxlnRgXeMLMAxplFCRhP/
         ViY9VdGU0YZXjQ0dbZNVm7fJzNNcz334AY8XyorwKB03Ekdy6h04hB/HeR6FqZEQm+4x
         uIxnA64xImpumxEYsCq6JuncRucdtW9tlTNn8gglW9bz4VGxyOXmq7avkKZr9FkSImFB
         Gv7Q==
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
Subject: [PATCH 4.14 157/195] HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working
Date: Thu, 15 Feb 2018 16:17:28 +0100
Message-Id: <20180215151713.766201930@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481099537609475?=
X-GMAIL-MSGID: =?utf-8?q?1592481816475222804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2638,7 +2638,6 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
@@ -2908,6 +2907,17 @@ bool hid_ignore(struct hid_device *hdev)
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
