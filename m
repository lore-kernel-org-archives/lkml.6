Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49iEifc1bXySQlU7kZwozmF+/iLeRJCxTV2xc7E0IyecmkmpaV6Onu1Dx85VCidKnTjl8ih
ARC-Seal: i=1; a=rsa-sha256; t=1524406506; cv=none;
        d=google.com; s=arc-20160816;
        b=GCxlo0kxPfDqa7CjCseTE1dNeHHPcS/RlSu+G3KcjVwER51ANYluiqbF9Ps3M9HG74
         4TNeXIQ2buOdliFB4IODhJMyQEmMxia1kid04ZiDebLuc+NIlrsIuhnQ6b71uNmofBfd
         tqXKOkLhswX/ggof7woB5/HO5MhTVTVj9UUDaEc0/j/JFT7umk6GN81y62Dg/VIASWvY
         IFx8Y39wslyN8tt9RawCe4oyJA8yGnWTForhwYmkiWXeggrW0U+ifidyRRPQ+EJLrNiN
         R7/c+vOr6b0SI9bXw3n6GQuoijkxsCg/3OnYBC44/ODwEFKD5FQKmpfrImV1cJqnw81B
         vnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tmFjeXqPC/L9/uwA6oG5Ze8sf51ZXMHHldVaj2XM5l0=;
        b=X+qVc89NA5ThUKf1x6H1hlAPrDmSfX98x2K/t4e1QGiU8Z9izHYua9COUOHeJfInWc
         3KHxv77+vf+Hq3O9pIhJjVdkLq108aJ1LHkZZ1522JmlDqJHAd/VckxxfrPPBXLw+Rx+
         rVzeUzqQAZzskV/RWKDv3DMPilMsKq24zmgBcDuvemzNTIK1faTNTptIhSOv9+1E6zHh
         XoxL5RbbVxAi3RgkEVhCh4xVmBO7ntDIj3VQgOwQJqf/SLZa35FV5LRkDL7T0BDocfbi
         2SLn9P8+dfiZTGQ6mY04/z6YSuK6u8PpbU0rj9CmITVYyLRABXNOFNN87ryQ5Wc4gM22
         Dm3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Jens Axboe <axboe@fb.com>,
	Thierry Escande <thierry.escande@linaro.org>
Subject: [PATCH 4.9 95/95] block/mq: fix potential deadlock during cpu hotplug
Date: Sun, 22 Apr 2018 15:54:04 +0200
Message-Id: <20180422135214.306911977@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456076621805727?=
X-GMAIL-MSGID: =?utf-8?q?1598456076621805727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>

commit 51d638b1f56a0bfd9219800620994794a1a2b219 upstream.

This can be triggered by hot-unplug one cpu.

