Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeCOSIa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:08:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45502 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeCOSI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:08:29 -0400
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH -next] hwmon: (scmi) return -EINVAL when sensor information is unavailable
Date: Thu, 15 Mar 2018 18:08:19 +0000
Message-Id: <1521137299-31363-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing NULL pointer to PTR_ERR will result in return value of 0
indicating success which is clearly not what it is intended here.

This patch returns -EINVAL instead when the sensor information is not
available.

Fixes: b23688aefb8b ("hwmon: add support for sensors exported via ARM SCMI")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/scmi-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Guenter,

I will try to push this via ARM-SoC if possible before v4.17 merge window.
So please provide Ack if you are fine.

Regards,
Sudeep

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 32e750373ced..363bf56eb0f2 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -138,7 +138,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	for (i = 0; i < nr_sensors; i++) {
 		sensor = handle->sensor_ops->info_get(handle, i);
 		if (!sensor)
-			return PTR_ERR(sensor);
+			return -EINVAL;
 
 		switch (sensor->type) {
 		case TEMPERATURE_C:
-- 
2.7.4
