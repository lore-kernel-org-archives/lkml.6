Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtTJntRwR/Krjbz5QuasRWGEgWPZNptWhZsHHFqPZdyU+7NOj8y5UnqLuOZaN5td0AuCkd2
ARC-Seal: i=1; a=rsa-sha256; t=1521483034; cv=none;
        d=google.com; s=arc-20160816;
        b=UBlF1iNfDfwImByXC5JJkLUOuuA9IT4Elj7Ever7jC6E/LS9TbfhTdD7OB68lywLZf
         gvpKhxNf2wzbmzeBgUfo9XM1TPyrT+LagDAuDSMbmRGaHjy7Bma0wUjrAUJJW2WWeRpQ
         kfGx+WBsGNfV5Hl9f4j3gGDO4fGsC1vqGaLsY6iljgnP8u4h18MxunCWPW5ucODFOhQG
         yeDHA43HPYH+SFKRGpYllSsmWv2zsUFI0OdfvX/1kq5pQzAt5SHtK/Uo52sxz+Co1SuX
         NjNEgwDrjbq242VADFZBoh31iF7CcXxH/hyq05C7RlS74cA2g2SyVYhm4Ho+kX2eC+s9
         trfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ivTKt/NnpAPtMqnGaRhAyUZVSGSnpLmRyOzt6tHeu+0=;
        b=iSqOcLiPk7n6Q2KZk+zkjcMNvox9e1jl/cnSwmBm910jFwXbF5JUy45E73pmCxBRso
         XDvCOqSV8sT5wehUCdbmfm6ZhseQe+F5JVxDgu8ahvPO5gbx7v5361ZipnIL6eUJ/Myp
         p1KTr7dbxthTsAlPo6AmB+/fczhW+TMD2SB+o6H+CUEh127/59Rm38cPbiGMV5zpswOH
         wOZ7XXI6lM0KGqLXHwNX/tahodgZ++0W7m8NI8ohDE3sBAkb+/R7zx3HSZYeoZtWeqz6
         Ac85YpotIoxEVZkJtVckRl+Rmfa6jRHRQd7QWvJnWp8QWBclBoFpl1whbsbwCcbBjIqB
         kx7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Yuyang Du <yuyang.du@intel.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 36/68] usb: gadget: dummy_hcd: Fix wrong power status bit clear/reset in dummy_hub_control()
Date: Mon, 19 Mar 2018 19:06:14 +0100
Message-Id: <20180319171832.880498306@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390594196287009?=
X-GMAIL-MSGID: =?utf-8?q?1595390594196287009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuyang Du <yuyang.du@intel.com>


[ Upstream commit 9f20dfb44d03745d0d3cef2ffb3abf8d8024fa61 ]

This fixes the commit: 1cd8fd2887e1 ("usb: gadget: dummy_hcd: add
SuperSpeed support").

In the case of ClearPortFeature and USB_PORT_FEAT_POWER, simply clear
the right bit regardless of what the wValue is.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Yuyang Du <yuyang.du@intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2001,16 +2001,13 @@ static int dummy_hub_control(
 			}
 			break;
 		case USB_PORT_FEAT_POWER:
-			if (hcd->speed == HCD_USB3) {
-				if (dum_hcd->port_status & USB_PORT_STAT_POWER)
-					dev_dbg(dummy_dev(dum_hcd),
-						"power-off\n");
-			} else
-				if (dum_hcd->port_status &
-							USB_SS_PORT_STAT_POWER)
-					dev_dbg(dummy_dev(dum_hcd),
-						"power-off\n");
-			/* FALLS THROUGH */
+			dev_dbg(dummy_dev(dum_hcd), "power-off\n");
+			if (hcd->speed == HCD_USB3)
+				dum_hcd->port_status &= ~USB_SS_PORT_STAT_POWER;
+			else
+				dum_hcd->port_status &= ~USB_PORT_STAT_POWER;
+			set_link_state(dum_hcd);
+			break;
 		default:
 			dum_hcd->port_status &= ~(1 << wValue);
 			set_link_state(dum_hcd);
@@ -2181,14 +2178,13 @@ static int dummy_hub_control(
 				if ((dum_hcd->port_status &
 				     USB_SS_PORT_STAT_POWER) != 0) {
 					dum_hcd->port_status |= (1 << wValue);
-					set_link_state(dum_hcd);
 				}
 			} else
 				if ((dum_hcd->port_status &
 				     USB_PORT_STAT_POWER) != 0) {
 					dum_hcd->port_status |= (1 << wValue);
-					set_link_state(dum_hcd);
 				}
+			set_link_state(dum_hcd);
 		}
 		break;
 	case GetPortErrorCount:
