Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161614AbeE1Kcw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161292AbeE1Kcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:32:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Yufen Yu <yuyufen@huawei.com>, Shaohua Li <sh.li@alibaba-inc.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 145/329] md/raid1: fix NULL pointer dereference
Date: Mon, 28 May 2018 12:01:14 +0200
Message-Id: <20180528100254.613735216@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 3de59bb9d551428cbdc76a9ea57883f82e350b4d ]

In handle_write_finished(), if r1_bio->bios[m] != NULL, it thinks
the corresponding conf->mirrors[m].rdev is also not NULL. But, it
is not always true.

Even if some io hold replacement rdev(i.e. rdev->nr_pending.count > 0),
raid1_remove_disk() can also set the rdev as NULL. That means,
bios[m] != NULL, but mirrors[m].rdev is NULL, resulting in NULL
pointer dereference in handle_write_finished and sync_request_write.

This patch can fix BUGs as follows:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000140
 IP: [<ffffffff815bbbbd>] raid1d+0x2bd/0xfc0
 PGD 12ab52067 PUD 12f587067 PMD 0
 Oops: 0000 [#1] SMP
 CPU: 1 PID: 2008 Comm: md3_raid1 Not tainted 4.1.44+ #130
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
 Call Trace:
  ? schedule+0x37/0x90
  ? prepare_to_wait_event+0x83/0xf0
  md_thread+0x144/0x150
  ? wake_atomic_t_function+0x70/0x70
  ? md_start_sync+0xf0/0xf0
  kthread+0xd8/0xf0
  ? kthread_worker_fn+0x160/0x160
  ret_from_fork+0x42/0x70
  ? kthread_worker_fn+0x160/0x160

 BUG: unable to handle kernel NULL pointer dereference at 00000000000000b8
 IP: sync_request_write+0x9e/0x980
 PGD 800000007c518067 P4D 800000007c518067 PUD 8002b067 PMD 0
 Oops: 0000 [#1] SMP PTI
 CPU: 24 PID: 2549 Comm: md3_raid1 Not tainted 4.15.0+ #118
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
 Call Trace:
  ? sched_clock+0x5/0x10
  ? sched_clock_cpu+0xc/0xb0
  ? flush_pending_writes+0x3a/0xd0
  ? pick_next_task_fair+0x4d5/0x5f0
  ? __switch_to+0xa2/0x430
  raid1d+0x65a/0x870
  ? find_pers+0x70/0x70
  ? find_pers+0x70/0x70
  ? md_thread+0x11c/0x160
  md_thread+0x11c/0x160
  ? finish_wait+0x80/0x80
  kthread+0x111/0x130
  ? kthread_create_worker_on_cpu+0x70/0x70
  ? do_syscall_64+0x6f/0x190
  ? SyS_exit_group+0x10/0x10
  ret_from_fork+0x35/0x40

Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Shaohua Li <sh.li@alibaba-inc.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid1.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1673,6 +1673,17 @@ static int raid1_remove_disk(struct mdde
 			struct md_rdev *repl =
 				conf->mirrors[conf->raid_disks + number].rdev;
 			freeze_array(conf, 0);
+			if (atomic_read(&repl->nr_pending)) {
+				/* It means that some queued IO of retry_list
+				 * hold repl. Thus, we cannot set replacement
+				 * as NULL, avoiding rdev NULL pointer
+				 * dereference in sync_request_write and
+				 * handle_write_finished.
+				 */
+				err = -EBUSY;
+				unfreeze_array(conf);
+				goto abort;
+			}
 			clear_bit(Replacement, &repl->flags);
 			p->rdev = repl;
 			conf->mirrors[conf->raid_disks + number].rdev = NULL;
