Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E2DC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A58E2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3ccBmkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A58E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeK3M3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:29:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51105 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3M3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:29:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id 125so4182089wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 17:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tO8nw6FUwpyV/om1q12v1m6KplW0p0N/EvdXjasG7+s=;
        b=W3ccBmkHBn//eyInWmkdCk9AwLo+K/WAuzaIt3meyD/Uuj7UD8fPwfkMvhoIqW3j/0
         E/UUmj4Vv+E0IhTKgGmix2A5do0K4trlZjTui35QKpKyGzkwyW0H/zfw1pgyFaSo71yD
         E3pGS8nOMWeijVL/hDyXQKYJPorA01ozicfq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tO8nw6FUwpyV/om1q12v1m6KplW0p0N/EvdXjasG7+s=;
        b=a8VRCyDbD/wlYlJuhWeYMNZnr8zVrL6yxZaur3omgr9O0HRQfSMfRyBGyysME72Zpc
         8FcMHbLI90fQnazZ1I6LuUJdevr6VngyCF5skIZknGdY6Iit/xtJ7vyKpwx/u9SrlfZU
         uCb3CVS4sxk5+ufL7mdKZQURt0bZQhLXGfOBW6Gd4n5ZExUraf71ATkTsQfKDn3QQZez
         A86LiYvUIKuMt6/8LJgxvsh2An15RveGs7WCliCDDI7c2KeHddzpiWH4CZsvTYoY+aa6
         eEnqDSeJSYzHs8skB3uZm09gQGTy/DWW/nu3CRLvpZ5oe79Ffg6ShoCM7RdHEn7r9uR7
         lhfA==
X-Gm-Message-State: AA+aEWZV0PVMd4GqmMsHqWEkjSgktZTNbYAonxOXipcbOhZbzZL/+1Wk
        nGCLO4SdkD9ND7XSIdu3L8jykw==
X-Google-Smtp-Source: AFSGD/XhUfwNpUDCjB6gJX/mzKJvBXxRzoQEUJpVum3eZNAipV6IGQDQeKO3kLKJ0MsPGJnPPgPQIw==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr3592117wmc.34.1543540939762;
        Thu, 29 Nov 2018 17:22:19 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id s9sm2521154wrw.26.2018.11.29.17.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 17:22:18 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] coresight: cpu-debug: Support for CA73 CPUs
Date:   Fri, 30 Nov 2018 09:22:04 +0800
Message-Id: <1543540924-16321-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
module can be initialized successfully when a SoC contain CA73 CPUs.

This patch has been verified on 96boards Hikey960.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 45b2460..e8819d7 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
 		.id	= 0x000bbd08,
 		.mask	= 0x000fffff,
 	},
+	{       /* Debug for Cortex-A73 */
+		.id	= 0x000bbd09,
+		.mask	= 0x000fffff,
+	},
 	{ 0, 0 },
 };
 
-- 
2.7.4

