Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF6CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F18223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F18223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHJFDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:03:24 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26448 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725198AbeHJFDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:03:24 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43311730"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Aug 2018 10:35:38 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id EBA3C4B6ADFF;
        Fri, 10 Aug 2018 10:35:37 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Fri, 10 Aug 2018 10:35:49 +0800
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] sched/core: Fix compiling warring in smp=n case
Date:   Fri, 10 Aug 2018 10:35:23 +0800
Message-ID: <20180810023523.23923-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: EBA3C4B6ADFF.A0D4E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling kernel with SMP disabled, the build warns with:

kernel/sched/core.c: In function ‘update_rq_clock_task’:
kernel/sched/core.c:139:17: warning: unused variable ‘irq_delta’ [-Wunused-variable]
  s64 steal = 0, irq_delta = 0;

Fix this by revert the HAVE_SCHED_AVG_IRQ to

  defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)

Fixes: 2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c45de46fdf10..ef954d96c80c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -177,7 +177,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->clock_task += delta;
 
-#ifdef HAVE_SCHED_AVG_IRQ
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
-- 
2.14.3



