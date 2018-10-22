Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88125C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085920853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mixtli.metztli.it header.i=@mixtli.metztli.it header.b="OU8UO07i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0085920853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metztli.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeJVShM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:37:12 -0400
Received: from mail7.static.mailgun.info ([104.130.122.7]:62236 "EHLO
        mail7.static.mailgun.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeJVShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mixtli.metztli.it; q=dns/txt;
 s=mx; t=1540203553; h=From: Date: Message-Id: To: Subject: Sender;
 bh=8b7MTVfCnMB991KBKN49GY+4Z5ZTA8XKoIs0U/ah6x0=; b=OU8UO07iFzvhO9A3OlcYt4uj3wAFlD5YO9Uhya0GQYX28sF+VdaMvck5rAsOtsGuQBri3xF0
 iYR8TPBke6ZA2ntmI2YbD7YycQtXy7Ii8ygqenKg30oktjwbuc4xnm6PWfHgvpG95/Lvag5g
 7AgxYIGsVneUTwVLtgSvKu5VQIc=
X-Mailgun-Sending-Ip: 104.130.122.7
X-Mailgun-Sid: WyIxYzIzYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjE3YjU0Il0=
Received: from huitzilopochtli.metztli-it.com (99-130-254-3.lightspeed.sntcca.sbcglobal.net [99.130.254.3])
 by mxa.mailgun.org with ESMTP id 5bcda421.7fa89040d9c0-smtp-out-n01;
 Mon, 22 Oct 2018 10:19:13 -0000 (UTC)
Received: by huitzilopochtli.metztli-it.com (Postfix, from userid 1000)
        id 3CE2E292B005; Mon, 22 Oct 2018 03:19:12 -0700 (PDT)
Subject: Reiser4 Linux 4.17.19-1 hangs in Google cloud VM, too.
To:     <reiserfs-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.1.1)
Message-Id: <20181022101912.3CE2E292B005@huitzilopochtli.metztli-it.com>
Date:   Mon, 22 Oct 2018 03:19:12 -0700 (PDT)
From:   jose.r.r@metztli.com (Metztli Information Technology)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I installed reiser4 -enhanced Linux kernel 4.17.19-1 --thus replacing the prior hung reiser4 -patched kernel 4.18.15-1 in the Google Compute Engine (GCE) cloud instance. After less than 24 hours the 4.17.19-1 hung in similar way to the 4.18.15-1.

Please note that I had been running my custom Metztli Reiser4 Debian Stretch image with reiser4 linux 4.14.20-1 without issues for several months
< https://github.com/Metztli/reiser4-debian-kernel-packaging-4.14.20 >  --until I decided to upgrade to newer kernel(s).

Below is the relevant section for 4.17.19-1 --remotely obtained by serial output:

