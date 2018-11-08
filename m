Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA34C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8FA2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8FA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeKHSkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:40:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:36794 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeKHSkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:40:15 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gKgFy-00062m-Cx; Thu, 08 Nov 2018 12:05:42 +0300
Subject: [PATCH v2 5/5] fuse: Verify userspace asks to requeue interrupt
 that we really sent
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Nov 2018 12:05:42 +0300
Message-ID: <154166794230.10655.6677489856107857328.stgit@localhost.localdomain>
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

When queue_interrupt() is called from fuse_dev_do_write(),
it came from userspace directly. Userspace may pass any
request id, even the request's we have not interrupted
(or even background's request). This patch adds sanity
check to make kernel safe against that.

v2: Keep in mind FR_INTERRUPTED is visible under fiq->waitq.lock
    in requeuer.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7684fb7dc680..403a2ebad468 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -475,9 +475,15 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 	fuse_put_request(fc, req);
 }
 
-static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
+static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->waitq.lock);
+	/* Check for we've sent request to interrupt this req */
+	if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags))) {
+		spin_unlock(&fiq->waitq.lock);
+		return -EINVAL;
+	}
+
 	if (list_empty(&req->intr_entry)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		/*
@@ -488,12 +494,13 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 		if (test_bit(FR_FINISHED, &req->flags)) {
 			list_del_init(&req->intr_entry);
 			spin_unlock(&fiq->waitq.lock);
-			return;
+			return 0;
 		}
 		wake_up_locked(&fiq->waitq);
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 	}
 	spin_unlock(&fiq->waitq.lock);
+	return 0;
 }
 
 static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
@@ -1951,8 +1958,9 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 			nbytes = -EINVAL;
 		else if (oh.error == -ENOSYS)
 			fc->no_interrupt = 1;
-		else if (oh.error == -EAGAIN)
-			queue_interrupt(&fc->iq, req);
+		else if (oh.error == -EAGAIN &&
+			 queue_interrupt(&fc->iq, req) < 0)
+			nbytes = -EINVAL;
 
 		fuse_put_request(fc, req);
 		fuse_copy_finish(cs);

