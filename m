Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-842223-1518038514-2-6634821515382194004
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518038513; b=E33EnHzxApd2Mk2u6JeOICS2uEixld+tiHBxezzSGYgOx5e
    zndGAGKJleHeRxwzLqLA9PfYLHzmvS9BxJaVaTImX710Lk9HouPgy635gAiSdZGm
    WdZdqNxl52ZMKKyMSfVaJU4ROOcRvYJiWo1KhmsmFfwtZMopKs8vpxnPZMkH+yf1
    byGBZmuKPLLTEEsfpobaTODshYSLS2MEZk4mFYEbTQbSRRtwBMShZ/k0RgG9/DWU
    TgrMYl40oEQ97Csq61aarOZLXyw43XQsrkUQ/jMFUsoTgZj8PcMAlKFXnAxuYs+z
    QSxqo7KWOf9GoJmR51uzhQFAVyCC0P/3QwCb3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038513; bh=q2s2sY3dwypEFYSCiCJ2hLiOAyq3rYapB9r
    UblEvalc=; b=E29JW+eauMUnSf11krYnJQi8hBilc/sO2uzP3yM/YgqW4NzHOCa
    F6yTFhuEwne1fb5i635AOuXjHtd/LL5anSGd1qkymm3UpZpwOnWcyCx8kqjascab
    zalg14CbG3BFDzJO2WCwDDcCtRb1kw5uXZCm3hkr5H+9FBKtYhRTSGWVAANPdnDd
    IyBi9Tc54N4IZrWyPaNz2ylwmukp2K0mhgKPl405Lm/jygV41Tr+iiV8q1IP/k2l
    C5vTzWeTgntbu770Hc0sMlS227qq2KwUZVbZz1nXVzYTvKs87Ydo6JS3U8/sNGsB
    SErl/7ogWlOV3PVNglJvR6HoyizzDT2Rw2A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeBGVVF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:21:05 -0500
Received: from osg.samsung.com ([64.30.133.232]:53567 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932276AbeBGVVB (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:01 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3.18 2/9] usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input
Date: Wed,  7 Feb 2018 14:20:25 -0700
Message-Id: <48094d82a68e9bb52f4463d46a8b0aa259c15a1c.1518036867.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream commit c6688ef9f297 ("usbip: fix stub_rx: harden CMD_SUBMIT path
to handle malicious input")

Harden CMD_SUBMIT path to handle malicious input that could trigger
large memory allocations. Add checks to validate transfer_buffer_length
and number_of_packets to protect against bad input requesting for
unbounded memory allocations. Validate early in get_pipe() and return
failure.

Reported-by: Secunia Research <vuln@secunia.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/stub_rx.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 2e07acda456e..f5533c99cd48 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -341,11 +341,13 @@ static struct stub_priv *stub_priv_alloc(struct stub_device *sdev,
 	return priv;
 }
 
-static int get_pipe(struct stub_device *sdev, int epnum, int dir)
+static int get_pipe(struct stub_device *sdev, struct usbip_header *pdu)
 {
 	struct usb_device *udev = sdev->udev;
 	struct usb_host_endpoint *ep;
 	struct usb_endpoint_descriptor *epd = NULL;
+	int epnum = pdu->base.ep;
+	int dir = pdu->base.direction;
 
 	if (epnum < 0 || epnum > 15)
 		goto err_ret;
@@ -358,6 +360,7 @@ static int get_pipe(struct stub_device *sdev, int epnum, int dir)
 		goto err_ret;
 
 	epd = &ep->desc;
+
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
@@ -380,6 +383,27 @@ static int get_pipe(struct stub_device *sdev, int epnum, int dir)
 	}
 
 	if (usb_endpoint_xfer_isoc(epd)) {
+		/* validate packet size and number of packets */
+		unsigned int maxp, packets, bytes;
+
+#define USB_EP_MAXP_MULT_SHIFT  11
+#define USB_EP_MAXP_MULT_MASK   (3 << USB_EP_MAXP_MULT_SHIFT)
+#define USB_EP_MAXP_MULT(m) \
+	(((m) & USB_EP_MAXP_MULT_MASK) >> USB_EP_MAXP_MULT_SHIFT)
+
+		maxp = usb_endpoint_maxp(epd);
+		maxp *= (USB_EP_MAXP_MULT(
+				__le16_to_cpu(epd->wMaxPacketSize)) + 1);
+		bytes = pdu->u.cmd_submit.transfer_buffer_length;
+		packets = DIV_ROUND_UP(bytes, maxp);
+
+		if (pdu->u.cmd_submit.number_of_packets < 0 ||
+		    pdu->u.cmd_submit.number_of_packets > packets) {
+			dev_err(&sdev->udev->dev,
+				"CMD_SUBMIT: isoc invalid num packets %d\n",
+				pdu->u.cmd_submit.number_of_packets);
+			return -1;
+		}
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndisocpipe(udev, epnum);
 		else
@@ -388,7 +412,7 @@ static int get_pipe(struct stub_device *sdev, int epnum, int dir)
 
 err_ret:
 	/* NOT REACHED */
-	dev_err(&sdev->interface->dev, "get pipe, epnum %d\n", epnum);
+	dev_err(&sdev->udev->dev, "CMD_SUBMIT: invalid epnum %d\n", epnum);
 	return -1;
 }
 
@@ -453,7 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	struct stub_priv *priv;
 	struct usbip_device *ud = &sdev->ud;
 	struct usb_device *udev = sdev->udev;
-	int pipe = get_pipe(sdev, pdu->base.ep, pdu->base.direction);
+	int pipe = get_pipe(sdev, pdu);
 
 	if (pipe == -1)
 		return;
-- 
2.14.1

