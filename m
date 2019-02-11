Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A041921855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895583;
	bh=KZt+uJOdGtv9LZw9v9/botkkhNIrXxcqavLa38Cwh44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MBMPCylL34Lz7MCBLza7ZaTiKAZh6PSj78QB/IghgG4CE8U95K5AnA4PHRtlT0EYK
	 r4vNPdIDySWEG1LeiOy1nXQi0CFZM9i+UznhvM00/VJX4z+ymVutjj/6Q9pz2QjbTa
	 /3TwdVA+WuCodXwBGsSEXcYcoQ1BtzKldsTzfj5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfBKOdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbfBKOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F080820675;
        Mon, 11 Feb 2019 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895577;
        bh=KZt+uJOdGtv9LZw9v9/botkkhNIrXxcqavLa38Cwh44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9yB72ev8zxPTWo7iO6JPOFNc+0ABtC2yqh2im0NMoPFyUUT8X2UaFy5N5mE+i6K2
         RgqAUfjGWcYDUvPIhMh5qJ+/Fn8utepCjwKkGAQsSYBMlSNhUWW/PmD3JWzMYuPa3D
         sOvc+kZ0Z9tpAaEMAFc9Q/H6l1mfP1awzCVc/UWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 252/352] hwmon: (lm80) fix a missing check of bus read in lm80 probe
Date:   Mon, 11 Feb 2019 15:17:59 +0100
Message-Id: <20190211141903.127252087@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



