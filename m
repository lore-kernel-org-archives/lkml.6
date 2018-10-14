Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C1CC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8973F20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8973F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeJNX3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:29:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37332 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728128AbeJNX3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:29:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004cp-SC; Sun, 14 Oct 2018 16:31:07 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000DN-7R; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Guenter Roeck" <linux@roeck-us.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.726227510@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 060/366] hwmon: (nct6775) Fix writing pwmX_mode
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 415eb2a1aaa4881cf85bd86c683356fdd8094a23 upstream.

pwmX_mode is defined in the ABI as 0=DC mode, 1=pwm mode. The chip
register bit is set to 1 for DC mode. This got mixed up, and writing
1 into pwmX_mode resulted in DC mode enabled. Fix it up by using
the ABI definition throughout the driver for consistency.

Fixes: 77eb5b3703d99 ("hwmon: (nct6775) Add support for pwm, pwm_mode, ... ")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hwmon/nct6775.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1287,7 +1287,7 @@ static void nct6775_update_pwm(struct de
 		duty_is_dc = data->REG_PWM_MODE[i] &&
 		  (nct6775_read_value(data, data->REG_PWM_MODE[i])
 		   & data->PWM_MODE_MASK[i]);
-		data->pwm_mode[i] = duty_is_dc;
+		data->pwm_mode[i] = !duty_is_dc;
 
 		fanmodecfg = nct6775_read_value(data, data->REG_FAN_MODE[i]);
 		for (j = 0; j < ARRAY_SIZE(data->REG_PWM); j++) {
@@ -2146,7 +2146,7 @@ show_pwm_mode(struct device *dev, struct
 	struct nct6775_data *data = nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 
-	return sprintf(buf, "%d\n", !data->pwm_mode[sattr->index]);
+	return sprintf(buf, "%d\n", data->pwm_mode[sattr->index]);
 }
 
 static ssize_t
@@ -2167,9 +2167,9 @@ store_pwm_mode(struct device *dev, struc
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
@@ -2178,7 +2178,7 @@ store_pwm_mode(struct device *dev, struc
 	data->pwm_mode[nr] = val;
 	reg = nct6775_read_value(data, data->REG_PWM_MODE[nr]);
 	reg &= ~data->PWM_MODE_MASK[nr];
-	if (val)
+	if (!val)
 		reg |= data->PWM_MODE_MASK[nr];
 	nct6775_write_value(data, data->REG_PWM_MODE[nr], reg);
 	mutex_unlock(&data->update_lock);

