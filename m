Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A699BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940F206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6940F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeJBUMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:12:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbeJBUMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:21 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A88A9266;
        Tue,  2 Oct 2018 13:28:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 133/228] block: fix deadline elevator drain for zoned block devices
Date:   Tue,  2 Oct 2018 06:23:50 -0700
Message-Id: <20181002132508.393243241@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 854f31ccdd7964c9c2e68da234a3a8aedb51cf6b upstream.

When the deadline scheduler is used with a zoned block device, writes
to a zone will be dispatched one at a time. This causes the warning
message:

deadline: forced dispatching is broken (nr_sorted=X), please report this

to be displayed when switching to another elevator with the legacy I/O
path while write requests to a zone are being retained in the scheduler
queue.

Prevent this message from being displayed when executing
elv_drain_elevator() for a zoned block device. __blk_drain_queue() will
loop until all writes are dispatched and completed, resulting in the
desired elevator queue drain without extensive modifications to the
deadline code itself to handle forced-dispatch calls.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Fixes: 8dc8146f9c92 ("deadline-iosched: Introduce zone locking support")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/elevator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/elevator.c
+++ b/block/elevator.c
@@ -609,7 +609,7 @@ void elv_drain_elevator(struct request_q
 
 	while (e->type->ops.sq.elevator_dispatch_fn(q, 1))
 		;
-	if (q->nr_sorted && printed++ < 10) {
+	if (q->nr_sorted && !blk_queue_is_zoned(q) && printed++ < 10 ) {
 		printk(KERN_ERR "%s: forced dispatching is broken "
 		       "(nr_sorted=%u), please report this\n",
 		       q->elevator->type->elevator_name, q->nr_sorted);


