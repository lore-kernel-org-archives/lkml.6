Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73AEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8124D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rainbow-software.org header.i=@rainbow-software.org header.b="DZb6mHZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8124D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rainbow-software.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeJSCqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:46:09 -0400
Received: from smtp-1b-out-4.atlantis.sk ([80.94.52.30]:41195 "EHLO
        smtp-1b-out-4.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeJSCqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:46:09 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 22:46:05 EDT
Received: from [192.168.0.2] (188-167-58-14.dynamic.chello.sk [188.167.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1b.atlantis.sk (Postfix) with ESMTPSA id EA1B98344A98;
        Thu, 18 Oct 2018 20:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rainbow-software.org;
        s=atlsmtp; t=1539887693;
        bh=Zwevnf+J6jNmlNG5EJIqRZ14xF+cC2KARYqHxkEQuBs=;
        h=From:To:Subject:Date:Cc;
        b=DZb6mHZCeJtAjOSEX/10YcodKYT1lhmaHmSPqoFB6YwG1AgppmuBlgJ/u83t5Kyc1
         E5xd1PaxLg3HTQWh5JYL7xfECsKdE4JcjyyoQ/WcTp/Buf72/g2O2D77X+yMJo15Rg
         5PQbj86y9dvFzzsK4hQ8WAiFuZehsbG8wU1g7tnI=
From:   Ondrej Zary <linux@rainbow-software.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: bioset changes in 4.18 broke aha1542
Date:   Thu, 18 Oct 2018 20:34:51 +0200
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc:     Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201810182034.51724.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
aha1542 works fine in 4.17 but crashes in 4.18. It's hard to bisect because
of many commits that don't compile.
# only skipped commits left to test
# possible first bad commit: [52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b] fs: convert block_dev.c to bioset_init()
# possible first bad commit: [a47a28b74a5c7c27bf621276b85ad6c124651236] target: convert to bioset_init()/mempool_init()
# possible first bad commit: [6f1c819c219f7841079f0f43ab62727a55b0d849] dm: convert to bioset_init()/mempool_init()
# possible first bad commit: [afeee514ce7f4cab605beedd03be71ebaf0c5fc8] md: convert to bioset_init()/mempool_init()
# possible first bad commit: [d19936a26658a7a53edd5619d631ee2c2c3151a2] bcache: convert to bioset_init()/mempool_init()
# possible first bad commit: [b906bbb6997785d9ea0bd3f5585537afa6257c43] lightnvm: convert to bioset_init()/mempool_init()

Testing manually, a47a28b74a5c7c27bf621276b85ad6c124651236 works.
52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b does not compile
8ac9f7c1fd1d342e82ddf078425423b050652ba0 does not compile
e292d7bc63c8f2adb3dfda27910e805f1b6557f9 does not compile
dad08527525f9a8ac9c7f278864c65f94bc5e9b3 does not compile
943cf9f3ca16133dbd00f9a4cbfea46512fcb0e8 works
..
fedc3abe7bd2dcc4c80bcf3cff8708a3908d8219 works
04c4950d5b373ba712d928592e05e73510785bca crashes

I'm lost.

Crash log:
[   84.257426] scsi host2: Adaptec AHA-1542 (SCSI-ID 7) at IO 0x330, IRQ 11, DMA 7
[   84.322595] scsi host2: Adaptec 1542
[   84.334777] bounce: isa pool size: 16 pages
[   84.616334] scsi 2:0:1:0: Direct-Access     QUANTUM  LP240S GM240S01X 4.6  PQ: 0 ANSI: 2 CCS
[   85.918900] sd 2:0:1:0: Power-on or device reset occurred
[   85.930516] sd 2:0:1:0: Attached scsi generic sg1 type 0
[   85.938942] sd 2:0:1:0: [sdb] 479350 512-byte logical blocks: (245 MB/234 MiB)
[   85.952956] sd 2:0:1:0: [sdb] Write Protect is off
[   85.957408] sd 2:0:1:0: [sdb] Mode Sense: 8b 00 00 08
[   85.970009] sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   86.018610] WARNING: CPU: 0 PID: 50 at block/bio.c:458 bio_alloc_bioset+0x52/0x185
[   86.020095] Modules linked in: aha1542 i2c_dev nouveau psmouse serio_raw 8139cp sg wmi hwmon ttm parport_pc parport intel_agp
[   86.020095] CPU: 0 PID: 50 Comm: kworker/u2:1 Not tainted 4.17.0-rc4+ #288
[   86.020095] Hardware name:  /i440ZX-W977TF, BIOS 4.51 PG 07/12/00
[   86.020095] Workqueue: events_unbound async_run_entry_fn
[   86.020095] EIP: bio_alloc_bioset+0x52/0x185
[   86.020095] EFLAGS: 00010202 CPU: 0
[   86.020095] EAX: 00000000 EBX: c77948a0 ECX: c77948a0 EDX: 00000001
[   86.020095] ESI: c77948a0 EDI: 00000001 EBP: cf985ba8 ESP: cf985b80
[   86.020095]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   86.020095] CR0: 80050033 CR2: 004d10a4 CR3: 0c711000 CR4: 00000290
[   86.020095] Call Trace:
[   86.020095]  bio_clone_bioset+0x87/0x17a
[   86.020095]  blk_queue_bounce+0x179/0x25c
[   86.020095]  blk_mq_make_request+0x5a/0x295
[   86.020095]  ? blk_mq_try_issue_directly+0x8b/0x8b
[   86.020095]  generic_make_request+0x184/0x246
[   86.020095]  ? alloc_buffer_head+0x13/0x49
[   86.020095]  submit_bio+0xd9/0xf1
[   86.020095]  ? bio_alloc_bioset+0xe1/0x185
[   86.020095]  ? alloc_page_buffers+0x6a/0x8a
[   86.020095]  ? guard_bio_eod+0x2c/0xae
[   86.020095]  submit_bh_wbc.isra.45+0x109/0x113
[   86.020095]  submit_bh+0xa/0xc
[   86.020095]  block_read_full_page+0x1be/0x1df
[   86.020095]  ? bd_may_claim+0x35/0x35
[   86.020095]  ? add_to_page_cache_lru+0x94/0xaf
[   86.020095]  blkdev_readpage+0xf/0x11
[   86.020095]  do_read_cache_page+0x75/0x118
[   86.020095]  ? blkdev_writepages+0xa/0xa
[   86.020095]  ? blkdev_writepages+0xa/0xa
[   86.020095]  read_cache_page+0xe/0x10
[   86.020095]  read_dev_sector+0x23/0x73
[   86.020095]  adfspart_check_ICS+0x3c/0x1c6
[   86.020095]  ? vsnprintf+0x8a/0x323
[   86.020095]  ? snprintf+0x15/0x17
[   86.020095]  check_partition+0xe3/0x16a
[   86.020095]  rescan_partitions+0x7d/0x33e
[   86.020095]  ? down_write+0xb/0x2c
[   86.020095]  ? bd_set_size+0x3e/0x6f
[   86.020095]  __blkdev_get+0x1b0/0x38a
[   86.020095]  ? get_nr_inodes_unused+0x25/0x3b
[   86.020095]  blkdev_get+0x8b/0x243
[   86.020095]  ? wake_up_bit+0x14/0x17
[   86.020095]  ? put_device+0xf/0x11
[   86.020095]  ? disk_put_part+0xf/0x11
[   86.020095]  __device_add_disk+0x338/0x36a
[   86.020095]  device_add_disk+0xd/0xf
[   86.020095]  sd_probe_async+0xf1/0x178
[   86.020095]  ? sd_revalidate_disk+0x1476/0x1476
[   86.020095]  async_run_entry_fn+0x33/0xb7
[   86.020095]  process_one_work+0xed/0x17e
[   86.020095]  worker_thread+0x168/0x1fb
[   86.020095]  kthread+0xcc/0xce
[   86.020095]  ? rescuer_thread+0x219/0x219
[   86.020095]  ? kthread_cancel_delayed_work_sync+0xf/0xf
[   86.020095]  ret_from_fork+0x2e/0x38
[   86.020095] Code: 1b 01 00 00 6b c2 0c 8b 55 e8 83 c0 54 e8 6b 0e f4 ff 85 c0 89 c3 0f 85 07 01 00 00 e9 fe 00 00 00 83 79 3c 00 75 0b 85 d2 74 07 <0f> 0b e9 ed 00 00 00 8b 4d e8 64 a1 9c 56 74 c7 83 b8 1c 04 00
[   86.020095] ---[ end trace f40f2545ef2bd465 ]---
[   86.259982] BUG: unable to handle kernel NULL pointer dereference at 0000004c
[   86.263681] *pde = 00000000
[   86.263681] Oops: 0000 [#1] SMP
[   86.263681] Modules linked in: aha1542 i2c_dev nouveau psmouse serio_raw 8139cp sg wmi hwmon ttm parport_pc parport intel_agp
[   86.263681] CPU: 0 PID: 50 Comm: kworker/u2:1 Tainted: G        W         4.17.0-rc4+ #288
[   86.263681] Hardware name:  /i440ZX-W977TF, BIOS 4.51 PG 07/12/00
[   86.263681] Workqueue: events_unbound async_run_entry_fn
[   86.263681] EIP: blk_queue_bounce+0x179/0x25c
[   86.263681] EFLAGS: 00010286 CPU: 0
[   86.263681] EAX: 00000000 EBX: 00000001 ECX: c77948a0 EDX: 00000001
[   86.263681] ESI: 00000001 EDI: 00000002 EBP: cf985c2c ESP: cf985be8
[   86.263681]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   86.263681] CR0: 80050033 CR2: 0000004c CR3: 0c711000 CR4: 00000290
[   86.263681] Call Trace:
[   86.263681]  blk_mq_make_request+0x5a/0x295
[   86.263681]  ? blk_mq_try_issue_directly+0x8b/0x8b
[   86.263681]  generic_make_request+0x184/0x246
[   86.263681]  ? alloc_buffer_head+0x13/0x49
[   86.263681]  submit_bio+0xd9/0xf1
[   86.263681]  ? bio_alloc_bioset+0xe1/0x185
[   86.263681]  ? alloc_page_buffers+0x6a/0x8a
[   86.263681]  ? guard_bio_eod+0x2c/0xae
[   86.263681]  submit_bh_wbc.isra.45+0x109/0x113
[   86.263681]  submit_bh+0xa/0xc
[   86.263681]  block_read_full_page+0x1be/0x1df
[   86.263681]  ? bd_may_claim+0x35/0x35
[   86.263681]  ? add_to_page_cache_lru+0x94/0xaf
[   86.263681]  blkdev_readpage+0xf/0x11
[   86.263681]  do_read_cache_page+0x75/0x118
[   86.263681]  ? blkdev_writepages+0xa/0xa
[   86.263681]  ? blkdev_writepages+0xa/0xa
[   86.263681]  read_cache_page+0xe/0x10
[   86.263681]  read_dev_sector+0x23/0x73
[   86.263681]  adfspart_check_ICS+0x3c/0x1c6
[   86.263681]  ? vsnprintf+0x8a/0x323
[   86.263681]  ? snprintf+0x15/0x17
[   86.263681]  check_partition+0xe3/0x16a
[   86.263681]  rescan_partitions+0x7d/0x33e
[   86.263681]  ? down_write+0xb/0x2c
[   86.263681]  ? bd_set_size+0x3e/0x6f
[   86.263681]  __blkdev_get+0x1b0/0x38a
[   86.263681]  ? get_nr_inodes_unused+0x25/0x3b
[   86.263681]  blkdev_get+0x8b/0x243
[   86.263681]  ? wake_up_bit+0x14/0x17
[   86.263681]  ? put_device+0xf/0x11
[   86.263681]  ? disk_put_part+0xf/0x11
[   86.263681]  __device_add_disk+0x338/0x36a
[   86.263681]  device_add_disk+0xd/0xf
[   86.263681]  sd_probe_async+0xf1/0x178
[   86.263681]  ? sd_revalidate_disk+0x1476/0x1476
[   86.263681]  async_run_entry_fn+0x33/0xb7
[   86.263681]  process_one_work+0xed/0x17e
[   86.263681]  worker_thread+0x168/0x1fb
[   86.263681]  kthread+0xcc/0xce
[   86.263681]  ? rescuer_thread+0x219/0x219
[   86.263681]  ? kthread_cancel_delayed_work_sync+0xf/0xf
[   86.263681]  ret_from_fork+0x2e/0x38
[   86.263681] Code: d4 8b 00 e8 8a ac fe ff 8b 45 d4 89 18 58 b9 a0 48 79 c7 8b 45 c0 ba 00 00 40 01 83 e0 01 89 45 c0 8b 45 d4 8b 00 e8 81 6e fe ff <8b> 58 4c 89 45 d0 8b 45 d0 0f b7 40 44 39 45 cc 73 62 8b 33 8b
[   86.263681] EIP: blk_queue_bounce+0x179/0x25c SS:ESP: 0068:cf985be8
[   86.263681] CR2: 000000000000004c
[   86.263681] ---[ end trace f40f2545ef2bd466 ]---


-- 
Ondrej Zary