======================================================
 [ INFO: possible circular locking dependency detected ]
 4.11.0+ #17 Not tainted
 -------------------------------------------------------
 step_after_susp/2640 is trying to acquire lock:
  (all_q_mutex){+.+...}, at: [<ffffffffb33f95b8>] blk_mq_queue_reinit_work+0x18/0x110

 but task is already holding lock:
  (cpu_hotplug.lock){+.+.+.}, at: [<ffffffffb306d04f>] cpu_hotplug_begin+0x7f/0xe0

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (cpu_hotplug.lock){+.+.+.}:
        lock_acquire+0x11c/0x230
        __mutex_lock+0x92/0x990
        mutex_lock_nested+0x1b/0x20
        get_online_cpus+0x64/0x80
        blk_mq_init_allocated_queue+0x3a0/0x4e0
        blk_mq_init_queue+0x3a/0x60
        loop_add+0xe5/0x280
        loop_init+0x124/0x177
        do_one_initcall+0x53/0x1c0
        kernel_init_freeable+0x1e3/0x27f
        kernel_init+0xe/0x100
        ret_from_fork+0x31/0x40

 -> #0 (all_q_mutex){+.+...}:
        __lock_acquire+0x189a/0x18a0
        lock_acquire+0x11c/0x230
        __mutex_lock+0x92/0x990
        mutex_lock_nested+0x1b/0x20
        blk_mq_queue_reinit_work+0x18/0x110
        blk_mq_queue_reinit_dead+0x1c/0x20
        cpuhp_invoke_callback+0x1f2/0x810
        cpuhp_down_callbacks+0x42/0x80
        _cpu_down+0xb2/0xe0
        freeze_secondary_cpus+0xb6/0x390
        suspend_devices_and_enter+0x3b3/0xa40
        pm_suspend+0x129/0x490
        state_store+0x82/0xf0
        kobj_attr_store+0xf/0x20
        sysfs_kf_write+0x45/0x60
        kernfs_fop_write+0x135/0x1c0
        __vfs_write+0x37/0x160
        vfs_write+0xcd/0x1d0
        SyS_write+0x58/0xc0
        do_syscall_64+0x8f/0x710
        return_from_SYSCALL_64+0x0/0x7a

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(cpu_hotplug.lock);
                                lock(all_q_mutex);
                                lock(cpu_hotplug.lock);
   lock(all_q_mutex);

  *** DEADLOCK ***

 8 locks held by step_after_susp/2640:
  #0:  (sb_writers#6){.+.+.+}, at: [<ffffffffb3244aed>] vfs_write+0x1ad/0x1d0
  #1:  (&of->mutex){+.+.+.}, at: [<ffffffffb32d3a51>] kernfs_fop_write+0x101/0x1c0
  #2:  (s_active#166){.+.+.+}, at: [<ffffffffb32d3a59>] kernfs_fop_write+0x109/0x1c0
  #3:  (pm_mutex){+.+...}, at: [<ffffffffb30d2ecd>] pm_suspend+0x21d/0x490
  #4:  (acpi_scan_lock){+.+.+.}, at: [<ffffffffb34dc3d7>] acpi_scan_lock_acquire+0x17/0x20
  #5:  (cpu_add_remove_lock){+.+.+.}, at: [<ffffffffb306d6d7>] freeze_secondary_cpus+0x27/0x390
  #6:  (cpu_hotplug.dep_map){++++++}, at: [<ffffffffb306cfd5>] cpu_hotplug_begin+0x5/0xe0
  #7:  (cpu_hotplug.lock){+.+.+.}, at: [<ffffffffb306d04f>] cpu_hotplug_begin+0x7f/0xe0

 stack backtrace:
 CPU: 3 PID: 2640 Comm: step_after_susp Not tainted 4.11.0+ #17
 Hardware name: Dell Inc. OptiPlex 7040/0JCTF8, BIOS 1.4.9 09/12/2016
 Call Trace:
  dump_stack+0x99/0xce
  print_circular_bug+0x1fa/0x270
  __lock_acquire+0x189a/0x18a0
  lock_acquire+0x11c/0x230
  ? lock_acquire+0x11c/0x230
  ? blk_mq_queue_reinit_work+0x18/0x110
  ? blk_mq_queue_reinit_work+0x18/0x110
  __mutex_lock+0x92/0x990
  ? blk_mq_queue_reinit_work+0x18/0x110
  ? kmem_cache_free+0x2cb/0x330
  ? anon_transport_class_unregister+0x20/0x20
  ? blk_mq_queue_reinit_work+0x110/0x110
  mutex_lock_nested+0x1b/0x20
  ? mutex_lock_nested+0x1b/0x20
  blk_mq_queue_reinit_work+0x18/0x110
  blk_mq_queue_reinit_dead+0x1c/0x20
  cpuhp_invoke_callback+0x1f2/0x810
  ? __flow_cache_shrink+0x160/0x160
  cpuhp_down_callbacks+0x42/0x80
  _cpu_down+0xb2/0xe0
  freeze_secondary_cpus+0xb6/0x390
  suspend_devices_and_enter+0x3b3/0xa40
  ? rcu_read_lock_sched_held+0x79/0x80
  pm_suspend+0x129/0x490
  state_store+0x82/0xf0
  kobj_attr_store+0xf/0x20
  sysfs_kf_write+0x45/0x60
  kernfs_fop_write+0x135/0x1c0
  __vfs_write+0x37/0x160
  ? rcu_read_lock_sched_held+0x79/0x80
  ? rcu_sync_lockdep_assert+0x2f/0x60
  ? __sb_start_write+0xd9/0x1c0
  ? vfs_write+0x1ad/0x1d0
  vfs_write+0xcd/0x1d0
  SyS_write+0x58/0xc0
  ? rcu_read_lock_sched_held+0x79/0x80
  do_syscall_64+0x8f/0x710
  ? trace_hardirqs_on_thunk+0x1a/0x1c
  entry_SYSCALL64_slow_path+0x25/0x25

The cpu hotplug path will hold cpu_hotplug.lock and then reinit all exiting
queues for blk mq w/ all_q_mutex, however, blk_mq_init_allocated_queue() will
contend these two locks in the inversion order. This is due to commit eabe06595d62
(blk/mq: Cure cpu hotplug lock inversion), it fixes a cpu hotplug lock inversion
issue because of hotplug rework, however the hotplug rework is still work-in-progress
and lives in a -tip branch and mainline cannot yet trigger that splat. The commit
breaks the linus's tree in the merge window, so this patch reverts the lock order
and avoids to splat linus's tree.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Cc: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2019,15 +2019,15 @@ struct request_queue *blk_mq_init_alloca
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 
-	mutex_lock(&all_q_mutex);
 	get_online_cpus();
+	mutex_lock(&all_q_mutex);
 
 	list_add_tail(&q->all_q_node, &all_q_list);
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q, cpu_online_mask);
 
-	put_online_cpus();
 	mutex_unlock(&all_q_mutex);
+	put_online_cpus();
 
 	return q;
 
