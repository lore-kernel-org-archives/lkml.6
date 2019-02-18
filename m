Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6106C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44A42070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498593;
	bh=6Pz3EJjgE4+kPzZmXS7CS95schs2k6etuBpZMpOJJ+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z74jUzlkRpxd+2xHY0XRoMlBUv7tA3Ds1I45zFu6ZYx1AbhcYMJN1CRZdptfC/HqZ
	 6xomL1HQab4CSXiCofECu7wWoYjmFsNBn4Vq2jsZyirI6bpCKZSAWJioqolyOR5k6D
	 9Y69X5uEa+8dwoPnlA0vNxWq36tACKEFp6T6A0uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbfBRODM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbfBRODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 178562173C;
        Mon, 18 Feb 2019 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498584;
        bh=6Pz3EJjgE4+kPzZmXS7CS95schs2k6etuBpZMpOJJ+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lsQ169dqV1dV56tR5qkcix2yy8Ms6VTF9hRDqs4OTO20Hu+MWt7p+GvSVqgUIplJ/
         jF/KO1bnWGrlH8zasu3N1l6ZEAi5lt9/n3+2wldudh9DZDpkGWGhL2Aj4E+CWc+w/q
         TXOb/hcox/T5Hi748CbOG72zpIPM9e6WtmXqNBGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 056/143] hwmon: (lm80) fix a missing check of the status of SMBus read
Date:   Mon, 18 Feb 2019 14:43:04 +0100
Message-Id: <20190218133531.162719769@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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



