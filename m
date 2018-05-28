Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936623AbeE1KLj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936567AbeE1KLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:11:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 132/185] hwmon: (nct6775) Fix writing pwmX_mode
Date: Mon, 28 May 2018 12:02:53 +0200
Message-Id: <20180528100104.749785175@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 415eb2a1aaa4881cf85bd86c683356fdd8094a23 ]

pwmX_mode is defined in the ABI as 0=DC mode, 1=pwm mode. The chip
register bit is set to 1 for DC mode. This got mixed up, and writing
1 into pwmX_mode resulted in DC mode enabled. Fix it up by using
the ABI definition throughout the driver for consistency.

Fixes: 77eb5b3703d99 ("hwmon: (nct6775) Add support for pwm, pwm_mode, ... ")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nct6775.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1286,7 +1286,7 @@ static void nct6775_update_pwm(struct de
 		duty_is_dc = data->REG_PWM_MODE[i] &&
 		  (nct6775_read_value(data, data->REG_PWM_MODE[i])
 		   & data->PWM_MODE_MASK[i]);
-		data->pwm_mode[i] = duty_is_dc;
+		data->pwm_mode[i] = !duty_is_dc;
 
 		fanmodecfg = nct6775_read_value(data, data->REG_FAN_MODE[i]);
 		for (j = 0; j < ARRAY_SIZE(data->REG_PWM); j++) {
@@ -2145,7 +2145,7 @@ show_pwm_mode(struct device *dev, struct
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 
-	return sprintf(buf, "%d\n", !data->pwm_mode[sattr->index]);
+	return sprintf(buf, "%d\n", data->pwm_mode[sattr->index]);
 }
 
 static ssize_t
@@ -2166,9 +2166,9 @@ store_pwm_mode(struct device *dev, struc
 	if (val > 1)
 		return -EINVAL;
 
-	/* Setting DC mode is not supported for all chips/channels */
+	/* Setting DC mode (0) is not supported for all chips/channels */
 	if (data->REG_PWM_MODE[nr] == 0) {
-		if (val)
+		if (!val)
 			return -EINVAL;
 		return count;
 	}
@@ -2177,7 +2177,7 @@ store_pwm_mode(struct device *dev, struc
 	data->pwm_mode[nr] = val;
 	reg = nct6775_read_value(data, data->REG_PWM_MODE[nr]);
 	reg &= ~data->PWM_MODE_MASK[nr];
-	if (val)
+	if (!val)
 		reg |= data->PWM_MODE_MASK[nr];
 	nct6775_write_value(data, data->REG_PWM_MODE[nr], reg);
 	mutex_unlock(&data->update_lock);
