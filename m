Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48gRICWED0giQZQ6M8lZEq6XA09oL+7uAx+oJXcGptceOBviIuxZnkL2X/Vh6T6CHxUCICr
ARC-Seal: i=1; a=rsa-sha256; t=1523981174; cv=none;
        d=google.com; s=arc-20160816;
        b=wVqSokJ0Ayo2Fe5VHwAjA+fvf14+OKT0xzyVz/0vVHYsS1wrVCyIMWF+ZX64GK4OrZ
         DNYl1RReIjDC+ZIYsboh5FgBM+38rASlcbjACsCNBnGTgSyYPlcMvFT2HaSKbb1CbwOg
         HH5N7cQ4oZ3zZ8XgZpPFul+krcUuQQOUWXvbTxc1x6Jok9FvThD/MTkIq3u0XoV706t6
         RJKIwrbjRJWAJG4HgDZdENQ4/VxzpLmjgcStZyoR1CzWYiVsuj+dm71e+9LpWak8ZRmB
         s37U6ln6n2KLmWggDnDMP9Zs0Z1b9xoEMDi4tTj57t1E84PKSN6KN0edujeNWMnTMDpn
         ifbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LwjDlbpy7sK7zLW1pXg6mU9SWENOKo8Z9Nm1bHVu0yY=;
        b=bCABDZLY/Y7vWWMsVHDl+EiphXq/j9KzWOXkq+4DuDiSq5hSImJ/i5ypTgdrH2MaBE
         nyxlKpD0hzaK7oB0suoiWd3T+PtpuywjygA6o1hBS3awOfziVYHhvIHK6cHNqrh25eMy
         m+u+B0/TuHGIphTGPQOJvrKqKTlRgLTLpPGqLxADn8w9eVU1obzdyMfh+a48LzXUg0Z2
         lkaGj+ElaPtBRlx7+zlrUE6AaC2mSA2CPmKzdBXM+zcd1YxjAxSx2LFPWZHHdz8zPLkS
         f+jqJZcleS0AlNdecD3lG1o1UMJPrrjgI2AB90KtJZAGecM8dSSfHUC4UYbLkwMFVV/z
         IVfQ==
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
Subject: [PATCH 4.14 02/49] cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN
Date: Tue, 17 Apr 2018 17:58:41 +0200
Message-Id: <20180417155715.138988519@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009688150088299?=
X-GMAIL-MSGID: =?utf-8?q?1598010084527598469?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -896,6 +896,12 @@ static const struct usb_device_id	produc
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
 }, {
+	/* Cinterion AHS3 modem by GEMALTO */
+	USB_DEVICE_AND_INTERFACE_INFO(0x1e2d, 0x0055, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
+}, {
 	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long) &cdc_info,
