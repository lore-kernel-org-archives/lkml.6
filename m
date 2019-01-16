Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7617C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892B9206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch14TTRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfAPUfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:35:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43027 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbfAPUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:35:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so3549420plb.10;
        Wed, 16 Jan 2019 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QjoILPpE8+jmI+dpdxf3bsz/uDnOAbXPRoRS0acOhnI=;
        b=ch14TTRb0rQ8NH1Wli3Z1ZmDoQ88maAkfz2wW6NSckvHYPlxunHB6NupCKGhL0k8CJ
         h0fX8SU9zkqE77zwv0hFZlR2fo045+xNvW+/RfQlp70rr+GMJ2HMuKNnNE+UrJPOjUFy
         8lhPLIhR0ddKbUpKbb6ulyyVAx1LKM+lboCM6/jnlvNZ8uXLkga2wSENYT1UCmiKb7le
         iXx7xe2FUfG6Ymw7I7BZyGl26tw8UmhrykcFhzVTs39cie63kK3bV9xYMaUoa9ALutf/
         6l5nsnKtIOenTAQ7YnA9ooJtnu5kdpS63Mc3n5zHdZErgmDxRpuqU0WwuFLF1cPeGwiv
         u6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjoILPpE8+jmI+dpdxf3bsz/uDnOAbXPRoRS0acOhnI=;
        b=jbS0iNJNnaRWHwwIr3PBJDdWTfmmfRgvxpeQiIuow+xH/lwghPJZdxkA2MBor7QRT4
         U+GNfs1zoXaqBlgkYP5U//pkVv3fTeAfSMML35wiD42ZJjcO/MZfXVkvsHCl4K65UQH+
         dwyyKAk+D9BmBFgP92uUQoki/z5mXLoaiDQC4pfvg4uzpaXTZWMkFNSgC+PIUiKMRPpk
         28RKxJVp/rr1NKzrkO5018RO/4VWS3SsfnCoiVwk5/ukTJ5ELA2PTgRl1uMFkLtxuEE4
         AYAsG2WaCuOAt7n53HHJnSdkl9crarMsbgbB9jft/aEMlab4TxDq5ZFdeiPUzwvwlJGn
         YpZQ==
X-Gm-Message-State: AJcUukfaXk1GE9CivHnXU+IBbFk1Mf2uLNCPq3W2k8B9LP+LmcJNRKq1
        w9lRshis6Mv5zbX07+2O/2I=
X-Google-Smtp-Source: ALg8bN4HEV21pdpFSkVQczoX0xmusclqELu3NiRADLPouvLAs3qYV0eJ51BkEgudtGB9IL4+gvxKIA==
X-Received: by 2002:a17:902:8c98:: with SMTP id t24mr11818662plo.130.1547670950406;
        Wed, 16 Jan 2019 12:35:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t87sm26118939pfk.122.2019.01.16.12.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 12:35:49 -0800 (PST)
