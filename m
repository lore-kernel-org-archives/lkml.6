Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86862C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546B320C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546B320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeJILVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:21:03 -0400
Received: from nautica.notk.org ([91.121.71.147]:37482 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJILVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:21:03 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 647D6C009; Tue,  9 Oct 2018 06:06:06 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: [PATCH 1/2] 9p/trans_fd: abort p9_read_work if req status changed
Date:   Tue,  9 Oct 2018 06:05:55 +0200
Message-Id: <1539057956-23741-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20181009020949.GA29622@nautica>
References: <20181009020949.GA29622@nautica>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

p9_read_work would try to handle an errored req even if it got put to
error state by another thread between the lookup (that worked) and the
time it had been fully read.
The request itself is safe to use because we hold a ref to it from the
lookup (for m->rreq, so it was safe to read into the request data buffer
until this point), but the req_list has been deleted at the same time
status changed, and client_cb already has been called as well, so we
should not do either.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Reported-by: syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
---

As written in reply to the bug report I'm not sure it's what syzbot
complained about exactly, but it feels like a correct thing to do.
The second patch is unrelated to the syzbot report, but something that
occured to me while looking at this ; I'll take both into linux-next
around the start of next week after getting some proper testing done
unless remarks happen.
(they pass basic tests already)

 net/9p/trans_fd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 12559c474dde..a0317d459cde 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -292,7 +292,6 @@ static void p9_read_work(struct work_struct *work)
 	__poll_t n;
 	int err;
 	struct p9_conn *m;
-	int status = REQ_STATUS_ERROR;
 
 	m = container_of(work, struct p9_conn, rq);
 
@@ -375,11 +374,17 @@ static void p9_read_work(struct work_struct *work)
 		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
 		m->rreq->rc.size = m->rc.offset;
 		spin_lock(&m->client->lock);
-		if (m->rreq->status != REQ_STATUS_ERROR)
-			status = REQ_STATUS_RCVD;
-		list_del(&m->rreq->req_list);
-		/* update req->status while holding client->lock  */
-		p9_client_cb(m->client, m->rreq, status);
+		if (m->rreq->status == REQ_STATUS_SENT) {
+			list_del(&m->rreq->req_list);
+			p9_client_cb(m->client, m->rreq, REQ_STATUS_RCVD);
+		} else {
+			spin_unlock(&m->client->lock);
+			p9_debug(P9_DEBUG_ERROR,
+				 "Request tag %d errored out while we were reading the reply\n",
+				 m->rc.tag);
+			err = -EIO;
+			goto error;
+		}
 		spin_unlock(&m->client->lock);
 		m->rc.sdata = NULL;
 		m->rc.offset = 0;
-- 
2.19.1

