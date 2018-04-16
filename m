Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeDPRxh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:53:37 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:59042 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeDPRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:53:36 -0400
From: <ahsan_hussain@mentor.com>
To: <linux@roeck-us.net>
CC: <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ahsan_hussain@mentor.com>,
        <noor_ahsan@mentor.com>, <cedric_hombourger@mentor.com>
Subject: [PATCH 1/1] hwmon: (ina2xx) initialize mutex before locking
Date: Mon, 16 Apr 2018 22:53:23 +0500
Message-ID: <1523901203-2981-1-git-send-email-ahsan_hussain@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahsan Hussain <ahsan_hussain@mentor.com>

Upstream commit 8d008c0c ("hwmon: (ina2xx) Make calibration register
value fixed"), makes ina2xx_set_shunt() call mutex_lock on an
un-initialized mutex. Initialize it prior so we don't get a NULL pointer
dereference error.

Fixes: 8d008c0c ("hwmon: (ina2xx) Make calibration register value fixed")

Signed-off-by: Ahsan Hussain <ahsan_hussain@mentor.com>
---
 drivers/hwmon/ina2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index a629f7c..1304f01 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -457,6 +457,8 @@ static int ina2xx_probe(struct i2c_client *client,
 			val = INA2XX_RSHUNT_DEFAULT;
 	}
 
+	mutex_init(&data->config_lock);
+
 	ina2xx_set_shunt(data, val);
 
 	ina2xx_regmap_config.max_register = data->config->registers;
@@ -473,8 +475,6 @@ static int ina2xx_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	mutex_init(&data->config_lock);
-
 	data->groups[group++] = &ina2xx_group;
 	if (id->driver_data == ina226)
 		data->groups[group++] = &ina226_group;
-- 
2.7.4
