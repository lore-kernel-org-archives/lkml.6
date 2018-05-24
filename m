Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+3rhzAM5Mw/uXT6dMBv96hOFS2Lgqfg/q8OkoWvkJmNGAjIeZOjG0hhTIkMkSC/PIA+YM
ARC-Seal: i=1; a=rsa-sha256; t=1527155075; cv=none;
        d=google.com; s=arc-20160816;
        b=Qb6fKIFkwoInGqpHwf1oCXSzqAqWjLNQ7xv0y+ERnx1B9XMajExTh7nKS+QEhHEEWa
         8V43Ywf2dwss1UujpWKVqfRcQTap8JHC86RGMRkV0GiOepFMND6HHqJDEbECNZG9WJWJ
         CAxzuKwJjdEfZeccPVIughOi6sxL3Piu/jgTptv5ugXeoYq6A7nTjf4Z1tiUqghfyyJy
         0f78892d4OQr2qYIncXkRLj1JhWm27aY7AbuSYkkSdf/PWPYnsiTfdgOyyM0lMTSaUwy
         +tnUTSmhB/4KJzaNalVxPiESGrl/a1UIm3wMPIPkEHshEadjqIHyrXTjLoB6VgHATxZz
         PBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zSUcbd4ayItTb+glmUHQ1oXopsAANrhoml08FVFfVmQ=;
        b=fUyHdO8NHifpwnYNbkY+HmpDnK+pMFwbF/3mNrcOuyf/TpMmzXnDMwAqJcGjtNbynd
         UtWTwlFguq+nRRAM2mhe7kdYWf1Cds/ku7uDeSvsl11QUb63t6N7fQnMX/Cvj1PoyKJr
         ewarSOejoJWczfA/3PixPSh9NLyYshmsOVYUfKy0yluSfVZ+4WJfLmHIEgozrwz7IOyK
         Pltx4E2FqA6LdzztzgZdGTDM6mvfq4iViLksBc3/JH68sixfUTjjFJcki2+BqEiShhzD
         2mLVbBR089utBLQgLdNEEWyQu4P4vjUkjM4/GFwUnnOqtXBUC4EZewMeyGW8gYbO7p35
         Q/xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1ug3VTCo;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1ug3VTCo;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 11/92] qmi_wwan: do not steal interfaces from class drivers
Date: Thu, 24 May 2018 11:37:48 +0200
Message-Id: <20180524093200.292686953@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338050226511788?=
X-GMAIL-MSGID: =?utf-8?q?1601338160204378303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -855,6 +855,18 @@ static int qmi_wwan_probe(struct usb_int
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
