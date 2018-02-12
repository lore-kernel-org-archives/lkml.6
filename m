Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeBLWWW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:22:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:64295 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932724AbeBLWVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:21:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="29490598"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 2/5] perf/x86: Introduce read function for x86_pmu
Date: Mon, 12 Feb 2018 14:20:32 -0800
Message-Id: <1518474035-21006-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Auto-reload needs to be specially handled in event count read.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 2 ++
 arch/x86/events/perf_event.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5a3ccd1..00a6251 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1881,6 +1881,8 @@ early_initcall(init_hw_perf_events);
 
 static inline void x86_pmu_read(struct perf_event *event)
 {
+	if (x86_pmu.read)
+		return x86_pmu.read(event);
 	x86_perf_event_update(event);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8e4ea143..805400b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -519,6 +519,7 @@ struct x86_pmu {
 	void		(*disable)(struct perf_event *);
 	void		(*add)(struct perf_event *);
 	void		(*del)(struct perf_event *);
+	void		(*read)(struct perf_event *event);
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	unsigned	eventsel;
-- 
2.7.4
