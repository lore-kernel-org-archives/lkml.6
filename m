Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB70C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC5621527
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuL3xX6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC5621527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406435AbeKTD2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405461AbeKTD2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:28:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F0902148E;
        Mon, 19 Nov 2018 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647042;
        bh=FWjil1LHvScI91d0vTZaRjsQWLcR00VDnI6IHZOD/h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuL3xX6kXMetCRmgS6cZt0aadBzhXWr06tCQbA+9HGTjuyz1QRB/HjChCMulrJEZC
         vSnzoIlt8G5ZlZPbQ6k8UGHYZH+qaiKpBgUu9QexRTONTudAHWm9/j641sBXgBY6Np
         UScDb8YDYb1Ns4j/KUK0AOTLOrpf6N5LJpdT8QKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 06/90] sparc: Fix single-pcr perf event counter management.
Date:   Mon, 19 Nov 2018 17:28:48 +0100
Message-Id: <20181119162621.746494880@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -919,6 +919,8 @@ static void read_in_all_counters(struct
 			sparc_perf_event_update(cp, &cp->hw,
 						cpuc->current_idx[i]);
 			cpuc->current_idx[i] = PIC_NO_INDEX;
+			if (cp->hw.state & PERF_HES_STOPPED)
+				cp->hw.state |= PERF_HES_ARCH;
 		}
 	}
 }
@@ -951,10 +953,12 @@ static void calculate_single_pcr(struct
 
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
@@ -980,6 +984,9 @@ static void calculate_multiple_pcrs(stru
 
 		cpuc->current_idx[i] = idx;
 
+		if (cp->hw.state & PERF_HES_ARCH)
+			continue;
+
 		sparc_pmu_start(cp, PERF_EF_RELOAD);
 	}
 out:
@@ -1071,6 +1078,8 @@ static void sparc_pmu_start(struct perf_
 	event->hw.state = 0;
 
 	sparc_pmu_enable_event(cpuc, &event->hw, idx);
+
+	perf_event_update_userpage(event);
 }
 
 static void sparc_pmu_stop(struct perf_event *event, int flags)
@@ -1363,9 +1372,9 @@ static int sparc_pmu_add(struct perf_eve
 	cpuc->events[n0] = event->hw.event_base;
 	cpuc->current_idx[n0] = PIC_NO_INDEX;
 
-	event->hw.state = PERF_HES_UPTODATE;
+	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 	if (!(ef_flags & PERF_EF_START))
-		event->hw.state |= PERF_HES_STOPPED;
+		event->hw.state |= PERF_HES_ARCH;
 
 	/*
 	 * If group events scheduling transaction was started,


