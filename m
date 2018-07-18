Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E0AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB8D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeGRDGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:06:24 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:12530 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbeGRDGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:06:24 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 0DEAEA1FBDEF34ABD298;
        Wed, 18 Jul 2018 10:30:51 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6I2UXlT045814;
        Wed, 18 Jul 2018 10:30:33 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071810303786-784097 ;
          Wed, 18 Jul 2018 10:30:37 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn, huang.chong@zte.com.cn
Subject: [PATCH] virtio_balloon: fix another race between migration and ballooning
Date:   Wed, 18 Jul 2018 10:29:28 +0800
Message-Id: <1531880968-39607-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-18 10:30:37,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-18 10:30:25,
        Serialize complete at 2018-07-18 10:30:25
X-MAIL: mse01.zte.com.cn w6I2UXlT045814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic when with high memory pressure, calltrace looks like,

PID: 21439 TASK: ffff881be3afedd0 CPU: 16 COMMAND: "java"
 #0 [ffff881ec7ed7630] machine_kexec at ffffffff81059beb
 #1 [ffff881ec7ed7690] __crash_kexec at ffffffff81105942
 #2 [ffff881ec7ed7760] crash_kexec at ffffffff81105a30
 #3 [ffff881ec7ed7778] oops_end at ffffffff816902c8
 #4 [ffff881ec7ed77a0] no_context at ffffffff8167ff46
 #5 [ffff881ec7ed77f0] __bad_area_nosemaphore at ffffffff8167ffdc
 #6 [ffff881ec7ed7838] __node_set at ffffffff81680300
 #7 [ffff881ec7ed7860] __do_page_fault at ffffffff8169320f
 #8 [ffff881ec7ed78c0] do_page_fault at ffffffff816932b5
 #9 [ffff881ec7ed78f0] page_fault at ffffffff8168f4c8
    [exception RIP: _raw_spin_lock_irqsave+47]
    RIP: ffffffff8168edef RSP: ffff881ec7ed79a8 RFLAGS: 00010046
    RAX: 0000000000000246 RBX: ffffea0019740d00 RCX: ffff881ec7ed7fd8
    RDX: 0000000000020000 RSI: 0000000000000016 RDI: 0000000000000008
    RBP: ffff881ec7ed79a8 R8: 0000000000000246 R9: 000000000001a098
    R10: ffff88107ffda000 R11: 0000000000000000 R12: 0000000000000000
    R13: 0000000000000008 R14: ffff881ec7ed7a80 R15: ffff881be3afedd0
    ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
#10 [ffff881ec7ed79b0] balloon_page_putback at ffffffff811fbfb9
#11 [ffff881ec7ed79e0] putback_movable_pages at ffffffff811e3155
#12 [ffff881ec7ed7a10] compact_zone at ffffffff811a843f
#13 [ffff881ec7ed7a60] compact_zone_order at ffffffff811a85ac
#14 [ffff881ec7ed7b00] try_to_compact_pages at ffffffff811a8961
#15 [ffff881ec7ed7b60] __alloc_pages_direct_compact at ffffffff816827d6
#16 [ffff881ec7ed7bc0] __alloc_pages_slowpath at ffffffff81682f64
#17 [ffff881ec7ed7cb0] __alloc_pages_nodemask at ffffffff8118b775
#18 [ffff881ec7ed7d60] alloc_pages_vma at ffffffff811d2a6a
#19 [ffff881ec7ed7dc8] do_huge_pmd_anonymous_page at ffffffff811ebf93
#20 [ffff881ec7ed7e28] handle_mm_fault at ffffffff811b1c1f
#21 [ffff881ec7ed7ec0] __do_page_fault at ffffffff81692f84
#22 [ffff881ec7ed7f20] do_page_fault at ffffffff816932b5
#23 [ffff881ec7ed7f50] page_fault at ffffffff8168f4c8 

It happens in the pagefault and results in double pagefault
during compacting pages when memory allocation fails.

Analysed the vmcore, the page leads to second pagefault is corrupted
with _mapcount=-256, but private=0.

It's caused by the race between migration and ballooning, and lock
missing in virtballoon_migratepage() of virtio_balloon driver. 
This patch fix the bug.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Huang Chong <huang.chong@zte.com.cn>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 6b237e3..3988c09 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -513,7 +513,9 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	tell_host(vb, vb->inflate_vq);
 
 	/* balloon's page migration 2nd step -- deflate "page" */
+	spin_lock_irqsave(&vb_dev_info->pages_lock, flags);
 	balloon_page_delete(page);
+	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb, vb->pfns, page);
 	tell_host(vb, vb->deflate_vq);
-- 
2.7.4

