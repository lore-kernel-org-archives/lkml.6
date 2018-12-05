Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9681EC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF6A20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP8T3FaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF6A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeLEJhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbeLEJhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:37:31 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50FB920851;
        Wed,  5 Dec 2018 09:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002651;
        bh=AEiYBnLeLCRKd65wPxauWAf1zR3bwxbO5t6Mj0KHlzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZP8T3FaYAhaB6Kg03UNWVONiV+IRYaJ/8PlTtzJX/DKKNgdnx6HPHZOO4uyZLLdPs
         0OorqIR5GGMmrD/UguuAE40yxgcfzGunlRAP5B+W/7GZHQEqJLLh2lRpYd6w3dEZgp
         hhHE5kH7PIamgcHGnMJp5pUkh42jey4wVU/iCQu8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 027/123] hwmon (ina2xx) Fix NULL id pointer in probe()
Date:   Wed,  5 Dec 2018 04:34:19 -0500
Message-Id: <20181205093555.5386-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolin Chen <nicoleotsuka@gmail.com>

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
2.17.1

