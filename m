Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52108C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D8E2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693838;
	bh=ZCfT/kp1TR+Xf4193Lj1qd4gG0ZZP3lhj/mphjeTJ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LQHc0xvDlQiJqEli8AcwKrIw0SbKSWm7DUrFFL8dNDMsoM+4eLziOPThYehCo1aGi
	 SMvVp5Pzew/PHBamWm73cGMrLcF79Qxv3ptKuWtRNZDvayFZBiigJAQT4/enSteohE
	 oEJ5Q0S+jJINTIQMM+4DI2nD44vD+ccRi2Xi5Ttw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbfA1Qn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:43:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388913AbfA1QXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4BEB21738;
        Mon, 28 Jan 2019 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692593;
        bh=ZCfT/kp1TR+Xf4193Lj1qd4gG0ZZP3lhj/mphjeTJ7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrLx3ajHbhzmIxOqiKB2TdQyV4BSIquahZPP6LXXG8z8cOcq/WTYEiBMN6c6dId8L
         CYBT6sE1QioagyL3TuGfDELw644vywzpX5p1UTMVLFDTsw+HgcXUwoI+z+ThKjB75L
         hU1FPO8ZcY2PXVCUGQDJVqo+vPjewQZvasUP9hkM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 084/107] hwmon: (lm80) fix a missing check of the status of SMBus read
Date:   Mon, 28 Jan 2019 11:19:24 -0500
Message-Id: <20190128161947.57405-84-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit c9c63915519b1def7043b184680f33c24cd49d7b ]

If lm80_read_value() fails, it returns a negative number instead of the
correct read data. Therefore, we should avoid using the data if it
fails.

The fix checks if lm80_read_value() fails, and if so, returns with the
error number.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
[groeck: One variable for return values is enough]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm80.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 4bcd9b882948..47ddae6b7038 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -360,9 +360,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = data->client;
 	unsigned long min, val;
 	u8 reg;
-	int err = kstrtoul(buf, 10, &val);
-	if (err < 0)
-		return err;
+	int rv;
+
+	rv = kstrtoul(buf, 10, &val);
+	if (rv < 0)
+		return rv;
 
 	/* Save fan_min */
 	mutex_lock(&data->update_lock);
@@ -390,8 +392,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	reg = (lm80_read_value(client, LM80_REG_FANDIV) &
-	       ~(3 << (2 * (nr + 1)))) | (data->fan_div[nr] << (2 * (nr + 1)));
+	rv = lm80_read_value(client, LM80_REG_FANDIV);
+	if (rv < 0)
+		return rv;
+	reg = (rv & ~(3 << (2 * (nr + 1))))
+	    | (data->fan_div[nr] << (2 * (nr + 1)));
 	lm80_write_value(client, LM80_REG_FANDIV, reg);
 
 	/* Restore fan_min */
-- 
2.19.1

