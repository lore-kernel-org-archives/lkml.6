Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15484C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE269217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="StTE4o0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfAJJAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:00:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42292 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfAJJAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:00:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so10390524wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=18XqnmtxO2ZjWnroEVY6EZhQhDEBrpPKdAHEWSzf+WU=;
        b=StTE4o0XcaXOhXmbEVctoZSfkYDxDJftLBtLSB+aOMwy6xCkH0BcV5DvLurqinEZ5d
         yotV4lgYIg217pLo1xVL3QfUFxxYzaI2ib4kkbGm7ufUkybttnVtZdjCnJemClaJw0EL
         5kheEW6GNU4boUXUB/G+HMnhl3E+Z2XB+REkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=18XqnmtxO2ZjWnroEVY6EZhQhDEBrpPKdAHEWSzf+WU=;
        b=U2OzruZ44SW8bv2g2JSLSn0h7XcZvfUFVnGddeLSHYjiN/2RMoebh1WgGbwqWsY3YC
         Yzvg/1k4QmqVxw++5aDS0MGWgH8WpxQPE+FQ/cna9zU3D/adCpNp6ryTri8eJlozaObD
         rpUy61ZkX81vBa3WrUzPQlSo1KBGFEn2Q4iaIaYGDmN2/iumTdxmZeJ3t+AS/adSponq
         b1YY9Nh5mnsxNCtN6kVXIyKIYhevPWyPSQPwFLRkVQOjvSrypKGXdBbnlCvnftd7D+p5
         Aw1JV9wOZparamWY4En2q2j6StW8YxS8OJb7C2zmBC6Nkp7jW+pruohKt6DfrqfXPv5+
         STLg==
X-Gm-Message-State: AJcUukcRPtHgTIN1OtzzScMJL9mfwdClJAR4K8bY0By43cDZtXXGYOwH
        6blKXKaWbZE0ioDTxK0QM4NFLw==
X-Google-Smtp-Source: ALg8bN4p1ZQuNVqDCrqwggX/aTkOENTsVdHD1g8Pgg5zQEoc+2qbWVw1fBTyboKuBWbZMFpNiZDfjw==
X-Received: by 2002:adf:f101:: with SMTP id r1mr8434701wro.32.1547110846578;
        Thu, 10 Jan 2019 01:00:46 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e487:f4e5:a382:9ce9])
        by smtp.gmail.com with ESMTPSA id v1sm78383304wrw.90.2019.01.10.01.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 01:00:45 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, tony@atomide.com,
        ladis@linux-mips.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Date:   Thu, 10 Jan 2019 10:00:40 +0100
Message-Id: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast autosuspend_delay in u64 to make sure that the full computation of
expires or slack will be done in u64, even on 32bits arch.
Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
is used when moving delay from msec to nsec

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Change since v1:
- add u64 cast for slack computation

 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..76d0676 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	last_busy = READ_ONCE(dev->power.last_busy);
 
-	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
 	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
@@ -525,7 +525,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 				 * We add a slack of 25% to gather wakeups
 				 * without sacrificing the granularity.
 				 */
-				u64 slack = READ_ONCE(dev->power.autosuspend_delay) *
+				u64 slack = (u64)READ_ONCE(dev->power.autosuspend_delay) *
 						    (NSEC_PER_MSEC >> 2);
 
 				dev->power.timer_expires = expires;
-- 
2.7.4

