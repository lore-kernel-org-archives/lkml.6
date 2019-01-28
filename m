Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8238FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5709F2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692757;
	bh=H3w7iQyLSktoE60p0KTrHDNUT8HwwE17kKhyhZKV3TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wnpgvf4St7z/7hcfVbb1mE0MGy2SCrLw+ZRnUcxce7xCAFXhqy5V93JX3tML1RJbK
	 nREcC2cUu6Rwmqzi5Sh2aEcKi5pqliwKccunIKbtqO2D2+Bnis4myyAPBkxojqHV9o
	 bUHU3ctQOXXbCes/eVD7kjklJLjqnINbl72K3NK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbfA1QZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390060AbfA1QZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:25:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0245C2084A;
        Mon, 28 Jan 2019 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692751;
        bh=H3w7iQyLSktoE60p0KTrHDNUT8HwwE17kKhyhZKV3TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOMlWigv+3YA7nWvMtE8Mlg2QmHJzdchRaFueXh4VMVBazZaFaormY/Xdid6C3ywj
         LVXA2KrIVR9LVLJLKNUXT7vvQfKNw0la+iGGKwM9qNBpXLqIib7GHq2ZKTz1MDYcbV
         Lh2KejqXV4aVraIe74CZN4O74jsTl9tiacbq6uw4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 64/80] hwmon: (lm80) fix a missing check of bus read in lm80 probe
Date:   Mon, 28 Jan 2019 11:23:45 -0500
Message-Id: <20190128162401.58841-64-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 9aa3aa15f4c2f74f47afd6c5db4b420fadf3f315 ]

In lm80_probe(), if lm80_read_value() fails, it returns a negative
error number which is stored to data->fan[f_min] and will be further
used. We should avoid using the data if the read fails.

The fix checks if lm80_read_value() fails, and if so, returns with the
error number.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm80.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 47ddae6b7038..cb6606a0470d 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -628,6 +628,7 @@ static int lm80_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct lm80_data *data;
+	int rv;
 
 	data = devm_kzalloc(dev, sizeof(struct lm80_data), GFP_KERNEL);
 	if (!data)
@@ -640,8 +641,14 @@ static int lm80_probe(struct i2c_client *client,
 	lm80_init_client(client);
 
 	/* A few vars need to be filled upon startup */
-	data->fan[f_min][0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
-	data->fan[f_min][1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+	rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
+	if (rv < 0)
+		return rv;
+	data->fan[f_min][0] = rv;
+	rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+	if (rv < 0)
+		return rv;
+	data->fan[f_min][1] = rv;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, lm80_groups);
-- 
2.19.1

