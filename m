Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3BDC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7A9214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789350;
	bh=+h2t07JGPZ7gUYYpxbqrNuTVz7dJzE33rJUrzM2JTAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CvhMhpjsbGgaUaw19PoTNDzVHDAA8QZ/oE2dyCwW5MX0TRJhyBs5w9O2HWV9pkmk3
	 GHEeDRn+fXLc9+R7a6zlCI7q79bLTW97n2b3t1uOxESHDOmmqzwfBMDGvnp7trDQ+z
	 QVjcYqlZwm10jatPklik3KHkDnX9AblWXLtZMD1Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7A9214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeLNMJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731008AbeLNMJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568FE2147D;
        Fri, 14 Dec 2018 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789343;
        bh=+h2t07JGPZ7gUYYpxbqrNuTVz7dJzE33rJUrzM2JTAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1f3VhupuXxIjIPIxXQ2Pig3O6zIdCapA2DrfKm1abe9nv1165zRF8ZuJ1JLUByvK
         SSQMHDK1xHEhEfqg8iJSGdv3IYBlhsgFvzLWYmV4yRiLrzfPn/hpNUp0ZhDdACV/ua
         hGr1qdD7RHAfFnG7K3/h5a1XZ6dBEfp6IsvtQ0yA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 24/89] hwmon (ina2xx) Fix NULL id pointer in probe()
Date:   Fri, 14 Dec 2018 12:59:37 +0100
Message-Id: <20181214115730.884160101@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 70df9ebbd82c794ddfbb49d45b337f18d5588dc2 ]

When using DT configurations, the id pointer might turn out to
be NULL. Then the driver encounters NULL pointer access:

  Unable to handle kernel read from unreadable memory at vaddr 00000018
  [...]
  PC is at ina2xx_probe+0x114/0x200
  LR is at ina2xx_probe+0x10c/0x200
  [...]
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

The reason is that i2c core returns the id pointer by matching
id_table with client->name, while the client->name is actually
using the name from the first string in the DT compatible list,
not the best one. So i2c core would fail to match the id_table
if the best matched compatible string isn't the first one, and
then would return a NULL id pointer.

This probably should be fixed in i2c core. But it doesn't hurt
to make the driver robust. So this patch fixes it by using the
"chip" that's added to unify both DT and non-DT configurations.

Additionally, since id pointer could be null, so as id->name:
  ina2xx 10-0047: power monitor (null) (Rshunt = 1000 uOhm)
  ina2xx 10-0048: power monitor (null) (Rshunt = 10000 uOhm)

So this patch also fixes NULL name pointer, using client->name
to play safe and to align with hwmon->name.

Fixes: bd0ddd4d0883 ("hwmon: (ina2xx) Add OF device ID table")
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ina2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 71d3445ba869..c2252cf452f5 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -491,7 +491,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	}
 
 	data->groups[group++] = &ina2xx_group;
-	if (id->driver_data == ina226)
+	if (chip == ina226)
 		data->groups[group++] = &ina226_group;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
@@ -500,7 +500,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		return PTR_ERR(hwmon_dev);
 
 	dev_info(dev, "power monitor %s (Rshunt = %li uOhm)\n",
-		 id->name, data->rshunt);
+		 client->name, data->rshunt);
 
 	return 0;
 }
-- 
2.19.1



