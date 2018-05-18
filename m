Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZonscUWgf5gNGfaUFIACaujCzdWzJqiFxdUOihMwj2Gbdi/3RpO/V2eQWLpgudB46Zcc6LG
ARC-Seal: i=1; a=rsa-sha256; t=1526631605; cv=none;
        d=google.com; s=arc-20160816;
        b=bq+2NefI/ObGYL+BMgy1HV4TguIvufL84VvnIQ2H76u/7SkCbmyvc5lFBK5N1nZHfa
         iuaq4rMHWc9NwP9nSKv8dtzOh9r/4B+IwDXVJBZFI6T0MbpfeVmph/VHSN9TdfLvJRuj
         w0Q3ajjDWphJa48yjJ8+XCq7KAev1bT6muJMpKqzvtHpa5QTqzgAWV2PNS0h7YMjBO0v
         rkNcI+sumJQaDLyytzXjvgimZg8JduhHBz99tVebCtIEJ4rSyRW0lDQytx2VpXyZYsWn
         bgVUrQgBs1jUt+qsrDQWTciYRozNG5Lv8P78W3YPJsZL+JadqX+qP9TrlhSDU9bcVdNE
         jhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=EQxYNP7cNU7XYe1ZDto5Zl3SfdARWchblfVCeoqVs0w=;
        b=tzn6cZdrUgBxTa+g+SHY+yJgI8zk4yeCMrJ8pkU4iKFI6yjrNx2dphKSak3nN1uv+I
         4wex/8Ll1K75XHHO/Affxi8IIKgolLipkBQuM41tLEKmtq9mxlp3B8OdaHXdoBQaUzD6
         5FXY3NfQFH+fETpi1Rk0ofY8U8KbtIguAXLF1CpkgleSRoJhF0VW90AyxaItT29xUzlH
         m6X3lDZLJp++nAr0lXGrQ+ZcIW8arIgMv5b+DTAtQFo+/afXs/AqvK2p1Ys2mhK188j5
         LaR5Rr6WN45m53JPnN3sSNn2oBOYpj/GrIFGQsGds0ckbg01oEl46/memn+4VFUYsDSI
         H23w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=C9rlpVsw;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=C9rlpVsw;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 19/45] qmi_wwan: do not steal interfaces from class drivers
Date: Fri, 18 May 2018 10:15:36 +0200
Message-Id: <20180518081531.306696848@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789183753332981?=
X-GMAIL-MSGID: =?utf-8?q?1600789261600140183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1338,6 +1338,18 @@ static int qmi_wwan_probe(struct usb_int
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
