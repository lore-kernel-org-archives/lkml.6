Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x2250CqWYjSVtnrIiwcP5HvbsOYpYwUGcO7I+QF2J1Dn0xNoDMrkGUVe2DvBlNdaKxAOsPKNO
ARC-Seal: i=1; a=rsa-sha256; t=1518323621; cv=none;
        d=google.com; s=arc-20160816;
        b=RYdNjvuevPETfGKlT5bYic6zBqOYh84SsFFwHlkOfEX7SwtVZrGOsYZcR2SEalM5iK
         qXH6yeumMhi29NL/HUH/rlLAFNIo6dN2l2tOnKRLq7VM/Nd4PslAvFiERJNs7bSfEAwv
         cI/gHevssUEoiKwcen1JGVXM/bfTUD5gNTt2XvZ8c2uhv9UTzqtA07AL1tkpsPZo6Tve
         jnpHKOGYxH03mu2xH539583Z7p0P5H0lSJHYUiwK+9aIKic4rnqMOovM6dP6SZjPOdc1
         I6lQvxJwhXMpNgspdiHqcWieed6nSX/FsAxx3oq5b3fINJMLcOp+UbHecthGS3+9i/Nx
         hr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=IYeSva/+cPvuuaL6NMT0G8neVjLxItLu5reN/e0Lrxk=;
        b=F/MeUJy/EQdYQSDGIWxlLQ3mxEHbseJFA0/OUrMI9JE7zbuyCW4Yi5b5IGYPpISqjJ
         cEIKCHQdhsK2M81fGhO179zrHyeP7PsIkUbj65yQI12Tz5yh+grfzQxeT0KOe41DZurL
         jgqWHfhMdeWo5OHiJyBrR1s4YhxQGSuw4ICmCeGLl/oMqBw6rqyBSJe93bUsB8ka4hhW
         canRtZdoiE/BYXQ5w7MfM/8Odke0nnUn39/jlvEK9e873VinbskTFzgBemkEQ2qHAd1C
         FEajPg0+h4GkjzeNV5z9aCKcoHvquSQfzLzV7pjkc+goN9A2nHHi0sFQ887z6XkxIunA
         z63w==
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
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Shuah Khan" <shuahkh@osg.samsung.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.245935806@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 73/79] usbip: fix stub_rx: get_pipe() to validate
 endpoint number
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077710103487950?=
X-GMAIL-MSGID: =?utf-8?q?1592077710103487950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 635f545a7e8be7596b9b2b6a43cab6bbd5a88e43 upstream.

get_pipe() routine doesn't validate the input endpoint number
and uses to reference ep_in and ep_out arrays. Invalid endpoint
number can trigger BUG(). Range check the epnum and returning
error instead of calling BUG().

Change caller stub_recv_cmd_submit() to handle the get_pipe()
error return.

Reported-by: Secunia Research <vuln@secunia.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_rx.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -356,15 +356,15 @@ static int get_pipe(struct stub_device *
 	struct usb_host_endpoint *ep;
 	struct usb_endpoint_descriptor *epd = NULL;
 
+	if (epnum < 0 || epnum > 15)
+		goto err_ret;
+
 	if (dir == USBIP_DIR_IN)
 		ep = udev->ep_in[epnum & 0x7f];
 	else
 		ep = udev->ep_out[epnum & 0x7f];
-	if (!ep) {
-		dev_err(&sdev->interface->dev, "no such endpoint?, %d\n",
-			epnum);
-		BUG();
-	}
+	if (!ep)
+		goto err_ret;
 
 	epd = &ep->desc;
 	if (usb_endpoint_xfer_control(epd)) {
@@ -395,9 +395,10 @@ static int get_pipe(struct stub_device *
 			return usb_rcvisocpipe(udev, epnum);
 	}
 
+err_ret:
 	/* NOT REACHED */
-	dev_err(&sdev->interface->dev, "get pipe, epnum %d\n", epnum);
-	return 0;
+	dev_err(&sdev->interface->dev, "get pipe() invalid epnum %d\n", epnum);
+	return -1;
 }
 
 static void masking_bogus_flags(struct urb *urb)
@@ -463,6 +464,9 @@ static void stub_recv_cmd_submit(struct
 	struct usb_device *udev = sdev->udev;
 	int pipe = get_pipe(sdev, pdu->base.ep, pdu->base.direction);
 
+	if (pipe == -1)
+		return;
+
 	priv = stub_priv_alloc(sdev, pdu);
 	if (!priv)
 		return;
