Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A55C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD2221508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7mn9CqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD2221508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbeKLIhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390929AbeKLIX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:28 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D4F0223C6;
        Sun, 11 Nov 2018 22:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975610;
        bh=KHQZqv7p8K82PUXgIoisfYEenK5idfwULdXPktaspmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7mn9CqAObmBfPO0H1+2eM8GeK4UB21Gp+KydWIWyT69u1Y8zzf962C7txyjnHoBd
         Ls96uW5/LR5yFDul//FmCL2doBchdc2ma0VJEFd0IkyBwYjVcv90Ofw4sniP3CgWZM
         kELxc8WU56PHU+/OF1b/8gDk0RfofeVkUqSOUaII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 019/141] sparc: Fix single-pcr perf event counter management.
Date:   Sun, 11 Nov 2018 14:24:38 -0800
Message-Id: <20181111221630.391701397@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/perf_event.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -926,6 +926,8 @@ static void read_in_all_counters(struct
 			sparc_perf_event_update(cp, &cp->hw,
 						cpuc->current_idx[i]);
 			cpuc->current_idx[i] = PIC_NO_INDEX;
+			if (cp->hw.state & PERF_HES_STOPPED)
+				cp->hw.state |= PERF_HES_ARCH;
 		}
 	}
 }
@@ -958,10 +960,12 @@ static void calculate_single_pcr(struct
 
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
@@ -987,6 +991,9 @@ static void calculate_multiple_pcrs(stru
 
 		cpuc->current_idx[i] = idx;
 
+		if (cp->hw.state & PERF_HES_ARCH)
+			continue;
+
 		sparc_pmu_start(cp, PERF_EF_RELOAD);
 	}
 out:
@@ -1078,6 +1085,8 @@ static void sparc_pmu_start(struct perf_
 	event->hw.state = 0;
 
 	sparc_pmu_enable_event(cpuc, &event->hw, idx);
+
+	perf_event_update_userpage(event);
 }
 
 static void sparc_pmu_stop(struct perf_event *event, int flags)
@@ -1370,9 +1379,9 @@ static int sparc_pmu_add(struct perf_eve
 	cpuc->events[n0] = event->hw.event_base;
 	cpuc->current_idx[n0] = PIC_NO_INDEX;
 
-	event->hw.state = PERF_HES_UPTODATE;
+	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 	if (!(ef_flags & PERF_EF_START))
-		event->hw.state |= PERF_HES_STOPPED;
+		event->hw.state |= PERF_HES_ARCH;
 
 	/*
 	 * If group events scheduling transaction was started,


