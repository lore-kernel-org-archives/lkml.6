Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeE3Rej (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:34:39 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36657 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeE3Reh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:34:37 -0400
X-Google-Smtp-Source: ADUXVKKMF1clviDi3ZNl6/S+Xz0j0Q1cP0NPPoiBnreQ9QzarKUE+HgwyWfwK7heEkR0lZiJkQubZw==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, Chris Healy <cphealy@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
Date: Wed, 30 May 2018 10:34:14 -0700
Message-Id: <20180530173414.6121-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Workaround introduced for i.MX53 in be9cae2479f48 ("usb: chipidea:
imx: Fix ULPI on imx53") seems to be applicable in case of i.MX51 as
well. Running latest kernel on ZII RDU1 Board (imx51-zii-rdu1.dts)
exhibits a kernel frozen on PORTSC access and applying the workaround
resolves the issue.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index e431c5aafe35..19f5f5f2a48a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -291,7 +291,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	pdata.usb_phy = data->phy;
 
-	if (of_device_is_compatible(np, "fsl,imx53-usb") && pdata.usb_phy &&
+	if ((of_device_is_compatible(np, "fsl,imx53-usb") ||
+	     of_device_is_compatible(np, "fsl,imx51-usb")) && pdata.usb_phy &&
 	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
 		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
 		data->override_phy_control = true;
-- 
2.17.0
