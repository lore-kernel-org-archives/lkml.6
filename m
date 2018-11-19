Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EBC20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH4Fw31B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EBC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbeKTAeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:34:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38875 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeKTAeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:34:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so6917678pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wSdV+/zcx8UY8cUfVujyWK2lZLqqr7izfcTZ3/Ms6VU=;
        b=XH4Fw31BKY5CuHoTi49/Ooq89/lBj811lMzAE26n23vEeOsX3f0W44OBq8Lat+yuFA
         VDGPmRhdsnC3cN58sumta1R1oM14YAvFdoEdvZ3AuCpVJACxdFpP1nwuh0ohX8K9tFkp
         Fig7F9oY4agDl8xPNtqWThfpxdMUmRg7BwF3EwL26ssmblU1H7eBeCP+/X+xMPYrcPJT
         cyfF99gE34WGCUEXH76sO5BuiC8qLYU/ZzxfOssM2roPebA0///WTbhmuU7J/bKP8ww8
         7jHayXbkwuNV+uKOETkd4Bt39QWHHOqZyJeUd2cNqKJ6bHBFEqMIy+qUptx1TZd91Jyh
         RKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wSdV+/zcx8UY8cUfVujyWK2lZLqqr7izfcTZ3/Ms6VU=;
        b=mzKpJ0A3JltVjbmLJ7NdMoRy0OynflInRkoPvwBiDdoUoCpfPm+lCHgxfCVQu9xUkW
         4Oxk3nas5AYSQD8pWsWw1m5moY5uHzIyZ4UFrUYhGWH5pufyM7xV4o1mchuYKyhbweQ7
         mCZAA8+6tPowVzfs/KLRFQ9eFBRhoM3EFDmPpCw9j0mGassl5Vh/QJkzdmCBasNYVy/V
         Q7h7beXYLErEJ9/lIHukOzovqsveSkRClYgr7JQRIx4QlvdJle68wZvljYFYsa16LA7r
         UX9j7cWjVKwzYxjGr+kHEWTC4S5oOA/VQlVJ89qrFP4Epc0GFiraL++Pw50oOCwDwVnP
         a2gA==
X-Gm-Message-State: AGRZ1gKciujYgVgNFRJ0W0uQnIThbCHB1oXLTU5ab5jbGu9n57lMd7cB
        +T+aFUgM3JkhGOidG7LFbBs=
X-Google-Smtp-Source: AJdET5cdnpdUK/IzseBvk724owqQifc9ccn/dTq3RvN3ilhxOzWfaPP4c8mo0vUAcwprAydmIKB9jQ==
X-Received: by 2002:a63:101d:: with SMTP id f29mr20392076pgl.38.1542636621915;
        Mon, 19 Nov 2018 06:10:21 -0800 (PST)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id q25sm44413708pgb.2.2018.11.19.06.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 06:10:21 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] timers: Make the lower-level timer function first call than higher-level
Date:   Mon, 19 Nov 2018 22:10:03 +0800
Message-Id: <20181119141003.6470-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The elements of the heads array are a linked list of timer events that
expire at the current time. And it can contain up to LVL_DEPTH levels
and the lower the level represents the smaller the time granularity.

Now the result is that the function, which will be called when the timer
expires, in the higher-level is called first than the lower-level function.
I think it might be better to call the lower-level timer function first
than the higher-level function. Because the lower-level has the smaller
granularity and delay has less impact on higher-level. So fix it.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/time/timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index fa49cd753dea..7c757b27aa58 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1674,12 +1674,13 @@ static inline void __run_timers(struct timer_base *base)
 	base->must_forward_clk = false;
 
 	while (time_after_eq(jiffies, base->clk)) {
+		int i;
 
 		levels = collect_expired_timers(base, heads);
 		base->clk++;
 
-		while (levels--)
-			expire_timers(base, heads + levels);
+		for (i = 0; i < levels; i++)
+			expire_timers(base, heads + i);
 	}
 	base->running_timer = NULL;
 	raw_spin_unlock_irq(&base->lock);
-- 
2.17.1

