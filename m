Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6175C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7756A206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217683;
	bh=wVvJFQ3rMnuJjMlfYzKBzyJ64LTGvZJvg+x+qGybW7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J/w0a/THqtWDnVmqcflGauLJEVa41kd7oqQ9jBGVe0BvW5da0/ZynBJkm9/Tilb/H
	 9N/PWl8AOfIumAacod22PsuiQblU71iSrLtv6HW0CmT0JL8qd9p/6ikNpbTaacydNR
	 PoK1AMgjmkyYouDdgmj5qes0zxmLBrOIg0uGxpl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391287AbfAKOlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403990AbfAKOlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8A2206B6;
        Fri, 11 Jan 2019 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217679;
        bh=wVvJFQ3rMnuJjMlfYzKBzyJ64LTGvZJvg+x+qGybW7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2oVnwezVx2PlvL2ieD4UzdU9n54QOE9oUfFD3YNEkmcQIxlAEP9Jr6MyZGK7RvYP2
         kg25jnPnQgo1gf2XAOSO9xbKIJJq84cwuQeGoEs3hVks8YuT/Z/M66518h9P2pzlhL
         vki5pKhMZ2O9z6+Y/WajzAwOik7Hmcle2u/ep3v0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 112/148] block: deactivate blk_stat timer in wbt_disable_default()
Date:   Fri, 11 Jan 2019 15:14:50 +0100
Message-Id: <20190111131118.740644193@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 544fbd16a461a318cd80537d1331c0df5c6cf930 upstream.

rwb_enabled() can't be changed when there is any inflight IO.

wbt_disable_default() may set rwb->wb_normal as zero, however the
blk_stat timer may still be pending, and the timer function will update
wrb->wb_normal again.

This patch introduces blk_stat_deactivate() and applies it in
wbt_disable_default(), then the following IO hang triggered when running
parted & switching io scheduler can be fixed:

[  369.937806] INFO: task parted:3645 blocked for more than 120 seconds.
[  369.938941]       Not tainted 4.20.0-rc6-00284-g906c801e5248 #498
[  369.939797] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  369.940768] parted          D    0  3645   3239 0x00000000
[  369.941500] Call Trace:
[  369.941874]  ? __schedule+0x6d9/0x74c
[  369.942392]  ? wbt_done+0x5e/0x5e
[  369.942864]  ? wbt_cleanup_cb+0x16/0x16
[  369.943404]  ? wbt_done+0x5e/0x5e
[  369.943874]  schedule+0x67/0x78
[  369.944298]  io_schedule+0x12/0x33
[  369.944771]  rq_qos_wait+0xb5/0x119
[  369.945193]  ? karma_partition+0x1c2/0x1c2
[  369.945691]  ? wbt_cleanup_cb+0x16/0x16
[  369.946151]  wbt_wait+0x85/0xb6
[  369.946540]  __rq_qos_throttle+0x23/0x2f
[  369.947014]  blk_mq_make_request+0xe6/0x40a
[  369.947518]  generic_make_request+0x192/0x2fe
[  369.948042]  ? submit_bio+0x103/0x11f
[  369.948486]  ? __radix_tree_lookup+0x35/0xb5
[  369.949011]  submit_bio+0x103/0x11f
[  369.949436]  ? blkg_lookup_slowpath+0x25/0x44
[  369.949962]  submit_bio_wait+0x53/0x7f
[  369.950469]  blkdev_issue_flush+0x8a/0xae
[  369.951032]  blkdev_fsync+0x2f/0x3a
[  369.951502]  do_fsync+0x2e/0x47
[  369.951887]  __x64_sys_fsync+0x10/0x13
[  369.952374]  do_syscall_64+0x89/0x149
[  369.952819]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  369.953492] RIP: 0033:0x7f95a1e729d4
[  369.953996] Code: Bad RIP value.
[  369.954456] RSP: 002b:00007ffdb570dd48 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
[  369.955506] RAX: ffffffffffffffda RBX: 000055c2139c6be0 RCX: 00007f95a1e729d4
[  369.956389] RDX: 0000000000000001 RSI: 0000000000001261 RDI: 0000000000000004
[  369.957325] RBP: 0000000000000002 R08: 0000000000000000 R09: 000055c2139c6ce0
[  369.958199] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c2139c0380
[  369.959143] R13: 0000000000000004 R14: 0000000000000100 R15: 0000000000000008

Cc: stable@vger.kernel.org
Cc: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-stat.h |    5 +++++
 block/blk-wbt.c  |    4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -145,6 +145,11 @@ static inline void blk_stat_activate_nse
 	mod_timer(&cb->timer, jiffies + nsecs_to_jiffies(nsecs));
 }
 
+static inline void blk_stat_deactivate(struct blk_stat_callback *cb)
+{
+	del_timer_sync(&cb->timer);
+}
+
 /**
  * blk_stat_activate_msecs() - Gather block statistics during a time window in
  * milliseconds.
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -760,8 +760,10 @@ void wbt_disable_default(struct request_
 	if (!rqos)
 		return;
 	rwb = RQWB(rqos);
-	if (rwb->enable_state == WBT_STATE_ON_DEFAULT)
+	if (rwb->enable_state == WBT_STATE_ON_DEFAULT) {
+		blk_stat_deactivate(rwb->cb);
 		rwb->wb_normal = 0;
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 


