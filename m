Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeEUKVV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:21:21 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35615 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751181AbeEUKUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:20:50 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520895600";
   d="scan'208";a="327708873"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Peter Rosin <peda@axentia.se>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 1/3] i2c: mux: pca954x: merge calls to of_match_device and of_device_get_match_data
Date: Mon, 21 May 2018 11:49:08 +0200
Message-Id: <1526896150-27134-2-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/i2c/muxes/i2c-mux-pca954x.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 09bafd3..ced840f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -373,7 +373,6 @@ static int pca954x_probe(struct i2c_client *client,
 	int num, force, class;
 	struct i2c_mux_core *muxc;
 	struct pca954x *data;
-	const struct of_device_id *match;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
@@ -394,10 +393,8 @@ static int pca954x_probe(struct i2c_client *client,
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
-	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
-	if (match)
-		data->chip = of_device_get_match_data(&client->dev);
-	else
+	data->chip = of_device_get_match_data(&client->dev);
+	if (!data->chip)
 		data->chip = &chips[id->driver_data];
 
 	if (data->chip->id.manufacturer_id != I2C_DEVICE_ID_NONE) {
