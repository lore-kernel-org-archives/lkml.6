Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E99C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6642218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2atdPES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeLRV3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41651 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeLRV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so17403607wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nqyu5M43GadzwCnPRoa+RxuMcREhWjlFWdJLqMc9jGQ=;
        b=j2atdPESHEFV/4g++6362Dn0lTQBNnxnzH4XmBQYNUrIb3mlUtWIFagD78R4S+HDSF
         LvkWqPFfyY4TNFGARRcyLqyLu4VHm09uBr9nQkBuef32lBBoIxl/D3vG5o+5pxKqYBjK
         Gv4gXvDQ7JBBdHUdPpE4uaB5t480jHwtYBrYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nqyu5M43GadzwCnPRoa+RxuMcREhWjlFWdJLqMc9jGQ=;
        b=BXL091mjzchhcuvXeVk51HojkQryKvxrv+8DPL1x45ZsVHGp2IC/lwUaXY23VwoBty
         /EYRfVZ5nxsMcC/pZMUkHerhbkhf7zi+oCzustAxoREoAyRQFCWvHXA9Ef/NcI3qXIlX
         s3kwehRCa0y6T9bhQz/GvHDUjQK+NvjZyIjR8BtG7c6l750SCMKAchVYPen9hqsZpCmC
         yKyaN4MclAeIAY8RpuZhvR3rmWKHm9/oMcytxbz4iLNV4ZVKq2JU+kEKoEaZ9IacPbyv
         +jiSE/UoF0deur/jYhq4jwg5HaWVDcosnBAPKGFPgWLSO65FlGRj1emIl+sS/d9Ld4dn
         Oc9w==
X-Gm-Message-State: AA+aEWYC89qJlBeO6yFcldtxNSeI1ycXWzZJDvQ3bhJQXkAmgUBOKh1o
        3w4uuh39EaYCfoNiCwuToSEz3bMHsLI=
X-Google-Smtp-Source: AFSGD/VTVpQlyDRypEE6IoC93q1oS0YV1w7aA+Dh85DQG1DNOzHkImV8DeoZAfxaewWylI2zHkEyog==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr15315181wrn.157.1545168551762;
        Tue, 18 Dec 2018 13:29:11 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:11 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated
        list:ARM/NOMADIK/U300/Ux500 ARCHITECTURES)
Subject: [PATCH 02/25] clocksource/drivers/dbx500: Demote dbx500 PRCMU clocksource
Date:   Tue, 18 Dec 2018 22:28:20 +0100
Message-Id: <20181218212844.30445-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

Demote the DBx500 PRCMU clocksource to quality 100 and
mark it as NONSTOP so it will still be used for
timekeeping across suspend/resume.

The Nomadik MTU timer which has higher precision will
be used when the system is up and running, thanks to
the recent changes properly utilizing the suspend
clocksources.

This was discussed back in 2011 when the driver was
written, but the infrastructure was not available
upstream to use this timer properly. Now the
infrastructure is there, so let's finalize the work.

Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index c1b96dc5f444..4054539fe066 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -46,10 +46,10 @@ static u64 notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
 
 static struct clocksource clocksource_dbx500_prcmu = {
 	.name		= "dbx500-prcmu-timer",
-	.rating		= 300,
+	.rating		= 100,
 	.read		= clksrc_dbx500_prcmu_read,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-- 
2.17.1

