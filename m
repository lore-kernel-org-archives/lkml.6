Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpNNPn0F/eh8SEp8PxnRsYYRjI5dQBRBIcllXlkJMpEp3S8jUCEE9e/XXh2BeSGkmZaEdmZ
ARC-Seal: i=1; a=rsa-sha256; t=1527156141; cv=none;
        d=google.com; s=arc-20160816;
        b=Wd4TpyVE8oCKFHzJzzWEy+uxOgi0fhHsXzJNDXYhn0/WmcFNyo+Ccb9fttK9sr+8tW
         GtGrikRQn5CB0dNOXkLBCD5fIoY7yth08goQVnFVs6l8F5jyCBY29n9jlOJ0+uk/FIDx
         Lw0jHFSfZcdE4ftPbs3khsIPWz6j42Rj02JpUUWcvhzm04HbkgxUCGnk6tuGxBfrMxf1
         ukPGEyXyGsM/OA3D2rf/6dJAp/yUw0xgPHvESVzOlMO+C6xuIU6Mz2W8cVtPrWLUgPuS
         1FeGLrPHnKlTI+GYSTmSu3Z8V9IVf7DTUrOGtQZqzQ3FoHnB3mepaZFp1C8vXMORy4A1
         175w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bShh4rwbarsT/EqE7AUK/mbmrGARhkfoBxds4g3rXPQ=;
        b=YZC3f43xBobqlF27l2LikxcvGTnauZcsv/sbONOfsG+aV1rbDadeDQbBR8DCAycimt
         ldfjYJFLQTwCc1+YlDLqswtMYaPWVT3mhD0F+cpUVPemGGeup5m/6d+flIx3YFW61BMH
         OG6+KZNul5YdEheFpFS8gUZGeDzH1auPZ6kfTBYeBJ+UUcAXsN8ZE1box5W37KzNH9dd
         URwFmxTG6qh3UMA3pd9MHcTEIcWUGB7NocoJSDzxAvcsxTe0/MzYkxM/JiQ/hrFkQmts
         KTN4vQHjrq2xqLjyzqec158vlxD+m2XKoo6iT5IOvtMmNsEOUiUgp4KDFkbefsNevPX9
         gxig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zO2ctOly;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zO2ctOly;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Dickens <christopher.a.dickens@gmail.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 079/161] usb: gadget: composite: fix incorrect handling of OS desc requests
Date: Thu, 24 May 2018 11:38:24 +0200
Message-Id: <20180524093028.008516478@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338421384534300?=
X-GMAIL-MSGID: =?utf-8?q?1601339278420354457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Dickens <christopher.a.dickens@gmail.com>

[ Upstream commit 5d6ae4f0da8a64a185074dabb1b2f8c148efa741 ]

When handling an OS descriptor request, one of the first operations is
to zero out the request buffer using the wLength from the setup packet.
There is no bounds checking, so a wLength > 4096 would clobber memory
adjacent to the request buffer. Fix this by taking the min of wLength
and the request buffer length prior to the memset. While at it, define
the buffer length in a header file so that magic numbers don't appear
throughout the code.

When returning data to the host, the data length should be the min of
the wLength and the valid data we have to return. Currently we are
returning wLength, thus requests for a wLength greater than the amount
of data in the OS descriptor buffer would return invalid (albeit zero'd)
data following the valid descriptor data. Fix this by counting the
number of bytes when constructing the data and using this when
determining the length of the request.

Signed-off-by: Chris Dickens <christopher.a.dickens@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |   40 +++++++++++++++++++---------------------
 include/linux/usb/composite.h  |    3 +++
 2 files changed, 22 insertions(+), 21 deletions(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1422,7 +1422,7 @@ static int count_ext_compat(struct usb_c
 	return res;
 }
 
-static void fill_ext_compat(struct usb_configuration *c, u8 *buf)
+static int fill_ext_compat(struct usb_configuration *c, u8 *buf)
 {
 	int i, count;
 
@@ -1449,10 +1449,12 @@ static void fill_ext_compat(struct usb_c
 				buf += 23;
 			}
 			count += 24;
-			if (count >= 4096)
-				return;
+			if (count + 24 >= USB_COMP_EP0_OS_DESC_BUFSIZ)
+				return count;
 		}
 	}
+
+	return count;
 }
 
 static int count_ext_prop(struct usb_configuration *c, int interface)
