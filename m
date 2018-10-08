Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBBAC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15F42152C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ91r9W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15F42152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeJHWjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbeJHWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C443421531;
        Mon,  8 Oct 2018 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012415;
        bh=Jz4EtWkgXYWFg6Ta5vfUkBQoZ9Sq7YtifsR3KF199d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJ91r9W/k400uDWGyfUrark62wtiezgqXSKIePc8yPyn/nShOO4bnpZFt90++qx45
         FK7fViEXEqj3NYVAqIadVoAD4BVsl8vg71mhgBNoNXc7vBf3yUS5I6lY1AP+d88MYy
         74bX3HzttidQ9dQVpZxWHh51z2/TiXNShhUCp//g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tao Ren <taoren@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 27/32] clocksource/drivers/fttmr010: Fix set_next_event handler
Date:   Mon,  8 Oct 2018 11:26:24 -0400
Message-Id: <20181008152629.70812-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <taoren@fb.com>

[ Upstream commit 4451d3f59f2a6f95e5d205c2d04ea072955d080d ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clocksource/timer-fttmr010.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index cdf23b628688..cdfe1c82f3f0 100644
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
2.17.1

