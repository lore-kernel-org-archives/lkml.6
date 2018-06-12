Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6E592C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8BC20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8BC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeFLHvw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:51:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:47405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933579AbeFLHvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:51:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 00:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="56615824"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2018 00:51:47 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 2/6] perf: Disable IRQs in address filter sync path
Date:   Tue, 12 Jun 2018 10:51:13 +0300
Message-Id: <20180612075117.65420-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PMU callbacks are executed in hardirq context, the address filter
sync code needs to disable interrupts when taking its spinlock, to be
consistent with the rest of its users. This may happen if the PMU is
used in AUX sampling or the PMI is delivered as a regular interrupt.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0f5cd1b08dbd..e1fce335a42a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2601,16 +2601,17 @@ static int perf_event_stop(struct perf_event *event, int restart)
 void perf_event_addr_filters_sync(struct perf_event *event)
 {
 	struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
+	unsigned long flags;
 
 	if (!has_addr_filter(event))
 		return;
 
-	raw_spin_lock(&ifh->lock);
+	raw_spin_lock_irqsave(&ifh->lock, flags);
 	if (event->addr_filters_gen != event->hw.addr_filters_gen) {
 		event->pmu->addr_filters_sync(event);
 		event->hw.addr_filters_gen = event->addr_filters_gen;
 	}
-	raw_spin_unlock(&ifh->lock);
+	raw_spin_unlock_irqrestore(&ifh->lock, flags);
 }
 EXPORT_SYMBOL_GPL(perf_event_addr_filters_sync);
 
-- 
2.17.1

