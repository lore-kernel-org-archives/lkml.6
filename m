Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEAAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B70219C7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B70219C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeHQX2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeHQX2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:28:30 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BEE21788;
        Fri, 17 Aug 2018 20:23:41 +0000 (UTC)
Date:   Fri, 17 Aug 2018 16:23:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julia Cartwright <julia@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [BUG v4.14-rt] kernel BUG at
 /work/rt/stable-rt.git/kernel/sched/core.c:1639!
Message-ID: <20180817162340.6e8482fd@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pulling in stable releases into v4.14-rt I triggered this with my CPU
hotplug test:

------------[ cut here ]------------
kernel BUG at /work/rt/stable-rt.git/kernel/sched/core.c:1639!
invalid opcode: 0000 [#1] PREEMPT SMP PTI
Modules linked in: sunrpc ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables uinput snd_hda_codec_idt snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd shpchp i2c_i801 soundcore floppy i915 drm_kms_helper drm fb_sys_fops sysimgblt sysfillrect syscopyarea i2c_algo_bit iosf_mbi video [last unloaded: speedstep_lib]
CPU: 1 PID: 2944 Comm: mkdumprd Not tainted 4.14.63-test-rt40+ #782
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS SDBLI944.86P 05/08/2007
task: ffff880037888d80 task.stack: ffffc90000538000
RIP: 0010:select_fallback_rq+0xc3/0x122
RSP: 0018:ffffc9000053bae0 EFLAGS: 00010046
RAX: 0000000000000100 RBX: 0000000000000100 RCX: 0000000000000000
RDX: 0000000000000100 RSI: 0000000000000100 RDI: ffffffff81c0aac0
RBP: ffff88004e53b600 R08: 0000000000000000 R09: 0000000000000008
R10: ffffc9000053bae0 R11: 0000000000025548 R12: 0000000000000003
R13: 0000000000000002 R14: 0000000000000020 R15: ffff88004e53b600
FS:  00007f5502038700(0000) GS:ffff88007d480000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001460c68 CR3: 00000000756f6000 CR4: 00000000000006e0
Call Trace:
 try_to_wake_up+0x1d5/0x30a
 ? rt_mutex_setprio+0x1f5/0x2e3
 __wake_up_q+0x47/0x6f
 rt_mutex_postunlock+0x1d/0x60
 rt_spin_lock_slowunlock+0x7c/0x87
 rt_spin_unlock+0xa/0x1f
 release_pages+0x60/0x1ef
 tlb_flush_mmu_free+0x28/0x3d
 arch_tlb_finish_mmu+0x39/0x5c
 tlb_finish_mmu+0x1e/0x2a
 exit_mmap+0xd1/0x131
 __mmput+0x2f/0xbb
 flush_old_exec+0x5f2/0x669
 load_elf_binary+0x293/0x13f0
 ? _raw_spin_lock+0x13/0x1c
 ? trace_preempt_on+0xd/0x2a
 ? preempt_count_sub+0x93/0x9c
 ? migrate_disable+0xe5/0x12b
 search_binary_handler+0x81/0x17e
 do_execveat_common.isra.33+0x4d6/0x6f6
 do_execve+0x1f/0x21
 SyS_execve+0x28/0x2f
 do_syscall_64+0x6a/0x7a
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x3054ea60b7
RSP: 002b:00007ffe63ee49a8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000000001460a90 RCX: 0000003054ea60b7
RDX: 0000000001460ac0 RSI: 0000000001460c70 RDI: 0000000001460a90
RBP: 0000000001460a90 R08: 0000000000000003 R09: 00000000ffffffdf
R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000001460c70 R14: 0000000001460ac0 R15: 000000000145c040
Code: 3b 05 2e 68 0e 01 89 c3 72 da 41 83 fd 01 74 1d 73 13 48 89 ef 41 bd 01 00 00 00 e8 be 7f 05 00 83 cb ff eb cd 41 83 fd 02 75 f5 <0f> 0b 48 c7 c6 40 84 15 82 48 89 ef 41 bd 02 00 00 00 e8 f4 fe 
RIP: select_fallback_rq+0xc3/0x122 RSP: ffffc9000053bae0


This isn't one of my normal crashes for the cpu hotplug test. It's
triggering on this part:

static int select_fallback_rq(int cpu, struct task_struct *p)
{

[..]

	for (;;) {
		/* Any allowed, online CPU? */
		for_each_cpu(dest_cpu, p->cpus_ptr) {
			if (!is_cpu_allowed(p, dest_cpu))
				continue;

			goto out;
		}

		/* No more Mr. Nice Guy. */
		switch (state) {
		case cpuset:
			if (IS_ENABLED(CONFIG_CPUSETS)) {
				cpuset_cpus_allowed_fallback(p);
				state = possible;
				break;
			}
			/* Fall-through */
		case possible:
			do_set_cpus_allowed(p, cpu_possible_mask);
			state = fail;
			break;

		case fail:
			BUG(); <-- Panic here
			break;
		}
	}


I'll investigate it a bit more, but wanted to see if you seen this too,
and if there's already a fix for it.

Thanks!

-- Steve
