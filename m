Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E0FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99ED208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99ED208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeIZKKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:10:05 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50014 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeIZKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 06:09:57 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g50yN-0006sG-SY; Tue, 25 Sep 2018 23:58:47 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, will.deacon@arm.com,
        songliubraving@fb.com, mingo@kernel.org, luto@kernel.org,
        hpa@zytor.com, npiggin@gmail.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 3/7] smp: use __cpumask_set_cpu in on_each_cpu_cond
Date:   Tue, 25 Sep 2018 23:58:40 -0400
Message-Id: <20180926035844.1420-4-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926035844.1420-1-riel@surriel.com>
References: <20180926035844.1420-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in on_each_cpu_cond sets CPUs in a locally allocated bitmask,
which should never be used by other CPUs simultaneously. There is no
need to use locked memory accesses to set the bits in this bitmap.

Switch to __cpumask_set_cpu.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d86eec5f51c1..a7d4f9f50a49 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -682,7 +682,7 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 		preempt_disable();
 		for_each_online_cpu(cpu)
 			if (cond_func(cpu, info))
-				cpumask_set_cpu(cpu, cpus);
+				__cpumask_set_cpu(cpu, cpus);
 		on_each_cpu_mask(cpus, func, info, wait);
 		preempt_enable();
 		free_cpumask_var(cpus);
-- 
2.17.1

