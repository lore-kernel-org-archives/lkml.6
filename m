Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+tF/SgM43PrCLDBwSZ4ovgIm5OhCdNWPHcQSbg8RGk+26OfzzXzQ/Y7J11yicKnTteCHtJ
ARC-Seal: i=1; a=rsa-sha256; t=1523472146; cv=none;
        d=google.com; s=arc-20160816;
        b=aelmijNEHF0HzWFxtILX0EOY0cd61A06Rrdm/wzJGNNJLk/A6raWyI+J1UvrCwSwrw
         SVEvinkg535S13LofyWIW9ryF28j0Cjoa3hXJ3V7CLQIzZDVJ9ZHU/BgQFBbVoODAa6U
         MI/GqpNpiZkHN2H31EMlmcygXwtRK/ZWSEqZwQCilF229exEcVUxqn8qotsSSYneMnl0
         AHn52uVJwxzuIhRvfum0+IGdRpyyE+TszHAYecNDwfAwHapolZ513w4xTWb9RwAe/rDf
         /g8YuwL8yX22YdFhAkZTUXwBV3gsotVyTtQbY+Vkc8Bl7//rKZHlDkR6fseFYf81zZLX
         XpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dJc1LKkDA034ePuCWeHw50EcGQuEBVuxMAZe3LafVz8=;
        b=jQCJRxh2A2G2yymH28f4QEqHgOdsl20dXBOz0XkZ+dzYBNsCeydWNs9TeyoUbXabCd
         2yn8ESM75uidQGueJbWFrf25RnRy045C92i8TOaP//PxRuIe09DamAoCkJqIncKn1Qct
         vNOHzxuvWthnyUKyDMxHbI44YMADVOj1b4W68LehXanPSIVZJEQxv7kHlnJUiFc+wTqp
         7oHlJFfIldOOx3sf0NdDVccEZbFKfxOLu59R6EkKmzt2X/72o33Kq6GKeovlxtKAVxoP
         pjaL+r4etokePW2X2c9//03Fp3AVnwi/0q73JQiuT6iWYUPWIx3yffpNYHX6V69j3JIO
         gwSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Sedat Dilek <sedat.dilek@gmail.com>,
	Szymon Janc <szymon.janc@codecoup.pl>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 086/121] Bluetooth: Send HCI Set Event Mask Page 2 command only when needed
Date: Wed, 11 Apr 2018 20:36:29 +0200
Message-Id: <20180411183501.574236530@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476329385636783?=
X-GMAIL-MSGID: =?utf-8?q?1597476329385636783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Holtmann <marcel@holtmann.org>


[ Upstream commit 313f6888c8fbb1bc8b36c9012ce4e1de848df696 ]

The Broadcom BCM20702 Bluetooth controller in ThinkPad-T530 devices
report support for the Set Event Mask Page 2 command, but actually do
return an error when trying to use it.

  < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
  > HCI Event: Command Complete (0x0e) plen 68
       Read Local Supported Commands (0x04|0x0002) ncmd 1
         Status: Success (0x00)
         Commands: 162 entries
           ...
           Set Event Mask Page 2 (Octet 22 - Bit 2)
           ...

  < HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
         Mask: 0x0000000000000000
  > HCI Event: Command Complete (0x0e) plen 4
       Set Event Mask Page 2 (0x03|0x0063) ncmd 1
         Status: Unknown HCI Command (0x01)

Since these controllers do not support any feature that would require
the event mask page 2 to be modified, it is safe to not send this
command at all. The default value is all bits set to zero.

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  9 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=21e6 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=F82FA8E8CFC0
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_core.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1635,6 +1635,7 @@ static void hci_set_event_mask_page_2(st
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 events[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	bool changed = false;
 
 	/* If Connectionless Slave Broadcast master role is supported
 	 * enable all necessary events for it.
@@ -1644,6 +1645,7 @@ static void hci_set_event_mask_page_2(st
 		events[1] |= 0x80;	/* Synchronization Train Complete */
 		events[2] |= 0x10;	/* Slave Page Response Timeout */
 		events[2] |= 0x20;	/* CSB Channel Map Change */
+		changed = true;
 	}
 
 	/* If Connectionless Slave Broadcast slave role is supported
@@ -1654,13 +1656,24 @@ static void hci_set_event_mask_page_2(st
 		events[2] |= 0x02;	/* CSB Receive */
 		events[2] |= 0x04;	/* CSB Timeout */
 		events[2] |= 0x08;	/* Truncated Page Complete */
+		changed = true;
 	}
 
 	/* Enable Authenticated Payload Timeout Expired event if supported */
-	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING)
+	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING) {
 		events[2] |= 0x80;
+		changed = true;
+	}
 
-	hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2, sizeof(events), events);
+	/* Some Broadcom based controllers indicate support for Set Event
+	 * Mask Page 2 command, but then actually do not support it. Since
+	 * the default value is all bits set to zero, the command is only
+	 * required if the event mask has to be changed. In case no change
+	 * to the event mask is needed, skip this command.
+	 */
+	if (changed)
+		hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2,
+			    sizeof(events), events);
 }
 
 static void hci_init3_req(struct hci_request *req, unsigned long opt)
