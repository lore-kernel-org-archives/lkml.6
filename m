Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA7520879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfAVLg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:36:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfAVLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:36:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MBZGZ22929611
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 03:35:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MBZGsp2929608;
        Tue, 22 Jan 2019 03:35:16 -0800
Date:   Tue, 22 Jan 2019 03:35:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-1a51c5da5acc6c188c917ba572eebac5f8793432@git.kernel.org>
Cc:     eranian@google.com, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        tglx@linutronix.de, acme@redhat.com
Reply-To: eranian@google.com, linux-kernel@vger.kernel.org,
          kan.liang@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
          peterz@infradead.org, mingo@kernel.org, ak@linux.intel.com,
          tglx@linutronix.de, acme@redhat.com
In-Reply-To: <1547169436-6266-1-git-send-email-eranian@google.com>
References: <1547169436-6266-1-git-send-email-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf core: Fix perf_proc_update_handler() bug
Git-Commit-ID: 1a51c5da5acc6c188c917ba572eebac5f8793432
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1a51c5da5acc6c188c917ba572eebac5f8793432
Gitweb:     https://git.kernel.org/tip/1a51c5da5acc6c188c917ba572eebac5f8793432
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Thu, 10 Jan 2019 17:17:16 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 18 Jan 2019 11:10:38 -0300

perf core: Fix perf_proc_update_handler() bug

The perf_proc_update_handler() handles /proc/sys/kernel/perf_event_max_sample_rate
syctl variable.  When the PMU IRQ handler timing monitoring is disabled, i.e,
when /proc/sys/kernel/perf_cpu_time_max_percent is equal to 0 or 100,
then no modification to sysctl_perf_event_sample_rate is allowed to prevent
possible hang from wrong values.

The problem is that the test to prevent modification is made after the
sysctl variable is modified in perf_proc_update_handler().

You get an error:

  $ echo 10001 >/proc/sys/kernel/perf_event_max_sample_rate
  echo: write error: invalid argument

But the value is still modified causing all sorts of inconsistencies:

  $ cat /proc/sys/kernel/perf_event_max_sample_rate
  10001

This patch fixes the problem by moving the parsing of the value after
the test.

Committer testing:

  # echo 100 > /proc/sys/kernel/perf_cpu_time_max_percent
  # echo 10001 > /proc/sys/kernel/perf_event_max_sample_rate
  -bash: echo: write error: Invalid argument
  # cat /proc/sys/kernel/perf_event_max_sample_rate
  10001
  #

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1547169436-6266-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..e5ede6918050 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -436,18 +436,18 @@ int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos)
 {
-	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-
-	if (ret || !write)
-		return ret;
-
+	int ret;
+	int perf_cpu = sysctl_perf_cpu_time_max_percent;
 	/*
 	 * If throttling is disabled don't allow the write:
 	 */
-	if (sysctl_perf_cpu_time_max_percent == 100 ||
-	    sysctl_perf_cpu_time_max_percent == 0)
+	if (write && (perf_cpu == 100 || perf_cpu == 0))
 		return -EINVAL;
 
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret || !write)
+		return ret;
+
 	max_samples_per_tick = DIV_ROUND_UP(sysctl_perf_event_sample_rate, HZ);
 	perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
 	update_perf_cpu_limits();
