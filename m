Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeEOIzA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:55:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45654 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752547AbeEOIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:52:38 -0400
X-UUID: 11ce0376175c4ed7a06c94c746e885ef-20180515
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, "Rob Herring" <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>
Subject: [PATCH v2 2/7] serdev: add dev_pm_domain_attach|detach()
Date: Tue, 15 May 2018 16:52:17 +0800
Message-ID: <6b4831836d1d642f9d4c520ffd6796e8a6295303.1526374087.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526374087.git.sean.wang@mediatek.com>
References: <cover.1526374087.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

In order to open up the required power gate before any operation can be
effectively performed over the serial bus between CPU and serdev, it's
clearly essential to add common attach functions for PM domains to serdev
at the probe phase.

Similarly, the relevant dettach function for the PM domains should be
properly and reversely added at the remove phase.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serdev/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index df93b72..c93d8ee 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 
@@ -330,8 +331,16 @@ EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
+	int ret;
+
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret != -EPROBE_DEFER) {
+		ret = sdrv->probe(to_serdev_device(dev));
+		if (ret)
+			dev_pm_domain_detach(dev, true);
+	}
 
-	return sdrv->probe(to_serdev_device(dev));
+	return ret;
 }
 
 static int serdev_drv_remove(struct device *dev)
@@ -339,6 +348,9 @@ static int serdev_drv_remove(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	if (sdrv->remove)
 		sdrv->remove(to_serdev_device(dev));
+
+	dev_pm_domain_detach(dev, true);
+
 	return 0;
 }
 
-- 
2.7.4
