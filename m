Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F68FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F131621902
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358097;
	bh=ipxqilM8Ex1jqOImokhK/5C8MCLz750F9Z1LiDpe57A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ehstkN0FWuVLWyf7nJknsqeC7A4JY+QzWA2FDMQ7DC39SmJz6pthpf/hlYN8xX8Ny
	 HDfxixqYT7M8ExmyRZzF3nnOpFrs2zLxiJiWPCsLAEpPEXfJboVVl8YirD3OAR+O3z
	 lcR0Z4Hkuu7xVoDdFraSlcMtSCvH3oHS4LTH4bho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfAXT2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbfAXT2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59893218FC;
        Thu, 24 Jan 2019 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358091;
        bh=ipxqilM8Ex1jqOImokhK/5C8MCLz750F9Z1LiDpe57A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJ6CezortZY+K3Mush2ZUEnK2n8WaYjKnlYHAqjhAuLR6ffYs15Zf6T33wkAg8jdZ
         PdvT71+sgenexETq0NlkallZxVsZ4Io9xtC/EYIX4zpRO+CsAEPSIGDdopiiAwp6+f
         zAKOjS95GV3mKYEFVU3BclFEuPd7M6l3alG4yydw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 096/104] dm snapshot: Fix excessive memory usage and workqueue stalls
Date:   Thu, 24 Jan 2019 20:20:25 +0100
Message-Id: <20190124190205.381518379@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 721b1d98fb517ae99ab3b757021cf81db41e67be ]

kcopyd has no upper limit to the number of jobs one can allocate and
issue. Under certain workloads this can lead to excessive memory usage
and workqueue stalls. For example, when creating multiple dm-snapshot
targets with a 4K chunk size and then writing to the origin through the
page cache. Syncing the page cache causes a large number of BIOs to be
issued to the dm-snapshot origin target, which itself issues an even
larger (because of the BIO splitting taking place) number of kcopyd
jobs.

Running the following test, from the device mapper test suite [1],

  dmtest run --suite snapshot -n many_snapshots_of_same_volume_N

, with 8 active snapshots, results in the kcopyd job slab cache growing
to 10G. Depending on the available system RAM this can lead to the OOM
killer killing user processes:

[463.492878] kthreadd invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP),
              nodemask=(null), order=1, oom_score_adj=0
