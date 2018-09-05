Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B0FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F2920652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F2920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeIENYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:24:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:51793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIENYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:24:46 -0400
Received: from homer.simpson.net ([185.191.218.38]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLO9y-1fwvd33UJ8-000YXd; Wed, 05
 Sep 2018 10:55:23 +0200
Message-ID: <1536137722.4813.66.camel@gmx.de>
Subject: [regression/bisected] 4.19 cycle boot time IO stalls
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@suse.de>, Jens Axboe <axboe@kernel.dk>
Date:   Wed, 05 Sep 2018 10:55:22 +0200
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:o85ibtPkd6MWIt4vrtref4eZ0q29I9o8Zj3FNK7UN25REwkVztb
 mJnFjf9O73MJ/zdHDORhPBFGoKCGnkXvWFV7qU3E+yY0tqvAYzHBoPBF/MOr+mUT0/we79x
 rAFaF2z7po8j+fGcfXYbQjLSvYHNhTZN8HXhkooAmH9ecMXJziSsYuczCFwgO1vpfABEZlS
 irbyIskKOujA/hva+Bqsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EhKIu3IUKqY=:w/KqnkAedujgFYbMwGtW5T
 U0ArnxJvXFbqgjl32KihJLe9Ofay2Mju4aGO5IwpMq5Eyt3mK+HI1oZwW5uPhKeAgA7BNcXPO
 5xOI0a8qyDiScaL97DOl90VUJ9DfpvLISo+ZCrhYggOWdH+4coKzzWMIUYLYbJ4y4VJ5qvMpb
 bH9ZBXIgbs+9K7RdQgwxhCh1ROoCA/29sWe37C4E74SzgrTJ+u5SUlPBNpI3sylXIOi8QzdTY
 dphI5qvHV+pLYiv+gHpIivXCPfV/tyuMcApgFBZ+lgAVYDLvk1E5v1xAVreS0FQSpmGXU2+Z9
 WAnGVzibWUE+N4aAoR6OUxt1Q/sLsxhQFsUbpxziuy6dPGDLzGGvipcbIzQpKYQCLps/0X19c
 yqMxg39zz+VxXg/zfZpcBfCopxYmlwEpN6qEznqhMoorgjX77LcU9HIdpB4S47+HIZ422j4cQ
 0YkM397+v6Q+vNGaIFhejyMZ+SIK/lia/oN4AxGZyJDBHR31LTAYsweD74k4VW62NdVDtOiw4
 1GSQX98OvU/NpBxm7zax1YIq+F1daHdKyzLtiXmMQd81wGgo6/dBzL0xBV4LpNepIe+GfAgr6
 ABUuMJAo4ryh7I1phpCnLno4xf+OseL2eBTIw9C9VUerR7RQSslxHH/dvSW05mNMGx2NfN/C7
 9S+faCLjVk7AJBwIsoRzNP3EFjY8hzav2dZ1Ge2cBSsR/VHTCGj4osGEa35c6BrhgfGQUmwBI
 YUJI2bLhPtOeM41yEZfOOpuhlmiDjZ5RaEDu/8aJJcNRoVkEuiqIgbub8vouRt6rCd5ojFhkp
 ohzVq7R
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've been seeing $subject, decided to take the time to try to bisect
the little bugger.  The hangs are not 100% repeatable, and while
bisection with a 5 boot go/nogo threshold seemed to go smoothly, it
ended up fingering a merge commit (sigh).

Box has an SSD (unused only by windows 10 box came with) and 3 spinning
rust buckets that I normally use with BFQ via a udev rule, but CFQ does
the same, so scheduler is seemingly irrelevant.  However, in 7 crash
dumps, all of which look about like the data below the bisect log,
there is something relevant, namely the hung 'tlp' task (powersaving
script of some sort for laptops according to the package description). 
That knob twiddling script is present/hung in all, making me a tad
suspicious, and indeed, testing with the final (bad) kernel, all I have
to do to eliminate hangs is to remove the 'tlp' package.  Verified via
remove, 5 boots work fine, reinstall, 2 of 5 hang, remove again, 10 of
10 work fine, reinstall, 2 in a row hang.

Seems pretty certain that tlp script is what inspires bug to raise its
ugly head.  WRT bisection result itself, munged merge seems far less
likely than a false negative having knocked bisection off course.

72f02ba66bd83b54054da20eae550123de84da6f is the first bad commit
git bisect start
# good: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect good 94710cac0ef4ee177a63b5227664b38c95bbf703
# bad: [60c1f89241d49bacf71035470684a8d7b4bb46ea] Merge tag 'dma-mapping-4.19-2' of git://git.infradead.org/users/hch/dma-mapping
git bisect bad 60c1f89241d49bacf71035470684a8d7b4bb46ea
# good: [54dbe75bbf1e189982516de179147208e90b5e45] Merge tag 'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
git bisect good 54dbe75bbf1e189982516de179147208e90b5e45
# bad: [d5acba26bfa097a618be425522b1ec4269d3edaf] Merge tag 'char-misc-4.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad d5acba26bfa097a618be425522b1ec4269d3edaf
# bad: [9bd553929f68921be0f2014dd06561e0c8249a0d] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect bad 9bd553929f68921be0f2014dd06561e0c8249a0d
# bad: [f91e654474d413201ae578820fb63f8a811f6c4e] Merge branch 'next-integrity' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect bad f91e654474d413201ae578820fb63f8a811f6c4e
# good: [c1c2ad82c772966d3cdb9a4852329fa2cf71853a] Merge tag 'edac_for_4.19' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp
git bisect good c1c2ad82c772966d3cdb9a4852329fa2cf71853a
# good: [51372570ac3c919b036e760f4ca449e81cf8e995] scsi: core: use blk_mq_run_hw_queues in scsi_kick_queue
git bisect good 51372570ac3c919b036e760f4ca449e81cf8e995
# good: [ac7da1b787d9ea43680c487613269742c48d8747] Merge branches 'clk-actions-s700', 'clk-exynos-unused', 'clk-qcom-dispcc-845', 'clk-scmi-round' and 'clk-cs2000-spdx' into clk-next
git bisect good ac7da1b787d9ea43680c487613269742c48d8747
# good: [6ff0497402ef7269ee6a72f62eb85adaa7a4768e] gpiolib: Fix of_node inconsistency
git bisect good 6ff0497402ef7269ee6a72f62eb85adaa7a4768e
# bad: [2b2f2aedba985108cbc92a761ac0d9fc4c774616] Merge tag 'gfs2-4.19.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect bad 2b2f2aedba985108cbc92a761ac0d9fc4c774616
# good: [1d45bb7f9d2a5cbae1e5d9a5f72adad84db4d318] gfs2: Use iomap for stuffed direct I/O reads
git bisect good 1d45bb7f9d2a5cbae1e5d9a5f72adad84db4d318
# good: [db06f826ec12bf0701ea7fc0a3c0aa00b84417c8] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good db06f826ec12bf0701ea7fc0a3c0aa00b84417c8
# good: [3f30f929bb17877ebc1653c6f3ff41863f1ba524] gfs2: cleanup: call gfs2_rgrp_ondisk2lvb from gfs2_rgrp_out
git bisect good 3f30f929bb17877ebc1653c6f3ff41863f1ba524
# good: [dffe12a82826082d2129ef91b17b257254cb60fc] gfs2: Fix gfs2_testbit to use clone bitmaps
git bisect good dffe12a82826082d2129ef91b17b257254cb60fc
# good: [f5580d0f8bf60993a5fbc73ee04678070ffbba57] gfs2: eliminate update_rgrp_lvb_unlinked
git bisect good f5580d0f8bf60993a5fbc73ee04678070ffbba57
# bad: [72f02ba66bd83b54054da20eae550123de84da6f] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad 72f02ba66bd83b54054da20eae550123de84da6f
# first bad commit: [72f02ba66bd83b54054da20eae550123de84da6f] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi

crash> ps | grep UN
    417      2   7  ffff8803f8992940  UN   0.0       0      0  [kworker/u16:4]
    476      2   7  ffff8803f02e9b80  UN   0.0       0      0  [jbd2/sdb3-8]
   3078   3072   6  ffff8803fb70e040  UN   1.0 1706708 177212  sddm-greeter
   3204   3155   0  ffff8803fb6e3700  UN   0.0   13784   3520  tlp
crash> bt 417
PID: 417    TASK: ffff8803f8992940  CPU: 7   COMMAND: "kworker/u16:4"
 #0 [ffff8803f04636f0] __schedule at ffffffff815cca93
 #1 [ffff8803f0463780] schedule at ffffffff815cd0a8
 #2 [ffff8803f0463788] io_schedule at ffffffff8108fb72
 #3 [ffff8803f0463798] blk_mq_get_tag at ffffffff812b3ff1
 #4 [ffff8803f0463800] blk_mq_get_request at ffffffff812aee79
 #5 [ffff8803f0463838] blk_mq_make_request at ffffffff812b153e
 #6 [ffff8803f04638a8] generic_make_request at ffffffff812a54c2
 #7 [ffff8803f0463900] __test_set_page_writeback at ffffffff81172a4e
 #8 [ffff8803f0463950] ext4_bio_write_page at ffffffffa01530d9 [ext4]
 #9 [ffff8803f0463998] mpage_submit_page at ffffffffa0134903 [ext4]
#10 [ffff8803f04639b0] mpage_process_page_bufs at ffffffffa0134a06 [ext4]
#11 [ffff8803f04639c8] mpage_prepare_extent_to_map at ffffffffa0135812 [ext4]
#12 [ffff8803f0463a98] ext4_writepages at ffffffffa0139ffd [ext4]
#13 [ffff8803f0463be8] do_writepages at ffffffff81173dec
#14 [ffff8803f0463c60] __writeback_single_inode at ffffffff8120f4fd
#15 [ffff8803f0463ca8] writeback_sb_inodes at ffffffff8120fbda
#16 [ffff8803f0463d38] __writeback_inodes_wb at ffffffff8120fe7d
#17 [ffff8803f0463d78] wb_writeback at ffffffff812101c3
#18 [ffff8803f0463e10] wb_workfn at ffffffff8121201a
#19 [ffff8803f0463e98] process_one_work at ffffffff8107e895
#20 [ffff8803f0463ed8] worker_thread at ffffffff8107eaa0
#21 [ffff8803f0463f10] kthread at ffffffff810844e3
#22 [ffff8803f0463f50] ret_from_fork at ffffffff81600205
crash> bt 476
PID: 476    TASK: ffff8803f02e9b80  CPU: 7   COMMAND: "jbd2/sdb3-8"
 #0 [ffff8803f23b7c70] __schedule at ffffffff815cca93
 #1 [ffff8803f23b7d00] schedule at ffffffff815cd0a8
 #2 [ffff8803f23b7d08] jbd2_journal_commit_transaction at ffffffffa0100fec [jbd2]
 #3 [ffff8803f23b7ea8] kjournald2 at ffffffffa010668d [jbd2]
 #4 [ffff8803f23b7f10] kthread at ffffffff810844e3
 #5 [ffff8803f23b7f50] ret_from_fork at ffffffff81600205
crash> bt 3078
PID: 3078   TASK: ffff8803fb70e040  CPU: 6   COMMAND: "sddm-greeter"
 #0 [ffff8803ef7dfcd8] __schedule at ffffffff815cca93
 #1 [ffff8803ef7dfd68] schedule at ffffffff815cd0a8
 #2 [ffff8803ef7dfd70] io_schedule at ffffffff8108fb72
 #3 [ffff8803ef7dfd80] generic_file_read_iter at ffffffff81167607
 #4 [ffff8803ef7dfe58] __vfs_read at ffffffff811e44db
 #5 [ffff8803ef7dfed0] vfs_read at ffffffff811e45d9
 #6 [ffff8803ef7dff00] ksys_read at ffffffff811e4b42
 #7 [ffff8803ef7dff38] do_syscall_64 at ffffffff810021ab
 #8 [ffff8803ef7dff50] entry_SYSCALL_64_after_hwframe at ffffffff81600088
    RIP: 00007f12702eeb78  RSP: 00007ffcbad8f1a0  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 000055aeebda4558  RCX: 00007f12702eeb78
    RDX: 0000000000004000  RSI: 000055aeebda4558  RDI: 000000000000001f
    RBP: 0000000000004000   R8: 0000000000000000   R9: 0000000000000000
    R10: fffffffffffffef8  R11: 0000000000000246  R12: 0000000000004000
    R13: 0000000000004000  R14: 000000000000001f  R15: 000055aeebda4558
    ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b
crash> bt 3204
PID: 3204   TASK: ffff8803fb6e3700  CPU: 0   COMMAND: "tlp"
 #0 [ffff8803fbb8bc20] __schedule at ffffffff815cca93
 #1 [ffff8803fbb8bcb0] schedule at ffffffff815cd0a8
 #2 [ffff8803fbb8bcb8] io_schedule at ffffffff8108fb72
 #3 [ffff8803fbb8bcc8] generic_file_read_iter at ffffffff81167607
 #4 [ffff8803fbb8bda0] __vfs_read at ffffffff811e44db
 #5 [ffff8803fbb8be18] vfs_read at ffffffff811e45d9
 #6 [ffff8803fbb8be48] kernel_read at ffffffff811e46ac
 #7 [ffff8803fbb8be60] prepare_binprm at ffffffff811ea206
 #8 [ffff8803fbb8be98] __do_execve_file at ffffffff811ebdf5
 #9 [ffff8803fbb8bf10] __x64_sys_execve at ffffffff811ec1e4
#10 [ffff8803fbb8bf38] do_syscall_64 at ffffffff810021ab
#11 [ffff8803fbb8bf50] entry_SYSCALL_64_after_hwframe at ffffffff81600088
    RIP: 00007fc972412477  RSP: 00007ffc81d0a458  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 0000559e02ed3ad0  RCX: 00007fc972412477
    RDX: 0000559e02d583a0  RSI: 0000559e02eda3d0  RDI: 0000559e02ed3ad0
    RBP: 0000559e02eda3d0   R8: 0000559e02ed66c0   R9: 0000559e02ed8180
    R10: 00000000000005b8  R11: 0000000000000202  R12: 0000559e02edf9b0
    R13: 0000559e02d583a0  R14: 0000000000000000  R15: 0000559e02ed53e0
    ORIG_RAX: 000000000000003b  CS: 0033  SS: 002b
crash>
