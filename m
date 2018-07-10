Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A760CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0890D208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0890D208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeGJKej (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:34:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:12080 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeGJKeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:34:37 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6AAYQU9031690;
        Tue, 10 Jul 2018 19:34:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Tue, 10 Jul 2018 19:34:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6AAYQdR031675
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 10 Jul 2018 19:34:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in iterate_supers
To:     viro@zeniv.linux.org.uk
References: <000000000000da8a9b0570a29c01@google.com>
Cc:     syzbot <syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <0145d376-7ef8-3e17-5a24-94de946a01e5@I-love.SAKURA.ne.jp>
Date:   Tue, 10 Jul 2018 19:34:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000da8a9b0570a29c01@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since syzbot found a C reproducer, I reproduced locally with below change applied.

----------------------------------------
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 32b4794..aca1cca 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -115,13 +115,6 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
 			t->comm, t->pid, timeout);
-		pr_err("      %s %s %.*s\n",
-			print_tainted(), init_utsname()->release,
-			(int)strcspn(init_utsname()->version, " "),
-			init_utsname()->version);
-		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
-			" disables this message.\n");
-		sched_show_task(t);
 		hung_task_show_lock = true;
 	}
 
@@ -190,8 +183,20 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	}
  unlock:
 	rcu_read_unlock();
-	if (hung_task_show_lock)
-		debug_show_all_locks();
+	if (hung_task_show_lock) {
+		extern void lockdep_print_held_locks(struct task_struct *p);
+
+		rcu_read_lock();
+		for_each_process_thread(g, t) {
+			if (!t->lockdep_depth)
+				continue;
+			sched_show_task(t);
+			lockdep_print_held_locks(t);
+			touch_nmi_watchdog();
+			touch_all_softlockup_watchdogs();
+		}
+		rcu_read_unlock();
+	}
 	if (hung_task_call_panic) {
 		trigger_all_cpu_backtrace();
 		panic("hung_task: blocked tasks");
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d31..e3de52d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -561,7 +561,7 @@ static void print_lock(struct held_lock *hlock)
 	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
 }
 
-static void lockdep_print_held_locks(struct task_struct *p)
+void lockdep_print_held_locks(struct task_struct *p)
 {
 	int i, depth = READ_ONCE(p->lockdep_depth);
 
@@ -575,7 +575,7 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	 * and it's not the current task.
 	 */
 	if (p->state == TASK_RUNNING && p != current)
-		return;
+		printk("RUNNING TASK\n");
 	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
 		print_lock(p->held_locks + i);
----------------------------------------

It turned out that, although the reason of stalling v9fs_mount() is currently
unknown, the reason of many processes stuck at iterate_supers() is that
they are unable to take s->s_umount object due to down_write_nested() below.

	/*
	 * sget() can have s_umount recursion.
	 *
	 * When it cannot find a suitable sb, it allocates a new
	 * one (this one), and tries again to find a suitable old
	 * one.
	 *
	 * In case that succeeds, it will acquire the s_umount
	 * lock of the old one. Since these are clearly distrinct
	 * locks, and this object isn't exposed yet, there's no
	 * risk of deadlocks.
	 *
	 * Annotate this by putting this lock in a different
	 * subclass.
	 */
	down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);

(The hashed address 00000000d803423d is printed among processes below.)