@@ -1497,25 +1499,20 @@ static int fill_ext_prop(struct usb_conf
 	struct usb_os_desc *d;
 	struct usb_os_desc_ext_prop *ext_prop;
 	int j, count, n, ret;
-	u8 *start = buf;
 
 	f = c->interface[interface];
+	count = 10; /* header length */
 	for (j = 0; j < f->os_desc_n; ++j) {
 		if (interface != f->os_desc_table[j].if_id)
 			continue;
 		d = f->os_desc_table[j].os_desc;
 		if (d)
 			list_for_each_entry(ext_prop, &d->ext_prop, entry) {
-				/* 4kB minus header length */
-				n = buf - start;
-				if (n >= 4086)
-					return 0;
-
-				count = ext_prop->data_len +
+				n = ext_prop->data_len +
 					ext_prop->name_len + 14;
-				if (count > 4086 - n)
-					return -EINVAL;
-				usb_ext_prop_put_size(buf, count);
+				if (count + n >= USB_COMP_EP0_OS_DESC_BUFSIZ)
+					return count;
+				usb_ext_prop_put_size(buf, n);
 				usb_ext_prop_put_type(buf, ext_prop->type);
 				ret = usb_ext_prop_put_name(buf, ext_prop->name,
 							    ext_prop->name_len);
@@ -1541,11 +1538,12 @@ static int fill_ext_prop(struct usb_conf
 				default:
 					return -EINVAL;
 				}
-				buf += count;
+				buf += n;
+				count += n;
 			}
 	}
 
-	return 0;
+	return count;
 }
 
 /*
@@ -1827,6 +1825,7 @@ unknown:
 			req->complete = composite_setup_complete;
 			buf = req->buf;
 			os_desc_cfg = cdev->os_desc_config;
+			w_length = min_t(u16, w_length, USB_COMP_EP0_OS_DESC_BUFSIZ);
 			memset(buf, 0, w_length);
 			buf[5] = 0x01;
 			switch (ctrl->bRequestType & USB_RECIP_MASK) {
@@ -1850,8 +1849,8 @@ unknown:
 					count += 16; /* header */
 					put_unaligned_le32(count, buf);
 					buf += 16;
-					fill_ext_compat(os_desc_cfg, buf);
-					value = w_length;
+					value = fill_ext_compat(os_desc_cfg, buf);
+					value = min_t(u16, w_length, value);
 				}
 				break;
 			case USB_RECIP_INTERFACE:
@@ -1880,8 +1879,7 @@ unknown:
 							      interface, buf);
 					if (value < 0)
 						return value;
-
-					value = w_length;
+					value = min_t(u16, w_length, value);
 				}
 				break;
 			}
@@ -2156,8 +2154,8 @@ int composite_os_desc_req_prepare(struct
 		goto end;
 	}
 
-	/* OS feature descriptor length <= 4kB */
-	cdev->os_desc_req->buf = kmalloc(4096, GFP_KERNEL);
+	cdev->os_desc_req->buf = kmalloc(USB_COMP_EP0_OS_DESC_BUFSIZ,
+					 GFP_KERNEL);
 	if (!cdev->os_desc_req->buf) {
 		ret = -ENOMEM;
 		usb_ep_free_request(ep0, cdev->os_desc_req);
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -54,6 +54,9 @@
 /* big enough to hold our biggest descriptor */
 #define USB_COMP_EP0_BUFSIZ	1024
 
+/* OS feature descriptor length <= 4kB */
+#define USB_COMP_EP0_OS_DESC_BUFSIZ	4096
+
 #define USB_MS_TO_HS_INTERVAL(x)	(ilog2((x * 1000 / 125)) + 1)
 struct usb_configuration;
 
