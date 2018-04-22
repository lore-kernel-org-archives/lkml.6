Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+hAXneIe1NKVz+AFBr1Btl8AfDc1QPiiW6v9lIdXJRt/RDXS20IErKLKDH0EDrkvXS+RYn
ARC-Seal: i=1; a=rsa-sha256; t=1524405301; cv=none;
        d=google.com; s=arc-20160816;
        b=QYYvj3bYIcZ7PyQfhxCWN5/6N+JHSBsQywy6qyfRSaKWir4NS2bauolLprJLM5oyYG
         OYgD8wjM1wFMxIzkq3XR9asPMFdPg9DggCmApdg2WcSdUa+0vwFRegylDFnCbcon6bag
         PZiYisHLrK2OyE4Ad2JSLWAquP/vgSVostYPIFv4YWIQZNl3dNLGT1AAZNy4n1jO0EJD
         rX23gMsAcYw0lfyEYqoGcObUhM5rQQ+ruDl7QIgVV57kCtCy8ruyeRcpA1Jx2NWJBhaL
         yCjFEuX7UFT8yBQcyqsbYrjuHr/UgLSNpdEobjlfeCc3XINMCmH9IvfdBDDhS+WJI/yq
         nz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0Xs9Ha41KJfg/uQmLt73ETfWcsszCXBQ/4QUnRcLe34=;
        b=GlJ8YQwgz4v88zxN7ObFgmVvg0GyN8jTlTJuVrtCjNUMzr5ulyELqHe0XX/cgNd2G+
         O9uyjzk5TcVJkNrzPc05CLS/bX7SxepSTi+nNnSd7Apjl56ufcbce1xyYE7wLW5JxA3t
         BacXwOjFuPDDl7MaWexvmFAenoWxY4NZFTemGW5zX43m0k0k2EEJTbYS93o8bD214hwl
         4WAppas7mdDBhbuTsdBsqgWZKnZZSZnvRL444u7kvaRxcOfvpy9HGHkt8E29qEGlvnj6
         ZXwNcfM0y9LnWKdDs6NJuS9sc5QDKCMXdNFIo4H7Din4L/M8H/Lq8mdWiElyqtYbda0v
         54eA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.16 017/196] usb: musb: gadget: misplaced out of bounds check
Date: Sun, 22 Apr 2018 15:50:37 +0200
Message-Id: <20180422135105.010906060@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454813951848255?=
X-GMAIL-MSGID: =?utf-8?q?1598454813951848255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit af6f8529098aeb0e56a68671b450cf74e7a64fcd upstream.

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Bin Liu <b-liu@ti.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_gadget_ep0.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -89,15 +89,19 @@ static int service_tx_status_request(
 		}
 
 		is_in = epnum & USB_DIR_IN;
-		if (is_in) {
-			epnum &= 0x0f;
+		epnum &= 0x0f;
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
+		if (is_in)
 			ep = &musb->endpoints[epnum].ep_in;
-		} else {
+		else
 			ep = &musb->endpoints[epnum].ep_out;
-		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}
