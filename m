Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BB421726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUabxBkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfAWHuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:50:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44468 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfAWHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:50:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so1167009wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 23:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dm1djdLVSS6M3bvErQJB+/zSgJ56gxH1n+KiZojviIM=;
        b=BUabxBkQ80rAjig3sHrjRpICpMA5l8DxYnd61NyX7VsUZaeF8Q+yY3sayjbTXdCDQx
         Ho7N26ZLjOaKxTeEN894vBwYx2rVgSmsjAngx0OVLrK3gq7P1LV6r4cLcmOI5yAn2ZWN
         GqlL9OnXaCzCyE0eo9/sz4z4z227wF84QCC5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dm1djdLVSS6M3bvErQJB+/zSgJ56gxH1n+KiZojviIM=;
        b=lLByr5nOcpuVfFjUxinR8jX/nXgmKg5klw3oW1/4pTz0aFyq4pleOtpz1Krv0kZ3MC
         k3KJAC5c2W95+VfqX4a/QxmawW3XM0GOvw4iljGwvkAG6FtnthIa1NJxP6Ps4gRx9TBx
         6Y9lAK5rP1UK+syDkTSnsAkCR1TrzYBEDGHF0Tb+hnlORqAkIVh+r3SXKiDmPwRIMjIW
         6xbIpkalT7Vxl0ucFC3aICa8lXUN7pK61PIj8WYCtCVgcQCoUViqMK0Yb7xk43vB4OoG
         U6bX1Nnkem4MXFmUhL+Ey+28opAzjUV26FgII/y9Zqi2O6PltW90ZJ7+Vlyo3YdkKSrF
         QOnw==
X-Gm-Message-State: AJcUukdfu1rWMzHCKbi2NvkIB7bvqLiPyJplw0hNyNL6ziZym0+4vUEm
        29aKa91GYRwFBXxp0jHvhsj39g==
X-Google-Smtp-Source: ALg8bN4s0KYtXXBBeFBnpT/Xl0L1FkFFTtFdhD1CirE/gZvyOhrdWY3aDTvRofhEuD6XWg0LmsxXkw==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr1455765wrt.241.1548229820000;
        Tue, 22 Jan 2019 23:50:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5ca6:2921:648b:56b6])
        by smtp.gmail.com with ESMTPSA id i186sm70138787wmd.19.2019.01.22.23.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 23:50:18 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 1/2] PM-runtime: update accounting_timestamp only when enable
Date:   Wed, 23 Jan 2019 08:50:13 +0100
Message-Id: <1548229814-24913-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
References: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing accounting_timestamp to something different from 0 during
pm_runtime_init() doesn't make sense and put useless ordering constraint between
timekeeping_init() and pm_runtime_init().
PM runtime should start accounting time only when it is enable and discard
the period when disabled.
Set accounting_timestamp to now when enabling PM runtime.

Suggested-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fb5e2b6..eccd37f1 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1306,10 +1306,15 @@ void pm_runtime_enable(struct device *dev)
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
-	if (dev->power.disable_depth > 0)
+	if (dev->power.disable_depth > 0) {
 		dev->power.disable_depth--;
-	else
+
+		/* About to enable runtime pm, set accounting_timestamp to now */
+		if (!dev->power.disable_depth)
+			dev->power.accounting_timestamp = jiffies;
+	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
+	}
 
 	WARN(!dev->power.disable_depth &&
 	     dev->power.runtime_status == RPM_SUSPENDED &&
@@ -1506,7 +1511,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = jiffies;
+	dev->power.accounting_timestamp = 0;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-- 
2.7.4

