Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqqrcjrFdc3ImCGJ/VF+zeFZqb45QTEcXfY8+6/i+gbLfWw62Zo2hFXsMqSXrLldfrqFDAT
ARC-Seal: i=1; a=rsa-sha256; t=1525116416; cv=none;
        d=google.com; s=arc-20160816;
        b=xAZEjhbAhpUPGycIEGIkAm49nuFa1UVI5DN8rJ+o3QR09ccjhWRXUwzcAXnGYTa3v5
         3RLjtbBGDLPb3yjaylaBsbb4gd0hSheaeY4QJzds9WB7yDrFeMSOAFwaWBDqb1Kc+KEG
         6tlOej1nmP0Un7stvuX/ZyQ2fn3mj9/SivOrfQek2Jk4GqlJqg4ovdRlNYnQNZLCI+qK
         Dbu/tpo+cMd8+skZLszzDGqvy0YVpIqokU66d7/aOXoJaK0dQ44KrdXHtMyT1/CsjuHS
         q9xXjkpzwrNPOZ/g2gi3+hHdBTjS/O2LZr+wiWuYirQm8nnG9cJ9t6Xf5CMM/CSC91Ax
         RICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=HXMIXgaSzMIzSKvDiOOP8V/5bHObYly43SKACWb8iB0=;
        b=BvRBGSiATo8BGOVpaarKaZWDrzBSbFHzYFJw8cirzq9/v/soeDAUrZ0llXv51JfeCc
         1B/Afd+CdPp7d3XCZDWnJ+otmml8CJ5lbqSy+5W0nbr0IcfDreo6RSFD9CZTWSe5J/Dq
         aDac3F3+OnJPkS0/nfznLE96dWGl6cNqAyS47RFMCnl+/v9kuomMN9c3PWflH8XRskMI
         OA4wjBvsULWq2/VKe2NoniW+5RjLtNzaqp4gjX0rh1y0vfUzZyiGgexv3JnE/j1ecpiu
         7DpADZCiOSZpAZIUyw3vDaeGVSC936BAamlw0PvLXk23nSeFSt8oNMSZD/FD2rVBeg/F
         udew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4DB22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 12/91] usbip: vhci_hcd: check rhport before using in vhci_hub_control()
Date: Mon, 30 Apr 2018 12:23:54 -0700
Message-Id: <20180430184004.862563869@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200532252138668?=
X-GMAIL-MSGID: =?utf-8?q?1599200471837805847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 5b22f676118ff25049382041da0db8012e57c9e8 upstream.

Validate !rhport < 0 before using it to access port_status array.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vhci_hcd.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -368,6 +368,8 @@ static int vhci_hub_control(struct usb_h
 		usbip_dbg_vhci_rh(" ClearHubFeature\n");
 		break;
 	case ClearPortFeature:
+		if (rhport < 0)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed == HCD_USB3) {
@@ -525,11 +527,16 @@ static int vhci_hub_control(struct usb_h
 				goto error;
 			}
 
+			if (rhport < 0)
+				goto error;
+
 			vhci_hcd->port_status[rhport] |= USB_PORT_STAT_SUSPEND;
 			break;
 		case USB_PORT_FEAT_POWER:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_POWER\n");
+			if (rhport < 0)
+				goto error;
 			if (hcd->speed == HCD_USB3)
 				vhci_hcd->port_status[rhport] |= USB_SS_PORT_STAT_POWER;
 			else
@@ -538,6 +545,8 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
+			if (rhport < 0)
+				goto error;
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed != HCD_USB3) {
 				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
@@ -548,6 +557,8 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
+			if (rhport < 0)
+				goto error;
 			/* if it's already enabled, disable */
 			if (hcd->speed == HCD_USB3) {
 				vhci_hcd->port_status[rhport] = 0;
@@ -568,6 +579,8 @@ static int vhci_hub_control(struct usb_h
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
+			if (rhport < 0)
+				goto error;
 			if (hcd->speed == HCD_USB3) {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_SS_PORT_STAT_POWER) != 0) {
