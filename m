Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbeEaLWu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:22:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754593AbeEaLWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:38 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [PATCH v2 01/21] usb: phy: use match_string() helper
Date: Thu, 31 May 2018 19:11:06 +0800
Message-ID: <1527765086-19873-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - donot rename err to ret  - per Andy

 drivers/usb/phy/of.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/of.c b/drivers/usb/phy/of.c
index 1ab134f..9d74081 100644
--- a/drivers/usb/phy/of.c
+++ b/drivers/usb/phy/of.c
@@ -28,16 +28,16 @@
 enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
 {
 	const char *phy_type;
-	int err, i;
+	int err;
 
 	err = of_property_read_string(np, "phy_type", &phy_type);
 	if (err < 0)
 		return USBPHY_INTERFACE_MODE_UNKNOWN;
 
-	for (i = 0; i < ARRAY_SIZE(usbphy_modes); i++)
-		if (!strcmp(phy_type, usbphy_modes[i]))
-			return i;
+	err = match_string(usbphy_modes, ARRAY_SIZE(usbphy_modes), phy_type);
+	if (err < 0)
+		return USBPHY_INTERFACE_MODE_UNKNOWN;
 
-	return USBPHY_INTERFACE_MODE_UNKNOWN;
+	return err;
 }
 EXPORT_SYMBOL_GPL(of_usb_get_phy_mode);
-- 
1.7.12.4
