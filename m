Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4237FECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 12:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B704520843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 12:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mixtli.metztli.it header.i=@mixtli.metztli.it header.b="zfloN+cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B704520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metztli.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJUUlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 16:41:32 -0400
Received: from mail7.static.mailgun.info ([104.130.122.7]:42849 "EHLO
        mail7.static.mailgun.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeJUUlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 16:41:31 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Oct 2018 16:41:30 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mixtli.metztli.it; q=dns/txt;
 s=mx; t=1540124840; h=From: Date: Message-Id: To: Subject: Sender;
 bh=FQ21CJqEJVIxHSNogbEThgOFqoH6YzHxtKsmtG1EoOk=; b=zfloN+cnXn3ySgE8bjSswR6SLrVRHD1UKn1V+nXnSprkqztKe/ngt9j3kCz3tSGt6elF8bMM
 ai+aIlbU2ScIZmpRVOXyHxTZF95CUkccq3UdhnhNIfQVKq3vCwcam6HUzeXZak63hjy+1XNF
 huD7YEwXGsWQ6v6VssGdoNvOfNk=
X-Mailgun-Sending-Ip: 104.130.122.7
X-Mailgun-Sid: WyIxYzIzYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjE3YjU0Il0=
Received: from huitzilopochtli.metztli-it.com (99-130-254-3.lightspeed.sntcca.sbcglobal.net [99.130.254.3])
 by mxa.mailgun.org with ESMTP id 5bcc6f7a.7f568c04e270-smtp-out-n02;
 Sun, 21 Oct 2018 12:22:18 -0000 (UTC)
Received: by huitzilopochtli.metztli-it.com (Postfix, from userid 1000)
        id 84B20292433F; Sun, 21 Oct 2018 05:22:16 -0700 (PDT)
Subject: Reiser4 enhanced Debian 9.x Linux 4.18.xy series hung.
To:     <reiserfs-devel@vger.kernel.org>, <debian-kernel@lists.debian.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.1.1)
Message-Id: <20181021122216.84B20292433F@huitzilopochtli.metztli-it.com>
Date:   Sun, 21 Oct 2018 05:22:16 -0700 (PDT)
From:   jose.r.r@metztli.com (Metztli Information Technology)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niltze, all-

Ever since I build reiser4 -patched [1] Linux kernel 4.18.xy iterations I have had kernel hanging issues --which manifest themselves after considerable load and/or multitasking in my local development machine *and* in an vm instance running in Google Compute Engine (GCE).

