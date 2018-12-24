Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534082173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLXHUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:20:24 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:64224 "EHLO
        SHSQR01.unisoc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbeLXHUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:20:24 -0500
X-Greylist: delayed 1055 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Dec 2018 02:20:23 EST
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id wBO71huB079215
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:01:43 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id wBO6wpej070222
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 24 Dec 2018 14:58:51 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.93.106) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 24 Dec 2018 14:59:54
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Wang <vincent.wang@unisoc.com>,
        <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] sched/cpufreq: calculate util / max firstly in get_next_freq()
Date:   Mon, 24 Dec 2018 14:59:07 +0800
Message-ID: <1545634747-22401-1-git-send-email-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: SHCAS02.spreadtrum.com (10.0.1.202) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com wBO6wpej070222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Wang <vincent.wang@unisoc.com>

When a task that is in_iowait state is enqueued, cpufreq_update_util() will
be invoked with SCHED_CPUFREQ_IOWAIT flag. In this case,the value of util
and max, which are parameters used in get_next_freq(), will be cpu
frequency, instead of cpu util or capactiy.

For some 32bit architectures, the size of unsigned long is 32. When
calculating freq, there may be an overflow error in this expression:

freq = (freq + (freq >> 2)) * util / max;

This patch will fix this overflow risk by calulating util / max firstly,
whether they be frequency or util.

Signed-off-by: Vincent Wang <vincent.wang@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 kernel/sched/cpufreq_schedutil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3fffad3..7c372db1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -166,8 +166,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int ratio = util * 100 / max;
 
-	freq = (freq + (freq >> 2)) * util / max;
+	freq = (freq + (freq >> 2)) * ratio / 100;
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
-- 
2.7.4

