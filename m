Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50870C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148FE20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWH2flBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148FE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJ3WZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbeJ3WZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:25:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E02320827;
        Tue, 30 Oct 2018 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906342;
        bh=a9OgLvo3NGZJ2I6wv+g80VS1qRIURF8LbZ4qPxWH1e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWH2flBEceF2eoJq/neSwvx23UCET40SUFSklb4LYEVaxzOSGeBeWzzNyUlVxI08V
         73bhNkRJYyy3vBYKobYKmOyIMnxJbBzIFmiq86mztD0gl44kFgMEa0QyjqkR/qJCyS
         jmB3SQVQknREXaKPAmR5DbyxeMeNd73X3hMEy+ok=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 2/6] sparc: Throttle perf events properly.
Date:   Tue, 30 Oct 2018 09:30:53 -0400
Message-Id: <20181030133057.218186-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030133057.218186-1-sashal@kernel.org>
References: <20181030133057.218186-1-sashal@kernel.org>
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
index a5d0c2f08110..dd02219bcc35 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -23,6 +23,7 @@
 #include <asm/cpudata.h>
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
+#include <linux/sched/clock.h>
 #include <asm/nmi.h>
 #include <asm/pcr.h>
 #include <asm/cacheflush.h>
@@ -1611,6 +1612,8 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc;
 	struct pt_regs *regs;
+	u64 finish_clock;
+	u64 start_clock;
 	int i;
 
 	if (!atomic_read(&active_events))
@@ -1624,6 +1627,8 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 		return NOTIFY_DONE;
 	}
 
+	start_clock = sched_clock();
+
 	regs = args->regs;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1662,6 +1667,10 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
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

