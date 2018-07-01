Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94323C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DBE2530A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DBE2530A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031311AbeGAQgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:36:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031269AbeGAQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:36:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 935EB49B;
        Sun,  1 Jul 2018 16:36:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 153/157] block: Fix cloning of requests with a special payload
Date:   Sun,  1 Jul 2018 18:23:45 +0200
Message-Id: <20180701160900.883554494@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 297ba57dcdec7ea37e702bcf1a577ac32a034e21 upstream.

This patch avoids that removing a path controlled by the dm-mpath driver
while mkfs is running triggers the following kernel bug:

    kernel BUG at block/blk-core.c:3347!
    invalid opcode: 0000 [#1] PREEMPT SMP KASAN
    CPU: 20 PID: 24369 Comm: mkfs.ext4 Not tainted 4.18.0-rc1-dbg+ #2
    RIP: 0010:blk_end_request_all+0x68/0x70
    Call Trace:
     <IRQ>
     dm_softirq_done+0x326/0x3d0 [dm_mod]
     blk_done_softirq+0x19b/0x1e0
     __do_softirq+0x128/0x60d
     irq_exit+0x100/0x110
     smp_call_function_single_interrupt+0x90/0x330
     call_function_single_interrupt+0xf/0x20
     </IRQ>

Fixes: f9d03f96b988 ("block: improve handling of the magic discard payload")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3150,6 +3150,10 @@ static void __blk_rq_prep_clone(struct r
 	dst->cpu = src->cpu;
 	dst->__sector = blk_rq_pos(src);
 	dst->__data_len = blk_rq_bytes(src);
+	if (src->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		dst->rq_flags |= RQF_SPECIAL_PAYLOAD;
+		dst->special_vec = src->special_vec;
+	}
 	dst->nr_phys_segments = src->nr_phys_segments;
 	dst->ioprio = src->ioprio;
 	dst->extra_len = src->extra_len;


