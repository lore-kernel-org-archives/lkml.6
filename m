Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9B0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5F720862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5F720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbeKFSzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:55:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:59158 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeKFSzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:55:09 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxh6-0002vt-Jo; Tue, 06 Nov 2018 12:30:44 +0300
Subject: [PATCH 3/6] fuse: Wake up req->waitq of only not background
 requests in request_end()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:30:44 +0300
Message-ID: <154149664427.17764.8657194274267023078.stgit@localhost.localdomain>
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

Currently, we wait on req->waitq in request_wait_answer()
function only, and it's never used for background requests.
Since wake_up() is not a light-weight macros, instead of this,
it unfolds in really called function, which makes locking
operations taking some cpu cycles, let's avoid its call
for the case we definitely know it's completely useless.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 391498e680ec..739968ee8b0c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -464,8 +464,11 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 		fc->active_background--;
 		flush_bg_queue(fc);
 		spin_unlock(&fc->bg_lock);
+	} else {
+		/* Wake up waiter sleeping in request_wait_answer() */
+		wake_up(&req->waitq);
 	}
-	wake_up(&req->waitq);
+
 	if (req->end)
 		req->end(fc, req);
 put_request:

