Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D74C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783C221104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFdfcl9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783C221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeK3Fdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:33:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37241 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeK3Fdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:33:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so3249723wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZTpH/PWWAjrgAf66IMtXg3FL+HSUGQrMTer36R8djEg=;
        b=TFdfcl9fiMpLW+d2mLqNhUampoXJ99wZoOXtIYcERSTAQaZTF8IJUj48IoWVx0ezwa
         xzdomsJRFRAbsrs2fIUSEMKE1JpqTRj9LaM00ukUk96CNgx/hrkAkbkzEBJZmL460qOA
         pl4w3IZpBBCqIahZfKdKgZBEsOsF6GBBgUgdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZTpH/PWWAjrgAf66IMtXg3FL+HSUGQrMTer36R8djEg=;
        b=VhvAGS5au25uI84kT1VhAlVqynxAoCyvqK6rYyW86/Q58KCBVzkfIar0lncfiVAj1k
         skor9CRP2X06df3vAo/9YxnOK9NlVkZ95q6t4WryHQHgxzyCuP3tVn7JStez8epYgEHw
         01i+qtm9CGDfJ2fDDSWEcUz+FU68pdA0MK9IbKDJqfR5rLr3ZWKD73bOzFGuztVKbjK+
         SWW+GH+rgvM0+cMX41jlMwR8yPnCmf1UwgryqXfFEKlH/bhmWXf2YD++nJBjf2l2vu4X
         ahQpyligzm/ehjSOZ8/HRIDH259765wrCUu+n4J4yF/RxgIfNqPLjWuEhizWmOjUF4ta
         CzDw==
X-Gm-Message-State: AA+aEWZ2gjo6e9QuwIJS1YiMFw6GkBDVoqDZLkvn63DyF7e/hbUYa6Ra
        EPAFJGr0K5qMP76N/11eoOeRmA==
X-Google-Smtp-Source: AFSGD/VTgxeFc8Mz8d9Zj2QRcJIjGbt5/Z4qPrs+JcwiA0SpxzWfp54YNgV0hm0FSV1Uvcsuxzbq8g==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr2787679wma.85.1543516034254;
        Thu, 29 Nov 2018 10:27:14 -0800 (PST)
Received: from localhost.localdomain (183.250.136.77.rev.sfr.net. [77.136.250.183])
        by smtp.gmail.com with ESMTPSA id e8-v6sm5670788wmf.22.2018.11.29.10.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 10:27:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     vincent.guittot@linarol.org, john.stultz@linaro.org,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/hisi: Fix bad initialization
Date:   Thu, 29 Nov 2018 19:26:56 +0100
Message-Id: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, the thermal driver on hi6220 and hi3660 is broken.

That is due because part of the posted patchset was merged but a small
change in the DT was dropped.

The hi6220 and hi3660 do not have an interrupt name in the DT, so
finding interrupt by name fails.

In addition, the hi3660 only defines one thermal zone in the DT and we
are trying to register two sensors assuming we have two thermal zones
in the DT.

Fix this by adding a couple of line of code to add back compatibility
with older DT and change the sensors number to 1 for the hi3660.

Fixes: 2cffaeff083f (thermal/drivers/hisi: Use platform_get_irq_byname)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index c4111a9..3ab0e63 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -424,7 +424,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	struct platform_device *pdev = data->pdev;
 	struct device *dev = &pdev->dev;
 
-	data->nr_sensors = 2;
+	data->nr_sensors = 1;
 
 	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
 				    data->nr_sensors, GFP_KERNEL);
@@ -590,8 +590,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 
 		ret = platform_get_irq_byname(pdev, sensor->irq_name);
-		if (ret < 0)
-			return ret;
+		if (ret <= 0) {
+			ret = platform_get_irq(pdev, 0);
+			if (ret <=  0) {
+				dev_err(dev, "Failed get interrupt: %d\n", ret);
+				return ret;
+			}
+		}
 
 		ret = devm_request_threaded_irq(dev, ret, NULL,
 						hisi_thermal_alarm_irq_thread,
-- 
2.7.4

