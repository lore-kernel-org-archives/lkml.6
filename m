Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64850C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197B2206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197B2206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeIHClv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:41:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIHBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:55:36 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1CDFFFB7;
        Fri,  7 Sep 2018 21:12:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Moise <00moses.alexander00@gmail.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 018/145] block: Ensure that a request queue is dissociated from the cgroup controller
Date:   Fri,  7 Sep 2018 23:08:04 +0200
Message-Id: <20180907210905.036706082@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 24ecc3585348b616993a3c4d6dc2c6b8007e358c upstream.

Several block drivers call alloc_disk() followed by put_disk() if
something fails before device_add_disk() is called without calling
blk_cleanup_queue(). Make sure that also for this scenario a request
queue is dissociated from the cgroup controller. This patch avoids
that loading the parport_pc, paride and pf drivers triggers the
following kernel crash:

BUG: KASAN: null-ptr-deref in pi_init+0x42e/0x580 [paride]
Read of size 4 at addr 0000000000000008 by task modprobe/744
Call Trace:
dump_stack+0x9a/0xeb
kasan_report+0x139/0x350
pi_init+0x42e/0x580 [paride]
pf_init+0x2bb/0x1000 [pf]
do_one_initcall+0x8e/0x405
do_init_module+0xd9/0x2f2
load_module+0x3ab4/0x4700
SYSC_finit_module+0x176/0x1a0
do_syscall_64+0xee/0x2b0
entry_SYSCALL_64_after_hwframe+0x42/0xb7

Reported-by: Alexandru Moise <00moses.alexander00@gmail.com>
Fixes: a063057d7c73 ("block: Fix a race between request queue removal and the block cgroup controller") # v4.17
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Tested-by: Alexandru Moise <00moses.alexander00@gmail.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-sysfs.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -804,6 +804,21 @@ static void __blk_release_queue(struct w
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
 
+	if (!blk_queue_dead(q)) {
+		/*
+		 * Last reference was dropped without having called
+		 * blk_cleanup_queue().
+		 */
+		WARN_ONCE(blk_queue_init_done(q),
+			  "request queue %p has been registered but blk_cleanup_queue() has not been called for that queue\n",
+			  q);
+		blk_exit_queue(q);
+	}
+
+	WARN(blkg_root_lookup(q),
+	     "request queue %p is being released but it has not yet been removed from the blkcg controller\n",
+	     q);
+
 	blk_free_queue_stats(q->stats);
 
 	blk_exit_rl(q, &q->root_rl);