My root file systems are reiser4, Software Format Release Number (SFRN) 4.0.1 and 4.0.2.
(Official current Reiser4 resources:
< https://reiser4.wiki.kernel.org/ >)

I have had very solid reiser4 Linux kernel builds for AMD64 up to now, for instance,
uname -a
Linux huitzilopochtli 4.14.0-3+reiser4.0.2-amd64 #1 SMP Debian 4.14.20-1+reiser4.0.2 (2018-02-18) x86_64 GNU/Linux

which is part of what could be termed as 'Reiser4 the Debian Way' because I modify Debian's unstable (Sid) kernel
packaging to build with GCC6 for Stretch-backports AMD64, i.e., 
< https://github.com/Metztli/reiser4-debian-kernel-packaging-4.14.20 >

Notwithstanding, here is a portion of a hung Linux kernel 4.18.15-1 running on GCE cloud whose serial output is as follows:

[14620.593659]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[14620.601867] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[14620.609814] kworker/u2:0    D    0     7      2 0x80000000
[14620.615430] Workqueue: writeback wb_workfn (flush-8:0)
[14620.620679] Call Trace:
[14620.623354]  ? __schedule+0x3f5/0x880
[14620.627144]  schedule+0x32/0x80
[14620.630402]  io_schedule+0x12/0x40
[14620.633969]  __lock_page+0x119/0x160
[14620.637686]  ? page_cache_tree_insert+0xe0/0xe0
[14620.797154]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
[14620.803130]  ? zlook+0x15/0x70 [reiser4]
[14620.807304]  ? utmost_child_internal+0x45/0x80 [reiser4]
[14620.812783]  write_jnode_list+0x7f/0xb0 [reiser4]
[14620.817663]  reiser4_write_fq+0x81/0x230 [reiser4]
[14620.822579]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[14620.828110]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[14620.833290]  flush_some_atom+0x113/0x530 [reiser4]
[14620.838213]  reiser4_writeout+0x151/0x230 [reiser4]
[14620.843220]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[14620.848885]  writeback_sb_inodes+0x8f/0xb0
[14620.853169]  __writeback_inodes_wb+0x87/0xb0
[14620.857564]  wb_writeback+0x288/0x320
[14620.861352]  ? wb_workfn+0x1a9/0x450
[14620.865044]  wb_workfn+0x1a9/0x450
[14620.868600]  process_one_work+0x191/0x370
[14620.872747]  worker_thread+0x4f/0x3b0
[14620.876534]  kthread+0xf8/0x130
[14620.879820]  ? rescuer_thread+0x340/0x340
[14620.883945]  ? kthread_create_worker_on_cpu+0x70/0x70
[14620.889120]  ret_from_fork+0x35/0x40
[14620.892854] INFO: task freshclam:373 blocked for more than 120 seconds.
[14620.899583]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[14620.907797] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[14620.915742] freshclam       D    0   373      1 0x00000000
[14620.921352] Call Trace:
[14620.923919]  ? __schedule+0x3f5/0x880
[14620.927695]  schedule+0x32/0x80
[14620.930969]  reiser4_go_to_sleep+0x5d/0x90 [reiser4]
[14620.936177]  ? remove_wait_queue+0x60/0x60
[14620.940422]  reiser4_atom_wait_event+0xc4/0x140 [reiser4]
[14620.945956]  reiser4_uncapture_page+0x79/0x190 [reiser4]
[14620.951391]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
[14620.956820]  truncate_cleanup_page+0x6f/0xc0
[14620.961254]  truncate_inode_pages_range+0x220/0x8b0
[14620.966396]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
[14620.972031]  kill_hook_extent+0x157/0x4a0 [reiser4]
[14620.977040]  ? create_hook_extent+0xd0/0xd0 [reiser4]
[14620.982230]  call_kill_hooks+0xa7/0xe0 [reiser4]
[14620.986969]  ? kill_units+0x80/0x80 [reiser4]
[14620.991458]  ? kill_head+0x20/0x20 [reiser4]
[14620.995865]  ? keyeq+0x20/0x20 [reiser4]
[14620.999928]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
[14621.005891]  ? lock_object+0x96/0x100 [reiser4]
[14621.010538]  ? _cond_resched+0x16/0x40
[14621.014461]  ? jload_gfp+0x73/0x1d0 [reiser4]
[14621.018950]  kill_node40+0x3d/0xe0 [reiser4]
[14621.023347]  carry_cut+0x54/0x90 [reiser4]
[14621.027579]  reiser4_carry+0x1c4/0x360 [reiser4]
[14621.032328]  ? reiser4_add_carry+0x24/0x40 [reiser4]
[14621.037413]  kill_node_content+0x143/0x210 [reiser4]
[14621.042499]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
[14621.048033]  ? reiser4_delete_node+0x220/0x220 [reiser4]
[14621.053473]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
[14621.058999]  ? validate_extended_coord+0x70/0x70 [reiser4]
[14621.064726]  cut_file_items+0x11f/0x1c0 [reiser4]
[14621.069558]  shorten_file+0x31/0x320 [reiser4]
[14621.074233]  delete_object_unix_file+0x3a/0xa0 [reiser4]
[14621.079671]  reiser4_evict_inode+0x80/0xd0 [reiser4]
[14621.084763]  evict+0xc1/0x1c0
[14621.087904]  do_unlinkat+0x13f/0x320
[14621.091653]  do_syscall_64+0x55/0x110
[14621.095478]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[14621.100766] RIP: 0033:0x7f05de584ea7
[14621.104451] Code: Bad RIP value.
[14621.107908] RSP: 002b:00007ffd5aef37a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[14621.115592] RAX: ffffffffffffffda RBX: 000055c53bd69df0 RCX: 00007f05de584ea7
[14621.122839] RDX: 00007ffd5aef38f0 RSI: 00007ffd5aef38f0 RDI: 000055c53bd69df0
[14621.130142] RBP: 000055c53bd87b70 R08: 000055c53bd87ce3 R09: 0000000000000071
[14621.137399] R10: 0000000000000073 R11: 0000000000000246 R12: 000055c53bd6d2e0
[14621.144648] R13: 00007ffd5aef38f0 R14: 00007f05df8fd6d8 R15: 000055c53bd87ce3
Oct 20 06:40:39 cohuatl kernel: [14620.586792] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
Oct 20 06:40:39 cohuatl kernel: [14620.593659]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:40:39 cohuatl kernel: [14620.601867] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:40:39 cohuatl kernel: [14620.609814] kworker/u2:0    D    0     7      2 0x80000000
Oct 20 06:40:39 cohuatl kernel: [14620.615430] Workqueue: writeback wb_workfn (flush-8:0)
Oct 20 06:40:39 cohuatl kernel: [14620.620679] Call Trace:
Oct 20 06:40:39 cohuatl kernel: [14620.623354]  ? __schedule+0x3f5/0x880
Oct 20 06:40:39 cohuatl kernel: [14620.627144]  schedule+0x32/0x80
Oct 20 06:40:39 cohuatl kernel: [14620.630402]  io_schedule+0x12/0x40
Oct 20 06:40:39 cohuatl kernel: [14620.633969]  __lock_page+0x119/0x160
Oct 20 06:40:39 cohuatl kernel: [14620.637686]  ? page_cache_tree_insert+0xe0/0xe0
Oct 20 06:40:39 cohuatl kernel: [14620.797154]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.803130]  ? zlook+0x15/0x70 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.807304]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.812783]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.817663]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.822579]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.828110]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.833290]  flush_some_atom+0x113/0x530 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.838213]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.843220]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.848885]  writeback_sb_inodes+0x8f/0xb0
Oct 20 06:40:39 cohuatl kernel: [14620.853169]  __writeback_inodes_wb+0x87/0xb0
Oct 20 06:40:39 cohuatl kernel: [14620.857564]  wb_writeback+0x288/0x320
Oct 20 06:40:39 cohuatl kernel: [14620.861352]  ? wb_workfn+0x1a9/0x450
Oct 20 06:40:39 cohuatl kernel: [14620.865044]  wb_workfn+0x1a9/0x450
Oct 20 06:40:39 cohuatl kernel: [14620.868600]  process_one_work+0x191/0x370
Oct 20 06:40:39 cohuatl kernel: [14620.872747]  worker_thread+0x4f/0x3b0
Oct 20 06:40:39 cohuatl kernel: [14620.876534]  kthread+0xf8/0x130
Oct 20 06:40:39 cohuatl kernel: [14620.879820]  ? rescuer_thread+0x340/0x340
Oct 20 06:40:39 cohuatl kernel: [14620.883945]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 20 06:40:39 cohuatl kernel: [14620.889120]  ret_from_fork+0x35/0x40
Oct 20 06:40:39 cohuatl kernel: [14620.892854] INFO: task freshclam:373 blocked for more than 120 seconds.
Oct 20 06:40:39 cohuatl kernel: [14620.899583]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:40:39 cohuatl kernel: [14620.907797] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:40:39 cohuatl kernel: [14620.915742] freshclam       D    0   373      1 0x00000000
Oct 20 06:40:39 cohuatl kernel: [14620.921352] Call Trace:
Oct 20 06:40:39 cohuatl kernel: [14620.923919]  ? __schedule+0x3f5/0x880
Oct 20 06:40:39 cohuatl kernel: [14620.927695]  schedule+0x32/0x80
Oct 20 06:40:39 cohuatl kernel: [14620.930969]  reiser4_go_to_sleep+0x5d/0x90 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.936177]  ? remove_wait_queue+0x60/0x60
Oct 20 06:40:39 cohuatl kernel: [14620.940422]  reiser4_atom_wait_event+0xc4/0x140 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.945956]  reiser4_uncapture_page+0x79/0x190 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.951391]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.956820]  truncate_cleanup_page+0x6f/0xc0
Oct 20 06:40:39 cohuatl kernel: [14620.961254]  truncate_inode_pages_range+0x220/0x8b0
Oct 20 06:40:39 cohuatl kernel: [14620.966396]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.972031]  kill_hook_extent+0x157/0x4a0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.977040]  ? create_hook_extent+0xd0/0xd0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.982230]  call_kill_hooks+0xa7/0xe0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.986969]  ? kill_units+0x80/0x80 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.991458]  ? kill_head+0x20/0x20 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.995865]  ? keyeq+0x20/0x20 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14620.999928]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.005891]  ? lock_object+0x96/0x100 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.010538]  ? _cond_resched+0x16/0x40
Oct 20 06:40:39 cohuatl kernel: [14621.014461]  ? jload_gfp+0x73/0x1d0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.018950]  kill_node40+0x3d/0xe0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.023347]  carry_cut+0x54/0x90 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.027579]  reiser4_carry+0x1c4/0x360 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.032328]  ? reiser4_add_carry+0x24/0x40 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.037413]  kill_node_content+0x143/0x210 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.042499]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.048033]  ? reiser4_delete_node+0x220/0x220 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.053473]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.058999]  ? validate_extended_coord+0x70/0x70 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.064726]  cut_file_items+0x11f/0x1c0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.069558]  shorten_file+0x31/0x320 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.074233]  delete_object_unix_file+0x3a/0xa0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.079671]  reiser4_evict_inode+0x80/0xd0 [reiser4]
Oct 20 06:40:39 cohuatl kernel: [14621.084763]  evict+0xc1/0x1c0
Oct 20 06:40:39 cohuatl kernel: [14621.087904]  do_unlinkat+0x13f/0x320
Oct 20 06:40:39 cohuatl kernel: [14621.091653]  do_syscall_64+0x55/0x110
Oct 20 06:40:39 cohuatl kernel: [14621.095478]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 20 06:40:39 cohuatl kernel: [14621.100766] RIP: 0033:0x7f05de584ea7
Oct 20 06:40:39 cohuatl kernel: [14621.104451] Code: Bad RIP value.
Oct 20 06:40:39 cohuatl kernel: [14621.107908] RSP: 002b:00007ffd5aef37a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
Oct 20 06:40:39 cohuatl kernel: [14621.115592] RAX: ffffffffffffffda RBX: 000055c53bd69df0 RCX: 00007f05de584ea7
Oct 20 06:40:39 cohuatl kernel: [14621.122839] RDX: 00007ffd5aef38f0 RSI: 00007ffd5aef38f0 RDI: 000055c53bd69df0
Oct 20 06:40:39 cohuatl kernel: [14621.130142] RBP: 000055c53bd87b70 R08: 000055c53bd87ce3 R09: 0000000000000071
Oct 20 06:40:39 cohuatl kernel: [14621.137399] R10: 0000000000000073 R11: 0000000000000246 R12: 000055c53bd6d2e0
Oct 20 06:40:39 cohuatl kernel: [14621.144648] R13: 00007ffd5aef38f0 R14: 00007f05df8fd6d8 R15: 000055c53bd87ce3
[14741.409930] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
[14741.417127]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[14741.425557] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[14741.433835] kworker/u2:0    D    0     7      2 0x80000000
[14741.439464] Workqueue: writeback wb_workfn (flush-8:0)
[14741.444827] Call Trace:
[14741.447402]  ? __schedule+0x3f5/0x880
[14741.451482]  schedule+0x32/0x80
[14741.454975]  io_schedule+0x12/0x40
[14741.458624]  __lock_page+0x119/0x160
[14741.462327]  ? page_cache_tree_insert+0xe0/0xe0
[14741.467105]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
[14741.473210]  ? zlook+0x15/0x70 [reiser4]
[14741.477308]  ? utmost_child_internal+0x45/0x80 [reiser4]
[14741.482770]  write_jnode_list+0x7f/0xb0 [reiser4]
[14741.487608]  reiser4_write_fq+0x81/0x230 [reiser4]
[14741.492607]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[14741.498154]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[14741.503447]  flush_some_atom+0x113/0x530 [reiser4]
[14741.508370]  reiser4_writeout+0x151/0x230 [reiser4]
[14741.513381]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[14741.519223]  writeback_sb_inodes+0x8f/0xb0
[14741.523473]  __writeback_inodes_wb+0x87/0xb0
[14741.527946]  wb_writeback+0x288/0x320
[14741.531739]  ? wb_workfn+0x1a9/0x450
[14741.535635]  wb_workfn+0x1a9/0x450
[14741.539199]  process_one_work+0x191/0x370
[14741.543634]  worker_thread+0x4f/0x3b0
[14741.547674]  kthread+0xf8/0x130
[14741.550940]  ? rescuer_thread+0x340/0x340
[14741.555070]  ? kthread_create_worker_on_cpu+0x70/0x70
[14741.560336]  ret_from_fork+0x35/0x40
[14741.564133] INFO: task freshclam:373 blocked for more than 120 seconds.
[14741.570872]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[14741.579084] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[14741.587086] freshclam       D    0   373      1 0x00000000
[14741.592704] Call Trace:
[14741.595371]  ? __schedule+0x3f5/0x880
[14741.599157]  schedule+0x32/0x80
[14741.602474]  reiser4_go_to_sleep+0x5d/0x90 [reiser4]
[14741.607778]  ? remove_wait_queue+0x60/0x60
[14741.612162]  reiser4_atom_wait_event+0xc4/0x140 [reiser4]
[14741.617731]  reiser4_uncapture_page+0x79/0x190 [reiser4]
[14741.623208]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
[14741.628653]  truncate_cleanup_page+0x6f/0xc0
[14741.633138]  truncate_inode_pages_range+0x220/0x8b0
[14741.638201]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
[14741.643835]  kill_hook_extent+0x157/0x4a0 [reiser4]
[14741.649069]  ? create_hook_extent+0xd0/0xd0 [reiser4]
[14741.654427]  call_kill_hooks+0xa7/0xe0 [reiser4]
[14741.659209]  ? kill_units+0x80/0x80 [reiser4]
[14741.664156]  ? kill_head+0x20/0x20 [reiser4]
[14741.668742]  ? keyeq+0x20/0x20 [reiser4]
[14741.672798]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
[14741.678952]  ? lock_object+0x96/0x100 [reiser4]
[14741.683624]  ? _cond_resched+0x16/0x40
[14741.687722]  ? jload_gfp+0x73/0x1d0 [reiser4]
[14741.692389]  kill_node40+0x3d/0xe0 [reiser4]
[14741.696879]  carry_cut+0x54/0x90 [reiser4]
[14741.701111]  reiser4_carry+0x1c4/0x360 [reiser4]
[14741.706133]  ? reiser4_add_carry+0x24/0x40 [reiser4]
[14741.711243]  kill_node_content+0x143/0x210 [reiser4]
[14741.716356]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
[14741.721888]  ? reiser4_delete_node+0x220/0x220 [reiser4]
[14741.727479]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
[14741.733350]  ? validate_extended_coord+0x70/0x70 [reiser4]
[14741.739011]  cut_file_items+0x11f/0x1c0 [reiser4]
[14741.743855]  shorten_file+0x31/0x320 [reiser4]
[14741.748455]  delete_object_unix_file+0x3a/0xa0 [reiser4]
[14741.754067]  reiser4_evict_inode+0x80/0xd0 [reiser4]
[14741.759327]  evict+0xc1/0x1c0
[14741.762613]  do_unlinkat+0x13f/0x320
[14741.766315]  do_syscall_64+0x55/0x110
[14741.770272]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[14741.775541] RIP: 0033:0x7f05de584ea7
[14741.779498] Code: Bad RIP value.
[14741.782863] RSP: 002b:00007ffd5aef37a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[14741.790855] RAX: ffffffffffffffda RBX: 000055c53bd69df0 RCX: 00007f05de584ea7
[14741.798114] RDX: 00007ffd5aef38f0 RSI: 00007ffd5aef38f0 RDI: 000055c53bd69df0
[14741.805373] RBP: 000055c53bd87b70 R08: 000055c53bd87ce3 R09: 0000000000000071
[14741.812754] R10: 0000000000000073 R11: 0000000000000246 R12: 000055c53bd6d2e0
[14741.820223] R13: 00007ffd5aef38f0 R14: 00007f05df8fd6d8 R15: 000055c53bd87ce3
Oct 20 06:42:40 cohuatl kernel: [14741.409930] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
Oct 20 06:42:40 cohuatl kernel: [14741.417127]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:42:40 cohuatl kernel: [14741.425557] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:42:40 cohuatl kernel: [14741.433835] kworker/u2:0    D    0     7      2 0x80000000
Oct 20 06:42:40 cohuatl kernel: [14741.439464] Workqueue: writeback wb_workfn (flush-8:0)
Oct 20 06:42:40 cohuatl kernel: [14741.444827] Call Trace:
Oct 20 06:42:40 cohuatl kernel: [14741.447402]  ? __schedule+0x3f5/0x880
Oct 20 06:42:40 cohuatl kernel: [14741.451482]  schedule+0x32/0x80
Oct 20 06:42:40 cohuatl kernel: [14741.454975]  io_schedule+0x12/0x40
Oct 20 06:42:40 cohuatl kernel: [14741.458624]  __lock_page+0x119/0x160
Oct 20 06:42:40 cohuatl kernel: [14741.462327]  ? page_cache_tree_insert+0xe0/0xe0
Oct 20 06:42:40 cohuatl kernel: [14741.467105]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.473210]  ? zlook+0x15/0x70 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.477308]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.482770]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.487608]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.492607]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.498154]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.503447]  flush_some_atom+0x113/0x530 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.508370]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.513381]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.519223]  writeback_sb_inodes+0x8f/0xb0
Oct 20 06:42:40 cohuatl kernel: [14741.523473]  __writeback_inodes_wb+0x87/0xb0
Oct 20 06:42:40 cohuatl kernel: [14741.527946]  wb_writeback+0x288/0x320
Oct 20 06:42:40 cohuatl kernel: [14741.531739]  ? wb_workfn+0x1a9/0x450
Oct 20 06:42:40 cohuatl kernel: [14741.535635]  wb_workfn+0x1a9/0x450
Oct 20 06:42:40 cohuatl kernel: [14741.539199]  process_one_work+0x191/0x370
Oct 20 06:42:40 cohuatl kernel: [14741.543634]  worker_thread+0x4f/0x3b0
Oct 20 06:42:40 cohuatl kernel: [14741.547674]  kthread+0xf8/0x130
Oct 20 06:42:40 cohuatl kernel: [14741.550940]  ? rescuer_thread+0x340/0x340
Oct 20 06:42:40 cohuatl kernel: [14741.555070]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 20 06:42:40 cohuatl kernel: [14741.560336]  ret_from_fork+0x35/0x40
Oct 20 06:42:40 cohuatl kernel: [14741.564133] INFO: task freshclam:373 blocked for more than 120 seconds.
Oct 20 06:42:40 cohuatl kernel: [14741.570872]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:42:40 cohuatl kernel: [14741.579084] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:42:40 cohuatl kernel: [14741.587086] freshclam       D    0   373      1 0x00000000
Oct 20 06:42:40 cohuatl kernel: [14741.592704] Call Trace:
Oct 20 06:42:40 cohuatl kernel: [14741.595371]  ? __schedule+0x3f5/0x880
Oct 20 06:42:40 cohuatl kernel: [14741.599157]  schedule+0x32/0x80
Oct 20 06:42:40 cohuatl kernel: [14741.602474]  reiser4_go_to_sleep+0x5d/0x90 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.607778]  ? remove_wait_queue+0x60/0x60
Oct 20 06:42:40 cohuatl kernel: [14741.612162]  reiser4_atom_wait_event+0xc4/0x140 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.617731]  reiser4_uncapture_page+0x79/0x190 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.623208]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.628653]  truncate_cleanup_page+0x6f/0xc0
Oct 20 06:42:40 cohuatl kernel: [14741.633138]  truncate_inode_pages_range+0x220/0x8b0
Oct 20 06:42:40 cohuatl kernel: [14741.638201]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.643835]  kill_hook_extent+0x157/0x4a0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.649069]  ? create_hook_extent+0xd0/0xd0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.654427]  call_kill_hooks+0xa7/0xe0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.659209]  ? kill_units+0x80/0x80 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.664156]  ? kill_head+0x20/0x20 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.668742]  ? keyeq+0x20/0x20 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.672798]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.678952]  ? lock_object+0x96/0x100 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.683624]  ? _cond_resched+0x16/0x40
Oct 20 06:42:40 cohuatl kernel: [14741.687722]  ? jload_gfp+0x73/0x1d0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.692389]  kill_node40+0x3d/0xe0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.696879]  carry_cut+0x54/0x90 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.701111]  reiser4_carry+0x1c4/0x360 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.706133]  ? reiser4_add_carry+0x24/0x40 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.711243]  kill_node_content+0x143/0x210 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.716356]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.721888]  ? reiser4_delete_node+0x220/0x220 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.727479]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.733350]  ? validate_extended_coord+0x70/0x70 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.739011]  cut_file_items+0x11f/0x1c0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.743855]  shorten_file+0x31/0x320 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.748455]  delete_object_unix_file+0x3a/0xa0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.754067]  reiser4_evict_inode+0x80/0xd0 [reiser4]
Oct 20 06:42:40 cohuatl kernel: [14741.759327]  evict+0xc1/0x1c0
Oct 20 06:42:40 cohuatl kernel: [14741.762613]  do_unlinkat+0x13f/0x320
Oct 20 06:42:40 cohuatl kernel: [14741.766315]  do_syscall_64+0x55/0x110
Oct 20 06:42:40 cohuatl kernel: [14741.770272]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 20 06:42:40 cohuatl kernel: [14741.775541] RIP: 0033:0x7f05de584ea7
Oct 20 06:42:40 cohuatl kernel: [14741.779498] Code: Bad RIP value.
Oct 20 06:42:40 cohuatl kernel: [14741.782863] RSP: 002b:00007ffd5aef37a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
Oct 20 06:42:40 cohuatl kernel: [14741.790855] RAX: ffffffffffffffda RBX: 000055c53bd69df0 RCX: 00007f05de584ea7
Oct 20 06:42:40 cohuatl kernel: [14741.798114] RDX: 00007ffd5aef38f0 RSI: 00007ffd5aef38f0 RDI: 000055c53bd69df0
Oct 20 06:42:40 cohuatl kernel: [14741.805373] RBP: 000055c53bd87b70 R08: 000055c53bd87ce3 R09: 0000000000000071
Oct 20 06:42:40 cohuatl kernel: [14741.812754] R10: 0000000000000073 R11: 0000000000000246 R12: 000055c53bd6d2e0
Oct 20 06:42:40 cohuatl kernel: [14741.820223] R13: 00007ffd5aef38f0 R14: 00007f05df8fd6d8 R15: 000055c53bd87ce3
[14862.232997] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
[14862.240041]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[14862.248310] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[14862.256273] kworker/u2:0    D    0     7      2 0x80000000
[14862.261885] Workqueue: writeback wb_workfn (flush-8:0)
[14862.267180] Call Trace:
[14862.269766]  ? __schedule+0x3f5/0x880
[14862.273540]  schedule+0x32/0x80
[14862.276788]  io_schedule+0x12/0x40
[14862.280303]  __lock_page+0x119/0x160
[14862.284005]  ? page_cache_tree_insert+0xe0/0xe0
[14862.288676]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
[14862.294625]  ? zlook+0x15/0x70 [reiser4]
[14862.298671]  ? utmost_child_internal+0x45/0x80 [reiser4]
[14862.304104]  write_jnode_list+0x7f/0xb0 [reiser4]
[14862.309027]  reiser4_write_fq+0x81/0x230 [reiser4]
[14862.313937]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[14862.319456]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[14862.324693]  flush_some_atom+0x113/0x530 [reiser4]
[14862.329612]  reiser4_writeout+0x151/0x230 [reiser4]
[14862.334638]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[14862.340253]  writeback_sb_inodes+0x8f/0xb0
[14862.344467]  __writeback_inodes_wb+0x87/0xb0
[14862.348850]  wb_writeback+0x288/0x320
[14862.352629]  ? wb_workfn+0x1a9/0x450
[14862.356317]  wb_workfn+0x1a9/0x450
[14862.359834]  process_one_work+0x191/0x370
[14862.363960]  worker_thread+0x4f/0x3b0
[14862.367732]  kthread+0xf8/0x130
[14862.371036]  ? rescuer_thread+0x340/0x340
[14862.375172]  ? kthread_create_worker_on_cpu+0x70/0x70
[14862.380346]  ret_from_fork+0x35/0x40
Oct 20 06:44:41 cohuatl kernel: [14862.232997] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
Oct 20 06:44:41 cohuatl kernel: [14862.240041]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:44:41 cohuatl kernel: [14862.248310] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:44:41 cohuatl kernel: [14862.256273] kworker/u2:0    D    0     7      2 0x80000000
Oct 20 06:44:41 cohuatl kernel: [14862.261885] Workqueue: writeback wb_workfn (flush-8:0)
Oct 20 06:44:41 cohuatl kernel: [14862.267180] Call Trace:
Oct 20 06:44:41 cohuatl kernel: [14862.269766]  ? __schedule+0x3f5/0x880
Oct 20 06:44:41 cohuatl kernel: [14862.273540]  schedule+0x32/0x80
Oct 20 06:44:41 cohuatl kernel: [14862.276788]  io_schedule+0x12/0x40
Oct 20 06:44:41 cohuatl kernel: [14862.280303]  __lock_page+0x119/0x160
Oct 20 06:44:41 cohuatl kernel: [14862.284005]  ? page_cache_tree_insert+0xe0/0xe0
Oct 20 06:44:41 cohuatl kernel: [14862.288676]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.294625]  ? zlook+0x15/0x70 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.298671]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.304104]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.309027]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.313937]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.319456]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.324693]  flush_some_atom+0x113/0x530 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.329612]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.334638]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 20 06:44:41 cohuatl kernel: [14862.340253]  writeback_sb_inodes+0x8f/0xb0
Oct 20 06:44:41 cohuatl kernel: [14862.344467]  __writeback_inodes_wb+0x87/0xb0
Oct 20 06:44:41 cohuatl kernel: [14862.348850]  wb_writeback+0x288/0x320
Oct 20 06:44:41 cohuatl kernel: [14862.352629]  ? wb_workfn+0x1a9/0x450
Oct 20 06:44:41 cohuatl kernel: [14862.356317]  wb_workfn+0x1a9/0x450
Oct 20 06:44:41 cohuatl kernel: [14862.359834]  process_one_work+0x191/0x370
Oct 20 06:44:41 cohuatl kernel: [14862.363960]  worker_thread+0x4f/0x3b0
Oct 20 06:44:41 cohuatl kernel: [14862.367732]  kthread+0xf8/0x130
Oct 20 06:44:41 cohuatl kernel: [14862.371036]  ? rescuer_thread+0x340/0x340
Oct 20 06:44:41 cohuatl kernel: [14862.375172]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 20 06:44:41 cohuatl kernel: [14862.380346]  ret_from_fork+0x35/0x40
Oct 20 06:45:04 cohuatl systemd[1]: Starting Daily apt upgrade and clean activities...
Oct 20 06:45:08 cohuatl systemd[1]: Started Daily apt upgrade and clean activities.
[14983.056093] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
[14983.063077]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[14983.071282] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[14983.079233] kworker/u2:0    D    0     7      2 0x80000000
[14983.084838] Workqueue: writeback wb_workfn (flush-8:0)
[14983.090100] Call Trace:
[14983.092673]  ? __schedule+0x3f5/0x880
[14983.096455]  schedule+0x32/0x80
[14983.099705]  io_schedule+0x12/0x40
[14983.103277]  __lock_page+0x119/0x160
[14983.107018]  ? page_cache_tree_insert+0xe0/0xe0
[14983.111693]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
[14983.117646]  ? zlook+0x15/0x70 [reiser4]
[14983.121693]  ? utmost_child_internal+0x45/0x80 [reiser4]
[14983.127130]  write_jnode_list+0x7f/0xb0 [reiser4]
[14983.132064]  reiser4_write_fq+0x81/0x230 [reiser4]
[14983.136973]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[14983.142491]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[14983.147677]  flush_some_atom+0x113/0x530 [reiser4]
[14983.152641]  reiser4_writeout+0x151/0x230 [reiser4]
[14983.157659]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[14983.163260]  writeback_sb_inodes+0x8f/0xb0
[14983.167554]  __writeback_inodes_wb+0x87/0xb0
[14983.171944]  wb_writeback+0x288/0x320
[14983.175717]  ? wb_workfn+0x1a9/0x450
[14983.179411]  wb_workfn+0x1a9/0x450
[14983.182981]  process_one_work+0x191/0x370
[14983.187126]  worker_thread+0x4f/0x3b0
[14983.190899]  kthread+0xf8/0x130
[14983.194151]  ? rescuer_thread+0x340/0x340
[14983.198287]  ? kthread_create_worker_on_cpu+0x70/0x70
[14983.203460]  ret_from_fork+0x35/0x40
[14983.207170] INFO: task freshclam:373 blocked for more than 120 seconds.
[14983.213899]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[14983.222105] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[14983.230311] freshclam       D    0   373      1 0x00000000
[14983.235913] Call Trace:
[14983.238498]  ? __schedule+0x3f5/0x880
[14983.242287]  schedule+0x32/0x80
[14983.245599]  io_schedule+0x12/0x40
[14983.249122]  wait_on_page_bit+0x116/0x160
[14983.253247]  ? page_cache_tree_insert+0xe0/0xe0
[14983.257911]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
[14983.263718]  reiser4_uncapture_page+0xa0/0x190 [reiser4]
[14983.269158]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
[14983.274590]  truncate_cleanup_page+0x6f/0xc0
[14983.280677]  truncate_inode_pages_range+0x220/0x8b0
[14983.285684]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
[14983.291294]  kill_hook_extent+0x157/0x4a0 [reiser4]
[14983.296313]  ? create_hook_extent+0xd0/0xd0 [reiser4]
[14983.301490]  call_kill_hooks+0xa7/0xe0 [reiser4]
[14983.306229]  ? kill_units+0x80/0x80 [reiser4]
[14983.310734]  ? kill_head+0x20/0x20 [reiser4]
[14983.315138]  ? keyeq+0x20/0x20 [reiser4]
[14983.319185]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
[14983.325151]  ? lock_object+0x96/0x100 [reiser4]
[14983.329802]  ? _cond_resched+0x16/0x40
[14983.333674]  ? jload_gfp+0x73/0x1d0 [reiser4]
[14983.338161]  kill_node40+0x3d/0xe0 [reiser4]
[14983.342568]  carry_cut+0x54/0x90 [reiser4]
[14983.346787]  reiser4_carry+0x1c4/0x360 [reiser4]
[14983.351528]  ? reiser4_add_carry+0x24/0x40 [reiser4]
[14983.356627]  kill_node_content+0x143/0x210 [reiser4]
[14983.361728]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
[14983.367302]  ? reiser4_delete_node+0x220/0x220 [reiser4]
[14983.372743]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
[14983.378281]  ? validate_extended_coord+0x70/0x70 [reiser4]
[14983.383891]  cut_file_items+0x11f/0x1c0 [reiser4]
[14983.388722]  shorten_file+0x31/0x320 [reiser4]
[14983.393292]  delete_object_unix_file+0x3a/0xa0 [reiser4]
[14983.398732]  reiser4_evict_inode+0x80/0xd0 [reiser4]
[14983.403915]  evict+0xc1/0x1c0
[14983.407014]  do_unlinkat+0x13f/0x320
[14983.410709]  do_syscall_64+0x55/0x110
[14983.414493]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[14983.419850] RIP: 0033:0x7f05de584ea7
[14983.423548] Code: Bad RIP value.
[14983.426914] RSP: 002b:00007ffd5aef37a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[14983.434675] RAX: ffffffffffffffda RBX: 000055c53bd69df0 RCX: 00007f05de584ea7
[14983.441983] RDX: 00007ffd5aef38f0 RSI: 00007ffd5aef38f0 RDI: 000055c53bd69df0
[14983.449234] RBP: 000055c53bd87b70 R08: 000055c53bd87ce3 R09: 0000000000000071
[14983.456480] R10: 0000000000000073 R11: 0000000000000246 R12: 000055c53bd6d2e0
[14983.463738] R13: 00007ffd5aef38f0 R14: 00007f05df8fd6d8 R15: 000055c53bd87ce3
Oct 20 06:46:42 cohuatl kernel: [14983.056093] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
Oct 20 06:46:42 cohuatl kernel: [14983.063077]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:46:42 cohuatl kernel: [14983.071282] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:46:42 cohuatl kernel: [14983.079233] kworker/u2:0    D    0     7      2 0x80000000
Oct 20 06:46:42 cohuatl kernel: [14983.084838] Workqueue: writeback wb_workfn (flush-8:0)
Oct 20 06:46:42 cohuatl kernel: [14983.090100] Call Trace:
Oct 20 06:46:42 cohuatl kernel: [14983.092673]  ? __schedule+0x3f5/0x880
Oct 20 06:46:42 cohuatl kernel: [14983.096455]  schedule+0x32/0x80
Oct 20 06:46:42 cohuatl kernel: [14983.099705]  io_schedule+0x12/0x40
Oct 20 06:46:42 cohuatl kernel: [14983.103277]  __lock_page+0x119/0x160
Oct 20 06:46:42 cohuatl kernel: [14983.107018]  ? page_cache_tree_insert+0xe0/0xe0
Oct 20 06:46:42 cohuatl kernel: [14983.111693]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.117646]  ? zlook+0x15/0x70 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.121693]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.127130]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.132064]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.136973]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.142491]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.147677]  flush_some_atom+0x113/0x530 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.152641]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.157659]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.163260]  writeback_sb_inodes+0x8f/0xb0
Oct 20 06:46:42 cohuatl kernel: [14983.167554]  __writeback_inodes_wb+0x87/0xb0
Oct 20 06:46:42 cohuatl kernel: [14983.171944]  wb_writeback+0x288/0x320
Oct 20 06:46:42 cohuatl kernel: [14983.175717]  ? wb_workfn+0x1a9/0x450
Oct 20 06:46:42 cohuatl kernel: [14983.179411]  wb_workfn+0x1a9/0x450
Oct 20 06:46:42 cohuatl kernel: [14983.182981]  process_one_work+0x191/0x370
Oct 20 06:46:42 cohuatl kernel: [14983.187126]  worker_thread+0x4f/0x3b0
Oct 20 06:46:42 cohuatl kernel: [14983.190899]  kthread+0xf8/0x130
Oct 20 06:46:42 cohuatl kernel: [14983.194151]  ? rescuer_thread+0x340/0x340
Oct 20 06:46:42 cohuatl kernel: [14983.198287]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 20 06:46:42 cohuatl kernel: [14983.203460]  ret_from_fork+0x35/0x40
Oct 20 06:46:42 cohuatl kernel: [14983.207170] INFO: task freshclam:373 blocked for more than 120 seconds.
Oct 20 06:46:42 cohuatl kernel: [14983.213899]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:46:42 cohuatl kernel: [14983.222105] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:46:42 cohuatl kernel: [14983.230311] freshclam       D    0   373      1 0x00000000
Oct 20 06:46:42 cohuatl kernel: [14983.235913] Call Trace:
Oct 20 06:46:42 cohuatl kernel: [14983.238498]  ? __schedule+0x3f5/0x880
Oct 20 06:46:42 cohuatl kernel: [14983.242287]  schedule+0x32/0x80
Oct 20 06:46:42 cohuatl kernel: [14983.245599]  io_schedule+0x12/0x40
Oct 20 06:46:42 cohuatl kernel: [14983.249122]  wait_on_page_bit+0x116/0x160
Oct 20 06:46:42 cohuatl kernel: [14983.253247]  ? page_cache_tree_insert+0xe0/0xe0
Oct 20 06:46:42 cohuatl kernel: [14983.257911]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.263718]  reiser4_uncapture_page+0xa0/0x190 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.269158]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.274590]  truncate_cleanup_page+0x6f/0xc0
Oct 20 06:46:42 cohuatl kernel: [14983.280677]  truncate_inode_pages_range+0x220/0x8b0
Oct 20 06:46:42 cohuatl kernel: [14983.285684]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.291294]  kill_hook_extent+0x157/0x4a0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.296313]  ? create_hook_extent+0xd0/0xd0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.301490]  call_kill_hooks+0xa7/0xe0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.306229]  ? kill_units+0x80/0x80 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.310734]  ? kill_head+0x20/0x20 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.315138]  ? keyeq+0x20/0x20 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.319185]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.325151]  ? lock_object+0x96/0x100 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.329802]  ? _cond_resched+0x16/0x40
Oct 20 06:46:42 cohuatl kernel: [14983.333674]  ? jload_gfp+0x73/0x1d0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.338161]  kill_node40+0x3d/0xe0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.342568]  carry_cut+0x54/0x90 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.346787]  reiser4_carry+0x1c4/0x360 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.351528]  ? reiser4_add_carry+0x24/0x40 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.356627]  kill_node_content+0x143/0x210 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.361728]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.367302]  ? reiser4_delete_node+0x220/0x220 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.372743]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.378281]  ? validate_extended_coord+0x70/0x70 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.383891]  cut_file_items+0x11f/0x1c0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.388722]  shorten_file+0x31/0x320 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.393292]  delete_object_unix_file+0x3a/0xa0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.398732]  reiser4_evict_inode+0x80/0xd0 [reiser4]
Oct 20 06:46:42 cohuatl kernel: [14983.403915]  evict+0xc1/0x1c0
Oct 20 06:46:42 cohuatl kernel: [14983.407014]  do_unlinkat+0x13f/0x320
Oct 20 06:46:42 cohuatl kernel: [14983.410709]  do_syscall_64+0x55/0x110
Oct 20 06:46:42 cohuatl kernel: [14983.414493]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 20 06:46:42 cohuatl kernel: [14983.419850] RIP: 0033:0x7f05de584ea7
Oct 20 06:46:42 cohuatl kernel: [14983.423548] Code: Bad RIP value.
Oct 20 06:46:42 cohuatl kernel: [14983.426914] RSP: 002b:00007ffd5aef37a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
Oct 20 06:46:42 cohuatl kernel: [14983.434675] RAX: ffffffffffffffda RBX: 000055c53bd69df0 RCX: 00007f05de584ea7
Oct 20 06:46:42 cohuatl kernel: [14983.441983] RDX: 00007ffd5aef38f0 RSI: 00007ffd5aef38f0 RDI: 000055c53bd69df0
Oct 20 06:46:42 cohuatl kernel: [14983.449234] RBP: 000055c53bd87b70 R08: 000055c53bd87ce3 R09: 0000000000000071
Oct 20 06:46:42 cohuatl kernel: [14983.456480] R10: 0000000000000073 R11: 0000000000000246 R12: 000055c53bd6d2e0
Oct 20 06:46:42 cohuatl kernel: [14983.463738] R13: 00007ffd5aef38f0 R14: 00007f05df8fd6d8 R15: 000055c53bd87ce3
[15103.879178] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
[15103.886053]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[15103.894311] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[15103.902388] kworker/u2:0    D    0     7      2 0x80000000
[15103.908003] Workqueue: writeback wb_workfn (flush-8:0)
[15103.913341] Call Trace:
[15103.915974]  ? __schedule+0x3f5/0x880
[15103.919764]  schedule+0x32/0x80
[15103.923017]  io_schedule+0x12/0x40
[15103.926544]  __lock_page+0x119/0x160
[15103.930234]  ? page_cache_tree_insert+0xe0/0xe0
[15104.009600]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
[15104.015587]  ? zlook+0x15/0x70 [reiser4]
[15104.019652]  ? utmost_child_internal+0x45/0x80 [reiser4]
[15104.025144]  write_jnode_list+0x7f/0xb0 [reiser4]
[15104.029990]  reiser4_write_fq+0x81/0x230 [reiser4]
[15104.034919]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[15104.040446]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[15104.045683]  flush_some_atom+0x113/0x530 [reiser4]
[15104.050609]  reiser4_writeout+0x151/0x230 [reiser4]
[15104.055626]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[15104.061241]  writeback_sb_inodes+0x8f/0xb0
[15104.065456]  __writeback_inodes_wb+0x87/0xb0
[15104.069841]  wb_writeback+0x288/0x320
[15104.073629]  ? wb_workfn+0x1a9/0x450
[15104.077319]  wb_workfn+0x1a9/0x450
[15104.080834]  process_one_work+0x191/0x370
[15104.084966]  worker_thread+0x4f/0x3b0
[15104.088742]  kthread+0xf8/0x130
[15104.091994]  ? rescuer_thread+0x340/0x340
[15104.096115]  ? kthread_create_worker_on_cpu+0x70/0x70
[15104.101280]  ret_from_fork+0x35/0x40
[15104.104978] INFO: task freshclam:373 blocked for more than 120 seconds.
[15104.111718]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[15104.119929] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[15104.127881] freshclam       D    0   373      1 0x00000000
[15104.133480] Call Trace:
[15104.136042]  ? __schedule+0x3f5/0x880
[15104.139831]  schedule+0x32/0x80
[15104.143102]  io_schedule+0x12/0x40
[15104.146620]  wait_on_page_bit+0x116/0x160
[15104.150753]  ? page_cache_tree_insert+0xe0/0xe0
[15104.155490]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
[15104.161290]  reiser4_uncapture_page+0xa0/0x190 [reiser4]
[15104.166739]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
[15104.172167]  truncate_cleanup_page+0x6f/0xc0
[15104.176574]  truncate_inode_pages_range+0x220/0x8b0
[15104.181583]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
[15104.187192]  kill_hook_extent+0x157/0x4a0 [reiser4]
[15104.192205]  ? create_hook_extent+0xd0/0xd0 [reiser4]
[15104.197396]  call_kill_hooks+0xa7/0xe0 [reiser4]
[15104.202140]  ? kill_units+0x80/0x80 [reiser4]
[15104.206622]  ? kill_head+0x20/0x20 [reiser4]
[15104.211012]  ? keyeq+0x20/0x20 [reiser4]
[15104.215075]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
[15104.221034]  ? lock_object+0x96/0x100 [reiser4]
[15104.225679]  ? _cond_resched+0x16/0x40
[15104.229550]  ? jload_gfp+0x73/0x1d0 [reiser4]
[15104.234053]  kill_node40+0x3d/0xe0 [reiser4]
[15104.238469]  carry_cut+0x54/0x90 [reiser4]
[15104.242813]  reiser4_carry+0x1c4/0x360 [reiser4]
[15104.247562]  ? reiser4_add_carry+0x24/0x40 [reiser4]
[15104.252662]  kill_node_content+0x143/0x210 [reiser4]
[15104.260217]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
[15104.265751]  ? reiser4_delete_node+0x220/0x220 [reiser4]
[15104.271362]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
[15104.276901]  ? validate_extended_coord+0x70/0x70 [reiser4]
[15104.282513]  cut_file_items+0x11f/0x1c0 [reiser4]
[15104.287343]  shorten_file+0x31/0x320 [reiser4]
[15104.291935]  delete_object_unix_file+0x3a/0xa0 [reiser4]
[15104.297387]  reiser4_evict_inode+0x80/0xd0 [reiser4]
[15104.302655]  evict+0xc1/0x1c0
[15104.305744]  do_unlinkat+0x13f/0x320
[15104.309439]  do_syscall_64+0x55/0x110
[15104.313232]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[15104.318402] RIP: 0033:0x7f05de584ea7
[15104.322108] Code: Bad RIP value.
[15104.325476] RSP: 002b:00007ffd5aef37a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[15104.333167] RAX: ffffffffffffffda RBX: 000055c53bd69df0 RCX: 00007f05de584ea7
[15104.340424] RDX: 00007ffd5aef38f0 RSI: 00007ffd5aef38f0 RDI: 000055c53bd69df0
[15104.347779] RBP: 000055c53bd87b70 R08: 000055c53bd87ce3 R09: 0000000000000071
[15104.355032] R10: 0000000000000073 R11: 0000000000000246 R12: 000055c53bd6d2e0
[15104.362288] R13: 00007ffd5aef38f0 R14: 00007f05df8fd6d8 R15: 000055c53bd87ce3
Oct 20 06:48:43 cohuatl kernel: [15103.879178] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
Oct 20 06:48:43 cohuatl kernel: [15103.886053]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:48:43 cohuatl kernel: [15103.894311] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:48:43 cohuatl kernel: [15103.902388] kworker/u2:0    D    0     7      2 0x80000000
Oct 20 06:48:43 cohuatl kernel: [15103.908003] Workqueue: writeback wb_workfn (flush-8:0)
Oct 20 06:48:43 cohuatl kernel: [15103.913341] Call Trace:
Oct 20 06:48:43 cohuatl kernel: [15103.915974]  ? __schedule+0x3f5/0x880
Oct 20 06:48:43 cohuatl kernel: [15103.919764]  schedule+0x32/0x80
Oct 20 06:48:43 cohuatl kernel: [15103.923017]  io_schedule+0x12/0x40
Oct 20 06:48:43 cohuatl kernel: [15103.926544]  __lock_page+0x119/0x160
Oct 20 06:48:43 cohuatl kernel: [15103.930234]  ? page_cache_tree_insert+0xe0/0xe0
Oct 20 06:48:43 cohuatl kernel: [15104.009600]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.015587]  ? zlook+0x15/0x70 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.019652]  ? utmost_child_internal+0x45/0x80 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.025144]  write_jnode_list+0x7f/0xb0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.029990]  reiser4_write_fq+0x81/0x230 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.034919]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.040446]  flush_current_atom+0x3ae/0x8a0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.045683]  flush_some_atom+0x113/0x530 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.050609]  reiser4_writeout+0x151/0x230 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.055626]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.061241]  writeback_sb_inodes+0x8f/0xb0
Oct 20 06:48:43 cohuatl kernel: [15104.065456]  __writeback_inodes_wb+0x87/0xb0
Oct 20 06:48:43 cohuatl kernel: [15104.069841]  wb_writeback+0x288/0x320
Oct 20 06:48:43 cohuatl kernel: [15104.073629]  ? wb_workfn+0x1a9/0x450
Oct 20 06:48:43 cohuatl kernel: [15104.077319]  wb_workfn+0x1a9/0x450
Oct 20 06:48:43 cohuatl kernel: [15104.080834]  process_one_work+0x191/0x370
Oct 20 06:48:43 cohuatl kernel: [15104.084966]  worker_thread+0x4f/0x3b0
Oct 20 06:48:43 cohuatl kernel: [15104.088742]  kthread+0xf8/0x130
Oct 20 06:48:43 cohuatl kernel: [15104.091994]  ? rescuer_thread+0x340/0x340
Oct 20 06:48:43 cohuatl kernel: [15104.096115]  ? kthread_create_worker_on_cpu+0x70/0x70
Oct 20 06:48:43 cohuatl kernel: [15104.101280]  ret_from_fork+0x35/0x40
Oct 20 06:48:43 cohuatl kernel: [15104.104978] INFO: task freshclam:373 blocked for more than 120 seconds.
Oct 20 06:48:43 cohuatl kernel: [15104.111718]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
Oct 20 06:48:43 cohuatl kernel: [15104.119929] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 20 06:48:43 cohuatl kernel: [15104.127881] freshclam       D    0   373      1 0x00000000
Oct 20 06:48:43 cohuatl kernel: [15104.133480] Call Trace:
Oct 20 06:48:43 cohuatl kernel: [15104.136042]  ? __schedule+0x3f5/0x880
Oct 20 06:48:43 cohuatl kernel: [15104.139831]  schedule+0x32/0x80
Oct 20 06:48:43 cohuatl kernel: [15104.143102]  io_schedule+0x12/0x40
Oct 20 06:48:43 cohuatl kernel: [15104.146620]  wait_on_page_bit+0x116/0x160
Oct 20 06:48:43 cohuatl kernel: [15104.150753]  ? page_cache_tree_insert+0xe0/0xe0
Oct 20 06:48:43 cohuatl kernel: [15104.155490]  reiser4_wait_page_writeback+0x4e/0x80 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.161290]  reiser4_uncapture_page+0xa0/0x190 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.166739]  reiser4_invalidatepage+0xcd/0x1a0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.172167]  truncate_cleanup_page+0x6f/0xc0
Oct 20 06:48:43 cohuatl kernel: [15104.176574]  truncate_inode_pages_range+0x220/0x8b0
Oct 20 06:48:43 cohuatl kernel: [15104.181583]  reiser4_invalidate_pages+0x46/0x60 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.187192]  kill_hook_extent+0x157/0x4a0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.192205]  ? create_hook_extent+0xd0/0xd0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.197396]  call_kill_hooks+0xa7/0xe0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.202140]  ? kill_units+0x80/0x80 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.206622]  ? kill_head+0x20/0x20 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.211012]  ? keyeq+0x20/0x20 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.215075]  prepare_for_compact.isra.29+0x609/0x730 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.221034]  ? lock_object+0x96/0x100 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.225679]  ? _cond_resched+0x16/0x40
Oct 20 06:48:43 cohuatl kernel: [15104.229550]  ? jload_gfp+0x73/0x1d0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.234053]  kill_node40+0x3d/0xe0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.238469]  carry_cut+0x54/0x90 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.242813]  reiser4_carry+0x1c4/0x360 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.247562]  ? reiser4_add_carry+0x24/0x40 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.252662]  kill_node_content+0x143/0x210 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.260217]  cut_tree_worker_common+0x207/0x3f0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.265751]  ? reiser4_delete_node+0x220/0x220 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.271362]  reiser4_cut_tree_object+0xf2/0x200 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.276901]  ? validate_extended_coord+0x70/0x70 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.282513]  cut_file_items+0x11f/0x1c0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.287343]  shorten_file+0x31/0x320 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.291935]  delete_object_unix_file+0x3a/0xa0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.297387]  reiser4_evict_inode+0x80/0xd0 [reiser4]
Oct 20 06:48:43 cohuatl kernel: [15104.302655]  evict+0xc1/0x1c0
Oct 20 06:48:43 cohuatl kernel: [15104.305744]  do_unlinkat+0x13f/0x320
Oct 20 06:48:43 cohuatl kernel: [15104.309439]  do_syscall_64+0x55/0x110
Oct 20 06:48:43 cohuatl kernel: [15104.313232]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 20 06:48:43 cohuatl kernel: [15104.318402] RIP: 0033:0x7f05de584ea7
Oct 20 06:48:43 cohuatl kernel: [15104.322108] Code: Bad RIP value.
Oct 20 06:48:43 cohuatl kernel: [15104.325476] RSP: 002b:00007ffd5aef37a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
Oct 20 06:48:43 cohuatl kernel: [15104.333167] RAX: ffffffffffffffda RBX: 000055c53bd69df0 RCX: 00007f05de584ea7
Oct 20 06:48:43 cohuatl kernel: [15104.340424] RDX: 00007ffd5aef38f0 RSI: 00007ffd5aef38f0 RDI: 000055c53bd69df0
Oct 20 06:48:43 cohuatl kernel: [15104.347779] RBP: 000055c53bd87b70 R08: 000055c53bd87ce3 R09: 0000000000000071
Oct 20 06:48:43 cohuatl kernel: [15104.355032] R10: 0000000000000073 R11: 0000000000000246 R12: 000055c53bd6d2e0
Oct 20 06:48:43 cohuatl kernel: [15104.362288] R13: 00007ffd5aef38f0 R14: 00007f05df8fd6d8 R15: 000055c53bd87ce3
[15224.702275] INFO: task kworker/u2:0:7 blocked for more than 120 seconds.
[15224.709544]       Not tainted 4.18.0-2+reiser4.0.2-amd64 #1 Debian 4.18.15-1+reiser4.0.2
[15224.717767] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[15224.725761] kworker/u2:0    D    0     7      2 0x80000000
[15224.731382] Workqueue: writeback wb_workfn (flush-8:0)
[15224.736648] Call Trace:
[15224.739383]  ? __schedule+0x3f5/0x880
[15224.743174]  schedule+0x32/0x80
[15224.746508]  io_schedule+0x12/0x40
[15224.750035]  __lock_page+0x119/0x160
[15224.753808]  ? page_cache_tree_insert+0xe0/0xe0
[15224.758612]  write_jnodes_to_disk_extent+0x373/0x550 [reiser4]
[15224.764646]  ? zlook+0x15/0x70 [reiser4]
[15224.768698]  ? utmost_child_internal+0x45/0x80 [reiser4]
[15224.774131]  write_jnode_list+0x7f/0xb0 [reiser4]
[15224.778976]  reiser4_write_fq+0x81/0x230 [reiser4]
[15224.784005]  ? longterm_unlock_znode+0xbf/0x2a0 [reiser4]
[15224.789536]  flush_current_atom+0x3ae/0x8a0 [reiser4]
[15224.794769]  flush_some_atom+0x113/0x530 [reiser4]
[15224.799811]  reiser4_writeout+0x151/0x230 [reiser4]
[15224.804865]  reiser4_writeback_inodes+0x9c/0x130 [reiser4]
[15224.810486]  writeback_sb_inodes+0x8f/0xb0
[15224.814753]  __writeback_inodes_wb+0x87/0xb0
[15224.819186]  wb_writeback+0x288/0x320
[15224.822969]  ? wb_workfn+0x1a9/0x450
[15224.826664]  wb_workfn+0x1a9/0x450
[15224.830187]  process_one_work+0x191/0x370
[15224.834330]  worker_thread+0x4f/0x3b0
[15224.838107]  kthread+0xf8/0x130
[15224.841369]  ? rescuer_thread+0x340/0x340
[15224.845492]  ? kthread_create_worker_on_cpu+0x70/0x70
[15224.850722]  ret_from_fork+0x35/0x40


Any insight would be greatly appreciated. Thank you.


Best Professional Regards.


[1] reiser4-for-4.18.0.patch.gz @
< https://sourceforge.net/projects/reiser4/files/reiser4-for-linux-4.x/ >

-- 
Jose R R
http://metztli.it
---------------------------------------------------------------------------------------------
Download Metztli Reiser4: Debian Stretch w/ Linux 4.17 AMD64
---------------------------------------------------------------------------------------------
feats ZSTD compression https://sf.net/projects/metztli-reiser4/
-------------------------------------------------------------------------------------------
Official current Reiser4 resources: https://reiser4.wiki.kernel.org/
