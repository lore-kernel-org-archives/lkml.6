Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5FEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6B2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA6B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJJRNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:13:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJRNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:13:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9A9pqX71424069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Oct 2018 02:51:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9A9pqI11424066;
        Wed, 10 Oct 2018 02:51:52 -0700
Date:   Wed, 10 Oct 2018 02:51:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peng Hao <tipbot@zytor.com>
Message-ID: <tip-d59e0ba19481c0046d2ea2bd0e5344eeaf45aace@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peng.hao2@zte.com.cn, hpa@zytor.com
Reply-To: peng.hao2@zte.com.cn, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <1539099815-2943-1-git-send-email-penghao122@sina.com.cn>
References: <1539099815-2943-1-git-send-email-penghao122@sina.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tick/sched : Remove redundant cpu_online() check
Git-Commit-ID: d59e0ba19481c0046d2ea2bd0e5344eeaf45aace
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

Commit-ID:  d59e0ba19481c0046d2ea2bd0e5344eeaf45aace
Gitweb:     https://git.kernel.org/tip/d59e0ba19481c0046d2ea2bd0e5344eeaf45aace
Author:     Peng Hao <peng.hao2@zte.com.cn>
AuthorDate: Tue, 9 Oct 2018 11:43:35 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Oct 2018 11:47:20 +0200

tick/sched : Remove redundant cpu_online() check

can_stop_idle_tick() checks cpu_online() twice. The first check leaves the
function when the CPU is not online, so the second check it
redundant. Remove it.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fweisbec@gmail.com
Link: https://lkml.kernel.org/r/1539099815-2943-1-git-send-email-penghao122@sina.com.cn
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5b33e2f5c0ed..69e673b88474 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -885,7 +885,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (need_resched())
 		return false;
 
-	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
+	if (unlikely(local_softirq_pending())) {
 		static int ratelimit;
 
 		if (ratelimit < 10 &&
