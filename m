Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A008C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198182084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F78USvTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198182084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbeKCDy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:26 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E52820837;
        Fri,  2 Nov 2018 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184372;
        bh=GvBHhN3x8/oJOl7rLoRgnhtyLju4x2bkvFV5DxRejGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F78USvTbk613ze4Rc05C1GfZPV8s4pmGrRjizYDNh8Fku5+ayqsLJfNij10qz8oxq
         eW0VJz/q4S6xuPclqaXInq70VE3tCo98ofNBoSUbSdk1Pf6s/ki9mz1YlIodtek/mn
         xgW4GGYrc4HL1+nlCO5fI3SCJjD2Mzc+0DT7iJF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 147/150] sparc: Fix single-pcr perf event counter management.
Date:   Fri,  2 Nov 2018 19:35:09 +0100
Message-Id: <20181102182912.632649499@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/perf_event.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -927,6 +927,8 @@ static void read_in_all_counters(struct
 			sparc_perf_event_update(cp, &cp->hw,
 						cpuc->current_idx[i]);
 			cpuc->current_idx[i] = PIC_NO_INDEX;
+			if (cp->hw.state & PERF_HES_STOPPED)
+				cp->hw.state |= PERF_HES_ARCH;
 		}
 	}
 }
@@ -959,10 +961,12 @@ static void calculate_single_pcr(struct
 
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
@@ -988,6 +992,9 @@ static void calculate_multiple_pcrs(stru
 
 		cpuc->current_idx[i] = idx;
 
+		if (cp->hw.state & PERF_HES_ARCH)
+			continue;
+
 		sparc_pmu_start(cp, PERF_EF_RELOAD);
 	}
 out:
@@ -1079,6 +1086,8 @@ static void sparc_pmu_start(struct perf_
 	event->hw.state = 0;
 
 	sparc_pmu_enable_event(cpuc, &event->hw, idx);
+
+	perf_event_update_userpage(event);
 }
 
 static void sparc_pmu_stop(struct perf_event *event, int flags)
@@ -1371,9 +1380,9 @@ static int sparc_pmu_add(struct perf_eve
 	cpuc->events[n0] = event->hw.event_base;
 	cpuc->current_idx[n0] = PIC_NO_INDEX;
 
-	event->hw.state = PERF_HES_UPTODATE;
+	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 	if (!(ef_flags & PERF_EF_START))
-		event->hw.state |= PERF_HES_STOPPED;
+		event->hw.state |= PERF_HES_ARCH;
 
 	/*
 	 * If group events scheduling transaction was started,


