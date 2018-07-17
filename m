Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF40ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D92208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D92208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeGQHWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:22:00 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:56308 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeGQHWA (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 17 Jul 2018 03:22:00 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 08:50:55 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 07:50:49 +0100
Date:   Tue, 17 Jul 2018 08:50:48 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180717065048.74mmgk4t5utjaa6a@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've recently noticed that commit 554c8aa8ecad ("sched: idle: Select
idle state before stopping the tick") causes severe performance drop
for systems using pcc-cpufreq driver. Depending on the number of CPUs
the system might be almost unusable. The OS jitter for 4.17.y and
4.18.-rcx kernels is off the charts, you can even spot it with top
command (issued when the system is supposedly idle), e.g.

 top - 14:44:24 up 2 min,  1 user,  load average: 90.11, 38.20, 14.38
 Tasks: 1199 total, 109 running, 541 sleeping,   0 stopped,   0 zombie
 %Cpu(s):  1.2 us, 58.7 sy,  0.0 ni, 39.3 id,  0.6 wa,  0.0 hi,  0.3 si,  0.0 st
 KiB Mem:  13137064+total,  1192168 used, 13017848+free,     2340 buffers
 KiB Swap:  2104316 total,        0 used,  2104316 free.   522296 cached Mem

   PID USER      PR  NI    VIRT    RES    SHR S    %CPU  %MEM     TIME+ COMMAND
  3373 root      20   0  982024  49916  36120 R  96.691 0.038   0:19.54 kubelet
    67 root      20   0       0      0      0 R  78.676 0.000   0:49.36 kworker/9:0
    25 root      20   0       0      0      0 R  78.125 0.000   0:49.67 kworker/2:0
   182 root      20   0       0      0      0 R  75.735 0.000   1:18.17 kworker/28:0
    43 root      20   0       0      0      0 R  75.000 0.000   0:11.56 kworker/5:0
   103 root      20   0       0      0      0 R  74.449 0.000   0:46.83 kworker/15:0
   334 root      20   0       0      0      0 R  72.978 0.000   1:06.88 kworker/53:0
   789 root      20   0       0      0      0 R  69.853 0.000   1:29.50 kworker/38:1
   418 root      20   0       0      0      0 R  69.301 0.000   0:41.33 kworker/67:0
   779 root      20   0       0      0      0 R  68.934 0.000   1:33.60 kworker/27:1
   773 root      20   0       0      0      0 R  68.566 0.000   1:37.91 kworker/22:1
   762 root      20   0       0      0      0 R  68.015 0.000   1:41.01 kworker/11:1
   769 root      20   0       0      0      0 R  67.647 0.000   1:37.65 kworker/18:1
   805 root      20   0       0      0      0 R  67.096 0.000   1:30.96 kworker/54:1
   840 root      20   0       0      0      0 R  66.912 0.000   1:23.82 kworker/89:1
   812 root      20   0       0      0      0 R  66.728 0.000   1:31.89 kworker/59:1
   847 root      20   0       0      0      0 R  66.360 0.000   1:28.40 kworker/96:1
   763 root      20   0       0      0      0 R  66.176 0.000   1:42.57 kworker/12:1
   772 root      20   0       0      0      0 R  66.176 0.000   1:12.58 kworker/21:1
   821 root      20   0       0      0      0 R  66.176 0.000   1:29.62 kworker/69:1
   923 root      20   0       0      0      0 R  65.809 0.000   1:44.32 kworker/3:18
  1284 root      20   0       0      0      0 R  65.809 0.000   1:23.50 kworker/101:2
    61 root      20   0       0      0      0 R  65.625 0.000   1:29.37 kworker/8:0
  3531 root      20   0   24384   3768   2356 R  65.625 0.003   0:08.91 top
   771 root      20   0       0      0      0 R  65.074 0.000   1:37.90 kworker/20:1
   767 root      20   0       0      0      0 R  64.706 0.000   1:38.01 kworker/16:1
   764 root      20   0       0      0      0 R  64.522 0.000   1:40.28 kworker/13:1
   765 root      20   0       0      0      0 R  64.154 0.000   1:40.13 kworker/14:1

When I apply below patch (trying to revert essential parts of commit
554c8aa8ecad) behaviour seems back to normal.

I know that pcc-cpufreq driver is not "state-of-the-art" when it comes
to cpufreq drivers and you better not use it. But I wonder whether
commit 554c8aa8ecad ("sched: idle: Select idle state before stopping
the tick") introduced bad behaviour for other cases as well.

I'll send some performance results to illustrate the issue asap. I've
also tried to modify pcc-cpufreq to reduce the amount of frequency
changes triggered by this driver but this does not help for kernels
where commit 554c8aa8ecad is applied.


Andreas

---

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1a3e9bddd17b..377a62ec475c 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -185,18 +185,13 @@ static void cpuidle_idle_call(void)
 	} else {
 		bool stop_tick = true;
 
+		tick_nohz_idle_stop_tick();
+		rcu_idle_enter();
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick)
-			tick_nohz_idle_stop_tick();
-		else
-			tick_nohz_idle_retain_tick();
-
-		rcu_idle_enter();
-
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
