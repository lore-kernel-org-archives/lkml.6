Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497CCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB8220844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB8220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbeIHCQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:16:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIHCQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:16:12 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C438F4A;
        Fri,  7 Sep 2018 21:33:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+39749ed7d9ef6dfb23f6@syzkaller.appspotmail.com,
        Yiwen Jiang <jiangyiwen@huwei.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4.9 18/63] net/9p/trans_fd.c: fix race-condition by flushing workqueue before the kfree()
Date:   Fri,  7 Sep 2018 23:09:49 +0200
Message-Id: <20180907211014.001725757@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit 430ac66eb4c5b5c4eb846b78ebf65747510b30f1 upstream.

The patch adds the flush in p9_mux_poll_stop() as it the function used by
p9_conn_destroy(), in turn called by p9_fd_close() to stop the async
polling associated with the data regarding the connection.

Link: http://lkml.kernel.org/r/20180720092730.27104-1-tomasbortoli@gmail.com
Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+39749ed7d9ef6dfb23f6@syzkaller.appspotmail.com
To: Eric Van Hensbergen <ericvh@gmail.com>
To: Ron Minnich <rminnich@sandia.gov>
To: Latchesar Ionkov <lucho@ionkov.net>
Cc: Yiwen Jiang <jiangyiwen@huwei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/trans_fd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -181,6 +181,8 @@ static void p9_mux_poll_stop(struct p9_c
 	spin_lock_irqsave(&p9_poll_lock, flags);
 	list_del_init(&m->poll_pending_link);
 	spin_unlock_irqrestore(&p9_poll_lock, flags);
+
+	flush_work(&p9_poll_work);
 }
 
 /**


