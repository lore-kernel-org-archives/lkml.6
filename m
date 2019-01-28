Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7A42175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695464;
	bh=HyMAqaFJwl6HiEL4HU+bZrxP9e1YDEIkXQIbeN9mQAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOoNsXhTRMKSZXp5sX4pfFBJkjp2gyxS4JfC0UZC1bf9sR8uZ7JvZckpKEFZavKiC
	 5Tolx0tGuSGVcJebDfKWwTKXgjmo1BKG9MIytq4DTC8TeHXYGVrfV3Tr087ogEhUL2
	 YT+CwxySPVutvXCkQQmMwxJ49F9yTvmiYjmJB6D4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbfA1RLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:11:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731301AbfA1QKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:10:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960402084A;
        Mon, 28 Jan 2019 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691800;
        bh=HyMAqaFJwl6HiEL4HU+bZrxP9e1YDEIkXQIbeN9mQAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdP95uBu6wEt+49bKC8MhrIIxJqguIQyUsPavQ7qrjXcwE9Yhz87kY035jPx7216L
         TzxDuPrDQMkfYaGyT08Q5baVP2CIukCRe2dIQNwpYAic7HYrXO7+kNuQCj6Fclhn5H
         FUuUcMYD7GR3MNTGqNH8bCb9LP/uavOwpzsz3VQc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 221/258] hwmon: (lm80) fix a missing check of bus read in lm80 probe
Date:   Mon, 28 Jan 2019 10:58:47 -0500
Message-Id: <20190128155924.51521-221-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 04f9df0d2341..0e30fa00204c 100644
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

