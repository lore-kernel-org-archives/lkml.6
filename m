Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0DEC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718DD20838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjCHYy+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718DD20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeJ3WVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbeJ3WVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D012084A;
        Tue, 30 Oct 2018 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906059;
        bh=VlOjR0Ch568BE8f68o9wUsUAfvEEdrGIJFgP+puYs5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjCHYy+3lkgOsB/aR13wWpPLbui5bhiranEjG+JWX26VG5QcEuHu1zZw6VDFAPVEm
         ttFmF91IwBMyu9/CD86AhRItp3WShIm6E7gqwpEMVfwAkUUJNLeF20B0j3p6GoK5Jm
         /He1YHO9cZ6MKB86t6e2hwyaFQWfIIR68m4ZuGqY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 13/33] sparc: Throttle perf events properly.
Date:   Tue, 30 Oct 2018 09:26:37 -0400
Message-Id: <20181030132657.217970-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 455adb3174d2c8518cef1a61140c211f6ac224d2 ]

Like x86 and arm, call perf_sample_event_took() in perf event
NMI interrupt handler.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/perf_event.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index a4cc26bd89a2..67b3e6b3ce5d 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -24,6 +24,7 @@
 #include <asm/cpudata.h>
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
+#include <linux/sched/clock.h>
 #include <asm/nmi.h>
 #include <asm/pcr.h>
 #include <asm/cacheflush.h>
@@ -1612,6 +1613,8 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc;
 	struct pt_regs *regs;
+	u64 finish_clock;
+	u64 start_clock;
 	int i;
 
 	if (!atomic_read(&active_events))
@@ -1625,6 +1628,8 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 		return NOTIFY_DONE;
 	}
 
+	start_clock = sched_clock();
+
 	regs = args->regs;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1663,6 +1668,10 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 			sparc_pmu_stop(event, 0);
 	}
 
+	finish_clock = sched_clock();
+
+	perf_sample_event_took(finish_clock - start_clock);
+
 	return NOTIFY_STOP;
 }
 
-- 
2.17.1

