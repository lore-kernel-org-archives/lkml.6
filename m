Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E4FC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFBB2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzVxiRPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFBB2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeKDLuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:50:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42274 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeKDLuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:50:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so2761272plo.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 19:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1m8OIwyzt2+9gVvsqamsb6tKmgHyQuFV5GCG7ids4Zc=;
        b=FzVxiRPvGn1ZGXjcxsGQoinPtWssKUfbNB1wOtbMPlbmCQBdcNMuyVv5h0V/uY1J9D
         6X/pqCWUIkmbuhbaP/iBq8iwK5JBHQTcIZFcrP8qpVRY9crKO7yH3xmQ7OdQ8u/+10Wo
         mwbXyULruuUXlWJRhK4AneQLPROX55APuSwYEEd+Z7LbbOUpTbECRKaQ2YRzewGW+w4i
         7hfKc1Xs7tY7DBvV3/+bMhFwkAPOeVzOnNC/jOVleCCScCh0r8thwrS/8pvYolR0GXTG
         2t72sW96vvAWC2T6n4d826nvy6C/edVyBzeSSYT3I0HpBGDbyZdAI3f+cWLnIS9ZFwD1
         2LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1m8OIwyzt2+9gVvsqamsb6tKmgHyQuFV5GCG7ids4Zc=;
        b=cBEVe2npL3rg3lsrXg//dPym/84VRBR/vCSWH5SeXzmJ84JIkT69IcTfzg5hIHP6Nv
         ihe+rpY0oNSpwMXwmz1Uv7TqU2oMT+1kgx+HaVodDCFGbBYaTFR3/6rx6B0QOtruylww
         AePHOBLAJ/dCGeYk1jRDxfmzt6GsVm47ApP2MCRFBOR6X6NiHuHIzQdLbPDeKc3h31bM
         EhXOqrDnEYG2lyfLuHIyNdtsU/DIq7Hlw8Y+50Xq364pxzTvTl/X2bwfU6iaN8TgCFHt
         CiUvP5aa0t8c3DPgdHHm28t8ZJ94FniS1LbQoWv/hVDsZE3mim8ksc2Cxqs/kUr98pun
         Ifrw==
X-Gm-Message-State: AGRZ1gL5lz27o761ZuCAVXkXejyK4biIC9ru4eGdgxYB9pPxTZH3g4q5
        b11lTLIBUTwsdl1i7+z2C8U=
X-Google-Smtp-Source: AJdET5chRbjNnHx80Jr4ST848mWTsTndpkPIl5rrhDmg4Tl+hbtbGcOKp1IsyG4Wahccy/qaacBxOQ==
X-Received: by 2002:a17:902:6b0a:: with SMTP id o10-v6mr17247324plk.208.1541298668737;
        Sat, 03 Nov 2018 19:31:08 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 124-v6sm51831189pfb.132.2018.11.03.19.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 19:31:08 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clockevents: remove unnecessary unlikely()
Date:   Sat,  3 Nov 2018 22:31:04 -0400
Message-Id: <20181104023104.2572-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() and WARN_ON_ONCE() already contains an unlikely(), so it's not
necessary to use unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/time/clockevents.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 8c0e4092f661..af58898d9ebf 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -39,10 +39,8 @@ static u64 cev_delta2ns(unsigned long latch, struct clock_event_device *evt,
 	u64 clc = (u64) latch << evt->shift;
 	u64 rnd;
 
-	if (unlikely(!evt->mult)) {
+	if (WARN_ON(!evt->mult))
 		evt->mult = 1;
-		WARN_ON(1);
-	}
 	rnd = (u64) evt->mult - 1;
 
 	/*
@@ -164,10 +162,8 @@ void clockevents_switch_state(struct clock_event_device *dev,
 		 * on it, so fix it up and emit a warning:
 		 */
 		if (clockevent_state_oneshot(dev)) {
-			if (unlikely(!dev->mult)) {
+			if (WARN_ON(!dev->mult))
 				dev->mult = 1;
-				WARN_ON(1);
-			}
 		}
 	}
 }
@@ -315,10 +311,8 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
 	int64_t delta;
 	int rc;
 
-	if (unlikely(expires < 0)) {
-		WARN_ON_ONCE(1);
+	if (WARN_ON_ONCE(expires < 0))
 		return -ETIME;
-	}
 
 	dev->next_event = expires;
 
-- 
2.17.0

