Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E974C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C7E2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4Ho8u1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C7E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJ3QLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:11:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34296 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeJ3QLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:11:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so11338852wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 00:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N5Q5sSbI4B5JCgElx2bWVHfEi1MDIM5mIJmzC9BH3Fk=;
        b=P4Ho8u1MdChCaPX+CqRl5yv97y74ge+wYhiax1pGlxFM/4ni6XQVcDYpKkOOqPvGTU
         P4s6G29WZfiCM1tEBuxtqJIcoIEo1uPd8WZoBMXng1voKxKvx76SLkjZVatXFvDcu/rt
         SVB/3OULQkAWQbElO7u7FtP2swKTUUZzqimo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N5Q5sSbI4B5JCgElx2bWVHfEi1MDIM5mIJmzC9BH3Fk=;
        b=U8mu5+JUtzXuh5E/GnBTte+Ks8v04AXVGLn9NhwVAGdg6bnhXIu8ycaTUwk7DWmMqC
         +HlU2kJsMlw7r/HymEGLngfQ7Tdd3J2Euk+k/CN1bI7yK4/6QV5Ml1wzNuRN25LMkaMH
         5WuLdruGU5yValVE/633rTClYt2LQ74/zBL7hCIRNRE8suA2rVeOrduh88cxXc8urLib
         yJNGAsZLEBIkhQbX066x86Lctcy+7bIzhm95HzE3sYw0L+M+r88XcPWdtt9t/hT98U6a
         EyGaNYjAFZ3+AervlHpS/sspwm4IsovqnOEon36AABBAJ1eGbriWCdT40ZxOTxP/uDoE
         CI9g==
X-Gm-Message-State: AGRZ1gKfTW7ETDPMLHHJbchO2oyAUZLC/R0thCQYZrPBhMcV1rg1qep+
        OWK2Oh60pNicC6Y9eHhviHwrKg==
X-Google-Smtp-Source: AJdET5cNO335I7UqWWwNC3YFmoo6yoO5GtQFPD4reYqxQdmj8aXL6hJn6DITUMtezYdLfYL7inI+9A==
X-Received: by 2002:adf:ae09:: with SMTP id x9-v6mr16534039wrc.102.1540883928482;
        Tue, 30 Oct 2018 00:18:48 -0700 (PDT)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id f67-v6sm6225586wme.22.2018.10.30.00.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 00:18:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf cs-etm: Correct CPU mode for samples
Date:   Tue, 30 Oct 2018 15:18:28 +0800
Message-Id: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9042f5e3539e ("perf tools: Stop fallbacking to kallsyms
for vdso symbols lookup"), the kernel address cannot be properly parsed
to kernel symbol with command 'perf script -k vmlinux'.  The reason is
CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
thus it fails to find corresponding map/dso in below flows:

  process_sample_event()
    `-> machine__resolve()
	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);

In this flow it needs to pass argument 'sample->cpumode' to tell what's
the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
any failure until the commit 9042f5e3539e ("perf tools: Stop fallbacking
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
host/guest and hypervisor mode.  Finally this patch uses the function
in instruction and branch samples and also apply in cs_etm__mem_access()
for a minor polishing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3b37d66..73430b7 100644
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
2.7.4

