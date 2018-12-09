Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B9C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40C320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40C320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeLIWEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35790 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726639AbeLIVza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:30 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72t-0002ij-Qo; Sun, 09 Dec 2018 21:55:28 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003do-94; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jiri Olsa" <jolsa@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Vince Weaver" <vincent.weaver@maine.edu>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.453880886@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 288/328] perf/core: Fix perf_pmu_unregister() locking
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit a9f9772114c8b07ae75bcb3654bd017461248095 upstream.

When we unregister a PMU, we fail to serialize the @pmu_idr properly.
Fix that by doing the entire thing under pmu_lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 2e80a82a49c4 ("perf: Dynamic pmu types")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - Also remove "out" label in free_pmu_context()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6705,20 +6705,17 @@ static void free_pmu_context(struct pmu
 {
 	struct pmu *i;
 
-	mutex_lock(&pmus_lock);
 	/*
 	 * Like a real lame refcount.
 	 */
 	list_for_each_entry(i, &pmus, entry) {
 		if (i->pmu_cpu_context == pmu->pmu_cpu_context) {
 			update_pmu_context(i, pmu);
-			goto out;
+			return;
 		}
 	}
 
 	free_percpu(pmu->pmu_cpu_context);
-out:
-	mutex_unlock(&pmus_lock);
 }
 static struct idr pmu_idr;
 
@@ -6930,12 +6927,8 @@ EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 void perf_pmu_unregister(struct pmu *pmu)
 {
-	int remove_device;
-
 	mutex_lock(&pmus_lock);
-	remove_device = pmu_bus_running;
 	list_del_rcu(&pmu->entry);
-	mutex_unlock(&pmus_lock);
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
@@ -6947,11 +6940,12 @@ void perf_pmu_unregister(struct pmu *pmu
 	free_percpu(pmu->pmu_disable_count);
 	if (pmu->type >= PERF_TYPE_MAX)
 		idr_remove(&pmu_idr, pmu->type);
-	if (remove_device) {
+	if (pmu_bus_running) {
 		device_del(pmu->dev);
 		put_device(pmu->dev);
 	}
 	free_pmu_context(pmu);
+	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 

