Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56812C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA5F218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYqTuq57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfBRHAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:00:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33756 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBRHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:00:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id q12so11496237lfm.0;
        Sun, 17 Feb 2019 23:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xMy+MMXgvfEqcqRMmLOTrdjgKY1i8XqsWTiCG6mS568=;
        b=LYqTuq57Fgbg8gWY1DN9MW2VGgxMDB0tYfGl2b19k/erUXjkiC299tWlBLMlg0oJEK
         4qdjvDTfnw1Cp/9ASxJ1Gn6KqTRVsYDtJ8hghqT4H9kmnxDaG6WuACVxmuADqC0PrFsV
         BnsCqSX7MpEhBeBHpcdIxvnxY6wxzlzZ0NmDmqKXbZx1RIQ14GYBgrKoQNfYi+0fg8On
         IBiSsxIdNTSWD5U5mIFwtS343U40zf2MOF/LJxlsZcCenW/+zJ+xifLvtG3M7X2neWqg
         rcS3wIQTFIrkyVkBxkwr6tNhy6WvhfKE7WvJkzmk/ctUi7/WVsQiICZgGb7qpzD3+492
         sxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xMy+MMXgvfEqcqRMmLOTrdjgKY1i8XqsWTiCG6mS568=;
        b=nY2239sMaR8cIeypHGDowcRjvHV4mwyM2xBpZhWwZSQ+rKbZMMJOcruI4UB46lUZiM
         Sq7xUGVuYLDKR6VZwoPnOgTPhLw/t0wIrO3JOR3Paa9lUv0Q6jkOt6Oxujnv6MEyXv2e
         eMdgE13ONHCKTHsj5UkXW0I+AUaUF1WRNFQqyfbwWOTW2TNmLsGbIRQan2/F0ABa0Dh7
         Yyzw7zciBl8IDotoHna0sbCzUt8ZgmPhGSwoo6bRNXMRx2SlPbgRAFaZr+3zXe9b58+g
         CjiPe82U9c/GadWRMqLf+192k72KFeLC7UmRKVIZgGLJBw4EMX/xiix1EDtJ6qbBbZdQ
         yS3g==
X-Gm-Message-State: AHQUAuZzoq0wKy23A8f8dd1aOazNDeS0aCBo7b8YYNMVCHcsTslEd6yM
        YnPn1UDfy33ymuhyECWczLLEphRbUCE=
X-Google-Smtp-Source: AHgI3Ia7gJ8RWbSrnKhua67ONlXyYGvxLKRqM6IoqobfXDKAg2OaAKiGmls7pdGpNS5xECQmSXYBTA==
X-Received: by 2002:a19:6001:: with SMTP id u1mr13681873lfb.56.1550473204430;
        Sun, 17 Feb 2019 23:00:04 -0800 (PST)
Received: from supervisor.net28 ([37.214.58.110])
        by smtp.gmail.com with ESMTPSA id k14sm3564520lfc.70.2019.02.17.23.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 23:00:03 -0800 (PST)
From:   Arthur Demchenkov <spinal.by@gmail.com>
Cc:     Arthur Demchenkov <spinal.by@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bq27x00: use cached flags
Date:   Mon, 18 Feb 2019 09:59:20 +0300
Message-Id: <20190218065920.16205-1-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flags were just read by bq27xxx_battery_update(),
no need to read them again.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 6dbbe95844a3..29b3a4056865 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1555,27 +1555,14 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
 		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
 }
 
-/*
- * Read flag register.
- * Return < 0 if something fails.
- */
 static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
-	int flags;
-	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
-
-	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
-	if (flags < 0) {
-		dev_err(di->dev, "error reading flag register:%d\n", flags);
-		return flags;
-	}
-
 	/* Unlikely but important to return first */
-	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
+	if (unlikely(bq27xxx_battery_overtemp(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_OVERHEAT;
-	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
+	if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_COLD;
-	if (unlikely(bq27xxx_battery_dead(di, flags)))
+	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_DEAD;
 
 	return POWER_SUPPLY_HEALTH_GOOD;
@@ -1612,6 +1599,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			cache.capacity = bq27xxx_battery_read_soc(di);
 			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
 				cache.energy = bq27xxx_battery_read_energy(di);
+			di->cache.flags = cache.flags;
 			cache.health = bq27xxx_battery_read_health(di);
 		}
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
-- 
2.11.0

