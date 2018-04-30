Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqO6SCGTXGz4wtJHTYDIJ/0WvBlcw8RHSdRksVKXEzbFn7wrD1h+HBIP6QXWm+XWsRuUbyQ
ARC-Seal: i=1; a=rsa-sha256; t=1525116244; cv=none;
        d=google.com; s=arc-20160816;
        b=yJ+wXALVpZfviPQ5s84C0si8E1tXBukZHsjOepSHCyxHHHi0odM++V4ZYnzk362Pi9
         PlXI2zfooGPtI9kFAUResR6JF9OqLjLED4dZDAr1g39+AzZEwJBz5WAAI3BOe9Sw5RgM
         Ve0Ei7pRhtgqAemlUtWF/zPDtfSK08g/f74z+mag0QjP8rGpnwLmhMD2I0++nc9slrSq
         PThRJqAJP+H5mz2KjZVAHTKIrAyYk68FA3eXs4TWgfwX+3L65bLuZz6hk3HnMXMEweFR
         fZmBMGbDUGYVMP0j54cGszA0xSx59JJK79LexWldfEFWl+st4skZ2Yw86iFHOxKHK5Da
         pWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=NBP2I9w8hBWndGXdLU9azy/7hXz8D81IHzwTJFu5s9M=;
        b=dPgprArgvWYJnb8oDWoCyuDX/o1czM0sD7Kw1Y6nS2xzc1QXu4AsX+sBe4OFY8KxMC
         oUc8dKe9P9YsPQ5nXXBBYizag9vfdd9IRIudnfhBQDZ+9XcWkjCx/xCR8gdT52603Fkh
         yJB4VeCGq2KLAFKKXq+Ie1YoDtuo7SvCgeYzm9PoOP/0dJwplivOxppxA+bScee8+FJR
         C3c+nHsruFKzeuKjOxFvI7F/UiR/d05y5s683O9VvnKSAj+08Lp8favmknSjL8YyOByL
         rOxVmg5Obsb1CeTrL24KS0slkF7QTheMPL55q5XdETZnauWI/TsT3Tm/rt0qelicLe9n
         pAyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFB622DC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasyl Vavrychuk <vvavrychuk@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 06/25] USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster
Date: Mon, 30 Apr 2018 12:23:13 -0700
Message-Id: <20180430183911.080067795@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290734996799?=
X-GMAIL-MSGID: =?utf-8?q?1599200290734996799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasyl Vavrychuk <vvavrychuk@gmail.com>

commit 470b5d6f0cf4674be2d1ec94e54283a1770b6a1a upstream.

Arrow USB Blaster integrated on MAX1000 board uses the same vendor ID
(0x0403) and product ID (0x6010) as the "original" FTDI device.

This patch avoids picking up by ftdi_sio of the first interface of this
USB device. After that this device can be used by Arrow user-space JTAG
driver.

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1908,7 +1908,8 @@ static int ftdi_8u2232c_probe(struct usb
 		return ftdi_jtag_probe(serial);
 
 	if (udev->product &&
-		(!strcmp(udev->product, "BeagleBone/XDS100V2") ||
+		(!strcmp(udev->product, "Arrow USB Blaster") ||
+		 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
 		 !strcmp(udev->product, "SNAP Connect E10")))
 		return ftdi_jtag_probe(serial);
 
