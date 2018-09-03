Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4CA2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4CA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbeICV43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:56:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbeICV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:56:28 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D6E8D1B;
        Mon,  3 Sep 2018 17:35:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 060/123] fuse: fix double request_end()
Date:   Mon,  3 Sep 2018 18:56:44 +0200
Message-Id: <20180903165721.975040144@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

commit 87114373ea507895a62afb10d2910bd9adac35a8 upstream.

Refcounting of request is broken when fuse_abort_conn() is called and
request is on the fpq->io list:

 - ref is taken too late
 - then it is not dropped

Fixes: 0d8e84b0432b ("fuse: simplify request abort")
Cc: <stable@vger.kernel.org> # v4.2
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -371,7 +371,7 @@ static void request_end(struct fuse_conn
 	struct fuse_iqueue *fiq = &fc->iq;
 
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
-		return;
+		goto out_put_req;
 
 	spin_lock(&fiq->waitq.lock);
 	list_del_init(&req->intr_entry);
@@ -400,6 +400,7 @@ static void request_end(struct fuse_conn
 	wake_up(&req->waitq);
 	if (req->end)
 		req->end(fc, req);
+out_put_req:
 	fuse_put_request(fc, req);
 }
 
@@ -2108,6 +2109,7 @@ void fuse_abort_conn(struct fuse_conn *f
 				set_bit(FR_ABORTED, &req->flags);
 				if (!test_bit(FR_LOCKED, &req->flags)) {
 					set_bit(FR_PRIVATE, &req->flags);
+					__fuse_get_request(req);
 					list_move(&req->list, &to_end1);
 				}
 				spin_unlock(&req->waitq.lock);
@@ -2134,7 +2136,6 @@ void fuse_abort_conn(struct fuse_conn *f
 
 		while (!list_empty(&to_end1)) {
 			req = list_first_entry(&to_end1, struct fuse_req, list);
-			__fuse_get_request(req);
 			list_del_init(&req->list);
 			request_end(fc, req);
 		}


