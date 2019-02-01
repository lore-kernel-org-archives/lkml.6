Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F65AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190732085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="P5Vu1PgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBABNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:13:55 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34913 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfBABNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:13:55 -0500
Received: by mail-yw1-f67.google.com with SMTP id j82so2108242ywb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 17:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=VitnP8IOTJp29TBG+XaEIrZnatp9B1HNOU5qW3PugAE=;
        b=P5Vu1PgPlq83lS4G8kIlHdOR89M555KUDoVyiEthSwyP57F1803mo1/Ooj7+NjNOCZ
         YSAJeClKlOJjd2obDLQczB82ZA846q99QvnFGbNb+tnGu0nSzQWVSxB87gqvuriac551
         oLiYXN5MbRFpVipJl21xbgJ0guUnA1nRMX/hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=VitnP8IOTJp29TBG+XaEIrZnatp9B1HNOU5qW3PugAE=;
        b=rOCV6+pkjYKMU9jGlm+NOz0Y9Tg2CaRyKqbP3UUTaILAThjw4QcUY6f7NF4+6MpLUE
         JPpA9BkeQG3qSkzihvgfl19xoCWAscqzfbtWMN50RJetRNmvjE6mXWfp5gYtFgiHHLiV
         Hrl724NlPXRxiDCWIqUPRqvqQ4YdrU8B1up1RlW2beC2jADT0mDLOfjCNocKAdzBTdSs
         kl9EZWDP1x5imCVPEf1DK0AMbOmmJnIaYiEDRCPau7ZlXBnHodQL3e6PAUyMsyZsWPP8
         0nn4ce5GimJH6ldEUFPJ+Oe33uE1BT4gnDuf7MU1Yera8iWyl73/4QBckjfUMiPJmZ2y
         D48A==
X-Gm-Message-State: AJcUuke9y3+t8hMktIhkGPDURB14wer29x4nNT9ROfgtvCkRp2gAsW5f
        LpLimqs7XAmcJEab6XGCdPgcGA==
X-Google-Smtp-Source: ALg8bN63Yn2ug/bRVHmbrEP4laDwLQf9C9PjyvUs5Tf+Je+pZG9ZDTrgsJIKSEPal9zdkmD3x1GvMw==
X-Received: by 2002:a81:7d0b:: with SMTP id y11mr34352010ywc.442.1548983633446;
        Thu, 31 Jan 2019 17:13:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:91ec])
        by smtp.gmail.com with ESMTPSA id g84sm7159486ywg.9.2019.01.31.17.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 17:13:52 -0800 (PST)
Date:   Thu, 31 Jan 2019 20:13:52 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] mm: Throttle allocators when failing reclaim over memory.high
Message-ID: <20190201011352.GA14370@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're trying to use memory.high to limit workloads, but have found that
containment can frequently fail completely and cause OOM situations
outside of the cgroup. This happens especially with swap space -- either
when none is configured, or swap is full. These failures often also
don't have enough warning to allow one to react, whether for a human or
for a daemon monitoring PSI.

Here is output from a simple program showing how long it takes in μsec
(column 2) to allocate a megabyte of anonymous memory (column 1) when a
cgroup is already beyond its memory high setting, and no swap is
available:

    [root@ktst ~]# systemd-run -p MemoryHigh=100M -p MemorySwapMax=1 \
    > --wait -t timeout 300 /root/mdf
    [...]
    95  1035
    96  1038
    97  1000
    98  1036
    99  1048
    100 1590
    101 1968
    102 1776
    103 1863
    104 1757
    105 1921
    106 1893
    107 1760
    108 1748
    109 1843
    110 1716
    111 1924
    112 1776
    113 1831
    114 1766
    115 1836
    116 1588
    117 1912
    118 1802
    119 1857
    120 1731
    [...]
    [System OOM in 2-3 seconds]

The delay does go up extremely marginally past the 100MB memory.high
threshold, as now we spend time scanning before returning to usermode,
but it's nowhere near enough to contain growth. It also doesn't get
worse the more pages you have, since it only considers nr_pages.

