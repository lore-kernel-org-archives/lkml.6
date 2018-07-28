Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12D3ECDFBD
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7035F20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7035F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeG1XWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:22:22 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44204 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeG1XWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:22:21 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjXA0-0000QZ-KV; Sat, 28 Jul 2018 17:54:00 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, luto@kernel.org,
        x86@kernel.org, vkuznets@redhat.com, mingo@kernel.org,
        efault@gmx.de, dave.hansen@intel.com, will.daecon@arm.com,
        catalin.marinas@arm.com, benh@kernel.crashing.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 02/10] smp: use __cpumask_set_cpu in on_each_cpu_cond
Date:   Sat, 28 Jul 2018 17:53:49 -0400
Message-Id: <20180728215357.3249-3-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180728215357.3249-1-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com>
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
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 084c8b3a2681..2dbc842dd385 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -680,7 +680,7 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 		preempt_disable();
 		for_each_online_cpu(cpu)
 			if (cond_func(cpu, info))
-				cpumask_set_cpu(cpu, cpus);
+				__cpumask_set_cpu(cpu, cpus);
 		on_each_cpu_mask(cpus, func, info, wait);
 		preempt_enable();
 		free_cpumask_var(cpus);
-- 
2.14.4

