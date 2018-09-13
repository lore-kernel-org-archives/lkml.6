Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157DFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAE820C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAE820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeIMSyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:54:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbeIMSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:54:02 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C556CD10;
        Thu, 13 Sep 2018 13:44:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com,
        Yiwen Jiang <jiangyiwen@huwei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 050/115] net/9p/trans_fd.c: fix race by holding the lock
Date:   Thu, 13 Sep 2018 15:31:10 +0200
Message-Id: <20180913131826.746777224@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
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

From: Tomas Bortoli <tomasbortoli@gmail.com>

[ Upstream commit 9f476d7c540cb57556d3cc7e78704e6cd5100f5f ]

It may be possible to run p9_fd_cancel() with a deleted req->req_list
and incur in a double del. To fix hold the client->lock while changing
the status, so the other threads will be synchronized.

Link: http://lkml.kernel.org/r/20180723184253.6682-1-tomasbortoli@gmail.com
Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
To: Eric Van Hensbergen <ericvh@gmail.com>
To: Ron Minnich <rminnich@sandia.gov>
To: Latchesar Ionkov <lucho@ionkov.net>
Cc: Yiwen Jiang <jiangyiwen@huwei.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/9p/trans_fd.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -199,15 +199,14 @@ static void p9_mux_poll_stop(struct p9_c
 static void p9_conn_cancel(struct p9_conn *m, int err)
 {
 	struct p9_req_t *req, *rtmp;
-	unsigned long flags;
 	LIST_HEAD(cancel_list);
 
 	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);
 
-	spin_lock_irqsave(&m->client->lock, flags);
+	spin_lock(&m->client->lock);
 
 	if (m->err) {
-		spin_unlock_irqrestore(&m->client->lock, flags);
+		spin_unlock(&m->client->lock);
 		return;
 	}
 
@@ -219,7 +218,6 @@ static void p9_conn_cancel(struct p9_con
 	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
 	}
-	spin_unlock_irqrestore(&m->client->lock, flags);
 
 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
 		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
@@ -228,6 +226,7 @@ static void p9_conn_cancel(struct p9_con
 			req->t_err = err;
 		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
 	}
+	spin_unlock(&m->client->lock);
 }
 
 static int
@@ -385,8 +384,9 @@ static void p9_read_work(struct work_str
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
 		list_del(&m->req->req_list);
-		spin_unlock(&m->client->lock);
+		/* update req->status while holding client->lock  */
 		p9_client_cb(m->client, m->req, status);
+		spin_unlock(&m->client->lock);
 		m->rc.sdata = NULL;
 		m->rc.offset = 0;
 		m->rc.capacity = 0;


