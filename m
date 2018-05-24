Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoyfNhuo1yShY6AcMrktrU/dj4csmoSUBIb79Hx5xVaCV4aVVT/UzdDkFlOCo7Tpi/eg52H
ARC-Seal: i=1; a=rsa-sha256; t=1527154970; cv=none;
        d=google.com; s=arc-20160816;
        b=m8l4PntC3Q0+BgjfXTeyyrxYrZ3isn6icyZRILLZaUtk/iEl5J/jHESkVudCPhjySz
         LHTTLuzoiCg+99PcLP6lIRKO89lidlRjRH3qvNkOW3LBt43J5cNbim1oFQxDeI7MGoDg
         lIb3J0asJi4CbaBN+I4YszPH01jonAET2SsTOptt3SGQ+/tECvb9vNR37pwGCWnmYIyJ
         bLWbxv8XCx7C+b/pQ7G7CSD3cKJ4NPy3LwqVY4ps8eH8lUKT3l+Ty1NqvRB6EYePqBYX
         OjWycKdmWhli99tre9r8J7d/lSzCJNJBy2D+xOWW5x8/NTnaphD4PDixE8EMX2DBh2vW
         8Z6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PZcvR5CWuB1BVBSAS8kqCgfeSNPJV/t0vxtDMoqul5k=;
        b=B/37a4hCxCUIBjq8pk93fYa7TNA7TqRskH3LgvTs1uYjnL5VPHCdwnWRoj/dODVAm3
         i5fSEXlUlXvyySjaSSZ2AYlqxGTPct4PvGhqAUnofUVYKt/TpgGJzzfKF8JZOZX+dUma
         NVYCd/l2KpbM67PPaJZ/9/pbE23UqRRrwba9c5hSEODLDTri9cyoa+61Ps5upphLwS6n
         3AjW7ByALmVc5auMxOE/QeGn1AENovFEF0lYv61CROD1v21M1PBedUkaZechLnYYn2ze
         I33PEZW5HEPixPo61Vpy1QCGtP4FhCa9BPXTYjy6KeSIdDQQcb0hjWIfiJfqldS08Dkm
         U0QQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BM5f/kVM;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BM5f/kVM;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 17/45] qmi_wwan: do not steal interfaces from class drivers
Date: Thu, 24 May 2018 11:38:25 +0200
Message-Id: <20180524093122.657904531@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338050226511788?=
X-GMAIL-MSGID: =?utf-8?q?1601338050226511788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/usb/qmi_wwan.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -866,6 +866,7 @@ static int qmi_wwan_probe(struct usb_int
 			  const struct usb_device_id *prod)
 {
 	struct usb_device_id *id = (struct usb_device_id *)prod;
+	struct usb_interface_descriptor *desc = &intf->cur_altsetting->desc;
 
 	/* Workaround to enable dynamic IDs.  This disables usbnet
 	 * blacklisting functionality.  Which, if required, can be
@@ -877,6 +878,18 @@ static int qmi_wwan_probe(struct usb_int
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
 	return usbnet_probe(intf, id);
 }
 
