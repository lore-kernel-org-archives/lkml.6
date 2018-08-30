Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49E520834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49E520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeH3TBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:01:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbeH3TBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65296B5CA;
        Thu, 30 Aug 2018 14:58:57 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 671B82166B41;
        Thu, 30 Aug 2018 14:58:55 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w7UEwtCR011857;
        Thu, 30 Aug 2018 10:58:55 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w7UEwtl3011853;
        Thu, 30 Aug 2018 10:58:55 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 30 Aug 2018 10:58:54 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>
cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Josef Bacik <jbacik@fb.com>
Subject: writeback throttling deadlock
Message-ID: <alpine.LRH.2.02.1808301053240.10353@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 14:58:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 14:58:57 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I report this deadlock in writeback throttling.

The deadlock happened in guest virtual machine with Debian kernel 4.17.17 
(4.17.0-3-amd64). The virtual machine had most of its memory swapped out, 
when I tried to shut it down, I got this deadlock. There was no io in 
flight.

[ 7489.721500] sysrq: SysRq : Show Blocked State
[ 7489.722797]   task                        PC stack   pid father
[ 7489.724489] kworker/u16:2   D    0   191      2 0x80000000
[ 7489.728397] Workqueue: writeback wb_workfn (flush-253:0)
[ 7489.762321] Call Trace:
[ 7489.786540]  ? __schedule+0x291/0x860
[ 7489.787518]  schedule+0x28/0x80
[ 7489.792302]  io_schedule+0x12/0x40
[ 7489.832883]  wbt_wait+0x1c1/0x350
[ 7489.873836]  ? finish_wait+0x80/0x80
[ 7489.877819]  blk_mq_make_request+0xe6/0x600
[ 7489.889763]  ? __split_and_process_bio+0xf7/0x170 [dm_mod]
[ 7489.928560]  generic_make_request+0x1a4/0x400
[ 7489.950406]  ? vring_mapping_error+0x16/0x50 [virtio_ring]
[ 7489.967869]  ? submit_bio+0x6c/0x140
[ 7489.968740]  submit_bio+0x6c/0x140
[ 7489.972731]  ? kmem_cache_alloc+0x1aa/0x1c0
[ 7489.998923]  ext4_io_submit+0x48/0x60 [ext4]
[ 7490.154733]  ext4_writepages+0x3ee/0xea0 [ext4]
[ 7490.173565]  ? __update_load_avg_se.isra.38+0x1cf/0x1e0
[ 7490.174916]  ? do_writepages+0x4b/0xe0
[ 7490.175855]  ? ext4_mark_inode_dirty+0x1d0/0x1d0 [ext4]
[ 7490.177261]  do_writepages+0x4b/0xe0
[ 7490.183513]  ? enqueue_entity+0x109/0x640
[ 7490.184549]  ? __writeback_single_inode+0x3d/0x330
[ 7490.185732]  __writeback_single_inode+0x3d/0x330
[ 7490.187222]  writeback_sb_inodes+0x1b2/0x460
[ 7490.188352]  __writeback_inodes_wb+0x5d/0xb0
[ 7490.189460]  wb_writeback+0x271/0x300
[ 7490.190357]  ? __switch_to_asm+0x34/0x70
[ 7490.191333]  ? wb_workfn+0x18d/0x410
[ 7490.192265]  wb_workfn+0x18d/0x410
[ 7490.193148]  process_one_work+0x17b/0x360
[ 7490.194325]  worker_thread+0x2e/0x390
[ 7490.195342]  ? process_one_work+0x360/0x360
[ 7490.196436]  kthread+0x113/0x130
[ 7490.198905]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 7490.200254]  ret_from_fork+0x35/0x40
[ 7490.201191] jbd2/dm-0-8     D    0   234      2 0x80000000
[ 7490.202555] Call Trace:
[ 7490.203183]  ? __schedule+0x291/0x860
[ 7490.204116]  ? __switch_to_asm+0x40/0x70
[ 7490.205204]  ? __switch_to_asm+0x34/0x70
[ 7490.206260]  ? bit_wait+0x50/0x50
[ 7490.207068]  schedule+0x28/0x80
[ 7490.207870]  io_schedule+0x12/0x40
[ 7490.208762]  bit_wait_io+0xd/0x50
[ 7490.209614]  __wait_on_bit+0x44/0x80
[ 7490.210518]  out_of_line_wait_on_bit+0x91/0xb0
[ 7490.211618]  ? init_wait_var_entry+0x40/0x40
[ 7490.216703]  jbd2_journal_commit_transaction+0x1036/0x17e0 [jbd2]
[ 7490.219424]  ? __switch_to_asm+0x40/0x70
[ 7490.220485]  ? kjournald2+0xbd/0x270 [jbd2]
[ 7490.221471]  kjournald2+0xbd/0x270 [jbd2]
[ 7490.222667]  ? finish_wait+0x80/0x80
[ 7490.223617]  ? commit_timeout+0x10/0x10 [jbd2]
[ 7490.224810]  kthread+0x113/0x130
[ 7490.225736]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 7490.227042]  ret_from_fork+0x35/0x40
[ 7490.228066] shutdown        D    0  6441   1837 0x00000004
[ 7490.229608] Call Trace:
[ 7490.230247]  ? __schedule+0x291/0x860
[ 7490.231205]  ? default_file_splice_write+0x20/0x20
[ 7490.232495]  schedule+0x28/0x80
[ 7490.233301]  wb_wait_for_completion+0x5e/0x90
[ 7490.235101]  ? finish_wait+0x80/0x80
[ 7490.236266]  sync_inodes_sb+0xc9/0x2b0
[ 7490.237269]  ? apic_timer_interrupt+0xa/0x20
[ 7490.238375]  ? default_file_splice_write+0x20/0x20
[ 7490.239650]  ? default_file_splice_write+0x20/0x20
[ 7490.240929]  iterate_supers+0x98/0x100
[ 7490.242529]  ksys_sync+0x40/0xb0
[ 7490.243756]  __ia32_sys_sync+0xa/0x10
[ 7490.244828]  do_syscall_64+0x55/0x110
[ 7490.245802]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

