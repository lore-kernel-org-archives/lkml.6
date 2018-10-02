Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848E5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469B52083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469B52083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbeJBURo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbeJBURn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:43 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AFFDCB2F;
        Tue,  2 Oct 2018 13:34:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 108/137] RDMA/uverbs: Atomically flush and mark closed the comp event queue
Date:   Tue,  2 Oct 2018 06:25:09 -0700
Message-Id: <20181002132506.066559052@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Wise <swise@opengridcomputing.com>

commit 67e3816842fe6414d629c7515b955952ec40c7d7 upstream.

Currently a uverbs completion event queue is flushed of events in
ib_uverbs_comp_event_close() with the queue spinlock held and then
released.  Yet setting ev_queue->is_closed is not set until later in
uverbs_hot_unplug_completion_event_file().

In between the time ib_uverbs_comp_event_close() releases the lock and
uverbs_hot_unplug_completion_event_file() acquires the lock, a completion
event can arrive and be inserted into the event queue by
ib_uverbs_comp_handler().

This can cause a "double add" list_add warning or crash depending on the
kernel configuration, or a memory leak because the event is never dequeued
since the queue is already closed down.

So add setting ev_queue->is_closed = 1 to ib_uverbs_comp_event_close().

Cc: stable@vger.kernel.org
Fixes: 1e7710f3f656 ("IB/core: Change completion channel to use the reworked objects schema")
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -424,6 +424,7 @@ static int ib_uverbs_comp_event_close(st
 			list_del(&entry->obj_list);
 		kfree(entry);
 	}
+	file->ev_queue.is_closed = 1;
 	spin_unlock_irq(&file->ev_queue.lock);
 
 	uverbs_close_fd(filp);


