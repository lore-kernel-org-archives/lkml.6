Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F000BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B801621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691804;
	bh=rpGuL0U3h7Hq77TNLq8XnKd1cHGOMWFsyjr95sIHu6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OUp2rHM6YvIp07/EfQ0zqKIPk21yI8np2rq5AID1GnlDq2Do2k/vc96JQ8N3ynDfT
	 yMTC9tYilrLc++WCkm/6kZViRYO+wyf06WvXSHGHkk9HuPyLDOfIeafjhj4CTbYXay
	 a+ygZpFWo9c2WlJxwQCKEOJv5mTQxKt3mnxd9AHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbfA1QKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731494AbfA1QJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77A42171F;
        Mon, 28 Jan 2019 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691799;
        bh=rpGuL0U3h7Hq77TNLq8XnKd1cHGOMWFsyjr95sIHu6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyM1/E60um74XuEihNRwEAzVukqBwm5yMk4idIBKsPHaxw6PWOepdF3YDJPdkCzLp
         QSTzZW2PUNpfTrap3uQekjmeHXgU8lbbVbtA+FhfP4nBiVA1WBTBJeuC9P+Su2+v36
         XfN1LN/nykgxQWYmdUtZVA9+hO/EUkd/4nnuFlmk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 220/258] hwmon: (lm80) fix a missing check of the status of SMBus read
Date:   Mon, 28 Jan 2019 10:58:46 -0500
Message-Id: <20190128155924.51521-220-sashal@kernel.org>
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
index 08e3945a6fbf..04f9df0d2341 100644
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

