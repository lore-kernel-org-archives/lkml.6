Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqweVmd3gjMc18rwCoLlkOVQ+iQXQltlPXwW5QfKJiL2jVteKTJ2FqQky4FD/Kh9AC6wnKh
ARC-Seal: i=1; a=rsa-sha256; t=1525116474; cv=none;
        d=google.com; s=arc-20160816;
        b=XumGgtbLsu2X/Cfr34/LxCzM0Nz7FM1Qp2Vxlg5+YlJgsOEwo9Oadtdk4SK4BhTPPQ
         figE1T3+HfeaaINEo+iwOqX/IgJffI+dVsZSA5tAHjiaqZGvz1AwTrQ6xiIIoOSLzO79
         5NHw3o6/aZhriSiprcIRdzhCIeYauDsgM3ntdEDXkVJ1AhTkukz1PXE9qyqPl9WC+Bzv
         AcpsA9KW3fPAG9Xk7sHMtU/b6cZfSOqNYM/6I/p39GeltswLhMI9F5liHvDT7YfYYKRJ
         r87SELHJRTrlkk5WVC2445Lcyy34mfMjrmokVtgiQ8oZxTK4X6Gz35cE0t567ddFZGHu
         d+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4BvKCxUUuwNII4hAb+Hr0NCQXngDG0WhSsLf4Ksas10=;
        b=XKF8EcXf19/1OBUc6H+jPj55mQdqWaP25A6RG0MtffpP1qdEy6qdzLy9Uq208AWZ2S
         jCI4fGa4s7kufJ1U8VMLFMmV6P01bJuwIJ1f6BW/uY5QIt1R5edWthMx2jUugVKAr0Z6
         hkmNyfu867fc53NNTeagfcWwLED+TdEqxJ7undUjW86Oswq4lLKZ9knt/0qBe8/MLdLt
         T5L885IybPyhbxSFxD8DPIntWPU4zkftaHksMRj0BiWc9w5i+nx0E/qrM1N+gFCPoVEy
         mcNjTWbFbjBsoN6qKipIYE0KURhfv0xhwwA3SjiaSPTsC2w2BkMbZglROhgDlKhlnYAh
         mPVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2227822DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.16 012/113] usbip: vhci_hcd: check rhport before using in vhci_hub_control()
Date: Mon, 30 Apr 2018 12:23:43 -0700
Message-Id: <20180430184015.592900904@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200532252138668?=
X-GMAIL-MSGID: =?utf-8?q?1599200532252138668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -354,6 +354,8 @@ static int vhci_hub_control(struct usb_h
 		usbip_dbg_vhci_rh(" ClearHubFeature\n");
 		break;
 	case ClearPortFeature:
+		if (rhport < 0)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed == HCD_USB3) {
@@ -511,11 +513,16 @@ static int vhci_hub_control(struct usb_h
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
@@ -524,6 +531,8 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
+			if (rhport < 0)
+				goto error;
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed != HCD_USB3) {
 				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
@@ -534,6 +543,8 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
+			if (rhport < 0)
+				goto error;
 			/* if it's already enabled, disable */
 			if (hcd->speed == HCD_USB3) {
 				vhci_hcd->port_status[rhport] = 0;
@@ -554,6 +565,8 @@ static int vhci_hub_control(struct usb_h
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
+			if (rhport < 0)
+				goto error;
 			if (hcd->speed == HCD_USB3) {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_SS_PORT_STAT_POWER) != 0) {
