Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB5CC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A22081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3A22081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeLIWEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35796 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbeLIVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:31 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72t-0002ii-QK; Sun, 09 Dec 2018 21:55:28 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003di-7O; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jiri Olsa" <jolsa@redhat.com>,
        "CAI Qian" <caiqian@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rob Herring" <robh@kernel.org>, "Ingo Molnar" <mingo@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Kan Liang" <kan.liang@intel.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Olsa" <jolsa@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.479312128@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 287/328] perf/core: Protect PMU device removal with a
 'pmu_bus_running' check, to fix CONFIG_DEBUG_TEST_DRIVER_REMOVE=y kernel
 panic
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

From: Jiri Olsa <jolsa@redhat.com>

commit 0933840acf7b65d6d30a5b6089d882afea57aca3 upstream.

CAI Qian reported a crash in the PMU uncore device removal code,
enabled by the CONFIG_DEBUG_TEST_DRIVER_REMOVE=y option:

  https://marc.info/?l=linux-kernel&m=147688837328451

The reason for the crash is that perf_pmu_unregister() tries to remove
a PMU device which is not added at this point. We add PMU devices
only after pmu_bus is registered, which happens in the
perf_event_sysfs_init() call and sets the 'pmu_bus_running' flag.

The fix is to get the 'pmu_bus_running' flag state at the point
the PMU is taken out of the PMU list and remove the device
later only if it's set.

Reported-by: CAI Qian <caiqian@redhat.com>
Tested-by: CAI Qian <caiqian@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20161020111011.GA13361@krava
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: no address filter attributes to clean up]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6930,7 +6930,10 @@ EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 void perf_pmu_unregister(struct pmu *pmu)
 {
+	int remove_device;
+
 	mutex_lock(&pmus_lock);
+	remove_device = pmu_bus_running;
 	list_del_rcu(&pmu->entry);
 	mutex_unlock(&pmus_lock);
 
@@ -6944,8 +6947,10 @@ void perf_pmu_unregister(struct pmu *pmu
 	free_percpu(pmu->pmu_disable_count);
 	if (pmu->type >= PERF_TYPE_MAX)
 		idr_remove(&pmu_idr, pmu->type);
-	device_del(pmu->dev);
-	put_device(pmu->dev);
+	if (remove_device) {
+		device_del(pmu->dev);
+		put_device(pmu->dev);
+	}
 	free_pmu_context(pmu);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);