[463.492894] kthreadd cpuset=/ mems_allowed=0
[463.492948] CPU: 7 PID: 2 Comm: kthreadd Not tainted 4.19.0-rc7 #3
[463.492950] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[463.492952] Call Trace:
[463.492964]  dump_stack+0x7d/0xbb
[463.492973]  dump_header+0x6b/0x2fc
[463.492987]  ? lockdep_hardirqs_on+0xee/0x190
[463.493012]  oom_kill_process+0x302/0x370
[463.493021]  out_of_memory+0x113/0x560
[463.493030]  __alloc_pages_slowpath+0xf40/0x1020
[463.493055]  __alloc_pages_nodemask+0x348/0x3c0
[463.493067]  cache_grow_begin+0x81/0x8b0
[463.493072]  ? cache_grow_begin+0x874/0x8b0
[463.493078]  fallback_alloc+0x1e4/0x280
[463.493092]  kmem_cache_alloc_node+0xd6/0x370
[463.493098]  ? copy_process.part.31+0x1c5/0x20d0
[463.493105]  copy_process.part.31+0x1c5/0x20d0
[463.493115]  ? __lock_acquire+0x3cc/0x1550
[463.493121]  ? __switch_to_asm+0x34/0x70
[463.493129]  ? kthread_create_worker_on_cpu+0x70/0x70
[463.493135]  ? finish_task_switch+0x90/0x280
[463.493165]  _do_fork+0xe0/0x6d0
[463.493191]  ? kthreadd+0x19f/0x220
[463.493233]  kernel_thread+0x25/0x30
[463.493235]  kthreadd+0x1bf/0x220
[463.493242]  ? kthread_create_on_cpu+0x90/0x90
[463.493248]  ret_from_fork+0x3a/0x50
[463.493279] Mem-Info:
[463.493285] active_anon:20631 inactive_anon:4831 isolated_anon:0
[463.493285]  active_file:80216 inactive_file:80107 isolated_file:435
[463.493285]  unevictable:0 dirty:51266 writeback:109372 unstable:0
[463.493285]  slab_reclaimable:31191 slab_unreclaimable:3483521
[463.493285]  mapped:526 shmem:4903 pagetables:1759 bounce:0
[463.493285]  free:33623 free_pcp:2392 free_cma:0
...
[463.493489] Unreclaimable slab info:
[463.493513] Name                      Used          Total
[463.493522] bio-6                   1028KB       1028KB
[463.493525] bio-5                   1028KB       1028KB
[463.493528] dm_snap_pending_exception     236783KB     243789KB
[463.493531] dm_exception              41KB         42KB
[463.493534] bio-4                   1216KB       1216KB
[463.493537] bio-3                 439396KB     439396KB
[463.493539] kcopyd_job           6973427KB    6973427KB
...
[463.494340] Out of memory: Kill process 1298 (ruby2.3) score 1 or sacrifice child
[463.494673] Killed process 1298 (ruby2.3) total-vm:435740kB, anon-rss:20180kB, file-rss:4kB, shmem-rss:0kB
[463.506437] oom_reaper: reaped process 1298 (ruby2.3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB

Moreover, issuing a large number of kcopyd jobs results in kcopyd
hogging the CPU, while processing them. As a result, processing of work
items, queued for execution on the same CPU as the currently running
kcopyd thread, is stalled for long periods of time, hurting performance.
Running the aforementioned test we get, in dmesg, messages like the
following:

[67501.194592] BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0 stuck for 27s!
[67501.195586] Showing busy workqueues and worker pools:
[67501.195591] workqueue events: flags=0x0
[67501.195597]   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=1/256
[67501.195611]     pending: cache_reap
[67501.195641] workqueue mm_percpu_wq: flags=0x8
[67501.195645]   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=1/256
[67501.195656]     pending: vmstat_update
[67501.195682] workqueue kblockd: flags=0x18
[67501.195687]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=1/256
[67501.195698]     pending: blk_timeout_work
[67501.195753] workqueue kcopyd: flags=0x8
[67501.195757]   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=1/256
[67501.195768]     pending: do_work [dm_mod]
[67501.195802] workqueue kcopyd: flags=0x8
[67501.195806]   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=1/256
[67501.195817]     pending: do_work [dm_mod]
[67501.195834] workqueue kcopyd: flags=0x8
[67501.195838]   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=1/256
[67501.195848]     pending: do_work [dm_mod]
[67501.195881] workqueue kcopyd: flags=0x8
[67501.195885]   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=1/256
[67501.195896]     pending: do_work [dm_mod]
[67501.195920] workqueue kcopyd: flags=0x8
[67501.195924]   pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=2/256
[67501.195935]     in-flight: 67:do_work [dm_mod]
[67501.195945]     pending: do_work [dm_mod]
[67501.195961] pool 8: cpus=4 node=0 flags=0x0 nice=0 hung=27s workers=3 idle: 129 23765

The root cause for these issues is the way dm-snapshot uses kcopyd. In
particular, the lack of an explicit or implicit limit to the maximum
number of in-flight COW jobs. The merging path is not affected because
it implicitly limits the in-flight kcopyd jobs to one.

Fix these issues by using a semaphore to limit the maximum number of
in-flight kcopyd jobs. We grab the semaphore before allocating a new
kcopyd job in start_copy() and start_full_bio() and release it after the
job finishes in copy_callback().

The initial semaphore value is configurable through a module parameter,
to allow fine tuning the maximum number of in-flight COW jobs. Setting
this parameter to zero initializes the semaphore to INT_MAX.

A default value of 2048 maximum in-flight kcopyd jobs was chosen. This
value was decided experimentally as a trade-off between memory
consumption, stalling the kernel's workqueues and maintaining a high
enough throughput.

Re-running the aforementioned test:

  * Workqueue stalls are eliminated
  * kcopyd's job slab cache uses a maximum of 130MB
  * The time taken by the test to write to the snapshot-origin target is
    reduced from 05m20.48s to 03m26.38s

[1] https://github.com/jthornber/device-mapper-test-suite

Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-snap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index e108deebbaaa..5d3797728b9c 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/log2.h>
 #include <linux/dm-kcopyd.h>
+#include <linux/semaphore.h>
 
 #include "dm.h"
 
@@ -105,6 +106,9 @@ struct dm_snapshot {
 	/* The on disk metadata handler */
 	struct dm_exception_store *store;
 
+	/* Maximum number of in-flight COW jobs. */
+	struct semaphore cow_count;
+
 	struct dm_kcopyd_client *kcopyd_client;
 
 	/* Wait for events based on state_bits */
@@ -145,6 +149,19 @@ struct dm_snapshot {
 #define RUNNING_MERGE          0
 #define SHUTDOWN_MERGE         1
 
+/*
+ * Maximum number of chunks being copied on write.
+ *
+ * The value was decided experimentally as a trade-off between memory
+ * consumption, stalling the kernel's workqueues and maintaining a high enough
+ * throughput.
+ */
+#define DEFAULT_COW_THRESHOLD 2048
+
+static int cow_threshold = DEFAULT_COW_THRESHOLD;
+module_param_named(snapshot_cow_threshold, cow_threshold, int, 0644);
+MODULE_PARM_DESC(snapshot_cow_threshold, "Maximum number of chunks being copied on write");
+
 DECLARE_DM_KCOPYD_THROTTLE_WITH_MODULE_PARM(snapshot_copy_throttle,
 		"A percentage of time allocated for copy on write");
 
@@ -1190,6 +1207,8 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad_hash_tables;
 	}
 
+	sema_init(&s->cow_count, (cow_threshold > 0) ? cow_threshold : INT_MAX);
+
 	s->kcopyd_client = dm_kcopyd_client_create(&dm_kcopyd_throttle);
 	if (IS_ERR(s->kcopyd_client)) {
 		r = PTR_ERR(s->kcopyd_client);
@@ -1563,6 +1582,7 @@ static void copy_callback(int read_err, unsigned long write_err, void *context)
 		}
 		list_add(&pe->out_of_order_entry, lh);
 	}
+	up(&s->cow_count);
 }
 
 /*
@@ -1586,6 +1606,7 @@ static void start_copy(struct dm_snap_pending_exception *pe)
 	dest.count = src.count;
 
 	/* Hand over to kcopyd */
+	down(&s->cow_count);
 	dm_kcopyd_copy(s->kcopyd_client, &src, 1, &dest, 0, copy_callback, pe);
 }
 
@@ -1606,6 +1627,7 @@ static void start_full_bio(struct dm_snap_pending_exception *pe,
 	pe->full_bio_end_io = bio->bi_end_io;
 	pe->full_bio_private = bio->bi_private;
 
+	down(&s->cow_count);
 	callback_data = dm_kcopyd_prepare_callback(s->kcopyd_client,
 						   copy_callback, pe);
 
-- 
2.19.1