[  224.224404] INFO: task a.out:5454 blocked for more than 10 seconds.
[  224.230981] INFO: task a.out:5476 blocked for more than 10 seconds.
[  224.237530] INFO: task a.out:5491 blocked for more than 10 seconds.
[  224.242368] INFO: task a.out:5514 blocked for more than 10 seconds.
[  224.246407] INFO: task a.out:5529 blocked for more than 10 seconds.
[  224.250429] INFO: task a.out:5681 blocked for more than 10 seconds.
[  224.254420] INFO: task a.out:5697 blocked for more than 10 seconds.
[  224.258822] INFO: task a.out:5711 blocked for more than 10 seconds.
[  224.262873] INFO: task a.out:5723 blocked for more than 10 seconds.
[  224.266883] INFO: task a.out:5740 blocked for more than 10 seconds.
[  224.270740] INFO: task a.out:5757 blocked for more than 10 seconds.
[  224.272797] INFO: task a.out:5769 blocked for more than 10 seconds.
[  224.274895] INFO: task a.out:5789 blocked for more than 10 seconds.
[  224.276914] INFO: task a.out:5799 blocked for more than 10 seconds.
[  224.278909] INFO: task a.out:5823 blocked for more than 10 seconds.
[  224.280760] INFO: task a.out:5833 blocked for more than 10 seconds.
[  224.282612] INFO: task a.out:5456 blocked for more than 10 seconds.
[  224.284464] INFO: task a.out:5474 blocked for more than 10 seconds.
[  224.286389] INFO: task a.out:5492 blocked for more than 10 seconds.
[  224.288445] INFO: task a.out:5526 blocked for more than 10 seconds.
[  224.290524] INFO: task a.out:5570 blocked for more than 10 seconds.
[  224.292544] INFO: task a.out:5679 blocked for more than 10 seconds.
[  224.294551] INFO: task a.out:5693 blocked for more than 10 seconds.
[  224.296468] INFO: task a.out:5707 blocked for more than 10 seconds.
[  224.298317] INFO: task a.out:5720 blocked for more than 10 seconds.
[  224.300167] INFO: task a.out:5745 blocked for more than 10 seconds.
[  224.302098] INFO: task a.out:5759 blocked for more than 10 seconds.
[  224.304110] INFO: task a.out:5770 blocked for more than 10 seconds.
[  224.306111] INFO: task a.out:5786 blocked for more than 10 seconds.
[  224.308129] INFO: task a.out:5798 blocked for more than 10 seconds.
[  224.310068] INFO: task a.out:5813 blocked for more than 10 seconds.
[  224.312073] INFO: task a.out:5825 blocked for more than 10 seconds.
[  224.313958] INFO: task a.out:5458 blocked for more than 10 seconds.
[  224.315811] INFO: task a.out:5477 blocked for more than 10 seconds.
[  224.317721] INFO: task a.out:5485 blocked for more than 10 seconds.
[  224.319709] INFO: task a.out:5521 blocked for more than 10 seconds.
[  224.321709] INFO: task a.out:5530 blocked for more than 10 seconds.
[  224.323633] INFO: task a.out:5575 blocked for more than 10 seconds.
[  224.325630] INFO: task a.out:5686 blocked for more than 10 seconds.
[  224.327633] INFO: task a.out:5698 blocked for more than 10 seconds.
[  224.329602] INFO: task a.out:5719 blocked for more than 10 seconds.
[  224.331501] INFO: task a.out:5734 blocked for more than 10 seconds.
[  224.333448] INFO: task a.out:5748 blocked for more than 10 seconds.
[  224.335411] INFO: task a.out:5763 blocked for more than 10 seconds.
[  224.337343] INFO: task a.out:5775 blocked for more than 10 seconds.
[  224.339231] INFO: task a.out:5788 blocked for more than 10 seconds.
[  224.341156] INFO: task a.out:5800 blocked for more than 10 seconds.
[  224.343165] INFO: task a.out:5821 blocked for more than 10 seconds.
[  224.345157] INFO: task a.out:5461 blocked for more than 10 seconds.
[  224.347063] INFO: task a.out:5475 blocked for more than 10 seconds.
[  224.348970] INFO: task a.out:5486 blocked for more than 10 seconds.
[  224.351030] INFO: task a.out:5567 blocked for more than 10 seconds.
[  224.353060] INFO: task a.out:5577 blocked for more than 10 seconds.
[  224.354909] INFO: task a.out:5672 blocked for more than 10 seconds.
[  224.356761] INFO: task a.out:5690 blocked for more than 10 seconds.
[  224.358740] INFO: task a.out:5712 blocked for more than 10 seconds.
[  224.360722] INFO: task a.out:5722 blocked for more than 10 seconds.
[  224.362725] INFO: task a.out:5742 blocked for more than 10 seconds.
[  224.364623] INFO: task a.out:5754 blocked for more than 10 seconds.
[  224.366649] INFO: task a.out:5768 blocked for more than 10 seconds.
[  224.368651] INFO: task a.out:5782 blocked for more than 10 seconds.
[  224.370523] INFO: task a.out:5796 blocked for more than 10 seconds.
[  224.372377] INFO: task a.out:5811 blocked for more than 10 seconds.
[  224.374224] INFO: task a.out:5824 blocked for more than 10 seconds.
[  224.376253] INFO: task a.out:5481 blocked for more than 10 seconds.
[  224.378262] INFO: task a.out:5494 blocked for more than 10 seconds.
[  224.380189] INFO: task a.out:5528 blocked for more than 10 seconds.
[  224.382210] INFO: task a.out:5576 blocked for more than 10 seconds.
[  224.384217] INFO: task a.out:5662 blocked for more than 10 seconds.
[  224.386101] INFO: task a.out:5675 blocked for more than 10 seconds.
[  224.387969] INFO: task a.out:5692 blocked for more than 10 seconds.
[  224.389825] INFO: task a.out:5708 blocked for more than 10 seconds.
[  224.391758] INFO: task a.out:5721 blocked for more than 10 seconds.
[  224.393657] INFO: task a.out:5736 blocked for more than 10 seconds.
[  224.395577] INFO: task a.out:5750 blocked for more than 10 seconds.
[  224.397571] INFO: task a.out:5767 blocked for more than 10 seconds.
[  224.399579] INFO: task a.out:5783 blocked for more than 10 seconds.
[  224.401539] INFO: task a.out:5795 blocked for more than 10 seconds.
[  224.403410] INFO: task a.out:5810 blocked for more than 10 seconds.
[  224.405301] INFO: task a.out:5465 blocked for more than 10 seconds.
[  224.407194] INFO: task a.out:5483 blocked for more than 10 seconds.
[  224.409169] INFO: task a.out:5493 blocked for more than 10 seconds.
[  224.411220] INFO: task a.out:5512 blocked for more than 10 seconds.
[  224.413257] INFO: task a.out:5571 blocked for more than 10 seconds.
[  224.415156] INFO: task a.out:5678 blocked for more than 10 seconds.
[  224.417071] INFO: task a.out:5689 blocked for more than 10 seconds.
[  224.418921] INFO: task a.out:5710 blocked for more than 10 seconds.
[  224.420791] INFO: task a.out:5728 blocked for more than 10 seconds.
[  224.422642] INFO: task a.out:5741 blocked for more than 10 seconds.
[  224.424491] INFO: task a.out:5753 blocked for more than 10 seconds.
[  224.426527] INFO: task a.out:5766 blocked for more than 10 seconds.
[  224.428583] INFO: task a.out:5777 blocked for more than 10 seconds.
[  224.430508] INFO: task a.out:5792 blocked for more than 10 seconds.
[  224.432408] INFO: task a.out:5804 blocked for more than 10 seconds.
[  224.434273] INFO: task a.out:5820 blocked for more than 10 seconds.
[  224.436125] INFO: task a.out:5467 blocked for more than 10 seconds.
[  224.437998] INFO: task a.out:5482 blocked for more than 10 seconds.
[  224.439868] INFO: task a.out:5506 blocked for more than 10 seconds.
[  224.441763] INFO: task a.out:5513 blocked for more than 10 seconds.
[  224.443824] INFO: task a.out:5520 blocked for more than 10 seconds.
[  224.445849] INFO: task a.out:5673 blocked for more than 10 seconds.
[  224.447810] INFO: task a.out:5691 blocked for more than 10 seconds.
[  224.449697] INFO: task a.out:5709 blocked for more than 10 seconds.
[  224.451550] INFO: task a.out:5724 blocked for more than 10 seconds.
[  224.453425] INFO: task a.out:5739 blocked for more than 10 seconds.
[  224.455320] INFO: task a.out:5756 blocked for more than 10 seconds.
[  224.457223] INFO: task a.out:5772 blocked for more than 10 seconds.
[  224.459271] INFO: task a.out:5787 blocked for more than 10 seconds.
[  224.461337] INFO: task a.out:5797 blocked for more than 10 seconds.
[  224.463336] INFO: task a.out:5818 blocked for more than 10 seconds.
[  224.465229] INFO: task a.out:5831 blocked for more than 10 seconds.
[  224.467137] INFO: task a.out:5469 blocked for more than 10 seconds.
[  224.468994] INFO: task a.out:5473 blocked for more than 10 seconds.
[  224.470930] INFO: task a.out:5484 blocked for more than 10 seconds.
[  224.472824] INFO: task a.out:5525 blocked for more than 10 seconds.
[  224.475015] INFO: task a.out:5661 blocked for more than 10 seconds.
[  224.477571] INFO: task a.out:5671 blocked for more than 10 seconds.
[  224.479594] INFO: task a.out:5685 blocked for more than 10 seconds.
[  224.481574] INFO: task a.out:5699 blocked for more than 10 seconds.
[  224.483441] INFO: task a.out:5704 blocked for more than 10 seconds.
[  224.485314] INFO: task a.out:5731 blocked for more than 10 seconds.
[  224.487163] INFO: task a.out:5749 blocked for more than 10 seconds.
[  224.489028] INFO: task a.out:5765 blocked for more than 10 seconds.
[  224.490958] INFO: task a.out:5776 blocked for more than 10 seconds.
[  224.493029] INFO: task a.out:5790 blocked for more than 10 seconds.
[  224.495054] INFO: task a.out:5801 blocked for more than 10 seconds.
[  224.497054] INFO: task a.out:5822 blocked for more than 10 seconds.
[  224.498927] khungtaskd      R  running task    29656   953      2 0x80000000
[  224.501027] Call Trace:
[  224.501796]  sched_show_task+0x33a/0x420
[  224.503205]  watchdog+0x7c7/0xba0
[  224.504277]  kthread+0x2e5/0x3e0
[  224.505373]  ? reset_hung_task_detector+0x30/0x30
[  224.506836]  ? kthread_delayed_work_timer_fn+0x250/0x250
[  224.508467]  ret_from_fork+0x3a/0x50
[  224.509645] 1 lock held by khungtaskd/953:
[  224.510933]  #0: 00000000a7346670 (rcu_read_lock){....}, at: watchdog+0x673/0xba0
[  224.513358] a.out           D27464  5454      1 0x00000004
[  224.515294] Call Trace:
[  224.516192]  __schedule+0xb55/0x1dd0
[  224.517399]  ? pci_mmcfg_check_reserved+0x120/0x120
[  224.518997]  ? mark_held_locks+0xc8/0x120
[  224.520392]  ? _raw_spin_unlock_irq+0x27/0x70
[  224.522016]  schedule+0x8f/0x1b0
[  224.523319]  rwsem_down_read_failed+0x24c/0x3a0
[  224.524907]  ? rwsem_down_write_failed+0xce0/0xce0
[  224.526626]  ? block_ioctl+0xd7/0x130
[  224.527932]  ? __ia32_sys_tee+0x200/0x200
[  224.529362]  call_rwsem_down_read_failed+0x18/0x30
[  224.530966]  ? call_rwsem_down_read_failed+0x18/0x30
[  224.532587]  down_read+0x4e/0xb0
[  224.533669]  ? iterate_supers+0x113/0x210
[  224.534939]  iterate_supers+0x113/0x210
[  224.536181]  ksys_sync+0xa5/0x170
[  224.537307]  ? sync_filesystem+0x200/0x200
[  224.538701]  ? kasan_check_write+0x14/0x20
[  224.540061]  ? fput+0x18/0x130
[  224.541107]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  224.542818]  ? do_syscall_64+0x21/0x4e0
[  224.544182]  __ia32_sys_sync+0x9/0x10
[  224.545437]  do_syscall_64+0xd6/0x4e0
[  224.546675]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  224.548256] RIP: 0033:0x7f774b2694d9
[  224.549409] Code: Bad RIP value.
[  224.550481] RSP: 002b:00007f774b966f18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
[  224.552780] RAX: ffffffffffffffda RBX: 0000000000602124 RCX: 00007f774b2694d9
[  224.554964] RDX: 00007f774b2694d9 RSI: 0000000000000000 RDI: 0000000000000000
[  224.557068] RBP: 0000000000602120 R08: 00007f774b966f70 R09: 00007f774b966f70
[  224.559216] R10: 00007f774b966f70 R11: 0000000000000246 R12: 0000000000000000
[  224.561546] R13: 0000000000008c00 R14: 0000000000000000 R15: 00000000756e0874
[  224.563801] 1 lock held by a.out/5454:
[  224.564980]  #0: 00000000d803423d (&type->s_umount_key#54){.+.+}, at: iterate_supers+0x113/0x210
[  224.567645] a.out           D27464  5476      1 0x00000004
[  224.569476] Call Trace:
[  224.570350]  __schedule+0xb55/0x1dd0
[  224.571556]  ? pci_mmcfg_check_reserved+0x120/0x120
[  224.573065]  ? mark_held_locks+0xc8/0x120
[  224.574334]  ? _raw_spin_unlock_irq+0x27/0x70
[  224.575721]  schedule+0x8f/0x1b0
[  224.576859]  rwsem_down_read_failed+0x24c/0x3a0
[  224.578280]  ? rwsem_down_write_failed+0xce0/0xce0
[  224.579772]  ? lock_downgrade+0x840/0x840
[  224.581060]  ? __ia32_sys_tee+0x200/0x200
[  224.582311]  call_rwsem_down_read_failed+0x18/0x30
[  224.583831]  ? call_rwsem_down_read_failed+0x18/0x30
[  224.585431]  down_read+0x4e/0xb0
[  224.586487]  ? iterate_supers+0x113/0x210
[  224.587757]  iterate_supers+0x113/0x210
[  224.588984]  ksys_sync+0xa5/0x170
[  224.590073]  ? sync_filesystem+0x200/0x200
[  224.591350]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  224.593043]  ? do_syscall_64+0x21/0x4e0
[  224.594309]  __ia32_sys_sync+0x9/0x10
[  224.595540]  do_syscall_64+0xd6/0x4e0
[  224.596773]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  224.598353] RIP: 0033:0x7f774b2694d9
[  224.599544] Code: Bad RIP value.
[  224.600702] RSP: 002b:00007f774b945f18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
[  224.603112] RAX: ffffffffffffffda RBX: 000000000060213c RCX: 00007f774b2694d9
[  224.605199] RDX: 00007f774b2694d9 RSI: ffffffffffffff98 RDI: 0000000000000001
[  224.607302] RBP: 0000000000602138 R08: 0000000000000000 R09: 0000000000000000
[  224.609402] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  224.611694] R13: 0000000000008c00 R14: 0000000000000000 R15: 00000000756e0874
[  224.613927] 1 lock held by a.out/5476:
[  224.615168]  #0: 00000000d803423d (&type->s_umount_key#54){.+.+}, at: iterate_supers+0x113/0x210
[  224.618055] a.out           D27464  5491      1 0x00000004
[  224.619811] Call Trace:
[  224.620649]  __schedule+0xb55/0x1dd0
[  224.621788]  ? pci_mmcfg_check_reserved+0x120/0x120
[  224.623301]  ? mark_held_locks+0xc8/0x120
[  224.624570]  ? _raw_spin_unlock_irq+0x27/0x70
[  224.625939]  schedule+0x8f/0x1b0
[  224.627059]  rwsem_down_read_failed+0x24c/0x3a0
[  224.628508]  ? rwsem_down_write_failed+0xce0/0xce0
[  224.630102]  ? block_ioctl+0xd7/0x130
[  224.631385]  ? __ia32_sys_tee+0x200/0x200
[  224.632659]  call_rwsem_down_read_failed+0x18/0x30
[  224.634158]  ? call_rwsem_down_read_failed+0x18/0x30
[  224.635732]  down_read+0x4e/0xb0
[  224.636782]  ? iterate_supers+0x113/0x210
[  224.638064]  iterate_supers+0x113/0x210
[  224.639287]  ksys_sync+0xa5/0x170
[  224.640370]  ? sync_filesystem+0x200/0x200
[  224.641665]  ? kasan_check_write+0x14/0x20
[  224.642994]  ? fput+0x18/0x130
[  224.644073]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  224.645787]  ? do_syscall_64+0x21/0x4e0
[  224.647115]  __ia32_sys_sync+0x9/0x10
[  224.648350]  do_syscall_64+0xd6/0x4e0
[  224.649592]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  224.651178] RIP: 0033:0x7f774b2694d9
[  224.652356] Code: Bad RIP value.
[  224.653414] RSP: 002b:00007f774b924f18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
[  224.655692] RAX: ffffffffffffffda RBX: 0000000000602154 RCX: 00007f774b2694d9
[  224.657831] RDX: 00007f774b2694d9 RSI: 0000000000000000 RDI: 0000000000000000
[  224.660026] RBP: 0000000000602150 R08: 0000000000000000 R09: 0000000000000000
[  224.662220] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  224.664520] R13: 0000000000008c00 R14: 0000000000000000 R15: 00000000756e0874
[  224.666681] 1 lock held by a.out/5491:
[  224.667890]  #0: 00000000d803423d (&type->s_umount_key#54){.+.+}, at: iterate_supers+0x113/0x210
(...snipped...)
[  227.999265] a.out           D27464  5463      1 0x00000004
[  228.001055] Call Trace:
[  228.001867]  __schedule+0xb55/0x1dd0
[  228.003079]  ? trace_hardirqs_on+0xd/0x10
[  228.004417]  ? pci_mmcfg_check_reserved+0x120/0x120
[  228.006059]  ? wait_woken+0x2b0/0x2b0
[  228.007311]  schedule+0x8f/0x1b0
[  228.008433]  p9_client_rpc+0x39a/0x1040
[  228.009721]  ? __free_pages_ok+0xfdc/0x1aa0
[  228.011141]  ? trace_event_raw_event_9p_client_res+0x310/0x310
[  228.013036]  ? p9_parse_header+0x12b/0x4f0
[  228.014435]  ? remove_wait_queue+0x1b0/0x1b0
[  228.015849]  ? mark_held_locks+0xc8/0x120
[  228.017191]  ? p9_fd_cancel+0x50/0x1f0
[  228.018472]  p9_client_flush+0xfa/0x1f0
[  228.019781]  ? p9_client_rpc+0x1040/0x1040
[  228.021204]  ? _raw_spin_unlock+0x22/0x30
[  228.022543]  ? p9_fd_cancel+0x50/0x1f0
[  228.023799]  p9_client_rpc+0x9d8/0x1040
[  228.025095]  ? trace_event_raw_event_9p_client_res+0x310/0x310
[  228.026997]  ? p9_idpool_put+0x31/0x40
[  228.028255]  ? mark_held_locks+0xc8/0x120
[  228.029598]  ? mark_held_locks+0xc8/0x120
[  228.030977]  ? remove_wait_queue+0x1b0/0x1b0
[  228.032414]  ? trace_hardirqs_on_caller+0x442/0x5c0
[  228.034044]  ? trace_hardirqs_on+0xd/0x10
[  228.035434]  ? p9_client_stat+0x1e4/0x4a0
[  228.036790]  ? kasan_check_read+0x11/0x20
[  228.038127]  p9_client_clunk+0x80/0x180
[  228.039431]  v9fs_mount+0x515/0x7d0
[  228.040615]  mount_fs+0x81/0x2b0
[  228.041733]  vfs_kern_mount+0x66/0x3c0
[  228.043241]  do_mount+0x366/0x2910
[  228.044403]  ? copy_mount_string+0x20/0x20
[  228.045780]  ? kmem_cache_alloc_trace+0x33c/0x750
[  228.047370]  ? copy_mount_options+0x55/0x2f0
[  228.048814]  ksys_mount+0x7e/0xd0
[  228.049997]  __x64_sys_mount+0xb9/0x150
[  228.051328]  ? trace_hardirqs_on_caller+0x442/0x5c0
[  228.052925]  do_syscall_64+0xd6/0x4e0
[  228.054171]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  228.055834] RIP: 0033:0x7f774b2694d9
[  228.057043] Code: Bad RIP value.
[  228.058164] RSP: 002b:00007f774b966f18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  228.060583] RAX: ffffffffffffffda RBX: 0000000000602124 RCX: 00007f774b2694d9
[  228.062873] RDX: 0000000020000340 RSI: 00000000200000c0 RDI: 0000000000000000
[  228.065187] RBP: 0000000000602120 R08: 00000000200003c0 R09: 00007f774b966f70
[  228.067481] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  228.069793] R13: 0000000000008c00 R14: 0000000000000000 R15: 00000000756e0874
[  228.072166] 1 lock held by a.out/5463:
[  228.073427]  #0: 00000000d803423d (&type->s_umount_key#53/1){+.+.}, at: sget_userns+0x21d/0xb50
(...snipped...)
[  280.160650] a.out           D27464  5463      1 0x00000004
[  280.162434] Call Trace:
[  280.163327]  __schedule+0xb55/0x1dd0
[  280.164569]  ? trace_hardirqs_on+0xd/0x10
[  280.165915]  ? pci_mmcfg_check_reserved+0x120/0x120
[  280.167526]  ? wait_woken+0x2b0/0x2b0
[  280.168818]  schedule+0x8f/0x1b0
[  280.169893]  p9_client_rpc+0x39a/0x1040
[  280.171455]  ? __free_pages_ok+0xfdc/0x1aa0
[  280.172865]  ? trace_event_raw_event_9p_client_res+0x310/0x310
[  280.174679]  ? p9_parse_header+0x12b/0x4f0
[  280.176010]  ? remove_wait_queue+0x1b0/0x1b0
[  280.177452]  ? mark_held_locks+0xc8/0x120
[  280.178830]  ? p9_fd_cancel+0x50/0x1f0
[  280.180109]  p9_client_flush+0xfa/0x1f0
[  280.181436]  ? p9_client_rpc+0x1040/0x1040
[  280.182758]  ? _raw_spin_unlock+0x22/0x30
[  280.184050]  ? p9_fd_cancel+0x50/0x1f0
[  280.185337]  p9_client_rpc+0x9d8/0x1040
[  280.186614]  ? trace_event_raw_event_9p_client_res+0x310/0x310
[  280.188527]  ? p9_idpool_put+0x31/0x40
[  280.189799]  ? mark_held_locks+0xc8/0x120
[  280.191170]  ? mark_held_locks+0xc8/0x120
[  280.192603]  ? remove_wait_queue+0x1b0/0x1b0
[  280.194048]  ? trace_hardirqs_on_caller+0x442/0x5c0
[  280.195666]  ? trace_hardirqs_on+0xd/0x10
[  280.197010]  ? p9_client_stat+0x1e4/0x4a0
[  280.198296]  ? kasan_check_read+0x11/0x20
[  280.199574]  p9_client_clunk+0x80/0x180
[  280.200848]  v9fs_mount+0x515/0x7d0
[  280.202058]  mount_fs+0x81/0x2b0
[  280.203180]  vfs_kern_mount+0x66/0x3c0
[  280.204456]  do_mount+0x366/0x2910
[  280.205664]  ? copy_mount_string+0x20/0x20
[  280.207064]  ? kmem_cache_alloc_trace+0x33c/0x750
[  280.208618]  ? copy_mount_options+0x55/0x2f0
[  280.210027]  ksys_mount+0x7e/0xd0
[  280.211114]  __x64_sys_mount+0xb9/0x150
[  280.212389]  ? trace_hardirqs_on_caller+0x442/0x5c0
[  280.213932]  do_syscall_64+0xd6/0x4e0
[  280.215187]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  280.216849] RIP: 0033:0x7f774b2694d9
[  280.218063] Code: Bad RIP value.
[  280.219196] RSP: 002b:00007f774b966f18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  280.221658] RAX: ffffffffffffffda RBX: 0000000000602124 RCX: 00007f774b2694d9
[  280.223981] RDX: 0000000020000340 RSI: 00000000200000c0 RDI: 0000000000000000
[  280.226240] RBP: 0000000000602120 R08: 00000000200003c0 R09: 00007f774b966f70
[  280.228403] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  280.230615] R13: 0000000000008c00 R14: 0000000000000000 R15: 00000000756e0874
[  280.232804] 1 lock held by a.out/5463:
[  280.234032]  #0: 00000000d803423d (&type->s_umount_key#53/1){+.+.}, at: sget_userns+0x21d/0xb50
[  280.236875] a.out           D27464  5481      1 0x00000004
[  280.238721] Call Trace:
[  280.239610]  __schedule+0xb55/0x1dd0
[  280.240798]  ? pci_mmcfg_check_reserved+0x120/0x120
[  280.242368]  ? mark_held_locks+0xc8/0x120
[  280.243712]  ? _raw_spin_unlock_irq+0x27/0x70
[  280.245182]  schedule+0x8f/0x1b0
[  280.246319]  rwsem_down_read_failed+0x24c/0x3a0
[  280.247852]  ? rwsem_down_write_failed+0xce0/0xce0
[  280.249415]  ? lock_downgrade+0x840/0x840
[  280.250785]  ? __ia32_sys_tee+0x200/0x200
[  280.252169]  call_rwsem_down_read_failed+0x18/0x30
[  280.253773]  ? call_rwsem_down_read_failed+0x18/0x30
[  280.255455]  down_read+0x4e/0xb0
[  280.256585]  ? iterate_supers+0x113/0x210
[  280.257931]  iterate_supers+0x113/0x210
[  280.259220]  ksys_sync+0xa5/0x170
[  280.260386]  ? sync_filesystem+0x200/0x200
[  280.261782]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  280.263495]  ? do_syscall_64+0x21/0x4e0
[  280.264874]  __ia32_sys_sync+0x9/0x10
[  280.266117]  do_syscall_64+0xd6/0x4e0
[  280.267364]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  280.269027] RIP: 0033:0x7f774b2694d9
[  280.270249] Code: Bad RIP value.
[  280.271390] RSP: 002b:00007f774b945f18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
[  280.273819] RAX: ffffffffffffffda RBX: 000000000060213c RCX: 00007f774b2694d9
[  280.275980] RDX: 00007f774b2694d9 RSI: ffffffffffffff98 RDI: 0000000000000001
[  280.278234] RBP: 0000000000602138 R08: 0000000000000000 R09: 0000000000000000
[  280.280421] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  280.282597] R13: 0000000000008c00 R14: 0000000000000000 R15: 00000000756e0874
[  280.284843] 1 lock held by a.out/5481:
[  280.286118]  #0: 00000000d803423d (&type->s_umount_key#54){.+.+}, at: iterate_supers+0x113/0x210

