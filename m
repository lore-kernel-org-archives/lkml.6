Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55024C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CEC20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfAVLho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:37:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfAVLho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:37:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MBaVOE2929919
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 03:36:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MBaU7L2929916;
        Tue, 22 Jan 2019 03:36:30 -0800
Date:   Tue, 22 Jan 2019 03:36:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-1497e804d1a6e2bd9107ddf64b0310449f4673eb@git.kernel.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, hpa@zytor.com,
        acme@redhat.com, eranian@google.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org
Reply-To: mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          eranian@google.com, acme@redhat.com, kan.liang@linux.intel.com,
          ak@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org
In-Reply-To: <1547885559-1657-1-git-send-email-eranian@google.com>
References: <1547885559-1657-1-git-send-email-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Handle TOPOLOGY headers with no CPU
Git-Commit-ID: 1497e804d1a6e2bd9107ddf64b0310449f4673eb
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

Commit-ID:  1497e804d1a6e2bd9107ddf64b0310449f4673eb
Gitweb:     https://git.kernel.org/tip/1497e804d1a6e2bd9107ddf64b0310449f4673eb
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Sat, 19 Jan 2019 00:12:39 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 11:28:56 -0300

perf tools: Handle TOPOLOGY headers with no CPU

This patch fixes an issue in cpumap.c when used with the TOPOLOGY
header. In some configurations, some NUMA nodes may have no CPU (empty
cpulist). Yet a cpumap map must be created otherwise perf abort with an
error. This patch handles this case by creating a dummy map.

  Before:

  $ perf record -o - -e cycles noploop 2 | perf script -i -
  0x6e8 [0x6c]: failed to process type: 80

  After:

  $ perf record -o - -e cycles noploop 2 | perf script -i -
  noploop for 2 seconds

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1547885559-1657-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 1ccbd3342069..383674f448fc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -134,7 +134,12 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 	if (!cpu_list)
 		return cpu_map__read_all_cpu_map();
 
-	if (!isdigit(*cpu_list))
+	/*
+	 * must handle the case of empty cpumap to cover
+	 * TOPOLOGY header for NUMA nodes with no CPU
+	 * ( e.g., because of CPU hotplug)
+	 */
+	if (!isdigit(*cpu_list) && *cpu_list != '\0')
 		goto out;
 
 	while (isdigit(*cpu_list)) {
@@ -181,8 +186,10 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 
 	if (nr_cpus > 0)
 		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else
+	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
+	else
+		cpus = cpu_map__dummy_new();
 invalid:
 	free(tmp_cpus);
 out:
