Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6252085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfBUKtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:49:41 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60269 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfBUKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:49:37 -0500
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id F240E40013;
        Thu, 21 Feb 2019 10:49:34 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 2/2] usb: chipidea: Refactor USB PHY selection and keep a single PHY
Date:   Thu, 21 Feb 2019 11:49:14 +0100
Message-Id: <20190221104914.32031-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221104914.32031-1-paul.kocialkowski@bootlin.com>
References: <20190221104914.32031-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code in charge of looking up the USB PHY when no platdata
is provided. Attempt to get a generic USB PHY first, then look for a
legacy USB PHY through device-tree and finally get any registered PHY
with the correct type.

This way, only a single USB PHY is obtained and the flow is easier to
understand and follow.

All error pointers (except for EPROBE_DEFER) are considered as PHY
not found.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/usb/chipidea/core.c | 49 ++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 016e4004fe9d..27749ace2d93 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -954,32 +954,47 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	} else if (ci->platdata->usb_phy) {
 		ci->usb_phy = ci->platdata->usb_phy;
 	} else {
-		ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys",
-							  0);
+		/* Look for a generic PHY first */
 		ci->phy = devm_phy_get(dev->parent, "usb-phy");
 
-		/* Fallback to grabbing any registered USB2 PHY */
-		if (IS_ERR(ci->usb_phy) &&
-		    PTR_ERR(ci->usb_phy) != -EPROBE_DEFER)
+		if (PTR_ERR(ci->phy) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto ulpi_exit;
+		} else if (IS_ERR(ci->phy)) {
+			ci->phy = NULL;
+		}
+
+		/* Look for a legacy USB PHY from device-tree next */
+		if (!ci->phy) {
+			ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent,
+								  "phys", 0);
+
+			if (PTR_ERR(ci->usb_phy) == -EPROBE_DEFER) {
+				ret = -EPROBE_DEFER;
+				goto ulpi_exit;
+			} else if (IS_ERR(ci->usb_phy)) {
+				ci->usb_phy = NULL;
+			}
+		}
+
+		/* Look for any registered legacy USB PHY as last resort */
+		if (!ci->phy && !ci->usb_phy) {
 			ci->usb_phy = devm_usb_get_phy(dev->parent,
 						       USB_PHY_TYPE_USB2);
 
-		/* if both generic PHY and USB PHY layers aren't enabled */
-		if (PTR_ERR(ci->phy) == -ENOSYS &&
-				PTR_ERR(ci->usb_phy) == -ENXIO) {
-			ret = -ENXIO;
-			goto ulpi_exit;
+			if (PTR_ERR(ci->usb_phy) == -EPROBE_DEFER) {
+				ret = -EPROBE_DEFER;
+				goto ulpi_exit;
+			} else if (IS_ERR(ci->usb_phy)) {
+				ci->usb_phy = NULL;
+			}
 		}
 
-		if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy)) {
-			ret = -EPROBE_DEFER;
+		/* No USB PHY was found in the end */
+		if (!ci->phy && !ci->usb_phy) {
+			ret = -ENXIO;
 			goto ulpi_exit;
 		}
-
-		if (IS_ERR(ci->phy))
-			ci->phy = NULL;
-		else if (IS_ERR(ci->usb_phy))
-			ci->usb_phy = NULL;
 	}
 
 	ret = ci_usb_phy_init(ci);
-- 
2.20.1

