Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7EFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350D22146F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqKBgcXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350D22146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeK1Jmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:42:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42922 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeK1Jmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:42:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so15643532qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Cq3ZiD+tGx4j1Y3n8GtCqDnN/1DyE4U5i4dIPs02Xnw=;
        b=YqKBgcXuzfqf6mvM/JRx1ZUyRRCtXurID5eUHr6bo74c5ugs2KjfjCiYirZgjMVssA
         or4TQjBGtQ4LcTlagZXkWWFgIQ28Bjs/PZw25QyGEAuRQobyjmEx8AcWC62VJcFwwovA
         T7zn7vDE2YhhRrDCYz77COdyyeZjXfbiYszC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cq3ZiD+tGx4j1Y3n8GtCqDnN/1DyE4U5i4dIPs02Xnw=;
        b=KEVWu1Sz8jwNmVct1dk5W29ISAp84uBPwdsxzb1Ka6LbzPCPxH6AVWb79PjuoIfOcb
         moK1ku5l+xRbwuwu/9EKBWk9/F5frvlxLDFvwmaXB1/TYuqk9wXJGD3qcrzxJZAu3I0o
         qbEPgXxSh9iiYSc94KA1itn1KOf90hi9mrHA/gYHDXdoGfteWnSUqh0Y1FeQNDvEaBcv
         NIms3GG/rKJZF3JZRelDYnZt/tiZsmEuffWY+OOSTu22oGNmOn60TBbDvFjF+kfnmEuA
         FpRx9fBcBFyR8bzXfbQ/gGx3r3CWWRGX/Ki4dC1E6kGnNqwx/slM9yWr6IXae4WJLF9D
         Io/Q==
X-Gm-Message-State: AA+aEWaf4Cu2mXAU1aUDuN+a0T6lVc/tETdUrTwXR8xzuY57lwLyt0RE
        2/ROIdwKoy3c7BRgwATyxNQYuQ==
X-Google-Smtp-Source: AFSGD/URovCBwyBBcM3CFyq1E3JQFzPHN5TGA3cOAbRz7dfCXJuDC4vyHdrJVm2fj/8ddmnZjzKIXQ==
X-Received: by 2002:a37:b084:: with SMTP id z126mr30666051qke.154.1543358593549;
        Tue, 27 Nov 2018 14:43:13 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id d32sm3226108qte.36.2018.11.27.14.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 14:43:12 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] thermal: Fix locking in cooling device sysfs update cur_state
Date:   Tue, 27 Nov 2018 17:43:11 -0500
Message-Id: <1543358591-25189-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs interface to update cooling device cur_state does not
currently holding cooling device lock sometimes leading to
stale values in cur_state if getting updated simultanelously
from user space and thermal framework. Adding the proper locking
code fixes this issue.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

V1->V2: Rearranged the code as per Daniel's  review comment 

 drivers/thermal/thermal_sysfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2241cea..aa99edb 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -712,11 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	if ((long)state < 0)
 		return -EINVAL;
 
+	mutex_lock(&cdev->lock);
+
 	result = cdev->ops->set_cur_state(cdev, state);
-	if (result)
-		return result;
-	thermal_cooling_device_stats_update(cdev, state);
-	return count;
+	if (!result)
+		thermal_cooling_device_stats_update(cdev, state);
+
+	mutex_unlock(&cdev->lock);
+	return result ? result : count;
 }
 
 static struct device_attribute
-- 
2.1.4

