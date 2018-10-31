Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D3BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C080520821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vm3ur4rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C080520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeKABo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbeKABo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:44:56 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36ECA20843;
        Wed, 31 Oct 2018 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004369;
        bh=ANlYY5PexmHne38Dkw1/AUdRA5aEy69M7u/3Oh19ljg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vm3ur4rbRwlBFl1gfc8t+qo3rKN8z2vKv4rbMrnKUzg771Gx3X7LLXhlCOs8Kkqyb
         3plpEaurzTCMUkS05MkI4lQ9SIbskKrlxFKImxkTikBxmiNdqLN2WvjNANHsVUyGH3
         RtbIHRaqvhgZpdaqCmQNT1UzwIe7RexznQcdQfBQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        stable@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/28] perf cs-etm: Correct CPU mode for samples
Date:   Wed, 31 Oct 2018 13:44:53 -0300
Message-Id: <20181031164508.4784-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Since commit edeb0c90df35 ("perf tools: Stop fallbacking to kallsyms for
vdso symbols lookup"), the kernel address cannot be properly parsed to
kernel symbol with command 'perf script -k vmlinux'.  The reason is
CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
thus it fails to find corresponding map/dso in below flows:

  process_sample_event()
    `-> machine__resolve()
	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);

In this flow it needs to pass argument 'sample->cpumode' to tell what's
the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
any failure until the commit edeb0c90df35 ("perf tools: Stop fallbacking
to kallsyms for vdso symbols lookup") has been merged.  The reason is
even with the wrong CPU mode the function thread__find_map() firstly
fails to find map but it will rollback to find kernel map for vdso
symbols lookup.  In the latest code it has removed the fallback code,
thus if CPU mode is PERF_RECORD_MISC_USER then it cannot find map
anymore with kernel address.

This patch is to correct samples CPU mode setting, it creates a new
helper function cs_etm__cpu_mode() to tell what's the CPU mode based on
the address with the info from machine structure; this patch has a bit
extension to check not only kernel and user mode, but also check for
host/guest and hypervisor mode.  Finally this patch uses the function in
instruction and branch samples and also apply in cs_etm__mem_access()
for a minor polishing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@kernel.org # v4.19
Link: http://lkml.kernel.org/r/1540883908-17018-1-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3b37d66dc533..73430b73570d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -244,6 +244,27 @@ static void cs_etm__free(struct perf_session *session)
 	zfree(&aux);
 }
 
+static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
+{
+	struct machine *machine;
+
+	machine = etmq->etm->machine;
+
+	if (address >= etmq->etm->kernel_start) {
+		if (machine__is_host(machine))
+			return PERF_RECORD_MISC_KERNEL;
+		else
+			return PERF_RECORD_MISC_GUEST_KERNEL;
+	} else {
+		if (machine__is_host(machine))
+			return PERF_RECORD_MISC_USER;
+		else if (perf_guest)
+			return PERF_RECORD_MISC_GUEST_USER;
+		else
+			return PERF_RECORD_MISC_HYPERVISOR;
+	}
+}
+
 static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 			      size_t size, u8 *buffer)
 {
@@ -258,10 +279,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 		return -1;
 
 	machine = etmq->etm->machine;
-	if (address >= etmq->etm->kernel_start)
-		cpumode = PERF_RECORD_MISC_KERNEL;
-	else
-		cpumode = PERF_RECORD_MISC_USER;
+	cpumode = cs_etm__cpu_mode(etmq, address);
 
 	thread = etmq->thread;
 	if (!thread) {
@@ -653,7 +671,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	struct perf_sample sample = {.ip = 0,};
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
-	event->sample.header.misc = PERF_RECORD_MISC_USER;
+	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	sample.ip = addr;
@@ -665,7 +683,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.cpu = etmq->packet->cpu;
 	sample.flags = 0;
 	sample.insn_len = 1;
-	sample.cpumode = event->header.misc;
+	sample.cpumode = event->sample.header.misc;
 
 	if (etm->synth_opts.last_branch) {
 		cs_etm__copy_last_branch_rb(etmq);
@@ -706,12 +724,15 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 		u64			nr;
 		struct branch_entry	entries;
 	} dummy_bs;
+	u64 ip;
+
+	ip = cs_etm__last_executed_instr(etmq->prev_packet);
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
-	event->sample.header.misc = PERF_RECORD_MISC_USER;
+	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
-	sample.ip = cs_etm__last_executed_instr(etmq->prev_packet);
+	sample.ip = ip;
 	sample.pid = etmq->pid;
 	sample.tid = etmq->tid;
 	sample.addr = cs_etm__first_executed_instr(etmq->packet);
@@ -720,7 +741,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 	sample.period = 1;
 	sample.cpu = etmq->packet->cpu;
 	sample.flags = 0;
-	sample.cpumode = PERF_RECORD_MISC_USER;
+	sample.cpumode = event->sample.header.misc;
 
 	/*
 	 * perf report cannot handle events without a branch stack
-- 
2.14.4

