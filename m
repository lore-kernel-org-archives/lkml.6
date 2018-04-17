Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/FHZY7coW3oy6oKWqr1DIn64E2x/rr400MLmBLyDVQWTvQK2P6ntuL6kEQTT+aOCA/8mWi
ARC-Seal: i=1; a=rsa-sha256; t=1523981440; cv=none;
        d=google.com; s=arc-20160816;
        b=FtVL4KZvMxY7NMSslw5Zn6B1kcCJn8idDyud5kNDiOilRmbKm8CMpND2tnmKRKJNxf
         KWy3fPAnk3h4zslOx5kQiTZjSQrgg3Bp8i1741NrbUI5gkotUToAKGladJ/84qA7ujM2
         Q0YPqe9p7cYhnj/C8Dy0LdnNVl+S3PEzexvpfIlFUzzENMT6VvL3ZPpwKjX+b+n62dqg
         NV2C5aa1PNUe97F77nVyCYpZXAzDeVRgFp7DpCudSbVyXWW1EMVChjMsMkv9XVc1i0lj
         kmx7NX+wy0OrMAYTTB7Cpi+UgVaHGzwdpZst9bTsFwL9O5AxHbvDss4W2iN6T1wK9lSx
         EJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UCBJgUTlPsVtVVW48VBOQIPqM+lL+d26HgClAR+LHMI=;
        b=L/jCwnxi6R5NQlsiqP5RvEsVFpfhAr1bY7i6m8mOUfIoWklZYong4TDdH8iA6gOo+Z
         ebuICUDQ4/3Trbrcfdtl5mZgjf1NJz9sVx1UXXy0mq+mPTihScbk4Gj2HirzPsGzvG5i
         WTYlexVTGran8BDcptwvR+X/hVPT1Yb2vHpbPhfhj8hR2Ht57Li+ycFVGkLJ1cC0CJVc
         HAzeZeB02GGXgIRCZ40096yp8/q/dMPwvXoPgSets+yhFMMf9HZALEibrNgT0J8muFkf
         JXVISjekJKebfqqE5T6svwG8iSfohRUbkneroCy6hhAIRXeHTe7VFOluMumeXNjt/EBw
         LVog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bassem Boubaker <bassem.boubaker@actia.fr>,
	Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 62/66] cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN
Date: Tue, 17 Apr 2018 17:59:35 +0200
Message-Id: <20180417155648.556676728@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009688150088299?=
X-GMAIL-MSGID: =?utf-8?q?1598010362809727210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bassem Boubaker <bassem.boubaker@actia.fr>


[ Upstream commit 53765341ee821c0a0f1dec41adc89c9096ad694c ]

The Cinterion AHS8 is a 3G device with one embedded WWAN interface
using cdc_ether as a driver.

The modem is controlled via AT commands through the exposed TTYs.

AT+CGDCONT write command can be used to activate or deactivate a WWAN
connection for a PDP context defined with the same command. UE
supports one WWAN adapter.

Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ether.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -774,6 +774,12 @@ static const struct usb_device_id	produc
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
 }, {
+	/* Cinterion AHS3 modem by GEMALTO */
+	USB_DEVICE_AND_INTERFACE_INFO(0x1e2d, 0x0055, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
+}, {
 	/* Telit modules */
 	USB_VENDOR_AND_INTERFACE_INFO(0x1bc7, USB_CLASS_COMM,
 			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
