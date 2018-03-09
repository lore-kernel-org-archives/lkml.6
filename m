Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCIJJg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:09:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeCIJJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:09:34 -0500
Date: Fri, 9 Mar 2018 01:09:12 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-bcfbe5c41d630ce6b74da45134cea484248b515a@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org,
        kan.liang@linux.intel.com, eranian@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, vincent.weaver@maine.edu
Reply-To: peterz@infradead.org, eranian@google.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, torvalds@linux-foundation.org
In-Reply-To: <1518474035-21006-3-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-3-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Introduce a ->read() callback in 'struct
 x86_pmu'
Git-Commit-ID: bcfbe5c41d630ce6b74da45134cea484248b515a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bcfbe5c41d630ce6b74da45134cea484248b515a
Gitweb:     https://git.kernel.org/tip/bcfbe5c41d630ce6b74da45134cea484248b515a
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 12 Feb 2018 14:20:32 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:22:20 +0100

perf/x86: Introduce a ->read() callback in 'struct x86_pmu'

Auto-reload needs to be specially handled when reading event counts.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Link: http://lkml.kernel.org/r/1518474035-21006-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       | 2 ++
 arch/x86/events/perf_event.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5a3ccd1715e2..00a6251981d2 100644
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
index 6495ffd57e3e..d445f0026989 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -520,6 +520,7 @@ struct x86_pmu {
 	void		(*disable)(struct perf_event *);
 	void		(*add)(struct perf_event *);
 	void		(*del)(struct perf_event *);
+	void		(*read)(struct perf_event *event);
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	unsigned	eventsel;
