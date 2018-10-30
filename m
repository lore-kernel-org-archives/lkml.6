Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28DEC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1032084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WclOJN/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1032084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeJ3WYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbeJ3WYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:24:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92AA720870;
        Tue, 30 Oct 2018 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906233;
        bh=BsHnIjYgXuoC11oxZT7ofy3A2mW7He8JOJXOh3b1QVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WclOJN/hS/NAZV6Q/i/j7mst8mgshkkMlWjymo6NVCr+zSPrLC7GbeDD8cmrGY9rY
         DGBeiPMsRveB1ifVd5r6YJZD80VHs3yvaNaoxvcNz45s8qrJfJWM7am/W3nEQiB//A
         IitswsAyRvdcNPHUvAsRa/C8hDuLieB2Zo6Fk6bw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 04/13] sparc: Fix single-pcr perf event counter management.
Date:   Tue, 30 Oct 2018 09:29:14 -0400
Message-Id: <20181030132923.218124-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132923.218124-1-sashal@kernel.org>
References: <20181030132923.218124-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit cfdc3170d214046b9509183fe9b9544dc644d40b ]

It is important to clear the hw->state value for non-stopped events
when they are added into the PMU.  Otherwise when the event is
scheduled out, we won't read the counter because HES_UPTODATE is still
set.  This breaks 'perf stat' and similar use cases, causing all the
events to show zero.

This worked for multi-pcr because we make explicit sparc_pmu_start()
calls in calculate_multiple_pcrs().  calculate_single_pcr() doesn't do
this because the idea there is to accumulate all of the counter
settings into the single pcr value.  So we have to add explicit
hw->state handling there.

Like x86, we use the PERF_HES_ARCH bit to track truly stopped events
so that we don't accidently start them on a reload.

Related to all of this, sparc_pmu_start() is missing a userpage update
so add it.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/perf_event.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 710f3278d448..71e7f77f6776 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -926,6 +926,8 @@ static void read_in_all_counters(struct cpu_hw_events *cpuc)
 			sparc_perf_event_update(cp, &cp->hw,
 						cpuc->current_idx[i]);
 			cpuc->current_idx[i] = PIC_NO_INDEX;
+			if (cp->hw.state & PERF_HES_STOPPED)
+				cp->hw.state |= PERF_HES_ARCH;
 		}
 	}
 }
@@ -958,10 +960,12 @@ static void calculate_single_pcr(struct cpu_hw_events *cpuc)
 
 		enc = perf_event_get_enc(cpuc->events[i]);
 		cpuc->pcr[0] &= ~mask_for_index(idx);
-		if (hwc->state & PERF_HES_STOPPED)
+		if (hwc->state & PERF_HES_ARCH) {
 			cpuc->pcr[0] |= nop_for_index(idx);
-		else
+		} else {
 			cpuc->pcr[0] |= event_encoding(enc, idx);
+			hwc->state = 0;
+		}
 	}
 out:
 	cpuc->pcr[0] |= cpuc->event[0]->hw.config_base;
@@ -987,6 +991,9 @@ static void calculate_multiple_pcrs(struct cpu_hw_events *cpuc)
 
 		cpuc->current_idx[i] = idx;
 
+		if (cp->hw.state & PERF_HES_ARCH)
+			continue;
+
 		sparc_pmu_start(cp, PERF_EF_RELOAD);
 	}
 out:
@@ -1078,6 +1085,8 @@ static void sparc_pmu_start(struct perf_event *event, int flags)
 	event->hw.state = 0;
 
 	sparc_pmu_enable_event(cpuc, &event->hw, idx);
+
+	perf_event_update_userpage(event);
 }
 
 static void sparc_pmu_stop(struct perf_event *event, int flags)
@@ -1370,9 +1379,9 @@ static int sparc_pmu_add(struct perf_event *event, int ef_flags)
 	cpuc->events[n0] = event->hw.event_base;
 	cpuc->current_idx[n0] = PIC_NO_INDEX;
 
-	event->hw.state = PERF_HES_UPTODATE;
+	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 	if (!(ef_flags & PERF_EF_START))
-		event->hw.state |= PERF_HES_STOPPED;
+		event->hw.state |= PERF_HES_ARCH;
 
 	/*
 	 * If group events scheduling transaction was started,
-- 
2.17.1

