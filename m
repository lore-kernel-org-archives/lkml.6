Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF79C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2481F2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2481F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeKEWrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:47:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbeKEWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:47:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5DRslZ348527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 05:27:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5DRs0S348524;
        Mon, 5 Nov 2018 05:27:54 -0800
Date:   Mon, 5 Nov 2018 05:27:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yangtao Li <tipbot@zytor.com>
Message-ID: <tip-7d9df98be66fec64349f9f1c9d3e896293fe7b45@git.kernel.org>
Cc:     tiny.windzz@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tiny.windzz@gmail.com
In-Reply-To: <20181104023104.2572-1-tiny.windzz@gmail.com>
References: <20181104023104.2572-1-tiny.windzz@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clockevents: Remove unnecessary unlikely()
Git-Commit-ID: 7d9df98be66fec64349f9f1c9d3e896293fe7b45
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7d9df98be66fec64349f9f1c9d3e896293fe7b45
Gitweb:     https://git.kernel.org/tip/7d9df98be66fec64349f9f1c9d3e896293fe7b45
Author:     Yangtao Li <tiny.windzz@gmail.com>
AuthorDate: Sat, 3 Nov 2018 22:31:04 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 14:22:54 +0100

clockevents: Remove unnecessary unlikely()

WARN_ON() and WARN_ON_ONCE() already contains an unlikely(), so it's not
necessary to use unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20181104023104.2572-1-tiny.windzz@gmail.com

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
 
