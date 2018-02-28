Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227beVLJAhBYkn9ENdCTHcf64ygl8r7FnSHiPS4IgBVUmifkSiCAHBlItgZMOxstgHmqYZuR
ARC-Seal: i=1; a=rsa-sha256; t=1519831335; cv=none;
        d=google.com; s=arc-20160816;
        b=TYe37Jst2gMX5PZOQ9d97zWY5aY1ReUKQHssW9lWCZrP0dQm6xWmM0rhyUWwHR7dAC
         Edjm2RIc8of1OEuXT8PhH8lqXzEY0kTjLFdaRTCORnJSxkmp42dG+8Ahi2Cu51PbDzlW
         BqQtZtLpLvlSba+1eWe0Gk7Saht8AFxtsPHLSZ7VHn3DvfwOpn8IF072Bpz2hzyUBRYS
         gxFQ699fVyQM5v2ZqZA5Xr8mM8/rZt6dFaeFdNZ8knztxdhdUiOE6/NoED5Hi9EnTIar
         mtPsDStR+CpfiYguh3o6pugExzm02mYb7EoQbjiGzUpUe6pProku+r2sBMc0RTvSJbYd
         DygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=+C71Y/AG37luWygfaH3tZ7/MuOjfqavo+iI10hg5zhY=;
        b=eUIFIycueihFUqPQSKsoR3AJwlvX7oXgOj9143i54N6FQgg5ZYVrPT6xfiFpbngY2R
         M2oe7WgbQABvSsqIAwUX6HHqfboSmqeuDoMun0bAP98xVtk+NQ8XwAKimM4hSxuycrcU
         I+vOooDOvsMryQhrbmqtuy0sdK1D69UL5Q29M/S474gOfs6mnETNDsyY03Q/6hJ3rpEF
         QFAFDLIlvXgPyEamBrxlzFLZTQM2vM3g4XbhXIbM60tO0kXQ6sklLLZSXzcYXMRR3Jp1
         wjlbQPXCZc5yVzthlQE54Xl/zGyn7Qe+zKmzv/EDs/Gc6edcVNAPldCceb5kOr5GuAQ7
         5GDQ==
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
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.466737990@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 016/140] USB: core: Add type-specific length check of
 BOS descriptors
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658661964216527?=
X-GMAIL-MSGID: =?utf-8?q?1593658661964216527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2:
 - Drop handling of USB_PTM_CAP_TYPE and USB_SSP_CAP_TYPE
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -878,6 +878,13 @@ void usb_release_bos_descriptor(struct u
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
@@ -886,6 +893,7 @@ int usb_get_bos_descriptor(struct usb_de
 	struct usb_dev_cap_header *cap;
 	unsigned char *buffer;
 	int length, total_len, num, i;
+	__u8 cap_type;
 	int ret;
 
 	bos = kzalloc(sizeof(struct usb_bos_descriptor), GFP_KERNEL);
@@ -938,7 +946,13 @@ int usb_get_bos_descriptor(struct usb_de
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
@@ -946,7 +960,7 @@ int usb_get_bos_descriptor(struct usb_de
 			continue;
 		}
 
-		switch (cap->bDevCapabilityType) {
+		switch (cap_type) {
 		case USB_CAP_TYPE_WIRELESS_USB:
 			/* Wireless USB cap descriptor is handled by wusb */
 			break;
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -800,6 +800,8 @@ struct usb_wireless_cap_descriptor {	/*
 	__u8  bReserved;
 } __attribute__((packed));
 
+#define USB_DT_USB_WIRELESS_CAP_SIZE	11
+
 /* USB 2.0 Extension descriptor */
 #define	USB_CAP_TYPE_EXT		2
 
