Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522A720685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgtPRmyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522A720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeIXLvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 07:51:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39598 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIXLvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 07:51:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id q8-v6so8672869wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 22:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pldtDI51qYuZ3dKbItu0/9cAgULQDz05Gb+R9ZIrxLA=;
        b=MgtPRmyS+aIGPKb7GoFZoK8G5xwz0pvD2vaJKxBojGdLH0plz0RQKRV2QonYfbmzym
         ijxVaHRXCDDK6fmQ0bdIkueu6uyiNcjbG3KsjbD1fzn+Pg9ZJA3EyHL07x8pTnFITIb/
         PQcInAqXABZ0YpMCniLloh+vYNcVgf/+9pwHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pldtDI51qYuZ3dKbItu0/9cAgULQDz05Gb+R9ZIrxLA=;
        b=RmlJ3c3jFVcVt01RpXcrk70wb84Mm8DMOhu7vLvEW+kN78bPBoIOzNhiIsf1nMRtKt
         HJepX1HdvrL/G6AGZaP6cyUW7KL2uhX71ObmQnSTQjFG6S+TB0aSu3vT5VT8WBQRHxQ5
         41Y6qzF1gQBbkKB1wvGSp/RZWCcS/BK9INFN0/HnZThnnJfiet+CnV1x0ybeUTQIC93x
         vC8y0KcPiZ4kzOIhigp8PTkMk3PeI1IFRfr9KkArvdqo3eiW0Lo3IqMZRuJ0qTpaFTz5
         mHjIWOEtlA20Po8BHO7l8bOH0cIhrn0OqoaH135S9rqqmvAKYROtBHHlvyRPiMPg5hEq
         oFbg==
X-Gm-Message-State: APzg51DOsFf8Bj+2di05aYtS/67XEjr6JvOLnfZaZpFeYZgoO+fGSF//
        +emZAO/amOI4Bh8z9y/Y8zO5Ow==
X-Google-Smtp-Source: ANB0VdaBsusOMpWUXyL2tTie6bxKCGdZcZN3NrlduvICXFQss4F1rLK6weRtsRp5kfmR4fYM7oUsxA==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr6197080wmc.80.1537768245880;
        Sun, 23 Sep 2018 22:50:45 -0700 (PDT)
Received: from localhost.localdomain (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.gmail.com with ESMTPSA id w94-v6sm43886226wrc.38.2018.09.23.22.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Sep 2018 22:50:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     mingo@kernel.org, Tao Ren <taoren@fb.com>,
        Lei YU <mine260309@gmail.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 2/2] clocksource/drivers/fttmr010: Fix set_next_event handler
Date:   Mon, 24 Sep 2018 07:50:29 +0200
Message-Id: <1537768229-3241-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537768229-3241-1-git-send-email-daniel.lezcano@linaro.org>
References: <f2ad506a-e537-97cf-465a-593361116b10@linaro.org>
 <1537768229-3241-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <taoren@fb.com>

Currently, the aspeed MATCH1 register is updated to <current_count -
cycles> in set_next_event handler, with the assumption that COUNT
register value is preserved when the timer is disabled and it continues
decrementing after the timer is enabled. But the assumption is wrong:
RELOAD register is loaded into COUNT register when the aspeed timer is
enabled, which means the next event may be delayed because timer
interrupt won't be generated until <0xFFFFFFFF - current_count +
cycles>.

The problem can be fixed by updating RELOAD register to <cycles>, and
COUNT register will be re-loaded when the timer is enabled and interrupt
is generated when COUNT register overflows.

The test result on Facebook Backpack-CMM BMC hardware (AST2500) shows
the issue is fixed: without the patch, usleep(100) suspends the process
for several milliseconds (and sometimes even over 40 milliseconds);
after applying the fix, usleep(100) takes averagely 240 microseconds to
return under the same workload level.

Signed-off-by: Tao Ren <taoren@fb.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Lei YU <mine260309@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index c020038..cf93f64 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -130,13 +130,17 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	cr &= ~fttmr010->t1_enable_val;
 	writel(cr, fttmr010->base + TIMER_CR);
 
-	/* Setup the match register forward/backward in time */
-	cr = readl(fttmr010->base + TIMER1_COUNT);
-	if (fttmr010->count_down)
-		cr -= cycles;
-	else
-		cr += cycles;
-	writel(cr, fttmr010->base + TIMER1_MATCH1);
+	if (fttmr010->count_down) {
+		/*
+		 * ASPEED Timer Controller will load TIMER1_LOAD register
+		 * into TIMER1_COUNT register when the timer is re-enabled.
+		 */
+		writel(cycles, fttmr010->base + TIMER1_LOAD);
+	} else {
+		/* Setup the match register forward in time */
+		cr = readl(fttmr010->base + TIMER1_COUNT);
+		writel(cr + cycles, fttmr010->base + TIMER1_MATCH1);
+	}
 
 	/* Start */
 	cr = readl(fttmr010->base + TIMER_CR);
-- 
2.7.4

