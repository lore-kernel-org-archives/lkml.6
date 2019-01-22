Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D943AC282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A921A21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvB2F9xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfAVOYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:24:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35252 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfAVOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:24:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so27606064wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tWy5IgM53R5DQsaBsmPIJYPahNQhBygKg9p4mjF1rG8=;
        b=KvB2F9xEA8wzh3bg0/Yjx88DsEX53SxjxLv0siS3s3D3QYFUzk/9oQA4WCdHip97jv
         puMrJroejhPxPLcRUO5b6TyZxyzmAuE5uMhb0fYBRJeDv+kec/LyOUybzt+5BUEe+G7K
         VJ5LeITyVg7I1edqgNaX+2cC04XPpvMEUZJy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tWy5IgM53R5DQsaBsmPIJYPahNQhBygKg9p4mjF1rG8=;
        b=ZXB4szOvUF0Tgll9dwIFTLNJ26lZe7ZuOzic6y37qZYxiIWjqB1lemSPcyREJBmZ1n
         W3DRj+xa08EP/0L/pRvay+IoVI8TI6F6/mfwJJUg08gkilnmRFzT1C9WEZ5YOICf5MR+
         M6RA0frsOmK7yXQdlCrsp6gGMfdkW8+PmGhJmjaO/dqZUGpP8fjSoy0g301QcvUhUuw4
         k6aZW7Q/yIFaPmcg6VRHoj/lngfdQc+pe5bhAzdQfrKPa7OusgY7JXUlHRIPKNG3I38n
         u0K9lV6abLEX5bl1dArqWKaEn3OpcwPFDAK5DAsKBa5gvjz4CAe2C03nDsaW9nKZWKJ5
         i7aQ==
X-Gm-Message-State: AJcUukcigJJRJXLbYDXmEBQIsm+Z4MqYgBT5OLCJ4mNqlaUbbycCOdev
        Nd2Qw273u7ZuFNiAwo3JaytNog==
X-Google-Smtp-Source: ALg8bN6JYljuXpowIKVynCu0BTlgO89A+xF1zZVKPnMicaryeNLdF/4gKAGO7mp7OvwXv4ffov+WIA==
X-Received: by 2002:a5d:64c7:: with SMTP id y7mr32520873wrv.207.1548167074288;
        Tue, 22 Jan 2019 06:24:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:609f:7896:d361:50c6])
        by smtp.gmail.com with ESMTPSA id l19sm52620119wme.21.2019.01.22.06.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 06:24:33 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
Date:   Tue, 22 Jan 2019 15:24:29 +0100
Message-Id: <1548167070-421-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
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
 drivers/base/power/runtime.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fb5e2b6..7df1d05 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1306,6 +1306,10 @@ void pm_runtime_enable(struct device *dev)
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
+	/* About to enable runtime pm, set accounting_timestamp to now */
+	if (dev->power.disable_depth == 1)
+		dev->power.accounting_timestamp = jiffies;
+
 	if (dev->power.disable_depth > 0)
 		dev->power.disable_depth--;
 	else
@@ -1506,7 +1510,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = jiffies;
+	dev->power.accounting_timestamp = 0;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-- 
2.7.4

