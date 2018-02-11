Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225ecvHwucy8vfkqhM8V2VYt+RguNWBhZPwCyuQSVwBO+JvvDNZI83qhSxEulqNtmiVxVBQA
ARC-Seal: i=1; a=rsa-sha256; t=1518323621; cv=none;
        d=google.com; s=arc-20160816;
        b=FWUybcGSjNLd/L5T5wslCH5qtSzUUkiZzcqm/3Vw1LZ6r6vveP7rbjvZpFEcJ88oyl
         GrOMaW6uv8/PuGmuHK5bhotzLtjLQUvxqcB6JJ7KBAT7xBbq5Go0u9djqJhOFh3BW20O
         0mj4XzznsnhuGCg3yPsjeApe8w0H9+z3lpx5M51rKQTCGNi4+90efHY3zP6TB+YGBeiM
         fGE3vATsSM+DOSvFF59wkVb4hZ+GGfqJMmM9vaQvSNi4WUwBIVLllRkMlrb0AhdQU9LZ
         hbKyxTTnu5bbX6RMekXgm5J9VxdNxKECVG/s0ppSFzppGD1qXOsaxaNPUnNzt1PiVlPL
         uA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=jNEuAdImRNXMINPc8UWXj1UhsmqtxGHzdq6asQyUDK0=;
        b=gB9mTHcqmg15+G63ccVZ7cIfjuiUbX1T+LkpKfEzfUjc+JBoP3m0eLil2Vf0+MyeuJ
         /2eBGOO+y9Jn4bmLOiqutlnM/0vZhOLPKfdjUFqubYVZZyyAz5SpReYHvQ2MVhleoh7x
         m5PikOsZqoHGkFKUUOBvy3R2tAQiitw5LCWilBZhPyd5FFFOxsZAmbZyeau+FXOJ79gJ
         WEvbCcV/PTcCQojgrda7KYsZuJGKRJHypmF4lLAGpb4YpDVOwCm3Jg//Qm8g3b8kbXV+
         pqSYxgbovUizUYUtakZEQxVKKS4qstPp+SAE2NEDsX44AVH0Dr1Z6LPQFCp9sTbp8zY7
         JoOg==
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
 "Secunia Research" <vuln@secunia.com>,
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.440200643@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 74/79] usbip: fix stub_rx: harden CMD_SUBMIT path to
 handle malicious input
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077709661989304?=
X-GMAIL-MSGID: =?utf-8?q?1592077709661989304?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2:
 - Device for logging purposes is &sdev->interface->dev
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_rx.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -350,11 +350,13 @@ static struct stub_priv *stub_priv_alloc
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
@@ -367,6 +369,15 @@ static int get_pipe(struct stub_device *
 		goto err_ret;
 
 	epd = &ep->desc;
+
+	/* validate transfer_buffer_length */
+	if (pdu->u.cmd_submit.transfer_buffer_length > INT_MAX) {
+		dev_err(&sdev->interface->dev,
+			"CMD_SUBMIT: -EMSGSIZE transfer_buffer_length %d\n",
+			pdu->u.cmd_submit.transfer_buffer_length);
+		return -1;
+	}
+
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
@@ -389,6 +400,21 @@ static int get_pipe(struct stub_device *
 	}
 
 	if (usb_endpoint_xfer_isoc(epd)) {
+		/* validate packet size and number of packets */
+		unsigned int maxp, packets, bytes;
+
+		maxp = usb_endpoint_maxp(epd);
+		maxp *= usb_endpoint_maxp_mult(epd);
+		bytes = pdu->u.cmd_submit.transfer_buffer_length;
+		packets = DIV_ROUND_UP(bytes, maxp);
+
+		if (pdu->u.cmd_submit.number_of_packets < 0 ||
+		    pdu->u.cmd_submit.number_of_packets > packets) {
+			dev_err(&sdev->interface->dev,
+				"CMD_SUBMIT: isoc invalid num packets %d\n",
+				pdu->u.cmd_submit.number_of_packets);
+			return -1;
+		}
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndisocpipe(udev, epnum);
 		else
@@ -397,7 +423,7 @@ static int get_pipe(struct stub_device *
 
 err_ret:
 	/* NOT REACHED */
-	dev_err(&sdev->interface->dev, "get pipe() invalid epnum %d\n", epnum);
+	dev_err(&sdev->interface->dev, "CMD_SUBMIT: invalid epnum %d\n", epnum);
 	return -1;
 }
 
@@ -462,7 +488,7 @@ static void stub_recv_cmd_submit(struct
 	struct stub_priv *priv;
 	struct usbip_device *ud = &sdev->ud;
 	struct usb_device *udev = sdev->udev;
-	int pipe = get_pipe(sdev, pdu->base.ep, pdu->base.direction);
+	int pipe = get_pipe(sdev, pdu);
 
 	if (pipe == -1)
 		return;
@@ -485,7 +511,8 @@ static void stub_recv_cmd_submit(struct
 	}
 
 	/* set priv->urb->transfer_buffer */
-	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
+	if (pdu->u.cmd_submit.transfer_buffer_length > 0 &&
+	    pdu->u.cmd_submit.transfer_buffer_length <= INT_MAX) {
 		priv->urb->transfer_buffer =
 			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
 				GFP_KERNEL);
