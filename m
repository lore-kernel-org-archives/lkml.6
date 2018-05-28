Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165787AbeE1Ogb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:36:31 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:56456 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968924AbeE1Og0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:36:26 -0400
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] usb: dwc3: of_simple: don't call pm_runtime_set_active()
Date: Mon, 28 May 2018 17:36:14 +0300
Message-ID: <1527518174-27860-2-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527518174-27860-1-git-send-email-rogerq@ti.com>
References: <1527518174-27860-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't call pm_runtime_set_active() as it will prevent the device
from being activated in the next pm_runtime_get_sync() call.

Also call pm_runtime_get_sync() before of_platform_populate().

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e98d221..2cbb5c0 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -121,6 +121,9 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_resetc_assert;
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	ret = of_platform_populate(np, NULL, NULL, dev);
 	if (ret) {
 		for (i = 0; i < simple->num_clocks; i++) {
@@ -131,10 +134,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 		goto err_resetc_assert;
 	}
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
-
 	return 0;
 
 err_resetc_assert:
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
