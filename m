Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227Bo1+Hb+pztquqQnDiAhP2Ubh3pKEu/LC5xSu5cP9la10jWKvPli0MLfc89yN3TA8J3BzN
ARC-Seal: i=1; a=rsa-sha256; t=1519831357; cv=none;
        d=google.com; s=arc-20160816;
        b=KBBPm2B6RTD5BgqcaIllYm2j3vmQqQ8zGJRGacbg0KTmlOI50ZcGEVNLC/10yBBmN8
         wugyGjWT8V2j5L2i1jFULknbmW6xtKWhrc907CrsqdQz4Ojllrd65DLF4KuIOBHQXjpS
         VFEQKDy/8KqxEU0NpknsIqVVyEqtTiLDns3Wqr9h0pVoq9l02pfAF0zoVzHbtxEPUQ1W
         gk7SQFbTQm9qtEQbNn+v9cKI14N6iUNlRE/QZGJLhcSKOaYXc96h/YyIUHIp7xKTriqE
         yXSEFcHBH9M2Z1bUfJHOlNc+cY3S9v93URPPJk7Ax6DSCbjVKQCz4HYWIo3D+XOX2Uql
         RNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=7KdVpCUxUntg/OwXRBuZWCkvsjlb+m9Hty6JQ5IyEic=;
        b=UZPFRJUuTB6KFtFat8eqHjadWTQGKnrsngZzXe1O+Y1ciNkcFmdy8v9GXaXrLxQuHv
         QBMKYpWFyJF28+QNHyMkbA3uRG5Xj6tAdxDv7tcmVBGJvq+sr7kDH/EMfkU+jlzjcCei
         wyKogtZMfdm3PC5ROlxVfEVI1MQfz7zp9INuILN6XHDXganQ/9gEBQ+A1ShWPc8SWBh+
         wajyCaqiiDcHLNU2RYlB8X6ztg6XMWGmPxU5fgf/j+R74wcmvy5IjF2diCkKnm+9IBgv
         Mkv38vZTS/LgCnXBfc2BbbuX9tyiwpKm255Cwdh5IqG3Ac6uv7gkN+nQSDzpRRjzKlAz
         FZsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Masakazu Mokuno" <masakazu.mokuno@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.721969954@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 023/254] USB: core: Add type-specific length check of
 BOS descriptors
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658661964216527?=
X-GMAIL-MSGID: =?utf-8?q?1593658685464178591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masakazu Mokuno <masakazu.mokuno@gmail.com>

commit 81cf4a45360f70528f1f64ba018d61cb5767249a upstream.

As most of BOS descriptors are longer in length than their header
'struct usb_dev_cap_header', comparing solely with it is not sufficient
to avoid out-of-bounds access to BOS descriptors.

This patch adds descriptor type specific length check in
usb_get_bos_descriptor() to fix the issue.

Signed-off-by: Masakazu Mokuno <masakazu.mokuno@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: drop handling of USB_PTM_CAP_TYPE and USB_SSP_CAP_TYPE]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -871,6 +871,13 @@ void usb_release_bos_descriptor(struct u
 	}
 }
 
+static const __u8 bos_desc_len[256] = {
+	[USB_CAP_TYPE_WIRELESS_USB] = USB_DT_USB_WIRELESS_CAP_SIZE,
+	[USB_CAP_TYPE_EXT]          = USB_DT_USB_EXT_CAP_SIZE,
+	[USB_SS_CAP_TYPE]           = USB_DT_USB_SS_CAP_SIZE,
+	[CONTAINER_ID_TYPE]         = USB_DT_USB_SS_CONTN_ID_SIZE,
+};
+
 /* Get BOS descriptor set */
 int usb_get_bos_descriptor(struct usb_device *dev)
 {
@@ -879,6 +886,7 @@ int usb_get_bos_descriptor(struct usb_de
 	struct usb_dev_cap_header *cap;
 	unsigned char *buffer;
 	int length, total_len, num, i;
+	__u8 cap_type;
 	int ret;
 
 	bos = kzalloc(sizeof(struct usb_bos_descriptor), GFP_KERNEL);
@@ -931,7 +939,13 @@ int usb_get_bos_descriptor(struct usb_de
 			dev->bos->desc->bNumDeviceCaps = i;
 			break;
 		}
+		cap_type = cap->bDevCapabilityType;
 		length = cap->bLength;
+		if (bos_desc_len[cap_type] && length < bos_desc_len[cap_type]) {
+			dev->bos->desc->bNumDeviceCaps = i;
+			break;
+		}
+
 		total_len -= length;
 
 		if (cap->bDescriptorType != USB_DT_DEVICE_CAPABILITY) {
@@ -939,7 +953,7 @@ int usb_get_bos_descriptor(struct usb_de
 			continue;
 		}
 
-		switch (cap->bDevCapabilityType) {
+		switch (cap_type) {
 		case USB_CAP_TYPE_WIRELESS_USB:
 			/* Wireless USB cap descriptor is handled by wusb */
 			break;
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -819,6 +819,8 @@ struct usb_wireless_cap_descriptor {	/*
 	__u8  bReserved;
 } __attribute__((packed));
 
+#define USB_DT_USB_WIRELESS_CAP_SIZE	11
+
 /* USB 2.0 Extension descriptor */
 #define	USB_CAP_TYPE_EXT		2
 
