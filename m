Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2449DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE33D20644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE33D20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJIXCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:02:10 -0400
Received: from mail115-100.sinamail.sina.com.cn ([218.30.115.100]:55122 "HELO
        mail115-100.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726468AbeJIXCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:02:09 -0400
Received: from unknown (HELO localhost.localdomain.localdomain)([171.223.32.216])
        by sina.com with ESMTP
        id 5BBCCCAA00000BD5; Tue, 9 Oct 2018 23:43:56 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 269695132116
From:   Peng Hao <penghao122@sina.com.cn>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peng.hao2@zte.com.cn
Subject: [PATCH] tick/sched : remove redundancy cpu_online check
Date:   Tue,  9 Oct 2018 11:43:35 -0400
Message-Id: <1539099815-2943-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

in can_stop_idle_tick cpu_online() was called earlier and if cpu
offline it will return. so it don't need to call cpu_online()
again.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5b33e2f..69e673b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -885,7 +885,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (need_resched())
 		return false;
 
-	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
+	if (unlikely(local_softirq_pending())) {
 		static int ratelimit;
 
 		if (ratelimit < 10 &&
-- 
1.8.3.1


