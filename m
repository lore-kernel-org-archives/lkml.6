Return-Path: <tomeu.vizoso@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521724506; cv=none;
        d=google.com; s=arc-20160816;
        b=fEgnNM5hPRJH1xGM9zIajOYpp+/DKz1zWiaGQ/x2HiIvlPsSe8yrxx0FTvzNTX1K22
         K0L+Ctu5gb6NhMPJqOUbaqt/GfPItnDYD4DeLvaefUzwb4qcUGNxjMaD+izlfIC2275L
         DG0yJKPiOX44pgwmLq8qFbN/tM77lqPNIE0RzObFhpu1UaMSg1btVdEsa5STOQ7gPpAw
         5WXcfTcmY7ntQwoIbBUb3SL3smsDZMogVInxCkkjy81tv1yotX7lLj63WAloK+I34WP0
         BtMEpEAkBdqYqagk3Xhqnd0LKBL5xOFP2mKdkE9aF8jfyYIC5LT8ec7SopNTCJ8/fC7v
         ZSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=OTN5fcY4D05x2aLJsFXenKBgUlvWaaZhkND8ovWTlfE=;
        b=yXBAl7pc8k7ZBeFFZ1pACW3F2KY9ulCyqLlypWQ7oT240yzKZyOfI7Z18a5IntunO6
         S+JpMcs62SjyiQK7aLfXob+Y+CiiBlSPBis/Wnf8/eoDO2BNy2E9a+WlZK2hnRzjeF3l
         +ciKDp01nER8gKRDywODa7INSx+F7WXVA4F79ACU5phDlcAPB0ezcUZp5JxYzdFOBigx
         mpD79S6neH+eWDaZUpUasYGEviyZiMoHEEs/6MCdpXi8P6RJAqrO8wcs+kUOEtXY/fgT
         fZsa5qpzEgHTsRxJk4MwrVUK2pnL4x4orkGjTallAO/wXoKxZGqLSmwDkQwSmaazgofk
         fpuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O8jZnGRn;
       spf=pass (google.com: domain of tomeu.vizoso@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tomeu.vizoso@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=collabora.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O8jZnGRn;
       spf=pass (google.com: domain of tomeu.vizoso@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tomeu.vizoso@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=collabora.com
X-Google-Smtp-Source: AG47ELvXu+d7OsIoze+kYREE9o65PaFXVo5ZwGEoTJ6cS5OOZgOk8XrnXtE+nmLgwWBqtEBqo5BzAg==
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Amelie Delaunay <amelie.delaunay@st.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH v3] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Thu, 22 Mar 2018 14:14:51 +0100
Message-Id: <20180322131451.12631-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630296773142922?=
X-GMAIL-MSGID: =?utf-8?q?1595643795820451692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

devm_regulator_get_optional returns -ENODEV if the regulator isn't
there, so if that's the case we have to make sure not to leave -ENODEV
in the regulator pointer.

Also, make sure we return 0 in that case, but correctly propagate any
other errors. Also propagate the error from _dwc2_hcd_start.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus supply")
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

v2: Only overwrite the error in the pointer after checking it (Heiko
    Stübner <heiko@sntech.de>)
v3: Remove hunks that shouldn't be in this patch
---
 drivers/usb/dwc2/hcd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dcfda5eb4cac..863aed20517f 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -359,8 +359,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
 {
 	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
-	if (IS_ERR(hsotg->vbus_supply))
+	if (PTR_ERR(hsotg->vbus_supply) == -ENODEV) {
+		hsotg->vbus_supply = NULL;
 		return 0;
+	} else if (IS_ERR(hsotg->vbus_supply)) {
+		hsotg->vbus_supply = NULL;
+		return PTR_ERR(hsotg->vbus_supply);
+	}
 
 	return regulator_enable(hsotg->vbus_supply);
 }
@@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	dwc2_vbus_supply_init(hsotg);
-
-	return 0;
+	return dwc2_vbus_supply_init(hsotg);
 }
 
 /*
-- 
2.14.3
