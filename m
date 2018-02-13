Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x227iv9cZNvlRhyk5cFCrAGDkUqm2fK3e8FqFXeQO6MSXe+NRW6OE7d/geB2R7ANDCnp7jZXF
ARC-Seal: i=1; a=rsa-sha256; t=1518552797; cv=none;
        d=google.com; s=arc-20160816;
        b=g1cB7H4Y2v4sVqlYJCgWUD7gDTw0eM31OMWzoLjPmxKGlozfkPt3cMM9EsYx0ts7zE
         Nz9b5V3IFGbWa+qbME8g2hn1v0mw8NxHz63gAvv73B8cV/gsD8c7HW746llCZjQ0WIVm
         HPpdkPFFf+S5VtT5msDFeTnlOy95xXX1IiJiyC2QBmYpX+Ia4ILx0WvqULeCSsC5z3oW
         dUebQ1HgorI2Lo4L/NdMwBGY0V9m1DWklAWkQ++GaeaEQSe05X7oT9aGn4LlFwYsCOyE
         XvihbuAk0RZx2RtXrfgBJwL4hBvImDvjzqVl1qh//QKHLgJBuLG69INHimpJ0g1998Xy
         mCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vIbuzjLf6sPBhs2qqlrE/AUSbz8XqGp1Zy/BYdLQtqk=;
        b=qOel5Q1eXdyvNAcVSt64j7HsKNIrbse0DmoiMDmjLL+7te3ffg0QNrkKtZPY822c9p
         Rh0hu5dJfLQsXJacFiQO1xY5TvKfbE5dMZza9rpq3tP5xPVsbCbszx2EjREFHHd1O5cV
         KPa5qm3bfI9OQv/JATMWAXJfXivCRa8bUOHoQwaTHNtWv2lIM31DGdbeeajwYV2g5L0G
         +y9OZDcVd628/aU91lN24N7H+TtPjyoLG0SpF5fHpb7weAhTbnzZnCGEzk7+5aFSBlwT
         zn7dyoMaKaWzduqPaZ3vuZQNGdynzgT1VXxGHqS4fcpQ9WyxP/XigtgdZVHaT3jf+zsP
         xBAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 3/4] platform/mellanox: mlxreg-hotplug: Change input for device create routine
Date: Tue, 13 Feb 2018 22:09:35 +0000
Message-Id: <1518559776-188942-4-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318018082428602?=
X-GMAIL-MSGID: =?utf-8?q?1592318018082428602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change the first input parameter in mlxreg_hotplug_device_create to the
pointer to mlxreg_hotplug private data in order to allow to use the fields
from the private data structure inside this routine.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index fe4910b..c1e1c4f 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -93,7 +93,7 @@ struct mlxreg_hotplug_priv_data {
 	bool after_probe;
 };
 
-static int mlxreg_hotplug_device_create(struct device *dev,
+static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 					struct mlxreg_core_data *data)
 {
 	/*
@@ -105,7 +105,7 @@ static int mlxreg_hotplug_device_create(struct device *dev,
 
 	data->hpdev.adapter = i2c_get_adapter(data->hpdev.nr);
 	if (!data->hpdev.adapter) {
-		dev_err(dev, "Failed to get adapter for bus %d\n",
+		dev_err(priv->dev, "Failed to get adapter for bus %d\n",
 			data->hpdev.nr);
 		return -EFAULT;
 	}
@@ -113,7 +113,7 @@ static int mlxreg_hotplug_device_create(struct device *dev,
 	data->hpdev.client = i2c_new_device(data->hpdev.adapter,
 					    data->hpdev.brdinfo);
 	if (!data->hpdev.client) {
-		dev_err(dev, "Failed to create client %s at bus %d at addr 0x%02x\n",
+		dev_err(priv->dev, "Failed to create client %s at bus %d at addr 0x%02x\n",
 			data->hpdev.brdinfo->type, data->hpdev.nr,
 			data->hpdev.brdinfo->addr);
 
@@ -270,10 +270,10 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
 			if (item->inversed)
 				mlxreg_hotplug_device_destroy(data);
 			else
-				mlxreg_hotplug_device_create(priv->dev, data);
+				mlxreg_hotplug_device_create(priv, data);
 		} else {
 			if (item->inversed)
-				mlxreg_hotplug_device_create(priv->dev, data);
+				mlxreg_hotplug_device_create(priv, data);
 			else
 				mlxreg_hotplug_device_destroy(data);
 		}
@@ -319,7 +319,7 @@ mlxreg_hotplug_health_work_helper(struct mlxreg_hotplug_priv_data *priv,
 		if (regval == MLXREG_HOTPLUG_HEALTH_MASK) {
 			if ((data->health_cntr++ == MLXREG_HOTPLUG_RST_CNTR) ||
 			    !priv->after_probe) {
-				mlxreg_hotplug_device_create(priv->dev, data);
+				mlxreg_hotplug_device_create(priv, data);
 				data->attached = true;
 			}
 		} else {
-- 
2.1.4