[91343.247237] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
[91343.254373]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91343.262590] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91343.270536] kworker/u2:1    D    0  2363      2 0x80000000
[91343.276151] Workqueue: writeback wb_workfn (flush-8:0)
[91343.281409] Call Trace:
[91343.284039]  ? __schedule+0x3dc/0x860
[91343.287817]  schedule+0x32/0x80
[91343.291078]  io_schedule+0x12/0x40
[91343.294673]  __lock_page+0x119/0x160
[91343.298395]  ? page_cache_tree_insert+0xe0/0xe0
[91343.303155]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
[91343.309117]  ? zlook+0x15/0x70 [reiser4]
[91343.313186]  ? utmost_child_internal+0x45/0x80 [reiser4]
[91343.318630]  write_jnode_list+0x7f/0xb0 [reiser4]
[91343.323470]  reiser4_write_fq+0x81/0x230 [reiser4]
[91343.328516]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[91343.334056]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[91343.339232]  flush_some_atom+0x113/0x530 [reiser4]
[91343.344150]  reiser4_writeout+0x151/0x230 [reiser4]
[91343.349162]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[91343.354774]  writeback_sb_inodes+0x8f/0xb0
[91343.359117]  __writeback_inodes_wb+0x87/0xb0
[91343.363524]  wb_writeback+0x288/0x320
[91343.367304]  ? wb_workfn+0x1a9/0x450
[91343.370988]  wb_workfn+0x1a9/0x450
[91343.374527]  process_one_work+0x177/0x350
[91343.378701]  worker_thread+0x4d/0x3c0
[91343.382481]  kthread+0xf8/0x130
[91343.385771]  ? rescuer_thread+0x350/0x350
[91343.390127]  ? kthread_create_worker_on_cpu+0x70/0x70
[91343.395343]  ret_from_fork+0x35/0x40
Oct 21 23:25:12 cohuatl kernel: [91343.247237] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
Oct 21 23:25:12 cohuatl kernel: [91343.254373]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:25:12 cohuatl kernel: [91343.262590] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:25:12 cohuatl kernel: [91343.270536] kworker/u2:1    D    0  2363      2 0x80000000
Oct 21 23:25:12 cohuatl kernel: [91343.276151] Workqueue: writeback wb_workfn (flush-8:0)
Oct 21 23:25:12 cohuatl kernel: [91343.281409] Call Trace:
Oct 21 23:25:12 cohuatl kernel: [91343.284039]  ? __schedule+0x3dc/0x860
Oct 21 23:25:12 cohuatl kernel: [91343.287817]  schedule+0x32/0x80
Oct 21 23:25:12 cohuatl kernel: [91343.291078]  io_schedule+0x12/0x40
Oct 21 23:25:12 cohuatl kernel: [91343.294673]  __lock_page+0x119/0x160
Oct 21 23:25:12 cohuatl kernel: [91343.298395]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:25:12 cohuatl kernel: [91343.303155]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.309117]  ? zlook+0x15/0x70 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.313186]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.318630]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.323470]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.328516]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.334056]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.339232]  flush_some_atom+0x113/0x530 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.344150]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.349162]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 21 23:25:12 cohuatl kernel: [91343.354774]  writeback_sb_inodes+0x8f/0xb0
Oct 21 23:25:12 cohuatl kernel: [91343.359117]  __writeback_inodes_wb+0x87/0xb0
Oct 21 23:25:12 cohuatl kernel: [91343.363524]  wb_writeback+0x288/0x320
Oct 21 23:25:12 cohuatl kernel: [91343.367304]  ? wb_workfn+0x1a9/0x450
Oct 21 23:25:12 cohuatl kernel: [91343.370988]  wb_workfn+0x1a9/0x450
Oct 21 23:25:12 cohuatl kernel: [91343.374527]  process_one_work+0x177/0x350
Oct 21 23:25:12 cohuatl kernel: [91343.378701]  worker_thread+0x4d/0x3c0
Oct 21 23:25:12 cohuatl kernel: [91343.382481]  kthread+0xf8/0x130
Oct 21 23:25:12 cohuatl kernel: [91343.385771]  ? rescuer_thread+0x350/0x350
Oct 21 23:25:12 cohuatl kernel: [91343.390127]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 21 23:25:12 cohuatl kernel: [91343.395343]  ret_from_fork+0x35/0x40
[91464.070318] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
[91464.077453]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91464.085672] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91464.093619] kworker/u2:1    D    0  2363      2 0x80000000
[91464.099344] Workqueue: writeback wb_workfn (flush-8:0)
[91464.104617] Call Trace:
[91464.107193]  ? __schedule+0x3dc/0x860
[91464.110980]  schedule+0x32/0x80
[91464.114237]  io_schedule+0x12/0x40
[91464.117752]  __lock_page+0x119/0x160
[91464.121539]  ? page_cache_tree_insert+0xe0/0xe0
[91464.251976]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
[91464.258025]  ? zlook+0x15/0x70 [reiser4]
[91464.262161]  ? utmost_child_internal+0x45/0x80 [reiser4]
[91464.267716]  write_jnode_list+0x7f/0xb0 [reiser4]
[91464.272561]  reiser4_write_fq+0x81/0x230 [reiser4]
[91464.277628]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[91464.283267]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[91464.288441]  flush_some_atom+0x113/0x530 [reiser4]
[91464.293357]  reiser4_writeout+0x151/0x230 [reiser4]
[91464.298477]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[91464.304102]  writeback_sb_inodes+0x8f/0xb0
[91464.308424]  __writeback_inodes_wb+0x87/0xb0
[91464.312807]  wb_writeback+0x288/0x320
[91464.316591]  ? wb_workfn+0x1a9/0x450
[91464.320277]  wb_workfn+0x1a9/0x450
[91464.323795]  process_one_work+0x177/0x350
[91464.328028]  worker_thread+0x4d/0x3c0
[91464.331803]  kthread+0xf8/0x130
[91464.335059]  ? rescuer_thread+0x350/0x350
[91464.339193]  ? kthread_create_worker_on_cpu+0x70/0x70
[91464.344366]  ret_from_fork+0x35/0x40
[91464.348068] INFO: task freshclam:3158 blocked for more than 120 seconds.
[91464.354886]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91464.363301] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91464.371245] freshclam       D    0  3158      1 0x00000000
[91464.376853] Call Trace:
[91464.379417]  ? __schedule+0x3dc/0x860
[91464.383226]  schedule+0x32/0x80
[91464.386574]  io_schedule+0x12/0x40
[91464.390093]  wait_on_page_bit+0x116/0x160
[91464.394226]  ? page_cache_tree_insert+0xe0/0xe0
[91464.398894]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
[91464.404679]  reiser4_uncapture_page+0x9c/0x160 [reiser4]
[91464.410116]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
[91464.415565]  truncate_cleanup_page+0x6f/0xc0
[91464.420008]  truncate_inode_pages_range+0x220/0x830
[91464.425020]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
[91464.430642]  kill_hook_extent+0x157/0x4a0 [reiser4]
[91464.435649]  ? create_hook_extent+0xd0/0xd0 [reiser4]
[91464.440824]  call_kill_hooks+0xa7/0xe0 [reiser4]
[91464.445682]  ? kill_units+0x80/0x80 [reiser4]
[91464.450209]  ? kill_head+0x20/0x20 [reiser4]
[91464.454607]  ? keyeq+0x20/0x20 [reiser4]
[91464.458649]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
[91464.464610]  ? lock_object+0x96/0x100 [reiser4]
[91464.469300]  ? _cond_resched+0x16/0x40
[91464.473186]  ? jload_gfp+0x73/0x1d0 [reiser4]
[91464.477676]  kill_node40+0x3d/0xe0 [reiser4]
[91464.482070]  carry_cut+0x54/0x90 [reiser4]
[91464.486286]  reiser4_carry+0x1c4/0x360 [reiser4]
[91464.491031]  ? reiser4_add_carry+0x24/0x40 [reiser4]
[91464.496121]  kill_node_content+0x143/0x210 [reiser4]
[91464.501213]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
[91464.506760]  ? reiser4_delete_node+0x220/0x220 [reiser4]
[91464.512357]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
[91464.517896]  ? validate_extended_coord+0x70/0x70 [reiser4]
[91464.523507]  cut_file_items+0x11f/0x1c0 [reiser4]
[91464.528476]  shorten_file+0x31/0x2b0 [reiser4]
[91464.533043]  delete_object_unix_file+0x3a/0xa0 [reiser4]
[91464.538601]  reiser4_evict_inode+0x80/0xd0 [reiser4]
[91464.543809]  evict+0xc1/0x1c0
[91464.546944]  do_unlinkat+0x13f/0x320
[91464.550663]  do_syscall_64+0x55/0x110
[91464.554482]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[91464.559658] RIP: 0033:0x7ff25aee8ea7
[91464.563345] RSP: 002b:00007ffd609c6048 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[91464.571030] RAX: ffffffffffffffda RBX: 000056466206a110 RCX: 00007ff25aee8ea7
[91464.578278] RDX: 00007ffd609c6190 RSI: 00007ffd609c6190 RDI: 000056466206a110
[91464.585528] RBP: 0000564662084b70 R08: 0000564662084ce3 R09: 0000000000000071
[91464.592783] R10: 0000000000000073 R11: 0000000000000246 R12: 000056466206a310
[91464.600052] R13: 00007ffd609c6190 R14: 00007ff25c2616d8 R15: 0000564662084ce3
Oct 21 23:27:13 cohuatl kernel: [91464.070318] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
Oct 21 23:27:13 cohuatl kernel: [91464.077453]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:27:13 cohuatl kernel: [91464.085672] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:27:13 cohuatl kernel: [91464.093619] kworker/u2:1    D    0  2363      2 0x80000000
Oct 21 23:27:13 cohuatl kernel: [91464.099344] Workqueue: writeback wb_workfn (flush-8:0)
Oct 21 23:27:13 cohuatl kernel: [91464.104617] Call Trace:
Oct 21 23:27:13 cohuatl kernel: [91464.107193]  ? __schedule+0x3dc/0x860
Oct 21 23:27:13 cohuatl kernel: [91464.110980]  schedule+0x32/0x80
Oct 21 23:27:13 cohuatl kernel: [91464.114237]  io_schedule+0x12/0x40
Oct 21 23:27:13 cohuatl kernel: [91464.117752]  __lock_page+0x119/0x160
Oct 21 23:27:13 cohuatl kernel: [91464.121539]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:27:13 cohuatl kernel: [91464.251976]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.258025]  ? zlook+0x15/0x70 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.262161]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.267716]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.272561]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.277628]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.283267]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.288441]  flush_some_atom+0x113/0x530 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.293357]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.298477]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.304102]  writeback_sb_inodes+0x8f/0xb0
Oct 21 23:27:13 cohuatl kernel: [91464.308424]  __writeback_inodes_wb+0x87/0xb0
Oct 21 23:27:13 cohuatl kernel: [91464.312807]  wb_writeback+0x288/0x320
Oct 21 23:27:13 cohuatl kernel: [91464.316591]  ? wb_workfn+0x1a9/0x450
Oct 21 23:27:13 cohuatl kernel: [91464.320277]  wb_workfn+0x1a9/0x450
Oct 21 23:27:13 cohuatl kernel: [91464.323795]  process_one_work+0x177/0x350
Oct 21 23:27:13 cohuatl kernel: [91464.328028]  worker_thread+0x4d/0x3c0
Oct 21 23:27:13 cohuatl kernel: [91464.331803]  kthread+0xf8/0x130
Oct 21 23:27:13 cohuatl kernel: [91464.335059]  ? rescuer_thread+0x350/0x350
Oct 21 23:27:13 cohuatl kernel: [91464.339193]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 21 23:27:13 cohuatl kernel: [91464.344366]  ret_from_fork+0x35/0x40
Oct 21 23:27:13 cohuatl kernel: [91464.348068] INFO: task freshclam:3158 blocked for more than 120 seconds.
Oct 21 23:27:13 cohuatl kernel: [91464.354886]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:27:13 cohuatl kernel: [91464.363301] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:27:13 cohuatl kernel: [91464.371245] freshclam       D    0  3158      1 0x00000000
Oct 21 23:27:13 cohuatl kernel: [91464.376853] Call Trace:
Oct 21 23:27:13 cohuatl kernel: [91464.379417]  ? __schedule+0x3dc/0x860
Oct 21 23:27:13 cohuatl kernel: [91464.383226]  schedule+0x32/0x80
Oct 21 23:27:13 cohuatl kernel: [91464.386574]  io_schedule+0x12/0x40
Oct 21 23:27:13 cohuatl kernel: [91464.390093]  wait_on_page_bit+0x116/0x160
Oct 21 23:27:13 cohuatl kernel: [91464.394226]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:27:13 cohuatl kernel: [91464.398894]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.404679]  reiser4_uncapture_page+0x9c/0x160 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.410116]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.415565]  truncate_cleanup_page+0x6f/0xc0
Oct 21 23:27:13 cohuatl kernel: [91464.420008]  truncate_inode_pages_range+0x220/0x830
Oct 21 23:27:13 cohuatl kernel: [91464.425020]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.430642]  kill_hook_extent+0x157/0x4a0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.435649]  ? create_hook_extent+0xd0/0xd0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.440824]  call_kill_hooks+0xa7/0xe0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.445682]  ? kill_units+0x80/0x80 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.450209]  ? kill_head+0x20/0x20 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.454607]  ? keyeq+0x20/0x20 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.458649]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.464610]  ? lock_object+0x96/0x100 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.469300]  ? _cond_resched+0x16/0x40
Oct 21 23:27:13 cohuatl kernel: [91464.473186]  ? jload_gfp+0x73/0x1d0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.477676]  kill_node40+0x3d/0xe0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.482070]  carry_cut+0x54/0x90 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.486286]  reiser4_carry+0x1c4/0x360 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.491031]  ? reiser4_add_carry+0x24/0x40 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.496121]  kill_node_content+0x143/0x210 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.501213]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.506760]  ? reiser4_delete_node+0x220/0x220 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.512357]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.517896]  ? validate_extended_coord+0x70/0x70 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.523507]  cut_file_items+0x11f/0x1c0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.528476]  shorten_file+0x31/0x2b0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.533043]  delete_object_unix_file+0x3a/0xa0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.538601]  reiser4_evict_inode+0x80/0xd0 [reiser4]
Oct 21 23:27:13 cohuatl kernel: [91464.543809]  evict+0xc1/0x1c0
Oct 21 23:27:13 cohuatl kernel: [91464.546944]  do_unlinkat+0x13f/0x320
Oct 21 23:27:13 cohuatl kernel: [91464.550663]  do_syscall_64+0x55/0x110
Oct 21 23:27:13 cohuatl kernel: [91464.554482]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 21 23:27:13 cohuatl kernel: [91464.559658] RIP: 0033:0x7ff25aee8ea7
Oct 21 23:27:13 cohuatl kernel: [91464.563345] RSP: 002b:00007ffd609c6048 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
Oct 21 23:27:13 cohuatl kernel: [91464.571030] RAX: ffffffffffffffda RBX: 000056466206a110 RCX: 00007ff25aee8ea7
Oct 21 23:27:13 cohuatl kernel: [91464.578278] RDX: 00007ffd609c6190 RSI: 00007ffd609c6190 RDI: 000056466206a110
Oct 21 23:27:13 cohuatl kernel: [91464.585528] RBP: 0000564662084b70 R08: 0000564662084ce3 R09: 0000000000000071
Oct 21 23:27:13 cohuatl kernel: [91464.592783] R10: 0000000000000073 R11: 0000000000000246 R12: 000056466206a310
Oct 21 23:27:13 cohuatl kernel: [91464.600052] R13: 00007ffd609c6190 R14: 00007ff25c2616d8 R15: 0000564662084ce3
[91584.893409] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
[91584.900540]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91584.908750] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91584.916693] kworker/u2:1    D    0  2363      2 0x80000000
[91584.922313] Workqueue: writeback wb_workfn (flush-8:0)
[91584.927568] Call Trace:
[91584.930137]  ? __schedule+0x3dc/0x860
[91584.933929]  schedule+0x32/0x80
[91584.937193]  io_schedule+0x12/0x40
[91584.940721]  __lock_page+0x119/0x160
[91584.944421]  ? page_cache_tree_insert+0xe0/0xe0
[91584.994712]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
[91585.000787]  ? zlook+0x15/0x70 [reiser4]
[91585.004844]  ? utmost_child_internal+0x45/0x80 [reiser4]
[91585.010308]  write_jnode_list+0x7f/0xb0 [reiser4]
[91585.015136]  reiser4_write_fq+0x81/0x230 [reiser4]
[91585.020046]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[91585.025569]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[91585.030742]  flush_some_atom+0x113/0x530 [reiser4]
[91585.035688]  reiser4_writeout+0x151/0x230 [reiser4]
[91585.040695]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[91585.046355]  writeback_sb_inodes+0x8f/0xb0
[91585.050583]  __writeback_inodes_wb+0x87/0xb0
[91585.054970]  wb_writeback+0x288/0x320
[91585.058750]  ? wb_workfn+0x1a9/0x450
[91585.062562]  wb_workfn+0x1a9/0x450
[91585.066091]  process_one_work+0x177/0x350
[91585.070218]  worker_thread+0x4d/0x3c0
[91585.073996]  kthread+0xf8/0x130
[91585.077250]  ? rescuer_thread+0x350/0x350
[91585.081375]  ? kthread_create_worker_on_cpu+0x70/0x70
[91585.086595]  ret_from_fork+0x35/0x40
[91585.090293] INFO: task freshclam:3158 blocked for more than 120 seconds.
[91585.097115]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91585.105411] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91585.113364] freshclam       D    0  3158      1 0x00000000
[91585.119021] Call Trace:
[91585.121601]  ? __schedule+0x3dc/0x860
[91585.125429]  schedule+0x32/0x80
[91585.128692]  io_schedule+0x12/0x40
[91585.132232]  wait_on_page_bit+0x116/0x160
[91585.136416]  ? page_cache_tree_insert+0xe0/0xe0
[91585.141085]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
[91585.146882]  reiser4_uncapture_page+0x9c/0x160 [reiser4]
[91585.152345]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
[91585.157828]  truncate_cleanup_page+0x6f/0xc0
[91585.162219]  truncate_inode_pages_range+0x220/0x830
[91585.167234]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
[91585.172777]  kill_hook_extent+0x157/0x4a0 [reiser4]
[91585.177784]  ? create_hook_extent+0xd0/0xd0 [reiser4]
[91585.182977]  call_kill_hooks+0xa7/0xe0 [reiser4]
[91585.187730]  ? kill_units+0x80/0x80 [reiser4]
[91585.192214]  ? kill_head+0x20/0x20 [reiser4]
[91585.196606]  ? keyeq+0x20/0x20 [reiser4]
[91585.200696]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
[91585.206751]  ? lock_object+0x96/0x100 [reiser4]
[91585.211396]  ? _cond_resched+0x16/0x40
[91585.215390]  ? jload_gfp+0x73/0x1d0 [reiser4]
[91585.219870]  kill_node40+0x3d/0xe0 [reiser4]
[91585.224281]  carry_cut+0x54/0x90 [reiser4]
[91585.228503]  reiser4_carry+0x1c4/0x360 [reiser4]
[91585.233246]  ? reiser4_add_carry+0x24/0x40 [reiser4]
[91585.238329]  kill_node_content+0x143/0x210 [reiser4]
[91585.243433]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
[91585.248975]  ? reiser4_delete_node+0x220/0x220 [reiser4]
[91585.254410]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
[91585.260083]  ? validate_extended_coord+0x70/0x70 [reiser4]
[91585.265752]  cut_file_items+0x11f/0x1c0 [reiser4]
[91585.270597]  shorten_file+0x31/0x2b0 [reiser4]
[91585.275227]  delete_object_unix_file+0x3a/0xa0 [reiser4]
[91585.280688]  reiser4_evict_inode+0x80/0xd0 [reiser4]
[91585.285828]  evict+0xc1/0x1c0
[91585.288922]  do_unlinkat+0x13f/0x320
[91585.292617]  do_syscall_64+0x55/0x110
[91585.296392]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[91585.301560] RIP: 0033:0x7ff25aee8ea7
[91585.305246] RSP: 002b:00007ffd609c6048 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[91585.312941] RAX: ffffffffffffffda RBX: 000056466206a110 RCX: 00007ff25aee8ea7
[91585.320194] RDX: 00007ffd609c6190 RSI: 00007ffd609c6190 RDI: 000056466206a110
[91585.327455] RBP: 0000564662084b70 R08: 0000564662084ce3 R09: 0000000000000071
[91585.334758] R10: 0000000000000073 R11: 0000000000000246 R12: 000056466206a310
[91585.342033] R13: 00007ffd609c6190 R14: 00007ff25c2616d8 R15: 0000564662084ce3
Oct 21 23:29:14 cohuatl kernel: [91584.893409] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
Oct 21 23:29:14 cohuatl kernel: [91584.900540]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:29:14 cohuatl kernel: [91584.908750] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:29:14 cohuatl kernel: [91584.916693] kworker/u2:1    D    0  2363      2 0x80000000
Oct 21 23:29:14 cohuatl kernel: [91584.922313] Workqueue: writeback wb_workfn (flush-8:0)
Oct 21 23:29:14 cohuatl kernel: [91584.927568] Call Trace:
Oct 21 23:29:14 cohuatl kernel: [91584.930137]  ? __schedule+0x3dc/0x860
Oct 21 23:29:14 cohuatl kernel: [91584.933929]  schedule+0x32/0x80
Oct 21 23:29:14 cohuatl kernel: [91584.937193]  io_schedule+0x12/0x40
Oct 21 23:29:14 cohuatl kernel: [91584.940721]  __lock_page+0x119/0x160
Oct 21 23:29:14 cohuatl kernel: [91584.944421]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:29:14 cohuatl kernel: [91584.994712]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.000787]  ? zlook+0x15/0x70 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.004844]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.010308]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.015136]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.020046]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.025569]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.030742]  flush_some_atom+0x113/0x530 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.035688]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.040695]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.046355]  writeback_sb_inodes+0x8f/0xb0
Oct 21 23:29:14 cohuatl kernel: [91585.050583]  __writeback_inodes_wb+0x87/0xb0
Oct 21 23:29:14 cohuatl kernel: [91585.054970]  wb_writeback+0x288/0x320
Oct 21 23:29:14 cohuatl kernel: [91585.058750]  ? wb_workfn+0x1a9/0x450
Oct 21 23:29:14 cohuatl kernel: [91585.062562]  wb_workfn+0x1a9/0x450
Oct 21 23:29:14 cohuatl kernel: [91585.066091]  process_one_work+0x177/0x350
Oct 21 23:29:14 cohuatl kernel: [91585.070218]  worker_thread+0x4d/0x3c0
Oct 21 23:29:14 cohuatl kernel: [91585.073996]  kthread+0xf8/0x130
Oct 21 23:29:14 cohuatl kernel: [91585.077250]  ? rescuer_thread+0x350/0x350
Oct 21 23:29:14 cohuatl kernel: [91585.081375]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 21 23:29:14 cohuatl kernel: [91585.086595]  ret_from_fork+0x35/0x40
Oct 21 23:29:14 cohuatl kernel: [91585.090293] INFO: task freshclam:3158 blocked for more than 120 seconds.
Oct 21 23:29:14 cohuatl kernel: [91585.097115]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:29:14 cohuatl kernel: [91585.105411] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:29:14 cohuatl kernel: [91585.113364] freshclam       D    0  3158      1 0x00000000
Oct 21 23:29:14 cohuatl kernel: [91585.119021] Call Trace:
Oct 21 23:29:14 cohuatl kernel: [91585.121601]  ? __schedule+0x3dc/0x860
Oct 21 23:29:14 cohuatl kernel: [91585.125429]  schedule+0x32/0x80
Oct 21 23:29:14 cohuatl kernel: [91585.128692]  io_schedule+0x12/0x40
Oct 21 23:29:14 cohuatl kernel: [91585.132232]  wait_on_page_bit+0x116/0x160
Oct 21 23:29:14 cohuatl kernel: [91585.136416]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:29:14 cohuatl kernel: [91585.141085]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.146882]  reiser4_uncapture_page+0x9c/0x160 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.152345]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.157828]  truncate_cleanup_page+0x6f/0xc0
Oct 21 23:29:14 cohuatl kernel: [91585.162219]  truncate_inode_pages_range+0x220/0x830
Oct 21 23:29:14 cohuatl kernel: [91585.167234]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.172777]  kill_hook_extent+0x157/0x4a0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.177784]  ? create_hook_extent+0xd0/0xd0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.182977]  call_kill_hooks+0xa7/0xe0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.187730]  ? kill_units+0x80/0x80 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.192214]  ? kill_head+0x20/0x20 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.196606]  ? keyeq+0x20/0x20 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.200696]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.206751]  ? lock_object+0x96/0x100 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.211396]  ? _cond_resched+0x16/0x40
Oct 21 23:29:14 cohuatl kernel: [91585.215390]  ? jload_gfp+0x73/0x1d0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.219870]  kill_node40+0x3d/0xe0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.224281]  carry_cut+0x54/0x90 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.228503]  reiser4_carry+0x1c4/0x360 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.233246]  ? reiser4_add_carry+0x24/0x40 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.238329]  kill_node_content+0x143/0x210 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.243433]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.248975]  ? reiser4_delete_node+0x220/0x220 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.254410]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.260083]  ? validate_extended_coord+0x70/0x70 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.265752]  cut_file_items+0x11f/0x1c0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.270597]  shorten_file+0x31/0x2b0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.275227]  delete_object_unix_file+0x3a/0xa0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.280688]  reiser4_evict_inode+0x80/0xd0 [reiser4]
Oct 21 23:29:14 cohuatl kernel: [91585.285828]  evict+0xc1/0x1c0
Oct 21 23:29:14 cohuatl kernel: [91585.288922]  do_unlinkat+0x13f/0x320
Oct 21 23:29:14 cohuatl kernel: [91585.292617]  do_syscall_64+0x55/0x110
Oct 21 23:29:14 cohuatl kernel: [91585.296392]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 21 23:29:14 cohuatl kernel: [91585.301560] RIP: 0033:0x7ff25aee8ea7
Oct 21 23:29:14 cohuatl kernel: [91585.305246] RSP: 002b:00007ffd609c6048 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
Oct 21 23:29:14 cohuatl kernel: [91585.312941] RAX: ffffffffffffffda RBX: 000056466206a110 RCX: 00007ff25aee8ea7
Oct 21 23:29:14 cohuatl kernel: [91585.320194] RDX: 00007ffd609c6190 RSI: 00007ffd609c6190 RDI: 000056466206a110
Oct 21 23:29:14 cohuatl kernel: [91585.327455] RBP: 0000564662084b70 R08: 0000564662084ce3 R09: 0000000000000071
Oct 21 23:29:14 cohuatl kernel: [91585.334758] R10: 0000000000000073 R11: 0000000000000246 R12: 000056466206a310
Oct 21 23:29:14 cohuatl kernel: [91585.342033] R13: 00007ffd609c6190 R14: 00007ff25c2616d8 R15: 0000564662084ce3
[91705.716488] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
[91705.723641]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91705.731907] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91705.739882] kworker/u2:1    D    0  2363      2 0x80000000
[91705.745501] Workqueue: writeback wb_workfn (flush-8:0)
[91705.750881] Call Trace:
[91705.753615]  ? __schedule+0x3dc/0x860
[91705.757513]  schedule+0x32/0x80
[91705.760779]  io_schedule+0x12/0x40
[91705.764298]  __lock_page+0x119/0x160
[91705.768000]  ? page_cache_tree_insert+0xe0/0xe0
[91705.772665]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
[91705.778617]  ? zlook+0x15/0x70 [reiser4]
[91705.782677]  ? utmost_child_internal+0x45/0x80 [reiser4]
[91705.788136]  write_jnode_list+0x7f/0xb0 [reiser4]
[91705.792981]  reiser4_write_fq+0x81/0x230 [reiser4]
[91705.797909]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[91705.803435]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[91705.808720]  flush_some_atom+0x113/0x530 [reiser4]
[91705.813658]  reiser4_writeout+0x151/0x230 [reiser4]
[91705.818671]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[91705.824282]  writeback_sb_inodes+0x8f/0xb0
[91705.828500]  __writeback_inodes_wb+0x87/0xb0
[91705.832886]  wb_writeback+0x288/0x320
[91705.836665]  ? wb_workfn+0x1a9/0x450
[91705.840357]  wb_workfn+0x1a9/0x450
[91705.843895]  process_one_work+0x177/0x350
[91705.848021]  worker_thread+0x4d/0x3c0
[91705.851798]  kthread+0xf8/0x130
[91705.855066]  ? rescuer_thread+0x350/0x350
[91705.859197]  ? kthread_create_worker_on_cpu+0x70/0x70
[91705.864379]  ret_from_fork+0x35/0x40
[91705.868091] INFO: task freshclam:3158 blocked for more than 120 seconds.
[91705.875004]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91705.883343] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91705.891523] freshclam       D    0  3158      1 0x00000000
[91705.897126] Call Trace:
[91705.899694]  ? __schedule+0x3dc/0x860
[91705.903487]  schedule+0x32/0x80
[91705.906755]  io_schedule+0x12/0x40
[91705.910274]  wait_on_page_bit+0x116/0x160
[91705.914399]  ? page_cache_tree_insert+0xe0/0xe0
[91705.919080]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
[91705.924987]  reiser4_uncapture_page+0x9c/0x160 [reiser4]
[91705.930538]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
[91705.935982]  truncate_cleanup_page+0x6f/0xc0
[91705.940382]  truncate_inode_pages_range+0x220/0x830
[91705.945415]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
[91705.950989]  kill_hook_extent+0x157/0x4a0 [reiser4]
[91705.955999]  ? create_hook_extent+0xd0/0xd0 [reiser4]
[91705.961186]  call_kill_hooks+0xa7/0xe0 [reiser4]
[91705.965924]  ? kill_units+0x80/0x80 [reiser4]
[91705.970400]  ? kill_head+0x20/0x20 [reiser4]
[91705.974792]  ? keyeq+0x20/0x20 [reiser4]
[91705.978847]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
[91705.987731]  ? lock_object+0x96/0x100 [reiser4]
[91705.992389]  ? _cond_resched+0x16/0x40
[91705.996256]  ? jload_gfp+0x73/0x1d0 [reiser4]
[91706.000746]  kill_node40+0x3d/0xe0 [reiser4]
[91706.005260]  carry_cut+0x54/0x90 [reiser4]
[91706.009501]  reiser4_carry+0x1c4/0x360 [reiser4]
[91706.014253]  ? reiser4_add_carry+0x24/0x40 [reiser4]
[91706.019341]  kill_node_content+0x143/0x210 [reiser4]
[91706.024629]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
[91706.030157]  ? reiser4_delete_node+0x220/0x220 [reiser4]
[91706.035608]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
[91706.041197]  ? validate_extended_coord+0x70/0x70 [reiser4]
[91706.046824]  cut_file_items+0x11f/0x1c0 [reiser4]
[91706.051660]  shorten_file+0x31/0x2b0 [reiser4]
[91706.056232]  delete_object_unix_file+0x3a/0xa0 [reiser4]
[91706.061677]  reiser4_evict_inode+0x80/0xd0 [reiser4]
[91706.066950]  evict+0xc1/0x1c0
[91706.070041]  do_unlinkat+0x13f/0x320
[91706.073760]  do_syscall_64+0x55/0x110
[91706.077553]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[91706.082847] RIP: 0033:0x7ff25aee8ea7
[91706.086548] RSP: 002b:00007ffd609c6048 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[91706.094245] RAX: ffffffffffffffda RBX: 000056466206a110 RCX: 00007ff25aee8ea7
[91706.101492] RDX: 00007ffd609c6190 RSI: 00007ffd609c6190 RDI: 000056466206a110
[91706.108744] RBP: 0000564662084b70 R08: 0000564662084ce3 R09: 0000000000000071
[91706.115997] R10: 0000000000000073 R11: 0000000000000246 R12: 000056466206a310
[91706.123255] R13: 00007ffd609c6190 R14: 00007ff25c2616d8 R15: 0000564662084ce3
Oct 21 23:31:14 cohuatl kernel: [91705.716488] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
Oct 21 23:31:14 cohuatl kernel: [91705.723641]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:31:14 cohuatl kernel: [91705.731907] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:31:14 cohuatl kernel: [91705.739882] kworker/u2:1    D    0  2363      2 0x80000000
Oct 21 23:31:14 cohuatl kernel: [91705.745501] Workqueue: writeback wb_workfn (flush-8:0)
Oct 21 23:31:14 cohuatl kernel: [91705.750881] Call Trace:
Oct 21 23:31:14 cohuatl kernel: [91705.753615]  ? __schedule+0x3dc/0x860
Oct 21 23:31:14 cohuatl kernel: [91705.757513]  schedule+0x32/0x80
Oct 21 23:31:14 cohuatl kernel: [91705.760779]  io_schedule+0x12/0x40
Oct 21 23:31:14 cohuatl kernel: [91705.764298]  __lock_page+0x119/0x160
Oct 21 23:31:14 cohuatl kernel: [91705.768000]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:31:14 cohuatl kernel: [91705.772665]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.778617]  ? zlook+0x15/0x70 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.782677]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.788136]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.792981]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.797909]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.803435]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.808720]  flush_some_atom+0x113/0x530 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.813658]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.818671]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.824282]  writeback_sb_inodes+0x8f/0xb0
Oct 21 23:31:14 cohuatl kernel: [91705.828500]  __writeback_inodes_wb+0x87/0xb0
Oct 21 23:31:14 cohuatl kernel: [91705.832886]  wb_writeback+0x288/0x320
Oct 21 23:31:14 cohuatl kernel: [91705.836665]  ? wb_workfn+0x1a9/0x450
Oct 21 23:31:14 cohuatl kernel: [91705.840357]  wb_workfn+0x1a9/0x450
Oct 21 23:31:14 cohuatl kernel: [91705.843895]  process_one_work+0x177/0x350
Oct 21 23:31:14 cohuatl kernel: [91705.848021]  worker_thread+0x4d/0x3c0
Oct 21 23:31:14 cohuatl kernel: [91705.851798]  kthread+0xf8/0x130
Oct 21 23:31:14 cohuatl kernel: [91705.855066]  ? rescuer_thread+0x350/0x350
Oct 21 23:31:14 cohuatl kernel: [91705.859197]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 21 23:31:14 cohuatl kernel: [91705.864379]  ret_from_fork+0x35/0x40
Oct 21 23:31:14 cohuatl kernel: [91705.868091] INFO: task freshclam:3158 blocked for more than 120 seconds.
Oct 21 23:31:14 cohuatl kernel: [91705.875004]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:31:14 cohuatl kernel: [91705.883343] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:31:14 cohuatl kernel: [91705.891523] freshclam       D    0  3158      1 0x00000000
Oct 21 23:31:14 cohuatl kernel: [91705.897126] Call Trace:
Oct 21 23:31:14 cohuatl kernel: [91705.899694]  ? __schedule+0x3dc/0x860
Oct 21 23:31:14 cohuatl kernel: [91705.903487]  schedule+0x32/0x80
Oct 21 23:31:14 cohuatl kernel: [91705.906755]  io_schedule+0x12/0x40
Oct 21 23:31:14 cohuatl kernel: [91705.910274]  wait_on_page_bit+0x116/0x160
Oct 21 23:31:14 cohuatl kernel: [91705.914399]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:31:14 cohuatl kernel: [91705.919080]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.924987]  reiser4_uncapture_page+0x9c/0x160 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.930538]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.935982]  truncate_cleanup_page+0x6f/0xc0
Oct 21 23:31:14 cohuatl kernel: [91705.940382]  truncate_inode_pages_range+0x220/0x830
Oct 21 23:31:14 cohuatl kernel: [91705.945415]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.950989]  kill_hook_extent+0x157/0x4a0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.955999]  ? create_hook_extent+0xd0/0xd0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.961186]  call_kill_hooks+0xa7/0xe0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.965924]  ? kill_units+0x80/0x80 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.970400]  ? kill_head+0x20/0x20 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.974792]  ? keyeq+0x20/0x20 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.978847]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.987731]  ? lock_object+0x96/0x100 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91705.992389]  ? _cond_resched+0x16/0x40
Oct 21 23:31:14 cohuatl kernel: [91705.996256]  ? jload_gfp+0x73/0x1d0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.000746]  kill_node40+0x3d/0xe0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.005260]  carry_cut+0x54/0x90 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.009501]  reiser4_carry+0x1c4/0x360 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.014253]  ? reiser4_add_carry+0x24/0x40 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.019341]  kill_node_content+0x143/0x210 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.024629]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.030157]  ? reiser4_delete_node+0x220/0x220 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.035608]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.041197]  ? validate_extended_coord+0x70/0x70 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.046824]  cut_file_items+0x11f/0x1c0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.051660]  shorten_file+0x31/0x2b0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.056232]  delete_object_unix_file+0x3a/0xa0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.061677]  reiser4_evict_inode+0x80/0xd0 [reiser4]
Oct 21 23:31:14 cohuatl kernel: [91706.066950]  evict+0xc1/0x1c0
Oct 21 23:31:14 cohuatl kernel: [91706.070041]  do_unlinkat+0x13f/0x320
Oct 21 23:31:14 cohuatl kernel: [91706.073760]  do_syscall_64+0x55/0x110
Oct 21 23:31:14 cohuatl kernel: [91706.077553]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 21 23:31:14 cohuatl kernel: [91706.082847] RIP: 0033:0x7ff25aee8ea7
Oct 21 23:31:14 cohuatl kernel: [91706.086548] RSP: 002b:00007ffd609c6048 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
Oct 21 23:31:14 cohuatl kernel: [91706.094245] RAX: ffffffffffffffda RBX: 000056466206a110 RCX: 00007ff25aee8ea7
Oct 21 23:31:14 cohuatl kernel: [91706.101492] RDX: 00007ffd609c6190 RSI: 00007ffd609c6190 RDI: 000056466206a110
Oct 21 23:31:14 cohuatl kernel: [91706.108744] RBP: 0000564662084b70 R08: 0000564662084ce3 R09: 0000000000000071
Oct 21 23:31:14 cohuatl kernel: [91706.115997] R10: 0000000000000073 R11: 0000000000000246 R12: 000056466206a310
Oct 21 23:31:14 cohuatl kernel: [91706.123255] R13: 00007ffd609c6190 R14: 00007ff25c2616d8 R15: 0000564662084ce3
[91826.539610] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
[91826.546911]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91826.555133] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91826.563135] kworker/u2:1    D    0  2363      2 0x80000000
[91826.568868] Workqueue: writeback wb_workfn (flush-8:0)
[91826.574119] Call Trace:
[91826.576699]  ? __schedule+0x3dc/0x860
[91826.580569]  schedule+0x32/0x80
[91826.583841]  io_schedule+0x12/0x40
[91826.587362]  __lock_page+0x119/0x160
[91826.591109]  ? page_cache_tree_insert+0xe0/0xe0
[91826.725946]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
[91826.731906]  ? zlook+0x15/0x70 [reiser4]
[91826.736084]  ? utmost_child_internal+0x45/0x80 [reiser4]
[91826.741522]  write_jnode_list+0x7f/0xb0 [reiser4]
[91826.746369]  reiser4_write_fq+0x81/0x230 [reiser4]
[91826.751291]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[91826.756833]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[91826.762034]  flush_some_atom+0x113/0x530 [reiser4]
[91826.766973]  reiser4_writeout+0x151/0x230 [reiser4]
[91826.772094]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[91826.777819]  writeback_sb_inodes+0x8f/0xb0
[91826.782096]  __writeback_inodes_wb+0x87/0xb0
[91826.786489]  wb_writeback+0x288/0x320
[91826.790428]  ? wb_workfn+0x1a9/0x450
[91826.794124]  wb_workfn+0x1a9/0x450
[91826.797657]  process_one_work+0x177/0x350
[91826.801795]  worker_thread+0x4d/0x3c0
[91826.805577]  kthread+0xf8/0x130
[91826.808844]  ? rescuer_thread+0x350/0x350
[91826.812990]  ? kthread_create_worker_on_cpu+0x70/0x70
[91826.818285]  ret_from_fork+0x35/0x40
[91826.821986] INFO: task freshclam:3158 blocked for more than 120 seconds.
[91826.828799]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91826.837060] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91826.845009] freshclam       D    0  3158      1 0x00000000
[91826.850757] Call Trace:
[91826.853326]  ? __schedule+0x3dc/0x860
[91826.857104]  schedule+0x32/0x80
[91826.860360]  io_schedule+0x12/0x40
[91826.863875]  wait_on_page_bit+0x116/0x160
[91826.868012]  ? page_cache_tree_insert+0xe0/0xe0
[91826.872673]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
[91826.878473]  reiser4_uncapture_page+0x9c/0x160 [reiser4]
[91826.883924]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
[91826.889352]  truncate_cleanup_page+0x6f/0xc0
[91826.893734]  truncate_inode_pages_range+0x220/0x830
[91826.898737]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
[91826.904274]  kill_hook_extent+0x157/0x4a0 [reiser4]
[91826.909277]  ? create_hook_extent+0xd0/0xd0 [reiser4]
[91826.914448]  call_kill_hooks+0xa7/0xe0 [reiser4]
[91826.919350]  ? kill_units+0x80/0x80 [reiser4]
[91826.923847]  ? kill_head+0x20/0x20 [reiser4]
[91826.928688]  ? keyeq+0x20/0x20 [reiser4]
[91826.932753]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
[91826.938712]  ? lock_object+0x96/0x100 [reiser4]
[91826.943444]  ? _cond_resched+0x16/0x40
[91826.947321]  ? jload_gfp+0x73/0x1d0 [reiser4]
[91826.951806]  kill_node40+0x3d/0xe0 [reiser4]
[91826.956249]  carry_cut+0x54/0x90 [reiser4]
[91826.960476]  reiser4_carry+0x1c4/0x360 [reiser4]
[91826.965232]  ? reiser4_add_carry+0x24/0x40 [reiser4]
[91826.970323]  kill_node_content+0x143/0x210 [reiser4]
[91826.977951]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
[91826.983490]  ? reiser4_delete_node+0x220/0x220 [reiser4]
[91826.988989]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
[91826.994535]  ? validate_extended_coord+0x70/0x70 [reiser4]
[91827.000161]  cut_file_items+0x11f/0x1c0 [reiser4]
[91827.004992]  shorten_file+0x31/0x2b0 [reiser4]
[91827.009558]  delete_object_unix_file+0x3a/0xa0 [reiser4]
[91827.015007]  reiser4_evict_inode+0x80/0xd0 [reiser4]
[91827.020103]  evict+0xc1/0x1c0
[91827.023180]  do_unlinkat+0x13f/0x320
[91827.026872]  do_syscall_64+0x55/0x110
[91827.030646]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[91827.035819] RIP: 0033:0x7ff25aee8ea7
[91827.039508] RSP: 002b:00007ffd609c6048 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[91827.047209] RAX: ffffffffffffffda RBX: 000056466206a110 RCX: 00007ff25aee8ea7
[91827.054475] RDX: 00007ffd609c6190 RSI: 00007ffd609c6190 RDI: 000056466206a110
[91827.061726] RBP: 0000564662084b70 R08: 0000564662084ce3 R09: 0000000000000071
[91827.069091] R10: 0000000000000073 R11: 0000000000000246 R12: 000056466206a310
[91827.076398] R13: 00007ffd609c6190 R14: 00007ff25c2616d8 R15: 0000564662084ce3
Oct 21 23:33:15 cohuatl kernel: [91826.539610] INFO: task kworker/u2:1:2363 blocked for more than 120 seconds.
Oct 21 23:33:15 cohuatl kernel: [91826.546911]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:33:15 cohuatl kernel: [91826.555133] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:33:15 cohuatl kernel: [91826.563135] kworker/u2:1    D    0  2363      2 0x80000000
Oct 21 23:33:15 cohuatl kernel: [91826.568868] Workqueue: writeback wb_workfn (flush-8:0)
Oct 21 23:33:15 cohuatl kernel: [91826.574119] Call Trace:
Oct 21 23:33:15 cohuatl kernel: [91826.576699]  ? __schedule+0x3dc/0x860
Oct 21 23:33:15 cohuatl kernel: [91826.580569]  schedule+0x32/0x80
Oct 21 23:33:15 cohuatl kernel: [91826.583841]  io_schedule+0x12/0x40
Oct 21 23:33:15 cohuatl kernel: [91826.587362]  __lock_page+0x119/0x160
Oct 21 23:33:15 cohuatl kernel: [91826.591109]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:33:15 cohuatl kernel: [91826.725946]  write_jnodes_to_disk_extent+0x373/0x510 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.731906]  ? zlook+0x15/0x70 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.736084]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.741522]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.746369]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.751291]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.756833]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.762034]  flush_some_atom+0x113/0x530 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.766973]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.772094]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.777819]  writeback_sb_inodes+0x8f/0xb0
Oct 21 23:33:15 cohuatl kernel: [91826.782096]  __writeback_inodes_wb+0x87/0xb0
Oct 21 23:33:15 cohuatl kernel: [91826.786489]  wb_writeback+0x288/0x320
Oct 21 23:33:15 cohuatl kernel: [91826.790428]  ? wb_workfn+0x1a9/0x450
Oct 21 23:33:15 cohuatl kernel: [91826.794124]  wb_workfn+0x1a9/0x450
Oct 21 23:33:15 cohuatl kernel: [91826.797657]  process_one_work+0x177/0x350
Oct 21 23:33:15 cohuatl kernel: [91826.801795]  worker_thread+0x4d/0x3c0
Oct 21 23:33:15 cohuatl kernel: [91826.805577]  kthread+0xf8/0x130
Oct 21 23:33:15 cohuatl kernel: [91826.808844]  ? rescuer_thread+0x350/0x350
Oct 21 23:33:15 cohuatl kernel: [91826.812990]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 21 23:33:15 cohuatl kernel: [91826.818285]  ret_from_fork+0x35/0x40
Oct 21 23:33:15 cohuatl kernel: [91826.821986] INFO: task freshclam:3158 blocked for more than 120 seconds.
Oct 21 23:33:15 cohuatl kernel: [91826.828799]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
Oct 21 23:33:15 cohuatl kernel: [91826.837060] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 21 23:33:15 cohuatl kernel: [91826.845009] freshclam       D    0  3158      1 0x00000000
Oct 21 23:33:15 cohuatl kernel: [91826.850757] Call Trace:
Oct 21 23:33:15 cohuatl kernel: [91826.853326]  ? __schedule+0x3dc/0x860
Oct 21 23:33:15 cohuatl kernel: [91826.857104]  schedule+0x32/0x80
Oct 21 23:33:15 cohuatl kernel: [91826.860360]  io_schedule+0x12/0x40
Oct 21 23:33:15 cohuatl kernel: [91826.863875]  wait_on_page_bit+0x116/0x160
Oct 21 23:33:15 cohuatl kernel: [91826.868012]  ? page_cache_tree_insert+0xe0/0xe0
Oct 21 23:33:15 cohuatl kernel: [91826.872673]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.878473]  reiser4_uncapture_page+0x9c/0x160 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.883924]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.889352]  truncate_cleanup_page+0x6f/0xc0
Oct 21 23:33:15 cohuatl kernel: [91826.893734]  truncate_inode_pages_range+0x220/0x830
Oct 21 23:33:15 cohuatl kernel: [91826.898737]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.904274]  kill_hook_extent+0x157/0x4a0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.909277]  ? create_hook_extent+0xd0/0xd0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.914448]  call_kill_hooks+0xa7/0xe0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.919350]  ? kill_units+0x80/0x80 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.923847]  ? kill_head+0x20/0x20 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.928688]  ? keyeq+0x20/0x20 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.932753]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.938712]  ? lock_object+0x96/0x100 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.943444]  ? _cond_resched+0x16/0x40
Oct 21 23:33:15 cohuatl kernel: [91826.947321]  ? jload_gfp+0x73/0x1d0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.951806]  kill_node40+0x3d/0xe0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.956249]  carry_cut+0x54/0x90 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.960476]  reiser4_carry+0x1c4/0x360 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.965232]  ? reiser4_add_carry+0x24/0x40 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.970323]  kill_node_content+0x143/0x210 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.977951]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.983490]  ? reiser4_delete_node+0x220/0x220 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.988989]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91826.994535]  ? validate_extended_coord+0x70/0x70 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91827.000161]  cut_file_items+0x11f/0x1c0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91827.004992]  shorten_file+0x31/0x2b0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91827.009558]  delete_object_unix_file+0x3a/0xa0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91827.015007]  reiser4_evict_inode+0x80/0xd0 [reiser4]
Oct 21 23:33:15 cohuatl kernel: [91827.020103]  evict+0xc1/0x1c0
Oct 21 23:33:15 cohuatl kernel: [91827.023180]  do_unlinkat+0x13f/0x320
Oct 21 23:33:15 cohuatl kernel: [91827.026872]  do_syscall_64+0x55/0x110
Oct 21 23:33:15 cohuatl kernel: [91827.030646]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 21 23:33:15 cohuatl kernel: [91827.035819] RIP: 0033:0x7ff25aee8ea7
Oct 21 23:33:15 cohuatl kernel: [91827.039508] RSP: 002b:00007ffd609c6048 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
Oct 21 23:33:15 cohuatl kernel: [91827.047209] RAX: ffffffffffffffda RBX: 000056466206a110 RCX: 00007ff25aee8ea7
Oct 21 23:33:15 cohuatl kernel: [91827.054475] RDX: 00007ffd609c6190 RSI: 00007ffd609c6190 RDI: 000056466206a110
Oct 21 23:33:15 cohuatl kernel: [91827.061726] RBP: 0000564662084b70 R08: 0000564662084ce3 R09: 0000000000000071
Oct 21 23:33:15 cohuatl kernel: [91827.069091] R10: 0000000000000073 R11: 0000000000000246 R12: 000056466206a310
Oct 21 23:33:15 cohuatl kernel: [91827.076398] R13: 00007ffd609c6190 R14: 00007ff25c2616d8 R15: 0000564662084ce3
[91947.362675] INFO: task ktxnmgrd:sda5:r:198 blocked for more than 120 seconds.
[91947.370089]       Not tainted 4.17.0-3+reiser4.0.2-amd64 #1 Debian 4.17.19-1+reiser4.0.2
[91947.378316] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[91947.386271] ktxnmgrd:sda5:r D    0   198      2 0x80000000
[91947.391925] Call Trace:
[91947.394497]  ? __schedule+0x3dc/0x860
[91947.398425]  ? longterm_lock_znode+0x45c/0x4f0 [reiser4]
[91947.404010]  schedule+0x32/0x80
[91947.407292]  reiser4_go_to_sleep+0x5d/0x90 [reiser4]
[91947.412425]  ? remove_wait_queue+0x60/0x60
[91947.469557]  reiser4_atom_wait_event+0xc4/0x140 [reiser4]
[91947.475119]  reiser4_write_fq+0x35/0x230 [reiser4]
[91947.480050]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[91947.485579]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[91947.490883]  commit_txnh+0x2e3/0x590 [reiser4]
[91947.495455]  reiser4_txn_restart+0x1e/0x80 [reiser4]
[91947.500564]  commit_some_atoms+0x152/0x1b0 [reiser4]
[91947.505658]  scan_mgr+0x41/0x70 [reiser4]
[91947.509796]  ktxnmgrd+0x130/0x1b0 [reiser4]
[91947.514098]  ? remove_wait_queue+0x60/0x60
[91947.518309]  kthread+0xf8/0x130
[91947.521578]  ? scan_mgr+0x70/0x70 [reiser4]
[91947.525877]  ? kthread_create_worker_on_cpu+0x70/0x70
[91947.531046]  ret_from_fork+0x35/0x40


As before, any insight is appreciated, as I am currently testing reiser4 -patched kernel 4.16.18-2 in the GCE instance.


Best Professional Regards.


P.S. Taking notice of the antipathy in the Debian Kernel developers list, I am leaving them out of the loop --even if I am using their kernel packaging to build 'Reiser4 the Debian Way'.

Official current Reiser4 resources:
< https://reiser4.wiki.kernel.org/ >