The current situation goes against both the expectations of users of
memory.high, and our intentions as cgroup v2 developers. In
cgroup-v2.txt, we claim that we will throttle and only under "extreme
conditions" will memory.high protection be breached. Likewise, cgroup v2
users generally also expect that memory.high should throttle workloads
as they exceed their high threshold. However, as seen above, this isn't
always how it works in practice -- even on banal setups like those with
no swap, or where swap has become exhausted, we can end up with
memory.high being breached and us having no weapons left in our arsenal
to combat runaway growth with, since reclaim is futile.

It's also hard for system monitoring software or users to tell how bad
the situation is, as "high" events for the memcg may in some cases be
benign, and in others be catastrophic. The current status quo is that we
fail containment in a way that doesn't provide any advance warning that
things are about to go horribly wrong (for example, we are about to
invoke the kernel OOM killer).

This patch introduces explicit throttling when reclaim is failing to
keep memcg size contained at the memory.high setting. It does so by
applying an exponential delay curve derived from the memcg's overage
compared to memory.high.  In the normal case where the memcg is either
below or only marginally over its memory.high setting, no throttling
will be performed.

This composes well with system health monitoring and remediation, as
these allocator delays are factored into PSI's memory pressure
calculations. This both creates a mechanism system administrators or
applications consuming the PSI interface to trivially see that the memcg
in question is struggling and use that to make more reasonable
decisions, and permits them enough time to act. Either of these can act
with significantly more nuance than that we can provide using the system
OOM killer.

This is a similar idea to memory.oom_control in cgroup v1 which would
put the cgroup to sleep if the threshold was violated, but it's also
significantly improved as it results in visible memory pressure, and
also doesn't schedule indefinitely, which previously made tracing and
other introspection difficult.

Contrast the previous results with a kernel with this patch:

    [root@ktst ~]# systemd-run -p MemoryHigh=100M -p MemorySwapMax=1 \
    > --wait -t timeout 300 /root/mdf
    [...]
    95  1002
    96  1000
    97  1002
    98  1003
    99  1000
    100 1043
    101 84724
    102 330628
    103 610511
    104 1016265
    105 1503969
    106 2391692
    107 2872061
    108 3248003
    109 4791904
    110 5759832
    111 6912509
    112 8127818
    113 9472203
    114 12287622
    115 12480079
    116 14144008
    117 15808029
    118 16384500
    119 16383242
    120 16384979
    [...]

As you can see, in the normal case, memory allocation takes around 1000
μsec. However, as we exceed our memory.high, things start to increase
exponentially, but fairly leniently at first. Our first megabyte over
memory.high takes us 0.16 seconds, then the next is 0.46 seconds, then
the next is almost an entire second. This gets worse until we reach our
eventual 2*HZ clamp per batch, resulting in 16 seconds per megabyte.
However, this is still making forward progress, so permits tracing or
further analysis with programs like GDB.

This patch expands on earlier work by Johannes Weiner. Thanks!

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18f4aefbe0bf..1844a88f1f68 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -65,6 +65,7 @@
 #include <linux/lockdep.h>
 #include <linux/file.h>
 #include <linux/tracehook.h>
+#include <linux/psi.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -2161,12 +2162,68 @@ static void high_work_func(struct work_struct *work)
 	reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
 }
 
