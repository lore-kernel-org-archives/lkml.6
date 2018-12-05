Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C690C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22068214DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZLwiw1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22068214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbeLEJwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbeLEJwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:52:38 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB856214DE;
        Wed,  5 Dec 2018 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003557;
        bh=8Td3uKLj41hM6ztRlMCd6uCFgBON/MA2X3QrvGeb/sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZLwiw1PdouxwFnJGfx/k2BYHuY9wZaFbjs+UBbIAVr5ZQJv4+izcIYGr7cVVRvZH
         gHlqSdvSRBNhRwJIKb9lKInp5bxsFMZuCctDLVLd64NK3rM+ASRaEpmUetO4Yn9Fxb
         qOSXtGJ2WgbeyfzO0Sce6gk5XsDKeXgrpbW9YahA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 04/33] s390/cpum_cf: Reject request for sampling in event initialization
Date:   Wed,  5 Dec 2018 04:51:02 -0500
Message-Id: <20181205095131.7685-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 613a41b0d16e617f46776a93b975a1eeea96417c ]

On s390 command perf top fails
[root@s35lp76 perf] # ./perf top -F100000  --stdio
   Error:
   cycles: PMU Hardware doesn't support sampling/overflow-interrupts.
   	Try 'perf stat'
[root@s35lp76 perf] #

Using event -e rb0000 works as designed.  Event rb0000 is the event
number of the sampling facility for basic sampling.

During system start up the following PMUs are installed in the kernel's
PMU list (from head to tail):
   cpum_cf --> s390 PMU counter facility device driver
   cpum_sf --> s390 PMU sampling facility device driver
   uprobe
   kprobe
   tracepoint
   task_clock
   cpu_clock

Perf top executes following functions and calls perf_event_open(2) system
call with different parameters many times:

cmd_top
--> __cmd_top
    --> perf_evlist__add_default
        --> __perf_evlist__add_default
            --> perf_evlist__new_cycles (creates event type:0 (HW)
			    		config 0 (CPU_CYCLES)
	        --> perf_event_attr__set_max_precise_ip
		    Uses perf_event_open(2) to detect correct
		    precise_ip level. Fails 3 times on s390 which is ok.

Then functions cmd_top
--> __cmd_top
    --> perf_top__start_counters
        -->perf_evlist__config
	   --> perf_can_comm_exec
               --> perf_probe_api
	           This functions test support for the following events:
		   "cycles:u", "instructions:u", "cpu-clock:u" using
		   --> perf_do_probe_api
		       --> perf_event_open_cloexec
		           Test the close on exec flag support with
			   perf_event_open(2).
	               perf_do_probe_api returns true if the event is
		       supported.
		       The function returns true because event cpu-clock is
		       supported by the PMU cpu_clock.
	               This is achieved by many calls to perf_event_open(2).

Function perf_top__start_counters now calls perf_evsel__open() for every
event, which is the default event cpu_cycles (config:0) and type HARDWARE
(type:0) which a predfined frequence of 4000.

Given the above order of the PMU list, the PMU cpum_cf gets called first
and returns 0, which indicates support for this sampling. The event is
fully allocated in the function perf_event_open (file kernel/event/core.c
near line 10521 and the following check fails:

        event = perf_event_alloc(&attr, cpu, task, group_leader, NULL,
		                 NULL, NULL, cgroup_fd);
	if (IS_ERR(event)) {
		err = PTR_ERR(event);
		goto err_cred;
	}

        if (is_sampling_event(event)) {
		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
			err = -EOPNOTSUPP;
			goto err_alloc;
		}
	}

The check for the interrupt capabilities fails and the system call
perf_event_open() returns -EOPNOTSUPP (-95).

Add a check to return -ENODEV when sampling is requested in PMU cpum_cf.
This allows common kernel code in the perf_event_open() system call to
test the next PMU in above list.

Fixes: 97b1198fece0 (" "s390, perf: Use common PMU interrupt disabled code")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 929c147e07b4..1b69bfdf59f9 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -344,6 +344,8 @@ static int __hw_perf_event_init(struct perf_event *event)
 		break;
 
 	case PERF_TYPE_HARDWARE:
+		if (is_sampling_event(event))	/* No sampling support */
+			return -ENOENT;
 		ev = attr->config;
 		/* Count user space (problem-state) only */
 		if (!attr->exclude_user && attr->exclude_kernel) {
-- 
2.17.1

