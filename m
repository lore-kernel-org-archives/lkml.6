Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CBFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BFA222B4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897744;
	bh=Mik7Q9ZBLa/I2Bz1gd8P7nWG9+zyF41C+/fk5QIsoHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kgace/zQwrSmAnS3Gg91NtENukv1dndW+0DjLvcHCnEsPugHecVm0FgjjJvnYy7D6
	 Y7u8jmXHtQrTGtC+oxZMIG09HZ7z6ym7L+1p8zEaZOtpPWTeAHFZmyYuq0vYtrGo4Q
	 Tpmgy2rpZHx9Pv/41XDbQuCivpTm5Xk+kFjcvxWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391557AbfBKPJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:09:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391575AbfBKPI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:08:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C611222A7;
        Mon, 11 Feb 2019 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897736;
        bh=Mik7Q9ZBLa/I2Bz1gd8P7nWG9+zyF41C+/fk5QIsoHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ldpk39kvXSlSpeDwOGZRRNgD5uOVsSj32Pd8dlg5ZxgiDykatTjrWDl5A22Tfiucn
         n/YUHrOQcPp//A1O1uK1bthuJGKKZ++aaztKXKcKJv9aeQIEnDQgaXm4M2FTyjKEzA
         7CrMdQgP8NsqeSNoAQVs4rXrXRXykebpwg21ojGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 081/137] hwmon: (lm80) fix a missing check of the status of SMBus read
Date:   Mon, 11 Feb 2019 15:19:22 +0100
Message-Id: <20190211141819.506092303@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



