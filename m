Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15644C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D446D20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D446D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbeKLGQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50798 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730595AbeKLFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsk-0000oN-Ie; Sun, 11 Nov 2018 19:58:54 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001nj-PD; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jiang Biao" <jiang.biao2@zte.com.cn>,
        "Huang Chong" <huang.chong@zte.com.cn>,
        "Michael S. Tsirkin" <mst@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.732144608@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 303/366] virtio_balloon: fix another race between
 migration and ballooning
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiang Biao <jiang.biao2@zte.com.cn>

commit 89da619bc18d79bca5304724c11d4ba3b67ce2c6 upstream.

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

It happens in the pagefault and results in double pagefault
during compacting pages when memory allocation fails.

Analysed the vmcore, the page leads to second pagefault is corrupted
with _mapcount=-256, but private=0.

It's caused by the race between migration and ballooning, and lock
missing in virtballoon_migratepage() of virtio_balloon driver.
This patch fix the bug.

Fixes: e22504296d4f64f ("virtio_balloon: introduce migration primitives to balloon pages")
Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Huang Chong <huang.chong@zte.com.cn>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -413,7 +413,9 @@ static int virtballoon_migratepage(struc
 	tell_host(vb, vb->inflate_vq);
 
 	/* balloon's page migration 2nd step -- deflate "page" */
+	spin_lock_irqsave(&vb_dev_info->pages_lock, flags);
 	balloon_page_delete(page);
+	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb->pfns, page);
 	tell_host(vb, vb->deflate_vq);

