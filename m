Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF7BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685C32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZMY+/Nhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685C32146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbeITDxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:53:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40642 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732113AbeITDxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:53:47 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8JM8Chs000743
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:13:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=wTgZ9auVCQe3Ddwy+sDwXPpbQxHOertCx4S6lW2HJO4=;
 b=ZMY+/NhjUJqInzc3hhX1TSYNowlSC8GMTuYUfeA+NXLe5cVhBRn4xBORJ5/Gh6wKXdb7
 lyEmBKsDodD+8bEmEUmaeORItu9Uh0mdO4PFugab+3WFrtL7TVM89ydeIzD3Tx2P+ME3
 /vhpvwPzD+31SoebGWHC/ljwdoHdpbZZcqc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2mkvck0kd0-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:13:47 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.18) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 19 Sep
 2018 15:13:45 -0700
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176) id
 B94A55E465FE; Wed, 19 Sep 2018 15:13:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     Tao Ren <taoren@fb.com>, <openbmc@lists.ozlabs.org>, <cov@fb.com>,
        <tfang@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Date:   Wed, 19 Sep 2018 15:13:31 -0700
Message-ID: <20180919221331.2511558-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/clocksource/timer-fttmr010.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index c020038ebfab..cf93f6419b51 100644
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

