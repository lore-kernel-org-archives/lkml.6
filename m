Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELvOLaPVRaw6N1ZhFRdrZkjKS5URa1K0aXHWuzCk/sizRgtJeQPTdl/HuOB67aS/kNa+pNkx
ARC-Seal: i=1; a=rsa-sha256; t=1521208189; cv=none;
        d=google.com; s=arc-20160816;
        b=AGMUnwnEaMAM1mQgqJX7TOXbpdqGJLSfHUZbPLrlyMWeEJf9rDY1X2eUPUDBmXSMgV
         b2SKBwKruM4DA9QWSJQ7FsBbzMajAyB282HTTiXTJZYG/UMNn6fc0AvQrolhOz7HVAFA
         7Vsdw/9qRuRSBotED4FgtsmQQJ0ap7RvgdtaYhL4BQcLUKCgsz4MvEhbWPgSrrlepGuh
         SsuOpCh0JCzRVviWqSwkfFVEezYSiYob+CTPPGEMMtm8zjTs3osZIS5Y6gssEgDjCTkm
         efTFQRXjcI8J2RKT/9ec2hd/O2HOSGjFzWKqOrvh6gDwMWBqtreaCuXH+UVxs65lUteq
         s0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=NY/gbJmxr/BIiLZaK+n5Ln7z3lRodDKnY7nIG1UyY4w=;
        b=ZVPCeb4YxgAW0PdXZaBHaV6MUuBvcOBWy/M4WykaYGFHB/kmDqzI6OhU8iwYVtg97q
         zNTxX76SFzRccwv6jIx63dGFcOPTCyZrvDUcfyfg+007EyxWae0HxjX3zs0sMuEUxKfd
         mJfjCEn8rs9gaYvPSVl4Yglfcf44u6AFnUIyU9xjDuJXcZ0MXSDVW7tC3efGUhFtbHfh
         yqjikZJmfApR1LsRRt4pgWx0nPvW5RcphTfTalhh8qwZCLOOhdMXrSOaY79U8Lm9Vp87
         W5cUsO/AGh6tBY5BV4DVzHYxp7+mZqfWVW9Th1FldUGehMWM9Wb9qQJfSX79P32MJVs9
         Ga+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org,
	linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/5] usb: gadget: Add NO_DMA dummies for DMA mapping API
Date: Fri, 16 Mar 2018 14:25:42 +0100
Message-Id: <1521206744-1504-4-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
References: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102398755040638?=
X-GMAIL-MSGID: =?utf-8?q?1595102398755040638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dummies for usb_gadget_{,un}map_request{,_by_dev}(), to allow
compile-testing if NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "usb_gadget_unmap_request_by_dev" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] undefined!
    ERROR: "usb_gadget_map_request_by_dev" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] undefined!
    ERROR: "usb_gadget_map_request" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "usb_gadget_unmap_request" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "usb_gadget_map_request" [drivers/usb/gadget/udc/renesas_usb3.ko] undefined!
    ERROR: "usb_gadget_unmap_request" [drivers/usb/gadget/udc/renesas_usb3.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state.
---
 include/linux/usb/gadget.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 66a5cff7ee142d6a..b68e7f9b210be122 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -805,6 +805,7 @@ int usb_otg_descriptor_init(struct usb_gadget *gadget,
 
 /* utility to simplify map/unmap of usb_requests to/from DMA */
 
+#ifdef	CONFIG_HAS_DMA
 extern int usb_gadget_map_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in);
 extern int usb_gadget_map_request(struct usb_gadget *gadget,
@@ -814,6 +815,17 @@ extern void usb_gadget_unmap_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in);
 extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in);
+#else /* !CONFIG_HAS_DMA */
+static inline int usb_gadget_map_request_by_dev(struct device *dev,
+		struct usb_request *req, int is_in) { return -ENOSYS; }
+static inline int usb_gadget_map_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in) { return -ENOSYS; }
+
+static inline void usb_gadget_unmap_request_by_dev(struct device *dev,
+		struct usb_request *req, int is_in) { }
+static inline void usb_gadget_unmap_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in) { }
+#endif /* !CONFIG_HAS_DMA */
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.7.4