Date:   Wed, 16 Jan 2019 12:35:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: linux-next: Tree for Jan 16
Message-ID: <20190116203547.GA788@roeck-us.net>
References: <20190116173838.042db659@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116173838.042db659@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:38:38PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190115:
> 
> The vfs tree still had its build failure for which I applied a patch.
> 
> The drm-misc tree gained conflicts against the drm-intel tree.
> 
> The mali-dp tree still had its failure for which I applied a merge
> fix patch.
> 
> The block tree gained a conflict against the fscrypt tree and build
> failures for which I applied 2 merge fix patches and a fix patch.
> 
> Non-merge commits (relative to Linus' tree): 1975
>  2069 files changed, 67760 insertions(+), 30784 deletions(-)
> 

Time for a damage report.

Build results:
	total: 159 pass: 148 fail: 11
Failed builds: 
	alpha:allmodconfig 
	ia64:defconfig 
	ia64:allnoconfig 
	ia64:tinyconfig 
	powerpc:ppc6xx_defconfig 
	sh:defconfig 
	sh:allnoconfig 
	sh:tinyconfig 
	sh:dreamcast_defconfig 
	sh:microdev_defconfig 
	sh:shx3_defconfig 
Qemu test results:
	total: 343 pass: 230 fail: 113
	[details dropped]

I won't address the build failures; I assume the culprits know through
0day. See https://kerneltests.org/builders/ for details and logs.

The main culprit of the qemu test failures is a block subsystem commit.
bisect log and bisected backtrace below. It may well be that there are
other failures in that subsystem - backtraces are not always the same.
Affected architectures are arm, mips, ppc, parisc, sparc, and x86.
sh4 may be affected as well, but all sh4 images fail to build and can
not be tested at this time.

Also, I suspect that the observed crashes may hide other failures - 
I had seen some boot stalls in next-20190115 (not bisected).

Guenter

---
# bad: [cbeb3db684f72d744e74c567542faac796d9cbd8] Add linux-next specific files for 20190116
# good: [1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8] Linux 5.0-rc2
git bisect start 'HEAD' 'v5.0-rc2'
# good: [11822c837bf744c38fab8370899338884d30f30b] Merge remote-tracking branch 'nfc-next/master'
git bisect good 11822c837bf744c38fab8370899338884d30f30b
# bad: [8c4aa656d7befa3ca3c5c2856eeabc30317d9775] Merge remote-tracking branch 'apparmor/apparmor-next'
git bisect bad 8c4aa656d7befa3ca3c5c2856eeabc30317d9775
# good: [2465c219c523ed47f2adae88805d3bb68fbc51c0] Merge remote-tracking branch 'drm-misc/for-linux-next'
git bisect good 2465c219c523ed47f2adae88805d3bb68fbc51c0
# good: [afa8e20f9d4d5aacf9158b7be36ec81ec499aa5c] Merge remote-tracking branch 'sound-asoc/for-next'
git bisect good afa8e20f9d4d5aacf9158b7be36ec81ec499aa5c
# bad: [ae563d4fc73ad2cfd1408e72fd3aa67c4f5c9c8d] Merge remote-tracking branch 'kgdb/kgdb-next'
git bisect bad ae563d4fc73ad2cfd1408e72fd3aa67c4f5c9c8d
# bad: [6cb6b5a89b70120f840f37e94ee10f9b8ffdabd9] Merge remote-tracking branch 'block/for-next'
git bisect bad 6cb6b5a89b70120f840f37e94ee10f9b8ffdabd9
# bad: [93670fad03e97d5526b23fe67a3fe2be52e21732] block: kill QUEUE_FLAG_NO_SG_MERGE
git bisect bad 93670fad03e97d5526b23fe67a3fe2be52e21732
# bad: [beab05e0114623255b4d5cd3776df6da26be42b0] block: introduce bvec_last_segment()
git bisect bad beab05e0114623255b4d5cd3776df6da26be42b0
# good: [f3effe4c1240a36a487ba1ff134478236a69b32d] block: rename bvec helpers
git bisect good f3effe4c1240a36a487ba1ff134478236a69b32d
# good: [cad1e6bb0ecfebbb3168ebc46dcf5e39f7bf2268] block: introduce bio_for_each_bvec() and rq_for_each_bvec()
git bisect good cad1e6bb0ecfebbb3168ebc46dcf5e39f7bf2268
# bad: [73f4209ccda9cf3d403692517bc90d5431c1ef2d] block: use bio_for_each_bvec() to map sg
git bisect bad 73f4209ccda9cf3d403692517bc90d5431c1ef2d
# bad: [258cfdfaf7bd729e759a0a91fd00ac9794796ad3] block: use bio_for_each_bvec() to compute multi-page bvec count
git bisect bad 258cfdfaf7bd729e759a0a91fd00ac9794796ad3
# first bad commit: [258cfdfaf7bd729e759a0a91fd00ac9794796ad3] block: use bio_for_each_bvec() to compute multi-page bvec count

--
Bisected backtrace:

[   24.745267] BUG: unable to handle kernel paging request at 0959bd38
[   24.745267] #PF error: [normal kernel read fault]
[   24.745267] *pde = 00000000 
[   24.745267] Oops: 0000 [#1] SMP
[   24.745267] CPU: 0 PID: 7 Comm: kworker/u2:0 Not tainted 5.0.0-rc2-next-20190116 #1
[   24.745267] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[   24.745267] Workqueue: events_unbound async_run_entry_fn
[   24.745267] EIP: blk_rq_map_sg+0x1cd/0x510
[   24.745267] Code: e8 a8 f2 01 00 8b 5d d0 8b 75 e8 89 f9 03 75 cc 89 f2 f7 d2
23 93 54 03 00 00 83 c2 01 39 bb 6c 03 00 00 0f 46 8b 6c 03 00 00 <8b> 18 39 ca
0f 47 d1 89 f1 c1 ee 0c 83 e3 03 81 e1 ff 0f 00 00 89
[   24.745267] EAX: 0959bd38 EBX: cfbfb500 ECX: 000000ff EDX: 00000000
[   24.745267] ESI: 00000000 EDI: 000000ff EBP: cf8b3bd8 ESP: cf8b3b94
[   24.745267] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00200212
[   24.745267] CR0: 80050033 CR2: 0959bd38 CR3: 09e72000 CR4: 003406d0
[   24.745267] Call Trace:
[   24.745267]  scsi_init_sgtable+0x30/0x70
[   24.745267]  scsi_init_io+0x2a/0x80
[   24.745267]  scsi_queue_rq+0x64e/0xa50
[   24.745267]  blk_mq_dispatch_rq_list+0x318/0x4c0
[   24.745267]  blk_mq_do_dispatch_sched+0x6d/0xf0
[   24.745267]  blk_mq_sched_dispatch_requests+0xee/0x150
[   24.745267]  __blk_mq_run_hw_queue+0x59/0xd0
[   24.745267]  __blk_mq_delay_run_hw_queue+0x177/0x1a0
[   24.745267]  blk_mq_run_hw_queue+0x72/0xc0
[   24.745267]  ? dd_merged_requests+0xb0/0xb0
[   24.745267]  blk_mq_sched_insert_request+0x103/0x190
[   24.745267]  blk_execute_rq_nowait+0x3c/0x50
[   24.745267]  blk_execute_rq+0x52/0x80
[   24.745267]  ? blk_execute_rq_nowait+0x50/0x50
[   24.745267]  __scsi_execute+0xd9/0x1d0
[   24.745267]  scsi_vpd_inquiry+0x62/0xb0
[   24.745267]  ? regcache_read+0x12f/0x160
[   24.745267]  scsi_get_vpd_buf+0x2f/0x90
[   24.745267]  scsi_attach_vpd+0x32/0xc0
[   24.745267]  scsi_probe_and_add_lun+0xa6e/0xb70
[   24.745267]  ? __pm_runtime_resume+0x4f/0x90
[   24.745267]  __scsi_add_device+0x103/0x120
[   24.745267]  ata_scsi_scan_host+0x8e/0x1b0
[   24.745267]  async_port_probe+0x3b/0x4b
[   24.745267]  ? ata_port_probe+0x30/0x30
[   24.745267]  async_run_entry_fn+0x35/0xf0
[   24.745267]  process_one_work+0x1e4/0x530
[   24.745267]  worker_thread+0x39/0x3d0
[   24.745267]  kthread+0xf2/0x110
[   24.745267]  ? drain_workqueue+0x170/0x170
[   24.745267]  ? kthread_park+0x90/0x90
[   24.745267]  ret_from_fork+0x2e/0x38
[   24.745267] Modules linked in:
[   24.745267] CR2: 000000000959bd38
[   24.745267] ---[ end trace 3e516846ce7ccae9 ]---
[   24.745267] EIP: blk_rq_map_sg+0x1cd/0x510
[   24.745267] Code: e8 a8 f2 01 00 8b 5d d0 8b 75 e8 89 f9 03 75 cc 89 f2 f7 d2
23 93 54 03 00 00 83 c2 01 39 bb 6c 03 00 00 0f 46 8b 6c 03 00 00 <8b> 18 39 ca
0f 47 d1 89 f1 c1 ee 0c 83 e3 03 81 e1 ff 0f 00 00 89
[   24.745267] EAX: 0959bd38 EBX: cfbfb500 ECX: 000000ff EDX: 00000000
[   24.745267] ESI: 00000000 EDI: 000000ff EBP: cf8b3bd8 ESP: c9e7649c
[   24.745267] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00200212
[   24.745267] CR0: 80050033 CR2: 0959bd38 CR3: 09e72000 CR4: 003406d0
[   24.745267] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:34
[   24.745267] in_atomic(): 1, irqs_disabled(): 1, pid: 7, name: kworker/u2:0
[   24.745267] INFO: lockdep is turned off.
[   24.745267] irq event stamp: 49332
[   24.745267] hardirqs last  enabled at (49331): [<c8c0176a>] trace_hardirqs_on_thunk+0xc/0x10
[   24.745267] hardirqs last disabled at (49332): [<c8c0177a>] trace_hardirqs_off_thunk+0xc/0x12
[   24.745267] softirqs last  enabled at (49330): [<c983dba2>] __do_softirq+0x2c2/0x3d7
[   24.745267] softirqs last disabled at (49323): [<c8c1d090>] call_on_stack+0x40/0x50
[   24.745267] CPU: 0 PID: 7 Comm: kworker/u2:0 Tainted: G      D 5.0.0-rc2-next-20190116 #1
[   24.745267] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[   24.745267] Workqueue: events_unbound async_run_entry_fn
[   24.745267] Call Trace:
[   24.745267]  dump_stack+0x66/0x8e
[   24.745267]  ___might_sleep.cold.85+0x8e/0x9f
[   24.745267]  __might_sleep+0x2e/0x80
[   24.745267]  exit_signals+0x25/0x220
[   24.745267]  do_exit+0x89/0xb80
[   24.745267]  ? kthread+0xf2/0x110
[   24.745267]  ? drain_workqueue+0x170/0x170
[   24.745267]  rewind_stack_do_exit+0x11/0x13

