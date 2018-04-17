Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48bHumD6JcTTi3uKD7vL+yCn0fb2C6kT7ZLgHWMSg6NO11MHXIucDeIqdqaF4t8nuXTCAHL
ARC-Seal: i=1; a=rsa-sha256; t=1523980998; cv=none;
        d=google.com; s=arc-20160816;
        b=OFqqXgpIu7aevs0eP6foZDFvP9SpVnypn6U30SG1OpZsIEqbOHxhWjVOb/x6QzWHsD
         /Bc8KJUTdj1FdHqrgT8tAmtr30YrqlnXnuL4K3ZV45a1ck/oQJ2/csdewFKm+LHERNnh
         u3yhKZzm6L/5uoEh87cNhCo3qzGYc7shciJyqx6EiaVcI+Zd1Ux7KsI6jrHo//eNN1S9
         9ZfkX73Ztjgil4S83Eeamb3Vwu2NPCaXYkcyKhqnSMiUgPewRGJCQop3u7RcEOhEfdX4
         g4SWU5qfW6NNyrxAwoE2WBPxrIw7pxJmrQUoz7IhgUcUVkelsXDUvgozlhl1EPyEvLc7
         BX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+Iy4W2hJDkPUDVRWdfCmPPWWrguk/edHIygZAdcQpX4=;
        b=abtzRBbCw0A6SAOlPRou3vA62UbM6g8SYBHXRmpBStMHmXmP+7vBiC4dul89jZoDIS
         5NAimw/XWiW0UPN1sSTNdoqTIQtciMJrZhhV0PI6u3G/4F7QioakXKhFBVDeUq8Fp0EE
         sOG0aFIu2MMQoYCPnS6FcfILMHecLV76RmDYlLIyjRTj6VbgFdbDwYu4iFXlAVC2SnPF
         AU16Tph6M6u9dd7vrvP3XCAOOKLqs20LLltwsYoKn5jEODslW8MQlSLoRUY3aIqc0bUl
         kyqswoTRT9os//ds1Pvf3aLFKNihfONwOxQcyXoP4IYGaq2rFr4hmDhmGxlAXBVZyITm
         3Pxg==
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
Subject: [PATCH 4.15 03/53] cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN
Date: Tue, 17 Apr 2018 17:58:28 +0200
Message-Id: <20180417155723.231030902@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009688150088299?=
X-GMAIL-MSGID: =?utf-8?q?1598009899089528059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
