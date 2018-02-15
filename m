Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2266gN4MnKqT5d1wQfFOvEYTN4LJrrWtlPw/D4Bzo1qn3835sCscneYppSU+KeUqxl8xXwHh
ARC-Seal: i=1; a=rsa-sha256; t=1518708025; cv=none;
        d=google.com; s=arc-20160816;
        b=d9bCm3lNvtJYDcFomwJUBdw5SoCPNMmOVKGJs2XBPH5gWWdSz2CaRjSGxbma9KaDw6
         G0ecyXDP5rkeswPbrdqN+tzqLQ6k8grCCruE2j0UrwN+99nRAfoDJpNSb83xkmnZYQUb
         hmhEM0rXftm4Yfk8tmtTzq35mANgdCMRzFRqNMVHEQzTA8n/tN9f3MSSP+7MD6TIXhfc
         hk83FJnMJzJ8Zi4wBqraCAYilnqzFH4JnePYmSZBoKN3vO5YVl1BjxG2NhPLfhr+Qqj3
         yYwgg8qgqW1VQtH6MZ09Y5sMkxaEIm8+RgeuqoTObnGn9MQDSpbRP7wB4de9rbW7f9zb
         9kBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3xPIWvjqMdj4dGBfJYcLjkztDhKO5VnVW060DFR836E=;
        b=eC4paJaVovcV99cGq4bPQ9NkTTINn+DZ/gVZ8jOYuOkrumoKiD1bRpGSEQPf4l9ohl
         uIBMO7x3DAozsKSbiAeGqAp2X2x9DuqVSARURbNPtgPSVJ7DSF+r9hNYNS2KIdlswxfh
         PYyRoyrYfvMktycMcOd+LI2RKk/pihwZQYD5OytwzxuU3Ohsg3HGrv4IRcLOwCeD8DPI
         zWOLRqHBGXxI/qFSpUsrKUzNXDVPnSOzGdNglX2/gaTyHJ3DEL2Cgylw3jzpcfZuNqAP
         3BLwrNioN7Jo+ngtZLXaB+ixznxpYJKD4HwZze39FSMnqnMaRY9/kTiT1n4I9LYjebqg
         dPxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Secunia Research <vuln@secunia.com>,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 16/45] usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input
Date: Thu, 15 Feb 2018 16:17:07 +0100
Message-Id: <20180215144119.306946021@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480786081271245?=
X-GMAIL-MSGID: =?utf-8?q?1592480786081271245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit c6688ef9f29762e65bce325ef4acd6c675806366 upstream.

Harden CMD_SUBMIT path to handle malicious input that could trigger
large memory allocations. Add checks to validate transfer_buffer_length
and number_of_packets to protect against bad input requesting for
unbounded memory allocations. Validate early in get_pipe() and return
failure.

Reported-by: Secunia Research <vuln@secunia.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/usb/usbip/stub_rx.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -341,11 +341,13 @@ static struct stub_priv *stub_priv_alloc
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
@@ -358,6 +360,7 @@ static int get_pipe(struct stub_device *
 		goto err_ret;
 
 	epd = &ep->desc;
+
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
@@ -380,6 +383,27 @@ static int get_pipe(struct stub_device *
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
@@ -388,7 +412,7 @@ static int get_pipe(struct stub_device *
 
 err_ret:
 	/* NOT REACHED */
-	dev_err(&sdev->interface->dev, "get pipe, epnum %d\n", epnum);
+	dev_err(&sdev->udev->dev, "CMD_SUBMIT: invalid epnum %d\n", epnum);
 	return -1;
 }
 
@@ -453,7 +477,7 @@ static void stub_recv_cmd_submit(struct
 	struct stub_priv *priv;
 	struct usbip_device *ud = &sdev->ud;
 	struct usb_device *udev = sdev->udev;
-	int pipe = get_pipe(sdev, pdu->base.ep, pdu->base.direction);
+	int pipe = get_pipe(sdev, pdu);
 
 	if (pipe == -1)
 		return;
