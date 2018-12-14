Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B1CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CBC214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789298;
	bh=yhGyDdBi24zOW8Lajk/R4t9Rvl+6Di8/eIbgtm16qwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qskyOueGbH8f4ilpYL1alZewAmjTvqf4c1FgKDWYN+iPJ6SMsQebPHwwMZGbMJJp4
	 eJBxYY+/0M7TjKaH2vJg+vPaIZ/DUCw9NAT8TuOd7nbD6klmJ0ejlW0cmPPu+/bie9
	 /WTW1oPVJwDw+7bHYONvoAqKiMeIqxi2ZR7fCK8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CBC214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbeLNMIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730706AbeLNMIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 337C721486;
        Fri, 14 Dec 2018 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789291;
        bh=yhGyDdBi24zOW8Lajk/R4t9Rvl+6Di8/eIbgtm16qwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1+r4b1NQA3M7XuNiZEmVOobdp73dsvUolt83BJJfp3YMIfjHmDNos+nWjaA4rj6/
         tZelyPr+k85uceH33GDJ8FzZH02SHLkG5iClRccoeVBD1z7e7l2VuD85kHoGFCygxg
         Xb0C5yQQTiSqn7WJCt8wwNVzMuHn3dCRzbIPgdmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 26/89] s390/cpum_cf: Reject request for sampling in event initialization
Date:   Fri, 14 Dec 2018 12:59:39 +0100
Message-Id: <20181214115730.986387878@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 61e91fee8467..edf6a61f0a64 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -349,6 +349,8 @@ static int __hw_perf_event_init(struct perf_event *event)
 		break;
 
 	case PERF_TYPE_HARDWARE:
+		if (is_sampling_event(event))	/* No sampling support */
+			return -ENOENT;
 		ev = attr->config;
 		/* Count user space (problem-state) only */
 		if (!attr->exclude_user && attr->exclude_kernel) {
-- 
2.19.1



