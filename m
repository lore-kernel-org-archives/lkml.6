Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066E5C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB45520825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB45520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeKHSjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:39:53 -0500
Received: from relay.sw.ru ([185.231.240.75]:36770 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeKHSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:39:52 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gKgFc-00062M-9m; Thu, 08 Nov 2018 12:05:20 +0300
Subject: [PATCH v2 1/5] fuse: Kill fasync only if interrupt is queued in
 queue_interrupt()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Nov 2018 12:05:20 +0300
Message-ID: <154166792021.10655.6752271937511795324.stgit@localhost.localdomain>
In-Reply-To: <154166765576.10655.15178401490817622677.stgit@localhost.localdomain>
References: <154166765576.10655.15178401490817622677.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should sent signal only in case of interrupt is really queued.
Not a real problem, but this makes the code clearer and intuitive.

v2: Move kill_fasync() under fiq->waitq.lock

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ae813e609932..1ecec7fcb841 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -476,9 +476,9 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (list_empty(&req->intr_entry)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		wake_up_locked(&fiq->waitq);
+		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 	}
 	spin_unlock(&fiq->waitq.lock);
-	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 }
 
 static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)

