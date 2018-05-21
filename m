Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeEUKUz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:20:55 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35615 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751597AbeEUKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:20:52 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520895600";
   d="scan'208";a="327708875"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 3/3] iio: potentiometer: merge calls to of_match_device and of_device_get_match_data
Date: Mon, 21 May 2018 11:49:10 +0200
Message-Id: <1526896150-27134-4-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop call to of_match_device, which is subsumed by the subsequent
call to of_device_get_match_data.  The code becomes simpler, and a
temporary variable can be dropped.

The semantic match that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
local idexpression match;
identifier i;
expression x, dev, e, e1;
@@
-        match@i = of_match_device(x, dev);
-        if (match) e = of_device_get_match_data(dev);
-        else e = e1;
+        e = of_device_get_match_data(dev);
+        if (!e) e = e1;

@@
identifier r.i;
@@
- const struct of_device_id *i;
... when != i
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/iio/potentiometer/max5481.c |    7 ++-----
 drivers/iio/potentiometer/mcp4018.c |    7 ++-----
 drivers/iio/potentiometer/mcp4531.c |    7 ++-----
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 320a7c9..c051ee0 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -147,7 +147,6 @@ static int mcp4018_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct mcp4018_data *data;
 	struct iio_dev *indio_dev;
-	const struct of_device_id *match;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_BYTE)) {
@@ -162,10 +161,8 @@ static int mcp4018_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	match = of_match_device(of_match_ptr(mcp4018_of_match), dev);
-	if (match)
-		data->cfg = of_device_get_match_data(dev);
-	else
+	data->cfg = of_device_get_match_data(dev);
+	if (!data->cfg)
 		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
 
 	indio_dev->dev.parent = dev;
diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index df894af..d87ca85 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -360,7 +360,6 @@ static int mcp4531_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct mcp4531_data *data;
 	struct iio_dev *indio_dev;
-	const struct of_device_id *match;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WORD_DATA)) {
@@ -375,10 +374,8 @@ static int mcp4531_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	match = of_match_device(of_match_ptr(mcp4531_of_match), dev);
-	if (match)
-		data->cfg = of_device_get_match_data(dev);
-	else
+	data->cfg = of_device_get_match_data(dev);
+	if (!data->cfg)
 		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
 
 	indio_dev->dev.parent = dev;
diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index ffe2761..6d2f13f 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -137,7 +137,6 @@ static int max5481_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct max5481_data *data;
 	const struct spi_device_id *id = spi_get_device_id(spi);
-	const struct of_device_id *match;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
@@ -149,10 +148,8 @@ static int max5481_probe(struct spi_device *spi)
 
 	data->spi = spi;
 
-	match = of_match_device(of_match_ptr(max5481_match), &spi->dev);
-	if (match)
-		data->cfg = of_device_get_match_data(&spi->dev);
-	else
+	data->cfg = of_device_get_match_data(&spi->dev);
+	if (!data->cfg)
 		data->cfg = &max5481_cfg[id->driver_data];
 
 	indio_dev->name = id->name;
