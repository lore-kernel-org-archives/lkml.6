Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJv/BMse0sD4FKezInOwQTmE574paIU2Zh9PsIwHb51X/mQuh3/mbwe/hOag1Dgkr+oN4P
ARC-Seal: i=1; a=rsa-sha256; t=1526631530; cv=none;
        d=google.com; s=arc-20160816;
        b=jXcTJ39lETrqY8j+U9H8VnFNBLKG14w310IFpWdWgWt5hM0KsyRP04oqzs45rvlckq
         i33JuwFwX2We26gsTdghSykGLVxhWA5S+yvb4FqzHj67zbUO+qu0d69KyLDwdtPf50Dk
         Xvk+JHSUEazoxtWktX+Bok2tmN6GwGQWVY9Piex7W7nMf0E1RX/yFZsoM9IU0L2k4SV+
         cow3bOqU1avgSGzHWoe41HGgEroTB5SNEN4e7pzU6N0ZDAegydHwxQpLJT3z8pAa+ZtQ
         AiUl0OaaEN95kcA1hZHtQFIV0M3VzkBx3rjjGUoUqAvtJJlqDQnenPHA122pAiLOVdLQ
         XGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=jU8JRr2nb5eqkECNqgLb+Ql0hb9LNYtl05BEGONfgK8=;
        b=CC9rSmtrQRBaNaLSUQqF0BGN6V/sya2SSo5mkv5hUSVfeb2v5PsWXvmkYhKTEsX3ih
         RUue9XaG/lkVm7pm+pcZEtwcMevZ2QB/k2b2UX/GVBbUudX0GgwmV7jjdzqkI0yTwvLk
         5Sdut73oHp05VDEitHao6R2448Q8iLHVJDlZkksZNaX2rt1pkQQVqbFDtXt22mJi+NKJ
         NtaQSL4vXOdpFpd1abPjXRGSzJQUqXjRt+/3b4+Wf/UYVYUmdNw+xd+2H6maOEwhQ2Zm
         91cEolyARJspJeS8gTltfEUDQLdz1onugt33nBEtJc193D8JkcCswqcUa3f/7/J3jjm9
         5eXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wFLyZLSt;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wFLyZLSt;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 20/55] qmi_wwan: do not steal interfaces from class drivers
Date: Fri, 18 May 2018 10:15:16 +0200
Message-Id: <20180518081458.429844789@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789183753332981?=
X-GMAIL-MSGID: =?utf-8?q?1600789183753332981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1344,6 +1344,18 @@ static int qmi_wwan_probe(struct usb_int
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
