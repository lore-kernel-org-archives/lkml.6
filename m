Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537ADC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2265520652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957279;
	bh=Uius6+4aG9NqoeM/HTyM7lG07GMzThwbrxYtNy5uZlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+2kI1HTSFLMXf+5m0YMnY92duKlIdY7wUBBwE8EJQI92a4pyp/2K367PlC0l112b
	 bzJc7P3npJ+D35Q5It14+qDqGW0iBvY87G/9hyFMuqGfTA3CQGJGPzxK++bzpte16Y
	 Pur2OmjQWVHS6Td9WkMW2Aeazb0pVPKi4tXuFgag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfBWV15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbfBWVGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B1720866;
        Sat, 23 Feb 2019 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956009;
        bh=Uius6+4aG9NqoeM/HTyM7lG07GMzThwbrxYtNy5uZlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0iQcNMUemuR8JsnKcpueNlxXDG1ROaOAS65OvNCgvadVO94VXhmqAqJ9kmkb4C5T
         t2iUxAf4NnI9CUXtueX5IRhuG85AXWzqPI+3DOW68xYYIGlsUJ9Mhdx+rpxfQEp02q
         4i4XWXqvykoHYviTFNPNhrAX1lk+rdKddGyFBJmY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 07/65] perf core: Fix perf_proc_update_handler() bug
Date:   Sat, 23 Feb 2019 16:05:42 -0500
Message-Id: <20190223210640.200911-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

[ Upstream commit 1a51c5da5acc6c188c917ba572eebac5f8793432 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a97f34bc14c8..7cc1c72a0742f 100644
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
-- 
2.19.1

