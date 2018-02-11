Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x226//tS4wKM0mKrmzhBv3xcDQ/VGvljP3wDBqS8M0fWTnHlY2Lf6uuoFX1ze05lr0s2FwKhx
ARC-Seal: i=1; a=rsa-sha256; t=1518323637; cv=none;
        d=google.com; s=arc-20160816;
        b=B214mCvhuzdavaqSLfX2K6xsNpbvFp4AzqnsuiRvSdroKv2vLfmUMz9j8fdUcgLYXE
         hCKhQapW3vdwYXpVAUKg/0e/GRmijRg6Kjf/JF3XKXCcyL74bEds0yrWx2Z6dKgWgzOG
         oqznrEBg1jdO0/ystbsAfv7mXyT/SDqe4t0c3pW0UPksNNYawa8JDISFvBDB3ru5C1Xt
         /y9kBnl7YFQQHqHBAajljt6pC2UF2kX5A4nqv+d1jEMvE90/CZqrxSodMQlh0STVwceJ
         Jt0x4b8o0bJpKAGsrinTh6bgRsH4RLrlq+3KY/ryrtgbB3mwXKyI1QJu6jAljW1HhXRg
         QdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=zJq28cAnDeP1bzoFNCKMI9tcZetmjfgv3NjM+k8CNw8=;
        b=WOz0gpA80NM38FpE/Y6Oc66Wv4yoWGdZXt4kiQ48ojF0CuooH/B+WYsSpVRZxKqJsI
         Vj0FJgabL2AcWdWgLz8clY+pv+n5KIlGeJnex7134ADRlzSUgrq8AH5ZR54jas9KJ6Bd
         jwDZ1ILN96FYZ67+V0T7fbbQBp1pdyvNg0zqhxaDILFbeJ8/idMf/CrzNQyXCUXg8UKV
         KYlGeGCtbbB8B4FQ8vRqcy+gBsRAovgPaML6YEn3kgDbp5oIrFhYB+U+dgQvW3W0Yfib
         Ua2oaLlsKN5zvEyda5vadHNVTEu/W/rtloFdl5O5tKo4dCU13LqRyZ8mSFGGAqz3lOYm
         U9rA==
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
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Secunia Research" <vuln@secunia.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.440011329@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 123/136] usbip: fix stub_rx: get_pipe() to validate
 endpoint number
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077710103487950?=
X-GMAIL-MSGID: =?utf-8?q?1592077726633299956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_rx.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -342,15 +342,15 @@ static int get_pipe(struct stub_device *
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
-		dev_err(&sdev->udev->dev, "no such endpoint?, %d\n",
-			epnum);
-		BUG();
-	}
+	if (!ep)
+		goto err_ret;
 
 	epd = &ep->desc;
 	if (usb_endpoint_xfer_control(epd)) {
@@ -381,9 +381,10 @@ static int get_pipe(struct stub_device *
 			return usb_rcvisocpipe(udev, epnum);
 	}
 
+err_ret:
 	/* NOT REACHED */
-	dev_err(&sdev->udev->dev, "get pipe, epnum %d\n", epnum);
-	return 0;
+	dev_err(&sdev->udev->dev, "get pipe() invalid epnum %d\n", epnum);
+	return -1;
 }
 
 static void masking_bogus_flags(struct urb *urb)
@@ -449,6 +450,9 @@ static void stub_recv_cmd_submit(struct
 	struct usb_device *udev = sdev->udev;
 	int pipe = get_pipe(sdev, pdu->base.ep, pdu->base.direction);
 
+	if (pipe == -1)
+		return;
+
 	priv = stub_priv_alloc(sdev, pdu);
 	if (!priv)
 		return;
