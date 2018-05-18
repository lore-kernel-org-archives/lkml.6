Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoekMC1HufSdwVYkkeojjv13/PY7CccnMNuPL9ANA2CPrt6gAzY6IWEtNyOn4zf7TqqxBj5
ARC-Seal: i=1; a=rsa-sha256; t=1526631691; cv=none;
        d=google.com; s=arc-20160816;
        b=voKnB5enJBuB9vGMB4GSU70uWb/1OTOi0VbWj9c1O6suS7SoPZZmT9kc2KetHeM4aK
         yW/l3u3pAqpJgBgmXRMxOx7haqnwFfTxPSya9cz2TyMxrGOI1Yl5/2Fye+wQi5xX6mEA
         OSIxW6pQtRR8SjIUm+nI5PNqYwZF21hbQ9fo3ed6S7gYMcfOIw3IEggBUSA+2IYRCcOF
         fCDf4qBMPfbOlXsp18v6iRKIDFMXXMuwK8pQFlhsWMzIMqbTk0rFur/wFaSzg5AXiLYL
         E+X/Bmpvozh8UvHf6pqBGCL5abrWNEzlhcMz6pAfWjReKuoVlT9Z3VGCeEjtbvkcDh9V
         FvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cnSolweg9VRXFbXWxfL3zOvH+YPubz45PDHcW0xXzLE=;
        b=KyCWVFeUZ0R4rCpDVfBBKjHo1A0IbyiayyeTnyww9KYbaBOxwdJSOVh/yUcGrVNvgo
         mgDO4YgCPJSS+WT/E6jTFCrwja9uMobrAEkVUw5lMzYXAa9FK02fn74NC5QHNqF0wDFk
         neJSUeat+os/dC8bnf2nE3ofQYKz6LY4CFVBQywpn945CxNF0/FYU75oc7a1T+2+MPRA
         iTKAzpOh+h3f+FIVUHQ5Wze5x2iN3I1NA97UrG/QEEDeqAwCwvraa7xutOb2boVVv8df
         5/wAzFsiGl07Nx+bGy4IbmK0jCFkSYkUiV6eR7A9z8DUzIOVdJlNJxoxSovOlQVcL2cv
         3kxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GkXpvC3/;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GkXpvC3/;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 13/33] qmi_wwan: do not steal interfaces from class drivers
Date: Fri, 18 May 2018 10:15:52 +0200
Message-Id: <20180518081535.619003972@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789183753332981?=
X-GMAIL-MSGID: =?utf-8?q?1600789352830538625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Bjørn Mork" <bjorn@mork.no>

[ Upstream commit 5697db4a696c41601a1d15c1922150b4dbf5726c ]

The USB_DEVICE_INTERFACE_NUMBER matching macro assumes that
the { vendorid, productid, interfacenumber } set uniquely
identifies one specific function.  This has proven to fail
for some configurable devices. One example is the Quectel
EM06/EP06 where the same interface number can be either
QMI or MBIM, without the device ID changing either.

Fix by requiring the vendor-specific class for interface number
based matching.  Functions of other classes can and should use
class based matching instead.

Fixes: 03304bcb5ec4 ("net: qmi_wwan: use fixed interface number matching")
Signed-off-by: BjÃ¸rn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1039,6 +1039,18 @@ static int qmi_wwan_probe(struct usb_int
 		id->driver_info = (unsigned long)&qmi_wwan_info;
 	}
 
+	/* There are devices where the same interface number can be
+	 * configured as different functions. We should only bind to
+	 * vendor specific functions when matching on interface number
+	 */
+	if (id->match_flags & USB_DEVICE_ID_MATCH_INT_NUMBER &&
+	    desc->bInterfaceClass != USB_CLASS_VENDOR_SPEC) {
+		dev_dbg(&intf->dev,
+			"Rejecting interface number match for class %02x\n",
+			desc->bInterfaceClass);
+		return -ENODEV;
+	}
+
 	/* Quectel EC20 quirk where we've QMI on interface 4 instead of 0 */
 	if (quectel_ec20_detected(intf) && desc->bInterfaceNumber == 0) {
 		dev_dbg(&intf->dev, "Quectel EC20 quirk, skipping interface 0\n");
