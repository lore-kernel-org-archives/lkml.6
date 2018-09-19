Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A213C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D120920877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkFZrDNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D120920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbeITDM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:12:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46594 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731811AbeITDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:12:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so3330406pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PzdWd2mtb/nvPV2IhoDNDYA/rSI1lOYNytq/vU+Td/4=;
        b=XkFZrDNdxh9jYEwRioSj+NknnXyxkQRGcbeXDYp5iqtP+M96MvkF9dLYVTTSHx1KeI
         UpCRbO/US02FsbEpjgHWsC+7AmyzpCKDbOys0zJsUK1QEyPdya9IH8DxsnoCuA6Y3zxU
         ipysodcFDlfU4EnOYf+UxnhLoDFOuz37HJAMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PzdWd2mtb/nvPV2IhoDNDYA/rSI1lOYNytq/vU+Td/4=;
        b=Z2du1pcqJ2s/Suh9+WkqEqQLDpiZ3lyRuc9sA0t5gi/vfiJGKLhHCfAIk237AmvizJ
         wK9Jxa8ff1s63toPKQbSvv4HOCHWRohgIL/Y1nQk5eU6p/E/9ynAE7YSncgCV6CW5N4h
         upxsskrzG88Vt5rm5VaqldDggUfBKrmy3MTIt3stmfzj/bhjOvCsfa9lckuCAp/k/77+
         Rzkpo3kYANg9HSKa6SBpdjtlifXYw+8H96otauCGXPB4VVQoNVx5k3TfWtw1hfUpIxYa
         DvezbM8wF7/38KvfIKuxEgnYIHysAEDz94YLNpR0gfd8HOTWM9bi0X/GBv6eAMs5WCCF
         RJww==
X-Gm-Message-State: APzg51AMuOAuLpxoQSHSXiX/lzO2WnEmEVcjB0vrGQfP7ANQHtruDHaq
        RZMTl5OKr1utsr7P00wRJ/zZQg==
X-Google-Smtp-Source: ANB0VdYShLTfo/RXp2iRsyGVWE+MnrINxvXNQ65pRhx+lBRqxhq/qhjyhLkS2jX9wP16Wr76t66EXw==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr34506524pgt.164.1537392757559;
        Wed, 19 Sep 2018 14:32:37 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id g5-v6sm28610476pgn.73.2018.09.19.14.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 14:32:36 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        natechancellor@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom: Fix section attribute for qcom_cpufreq_kryo_exit()
Date:   Wed, 19 Sep 2018 14:32:27 -0700
Message-Id: <c0fa33819e4b51a98e6d52e978cd856303d64097.1537392723.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an exit routine and is marked with __init. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index b8d1e6875f16..cb7063797c01 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -221,7 +221,7 @@ static int __init qcom_cpufreq_kryo_init(void)
 }
 module_init(qcom_cpufreq_kryo_init);
 
-static void __init qcom_cpufreq_kryo_exit(void)
+static void __exit qcom_cpufreq_kryo_exit(void)
 {
 	platform_device_unregister(kryo_cpufreq_pdev);
 	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
-- 
2.14.1

