Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164394AbeE1Kz1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164369AbeE1KzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Steven J. Hill" <steven.hill@cavium.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <htejun@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 310/496] mm/vmstat.c: fix vmstat_update() preemption BUG
Date: Mon, 28 May 2018 12:01:35 +0200
Message-Id: <20180528100332.859289706@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven J. Hill" <steven.hill@cavium.com>

[ Upstream commit c7f26ccfb2c31eb1bf810ba13d044fcf583232db ]

Attempting to hotplug CPUs with CONFIG_VM_EVENT_COUNTERS enabled can
cause vmstat_update() to report a BUG due to preemption not being
disabled around smp_processor_id().

Discovered on Ubiquiti EdgeRouter Pro with Cavium Octeon II processor.

  BUG: using smp_processor_id() in preemptible [00000000] code:
  kworker/1:1/269
  caller is vmstat_update+0x50/0xa0
  CPU: 0 PID: 269 Comm: kworker/1:1 Not tainted
  4.16.0-rc4-Cavium-Octeon-00009-gf83bbd5-dirty #1
  Workqueue: mm_percpu_wq vmstat_update
  Call Trace:
    show_stack+0x94/0x128
    dump_stack+0xa4/0xe0
    check_preemption_disabled+0x118/0x120
    vmstat_update+0x50/0xa0
    process_one_work+0x144/0x348
    worker_thread+0x150/0x4b8
    kthread+0x110/0x140
    ret_from_kernel_thread+0x14/0x1c

Link: http://lkml.kernel.org/r/1520881552-25659-1-git-send-email-steven.hill@cavium.com
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmstat.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1770,9 +1770,11 @@ static void vmstat_update(struct work_st
 		 * to occur in the future. Keep on running the
 		 * update worker thread.
 		 */
+		preempt_disable();
 		queue_delayed_work_on(smp_processor_id(), mm_percpu_wq,
 				this_cpu_ptr(&vmstat_work),
 				round_jiffies_relative(sysctl_stat_interval));
+		preempt_enable();
 	}
 }
 
