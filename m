Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B54C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A497E20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A497E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbeHALsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:48:09 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55900 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389113AbeHALsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:48:09 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fkny6-00010M-AO; Wed, 01 Aug 2018 06:02:58 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, mingo@kernel.org, peterz@infradead.org,
        luto@kernel.org, x86@kernel.org, efault@gmx.de,
        dave.hansen@intel.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 02/11] smp: use __cpumask_set_cpu in on_each_cpu_cond
Date:   Wed,  1 Aug 2018 06:02:46 -0400
Message-Id: <20180801100255.4278-3-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801100255.4278-1-riel@surriel.com>
References: <20180801100255.4278-1-riel@surriel.com>
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

