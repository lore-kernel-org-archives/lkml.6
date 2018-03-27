Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeC0Me5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:34:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:53241 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeC0Mey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:34:54 -0400
X-IronPort-AV: E=Sophos;i="5.48,367,1517900400";
   d="scan'208";a="10562905"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 04/10] iio: inkern: add module put/get on iio dev module when requesting channels
Date: Tue, 27 Mar 2018 15:32:37 +0300
Message-ID: <1522153963-1121-5-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When requesting channels for a particular consumer device,
besides requesting the device (incrementing the reference counter), also
do it for the driver module of the iio dev. This will avoid the situation
where the producer IIO device can be removed and the consumer is still
present in the kernel.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/inkern.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ec98790..68d9b87 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
@@ -152,6 +153,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
 	if (index < 0)
 		goto err_put;
 	channel->channel = &indio_dev->channels[index];
+	try_module_get(channel->indio_dev->driver_module);
 
 	return 0;
 
@@ -256,8 +258,10 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 	return chans;
 
 error_free_chans:
-	for (i = 0; i < mapind; i++)
+	for (i = 0; i < mapind; i++) {
+		module_put(chans[i].indio_dev->driver_module);
 		iio_device_put(chans[i].indio_dev);
+	}
 	kfree(chans);
 	return ERR_PTR(ret);
 }
@@ -351,6 +355,7 @@ void iio_channel_release(struct iio_channel *channel)
 {
 	if (!channel)
 		return;
+	module_put(channel->indio_dev->driver_module);
 	iio_device_put(channel->indio_dev);
 	kfree(channel);
 }
@@ -482,6 +487,7 @@ void iio_channel_release_all(struct iio_channel *channels)
 	struct iio_channel *chan = &channels[0];
 
 	while (chan->indio_dev) {
+		module_put(chan->indio_dev->driver_module);
 		iio_device_put(chan->indio_dev);
 		chan++;
 	}
-- 
2.7.4
