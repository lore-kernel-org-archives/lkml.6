Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999DFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB23214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAJDEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:04:42 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:49599 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfAJDEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:04:42 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x0A31w5X043523
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 10 Jan 2019 11:02:00 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.93.106) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 10 Jan 2019 11:02:09
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Wang <vincent.wang@unisoc.com>,
        Quentin Perret <quentin.perret@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH V2] sched/cpufreq: calculate util / cap in advance in map_util_freq()
Date:   Thu, 10 Jan 2019 11:02:05 +0800
Message-ID: <1547089325-15691-1-git-send-email-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: SHCAS02.spreadtrum.com (10.0.1.202) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x0A31w5X043523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Wang <vincent.wang@unisoc.com>

When a task that is in_iowait state is enqueued, cpufreq_update_util()
will be invoked with SCHED_CPUFREQ_IOWAIT flag. In this case,the value
of util and cap, which are parameters used in map_util_freq(), will be
cpu frequency, instead of cpu util and capactiy.

For some 32bit architectures, the size of unsigned long is 32. When
calculating freq, there may be an overflow error in this expression:

freq = (freq + (freq >> 2)) * util / cap;

This patch will fix this overflow risk by calulating util / cap in advance,
whether they be frequency or util.

Signed-off-by: Vincent Wang <vincent.wang@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
Changes from V1:
* Rebased onto v5.0-rc1;
* Addressed comments from Quentin Perret.
---
 include/linux/sched/cpufreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index afa940c..3f93c32 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -24,7 +24,7 @@ void cpufreq_remove_update_util_hook(int cpu);
 static inline unsigned long map_util_freq(unsigned long util,
 					unsigned long freq, unsigned long cap)
 {
-	return (freq + (freq >> 2)) * util / cap;
+	return ((freq + (freq >> 2)) * ((util << 10) / cap)) >> 10;
 }
 #endif /* CONFIG_CPU_FREQ */
 
-- 
2.7.4

