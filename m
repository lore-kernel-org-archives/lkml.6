Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224d3mKyMJY+1/g9y3KilIlqVi2hmZS/WY4ckR1WMtVi8w8xzduMJLYp3ywxYUfSEjFD1eVg
ARC-Seal: i=1; a=rsa-sha256; t=1518708012; cv=none;
        d=google.com; s=arc-20160816;
        b=iv6GGYRq0At1HMCeTbE2lfMvnwySiW1Mp1ATtp9FuXUlw8F2gLRlAXtrRjldyIxGiX
         iaXf59abSnPPTKvOR/EBE8qRPEfqyIaungDQ6meDDY12fKWdLs34zv1diDxPud6VQhDF
         arqedS8ugLt1AsG89VO4FIw9YY2Cvb35I1O1y11R6bbZTYeNNCfdJp/cspO5mnetdS53
         GhFyckjg0NCyp52wtz6Lel1Z3KqpslLiHLaRKNhAUAk4UqcrJzU/XEzcOhn33BXUvC5x
         e+7fM0sowHkO57iR+2+eRLaxJpssmU4z7GwIsYs0CyTiCLJJDI8RTWad65/d/uJA5ETV
         f78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7Kz5atqCmL3CAvnn0wJ8Tz8gxLQfXYJgTObSDM1kPQw=;
        b=wPdMoxVq08r5cm8UNU0KqenDDGMO3CEzV8Hr9jxSpNC9tHAPgBdqu/hvMf6r4Lsn3D
         22Iv0Dw2BSrl68+R2diEiWNAS/ZBHnsP+wRTrMcuEkpMPIXKWOZCwDziQzho6Ivx9AIL
         6HGhfNKe0yY87KlDC9SrCBuuISNVfCf2/uESruMWqvB3AsxaiVRG3JTMdtj3z8vk9JFZ
         bSRmI83QjKQwS0hwTbzy4SayjVaaqW5pbTH+IPeZQ8fpSTGerE9gW87rohy93VeLRnAl
         +YXyq86VWTfGGaV7HHYUziT1gH0qckjJzv5XtItuefT6mpaoHKf3B3XRKifRWutzHUA3
         uvKw==
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
Subject: [PATCH 3.18 15/45] usbip: fix stub_rx: get_pipe() to validate endpoint number
Date: Thu, 15 Feb 2018 16:17:06 +0100
Message-Id: <20180215144119.094610872@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480772836147626?=
X-GMAIL-MSGID: =?utf-8?q?1592480772836147626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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


---
 drivers/usb/usbip/stub_rx.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -347,15 +347,15 @@ static int get_pipe(struct stub_device *
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
@@ -386,9 +386,10 @@ static int get_pipe(struct stub_device *
 			return usb_rcvisocpipe(udev, epnum);
 	}
 
+err_ret:
 	/* NOT REACHED */
 	dev_err(&sdev->interface->dev, "get pipe, epnum %d\n", epnum);
-	return 0;
+	return -1;
 }
 
 static void masking_bogus_flags(struct urb *urb)
@@ -454,6 +455,9 @@ static void stub_recv_cmd_submit(struct
 	struct usb_device *udev = sdev->udev;
 	int pipe = get_pipe(sdev, pdu->base.ep, pdu->base.direction);
 
+	if (pipe == -1)
+		return;
+
 	priv = stub_priv_alloc(sdev, pdu);
 	if (!priv)
 		return;
