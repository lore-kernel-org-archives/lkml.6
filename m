Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/OrwsOAKoCwNpnizC8DLqI27842vPW9h+m+9/htmxKWN+xFYFXI6y3zQqTVsZT7/XGIH6J
ARC-Seal: i=1; a=rsa-sha256; t=1523980797; cv=none;
        d=google.com; s=arc-20160816;
        b=pZ6BloS2QMVY6ZR0S66FDzUCtCRK9Bkpy4Wr9h76gv5SuZT1vA0BylRq11qQqv6APh
         MIXfUN3ko48MjtgBeBSHInduoK6XMU8ngiF80sD7cMqgsIC22P1keMUKso0iZNawMuk7
         FjtV7ha6o3BExQXZto3HsTyrTw4g23zaXIKoZMcEUgQwyHf9w+E+BUAS60QYxS23dfED
         4xugBfcV24/utTepPuXohEADGSg8yJQ26pZrlrcW1MzoLWG4O/eOsiSwKaeiIMup8Grc
         u/8rq6Cyb3T/5cpUINV9OkhpryN278OTjzNcWbCNnb1ssfDR+Cd1K6iIdzxTCfMTogPK
         PZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BexU2GbvKfVTRmCb63oO0okT11xY1lrzh8LFVWFmelg=;
        b=nGtw/pCsvbkQVJug1xUun+bIEWN1h/zpAfG1mouiLo0HZjBlX/yFWSYCErm/A49ww/
         ZVraa7t6OQBNTl90wX2/GnURcXhdGoGViRe6+qfJxKxpDUaUdK1IPVTKaNeu7CTRPDWH
         KkRPDlGflq31+34HCihwP92dJh9V3qgLlwCtoL09IU6sJJCgJxKd5v2Nz+jzvkiKxGQ0
         N2Oemb6Gg3kdw1fP4iislmzkz3ih3yLWxfQJgbsiZrFcINeijpLXm1RD5gONKMH4/edj
         OvKWfa/qAZSO4KnHUTGna5qEl6yynV0VPeW6e/t1DuTTF4dJ4EDExXzd4GDynO9AfjDT
         ksfQ==
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
Subject: [PATCH 4.16 01/68] cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN
Date: Tue, 17 Apr 2018 17:57:14 +0200
Message-Id: <20180417155749.399588054@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009688150088299?=
X-GMAIL-MSGID: =?utf-8?q?1598009688150088299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -902,6 +902,12 @@ static const struct usb_device_id	produc
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
