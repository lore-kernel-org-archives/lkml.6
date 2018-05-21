Return-Path: <xieyisheng1@huawei.com>
X-Google-Smtp-Source: AB8JxZqzYMnY6LInKRtL/Q7EcNfrZtjQQXa+qZDjtIrTzvG0s1P8Ve0ag8GoOPmxqkijV7P8CRvS
ARC-Seal: i=1; a=rsa-sha256; t=1526904842; cv=none;
        d=google.com; s=arc-20160816;
        b=UH1cyElJ3UFDHDE0iVrvM13eODriJeNPxOX4ZwPDOXzO2XffmqKEfvvpb4fW++eBQM
         84bOSfNjB/gJwuqIYMAzWDDVOAOjXJygNMxBKs+la8MpCholcIBFSLJpC3gUl8h1FaM7
         9a+yWFanreSIJm8vvsQA67QhzfhGPsuYThisWjD6kOmzIi+kpzXwPVUQ3UnyPzcjOVOo
         vX7tPccWyAhVGG8twnEWETM7wQaJk5+zFcokg1gPrmBSHQhzZKL93O9OC2QLDA/fUR2g
         3BYbAHGaYjqBgXOe32NWoKi1a/3t6JKKKojatC/X6ijKKbd++kjT9Ri6bkrVLrA+50bK
         TNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=iRx9jKcrOS3rhHhwPPE7Q1woBVe/s2L9ohvWBe7jJLs=;
        b=ZIptnNQTochq6x/GBCK95ep/foLy43bIK0TMY6/az0esZ3UR0y2mbWHgVok+/+9zTX
         jcphKrontbuD7j3oq0NyoG97pHJppTmU/T2+yETTG7YCDR1J+ErOrv+/K0pRIOl3DqMe
         kWcJrOQOn6TaJreGChDaL2qmMqu2712IQkLtVKIbWfagClWW1AO9y+HwkPhji3mmFv/X
         tK1vF6/vszLzqqj5qjUhns7MJYoJz4KWrCbswq5X4tsdzz3ywfVQy0TuUxbWDPR6nZdF
         A4mhoTG3jxIdj+sCJtoaqSEqnFXC2rGO2ZpvOCBIu5QFhhYxjAQqIeZmRHChasfCjF1i
         +13A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>, <linux-usb@vger.kernel.org>,
	"Felipe Balbi" <balbi@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: [PATCH 01/33] usb: phy: use match_string() helper
Date: Mon, 21 May 2018 19:57:38 +0800
Message-ID: <1526903890-35761-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601075771849447048?=
X-GMAIL-MSGID: =?utf-8?q?1601075771849447048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/usb/phy/of.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/phy/of.c b/drivers/usb/phy/of.c
index 1ab134f..5777c9f 100644
--- a/drivers/usb/phy/of.c
+++ b/drivers/usb/phy/of.c
@@ -28,16 +28,14 @@
 enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
 {
 	const char *phy_type;
-	int err, i;
+	int ret;
 
-	err = of_property_read_string(np, "phy_type", &phy_type);
-	if (err < 0)
+	ret = of_property_read_string(np, "phy_type", &phy_type);
+	if (ret < 0)
 		return USBPHY_INTERFACE_MODE_UNKNOWN;
 
-	for (i = 0; i < ARRAY_SIZE(usbphy_modes); i++)
-		if (!strcmp(phy_type, usbphy_modes[i]))
-			return i;
+	ret = match_string(usbphy_modes, ARRAY_SIZE(usbphy_modes), phy_type);
 
-	return USBPHY_INTERFACE_MODE_UNKNOWN;
+	return (ret < 0) ? USBPHY_INTERFACE_MODE_UNKNOWN : ret;
 }
 EXPORT_SYMBOL_GPL(of_usb_get_phy_mode);
-- 
1.7.12.4
