Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F14DEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB91420693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB91420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933592AbeFLHvt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:51:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:47405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933242AbeFLHvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:51:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 00:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="56615820"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2018 00:51:45 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 1/6] perf: Disable PMU around address filter adjustment
Date:   Tue, 12 Jun 2018 10:51:12 +0300
Message-Id: <20180612075117.65420-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the PMU is used for AUX data sampling, the hardware event that triggers
it may come in during a critical section of address filters adjustment (if
it's delivered as NMI) and in turn call the address filter sync code,
causing a spinlock recursion.

To prevent this, disable the PMU around these critical sections, so that
AUX sampling won't take place there.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4e1a1bf8d867..0f5cd1b08dbd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6299,6 +6299,12 @@ static void perf_event_addr_filters_exec(struct perf_event *event, void *data)
 	if (!has_addr_filter(event))
 		return;
 
+	/*
+	 * if sampling kicks in in the critical section,
+	 * we risk spinlock recursion on the ifh::lock
+	 */
+	perf_pmu_disable(event->pmu);
+
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
 		if (filter->inode) {
@@ -6313,6 +6319,8 @@ static void perf_event_addr_filters_exec(struct perf_event *event, void *data)
 		event->addr_filters_gen++;
 	raw_spin_unlock_irqrestore(&ifh->lock, flags);
 
+	perf_pmu_enable(event->pmu);
+
 	if (restart)
 		perf_event_stop(event, 1);
 }
@@ -6993,6 +7001,8 @@ static void __perf_addr_filters_adjust(struct perf_event *event, void *data)
 	if (!file)
 		return;
 
+	perf_pmu_disable(event->pmu);
+
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
 		if (perf_addr_filter_match(filter, file, off,
@@ -7008,6 +7018,8 @@ static void __perf_addr_filters_adjust(struct perf_event *event, void *data)
 		event->addr_filters_gen++;
 	raw_spin_unlock_irqrestore(&ifh->lock, flags);
 
+	perf_pmu_enable(event->pmu);
+
 	if (restart)
 		perf_event_stop(event, 1);
 }
@@ -8261,6 +8273,8 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 
 	down_read(&mm->mmap_sem);
 
+	perf_pmu_disable(event->pmu);
+
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
 		event->addr_filters_offs[count] = 0;
@@ -8279,6 +8293,8 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 	event->addr_filters_gen++;
 	raw_spin_unlock_irqrestore(&ifh->lock, flags);
 
+	perf_pmu_enable(event->pmu);
+
 	up_read(&mm->mmap_sem);
 
 	mmput(mm);
-- 
2.17.1