+/*
+ * Clamp the maximum sleep time per allocation batch to 2 seconds. This is
+ * enough to still cause a significant slowdown in most cases, while still
+ * allowing diagnostics and tracing to proceed without becoming stuck.
+ */
+#define MEMCG_MAX_HIGH_DELAY_JIFFIES (2UL*HZ)
+
+/*
+ * When calculating the delay, we use these either side of the exponentiation to
+ * maintain precision and scale to a reasonable number of jiffies (see the table
+ * below.
+ *
+ * - MEMCG_DELAY_PRECISION_SHIFT: Extra precision bits while translating the
+ *   overage ratio to a delay.
+ * - MEMCG_DELAY_SCALING_SHIFT: The number of bits to scale down down the
+ *   proposed penalty in order to reduce to a reasonable number of jiffies, and
+ *   to produce a reasonable delay curve.
+ *
+ * MEMCG_DELAY_SCALING_SHIFT just happens to be a number that produces a
+ * reasonable delay curve compared to precision-adjusted overage, not
+ * penalising heavily at first, but still making sure that growth beyond the
+ * limit penalises misbehaviour cgroups by slowing them down exponentially. For
+ * example, with a high of 100 megabytes:
+ *
+ *  +-------+------------------------+
+ *  | usage | time to allocate in ms |
+ *  +-------+------------------------+
+ *  | 100M  |                      0 |
+ *  | 101M  |                      6 |
+ *  | 102M  |                     25 |
+ *  | 103M  |                     57 |
+ *  | 104M  |                    102 |
+ *  | 105M  |                    159 |
+ *  | 106M  |                    230 |
+ *  | 107M  |                    313 |
+ *  | 108M  |                    409 |
+ *  | 109M  |                    518 |
+ *  | 110M  |                    639 |
+ *  | 111M  |                    774 |
+ *  | 112M  |                    921 |
+ *  | 113M  |                   1081 |
+ *  | 114M  |                   1254 |
+ *  | 115M  |                   1439 |
+ *  | 116M  |                   1638 |
+ *  | 117M  |                   1849 |
+ *  | 118M  |                   2000 |
+ *  | 119M  |                   2000 |
+ *  | 120M  |                   2000 |
+ *  +-------+------------------------+
+ */
+ #define MEMCG_DELAY_PRECISION_SHIFT 20
+ #define MEMCG_DELAY_SCALING_SHIFT 14
+
 /*
  * Scheduled by try_charge() to be executed from the userland return path
  * and reclaims memory over the high limit.
  */
 void mem_cgroup_handle_over_high(void)
 {
+	unsigned long usage, high;
+	unsigned long pflags;
+	unsigned long penalty_jiffies, overage;
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
 	struct mem_cgroup *memcg = current->memcg_high_reclaim;
 
@@ -2177,9 +2234,68 @@ void mem_cgroup_handle_over_high(void)
 		memcg = get_mem_cgroup_from_mm(current->mm);
 
 	reclaim_high(memcg, nr_pages, GFP_KERNEL);
-	css_put(&memcg->css);
 	current->memcg_high_reclaim = NULL;
 	current->memcg_nr_pages_over_high = 0;
+
+	/*
+	 * memory.high is breached and reclaim is unable to keep up. Throttle
+	 * allocators proactively to slow down excessive growth.
+	 *
+	 * We use overage compared to memory.high to calculate the number of
+	 * jiffies to sleep (penalty_jiffies). Ideally this value should be
+	 * fairly lenient on small overages, and increasingly harsh when the
+	 * memcg in question makes it clear that it has no intention of stopping
+	 * its crazy behaviour, so we exponentially increase the delay based on
+	 * overage amount.
+	 */
+
+	usage = page_counter_read(&memcg->memory);
+	high = READ_ONCE(memcg->high);
+
+	if (usage <= high)
+		goto out;
+
+	overage = ((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT) / high;
+	penalty_jiffies = ((u64)overage * overage * HZ)
+		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
+
+	/*
+	 * Factor in the task's own contribution to the overage, such that four
+	 * N-sized allocations are throttled approximately the same as one
+	 * 4N-sized allocation.
+	 *
+	 * MEMCG_CHARGE_BATCH pages is nominal, so work out how much smaller or
+	 * larger the current charge patch is than that.
+	 */
+	penalty_jiffies = penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
+
+	/*
+	 * Clamp the max delay per usermode return so as to still keep the
+	 * application moving forwards and also permit diagnostics, albeit
+	 * extremely slowly.
+	 */
+	penalty_jiffies = min(penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
+
+	/*
+	 * Don't sleep if the amount of jiffies this memcg owes us is so low
+	 * that it's not even worth doing, in an attempt to be nice to those who
+	 * go only a small amount over their memory.high value and maybe haven't
+	 * been aggressively reclaimed enough yet.
+	 */
+	if (penalty_jiffies <= HZ / 100)
+		goto out;
+
+	/*
+	 * If we exit early, we're guaranteed to die (since
+	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
+	 * need to account for any ill-begotten jiffies to pay them off later.
+	 */
+	psi_memstall_enter(&pflags);
+	schedule_timeout_killable(penalty_jiffies);
+	psi_memstall_leave(&pflags);
+
+out:
+	css_put(&memcg->css);
 }
 
 static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-- 
2.20.1

