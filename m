Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8492CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DBB214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0PGmh6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DBB214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbeKVFhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:37:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45357 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeKVFhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:37:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so5012123qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/oB6qvy4AnPDvv256HxTIH+Yqrvw1FZpwg+vrRE4eHE=;
        b=g0PGmh6D8GTALlZdPVBg36xQfDEQ14CcNwmDJyDZsJW+3oRLtT2ePK1mEnW2DAnwrO
         rtbu0czijkOfKSeCYhcvmi2RVjNcDcbXP964f2sKL7GwkSN8t6NBFUrjZvmo9c0uBTH+
         E44/SWrred7s7VeiQNRuo75DekyYwiO95AlXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/oB6qvy4AnPDvv256HxTIH+Yqrvw1FZpwg+vrRE4eHE=;
        b=MitlJScuqiJfL3Zi3/DMHSiWXBuFRmhsBsm11VABGcL2OLlcdwAb4z8EdxnMT6hL+k
         AvPsv4/R0jB5qdM5gulk30M523sKySci51hEKXNfdTOOsoJmvQoZ/JLgKHRLBbI59Jks
         P8EhHsaKc9y+FtNL4I6/dTJ3gF1KjbaiUpFuQ1kckx8WOackNBn9HUg0kuv6eKUvDwjs
         nbewpYwLDtRnCGsoyGouIcVfeH8cnt/eyMMTSa6HqX7XMcz0oTtsyD5EihRe/7jZFmeC
         nI3S4McenlTvHHwMbRQboGZobJEeE19wtymhj+o7egmlDkZmqK2i1jB9w6glXJkSp5Ju
         5UMQ==
X-Gm-Message-State: AA+aEWbVd6OrXKwOAHnrVuOQebEit7kthmUtvM/PuMXy4Bk2pPau3G60
        IuuXvw06kC6+2MP+HS5KPj/AFg==
X-Google-Smtp-Source: AFSGD/Vz1fItUgNmXbgKXq6aUfTSIG7rV0Ij5LhqN/tVEgjbAYIlBsBk6Cf6M1UWWWeCrLeV890IPA==
X-Received: by 2002:a0c:d4f9:: with SMTP id y54mr7187097qvh.98.1542826893795;
        Wed, 21 Nov 2018 11:01:33 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id l33sm19719763qta.57.2018.11.21.11.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 11:01:33 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: Fix locking in cooling device sysfs update cur_state
Date:   Wed, 21 Nov 2018 14:01:31 -0500
Message-Id: <1542826891-28642-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs interface to update cooling device cur_state does not
currently hold cooling device lock, leading to stale values
in cur_state especially if getting updated simultanelously
from user space and thermal framework. Adding the proper locking
code fixes this issue.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2241cea..1f0c1e2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -712,10 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	if ((long)state < 0)
 		return -EINVAL;
 
+	mutex_lock(&cdev->lock);
 	result = cdev->ops->set_cur_state(cdev, state);
-	if (result)
+	if (result) {
+		mutex_unlock(&cdev->lock);
 		return result;
+	}
 	thermal_cooling_device_stats_update(cdev, state);
+	mutex_unlock(&cdev->lock);
 	return count;
 }
 
-- 
2.1.4

