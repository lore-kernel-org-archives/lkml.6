Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B8C2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfA1G3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:29:03 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:52678 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1G3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:29:02 -0500
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id x0S6RIY5095436
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 28 Jan 2019 14:27:18 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.93.106) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 28 Jan 2019 14:27:28
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Wang <vincent.wang@unisoc.com>,
        Quentin Perret <quentin.perret@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH V3] sched/cpufreq: calculate util / cap in advance in map_util_freq()
Date:   Mon, 28 Jan 2019 14:27:21 +0800
Message-ID: <1548656841-3440-1-git-send-email-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: SHCAS02.spreadtrum.com (10.0.1.202) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com x0S6RIY5095436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "vincent.wang" <vincent.wang@unisoc.com>

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
Changes from v2:
* Fix for 32bit architectures only.

Changes from V1:
* Rebased onto v5.0-rc1;
* Addressed comments from Quentin Perret.
---
 include/linux/sched/cpufreq.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index afa940cd50dc..22128a6c9c91 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -24,7 +24,15 @@ void cpufreq_remove_update_util_hook(int cpu);
 static inline unsigned long map_util_freq(unsigned long util,
 					unsigned long freq, unsigned long cap)
 {
+#ifdef CONFIG_64BIT
 	return (freq + (freq >> 2)) * util / cap;
+#else
+	/*
+	 * calculate util / cap in advance to prevent an overflow error
+	 * on 32bit architectures
+	 */
+	return ((freq + (freq >> 2)) * ((util << 10) / cap)) >> 10;
+#endif
 }
 #endif /* CONFIG_CPU_FREQ */
 
-- 
2.17.1

