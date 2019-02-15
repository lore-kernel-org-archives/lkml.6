Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBDEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC4320645
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKZkj40v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404207AbfBOWDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:03:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56001 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404140AbfBOWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:03:53 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so17375623itf.5;
        Fri, 15 Feb 2019 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YiI2FuvoVFdph8NWAUBbcJ+J2guAKi5W60RsKn8MqIk=;
        b=jKZkj40vu1/+/g6BqSV8njnqBALGyOawUyIIcdg33euAqkQi7dEouJTusQCpyYhnOr
         xuWdU490zatGcfKQO3OLNhAFiXov6X9x5ZFed4UXQRvh18eGxk5SZWIgj5EUW+RP7jXs
         S6Zh2zMOYC2mrImts228/VHBJ4y1j1bPetpVNHsCoDbwuaAuKh536u4kPFMC7h8+p4+M
         gWmtYzeswMch/L1zhmNFnseg675Z+SVP16OcYBSBob1o0HEqFZaEWzKasuDp/OOCRTHr
         9/ugVjj0ajzsVDSQRDKTan2jr1fsGEKf827//soafX5vMAgPMbhUBMeDoi0htRwXDaJH
         nRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YiI2FuvoVFdph8NWAUBbcJ+J2guAKi5W60RsKn8MqIk=;
        b=ln8WEQZD3oldRbkdsFavHg2hJVN0nSyQM60U/c9pT+apZYkbAiuvKqaXLDcN0gmuzg
         /MvYCSBdUGFtypgqByaMiBpDnukakuXivlQ50U4TNVJv8Kvgq327u9qgj2zw7yUGFuBx
         XOMsEHW3CinQUTO9/of5YESEs0qTP4cnLlvXUnwQKZuPIueVwHDP3jspr9+TxDPBH61T
         CoA+DjmZQweFxJvGFaVxQCB0iGG0M9XuqN3/z5NbjZMvTL6EK4OiP0iyg9U17z0sXhxC
         XQZ+socx/dCjGswGUTIIq1LPFrV9tnHWVnDzzRYsRzr3mhAL7kVFbvMYewc38PY9/26Z
         Feqg==
X-Gm-Message-State: AHQUAuYu+ibgKRvKzSSrkrbLeDmr8bJaELUrsb27elPAmDhn2BBoHRXE
        AnPYLvldER1/+k4Id9Iin83gLca6
X-Google-Smtp-Source: AHgI3Iaz/BTXEpaam5w/sZLvDaxRjRFZAVoSFkVV2eRNVWSLqOvgJq0jG2EKdO8ENTTQ7kom1iWI9w==
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr7103643ior.258.1550268231179;
        Fri, 15 Feb 2019 14:03:51 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id y12sm2748429ion.62.2019.02.15.14.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:03:50 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] max17042_battery: fix potential use-after-free on device remove
Date:   Fri, 15 Feb 2019 17:03:44 -0500
Message-Id: <20190215220344.16604-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The work which is scheduled on a POR boot is potentially left
pending or running until after the device module is removed,
which could result in a use-after-free.

Fix by registering a cancel/sync callback, which gets executed as
part of standard resource unwinding.

This issue was detected with the help of Coccinelle.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 2a8d75e5e930..581c6bd23388 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -995,6 +995,13 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
 	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
 };
 
+static void max17042_stop_work(void *data)
+{
+	struct max17042_chip *chip = data;
+
+	cancel_work_sync(&chip->work);
+}
+
 static int max17042_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1101,6 +1108,9 @@ static int max17042_probe(struct i2c_client *client,
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if (val & STATUS_POR_BIT) {
 		INIT_WORK(&chip->work, max17042_init_worker);
+		ret = devm_add_action(&client->dev, max17042_stop_work, chip);
+		if (ret)
+			return ret;
 		schedule_work(&chip->work);
 	} else {
 		chip->init_complete = 1;
-- 
2.17.1

