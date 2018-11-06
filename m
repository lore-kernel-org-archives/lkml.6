Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64170C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147DB20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147DB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbeKFSyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:54:55 -0500
Received: from relay.sw.ru ([185.231.240.75]:59146 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeKFSyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:54:54 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxgv-0002vh-Hb; Tue, 06 Nov 2018 12:30:33 +0300
Subject: [PATCH 1/6] fuse: Kill fasync only if interrupt is queued in
 queue_interrupt()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:30:33 +0300
Message-ID: <154149663324.17764.5859568987168525822.stgit@localhost.localdomain>
In-Reply-To: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
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

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fb2530ed84b3..7705f75c77a3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -468,6 +468,8 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 
 static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
+	bool kill = false;
+
 	spin_lock(&fiq->waitq.lock);
 	if (test_bit(FR_FINISHED, &req->flags)) {
 		spin_unlock(&fiq->waitq.lock);
@@ -476,9 +478,11 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (list_empty(&req->intr_entry)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		wake_up_locked(&fiq->waitq);
+		kill = true;
 	}
 	spin_unlock(&fiq->waitq.lock);
-	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
+	if (kill)
+		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 }
 
 static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)

