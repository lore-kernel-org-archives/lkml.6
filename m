Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B0F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B0F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeICV27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:28:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbeICV26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:28:58 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D46F8BB3;
        Mon,  3 Sep 2018 17:07:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.9 076/107] fuse: fix unlocked access to processing queue
Date:   Mon,  3 Sep 2018 18:56:40 +0200
Message-Id: <20180903165640.989235654@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

commit 45ff350bbd9d0f0977ff270a0d427c71520c0c37 upstream.

fuse_dev_release() assumes that it's the only one referencing the
fpq->processing list, but that's not true, since fuse_abort_conn() can be
doing the same without any serialization between the two.

Fixes: c3696046beb3 ("fuse: separate pqueue for clones")
Cc: <stable@vger.kernel.org> # v4.2
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2142,9 +2142,15 @@ int fuse_dev_release(struct inode *inode
 	if (fud) {
 		struct fuse_conn *fc = fud->fc;
 		struct fuse_pqueue *fpq = &fud->pq;
+		LIST_HEAD(to_end);
 
+		spin_lock(&fpq->lock);
 		WARN_ON(!list_empty(&fpq->io));
-		end_requests(fc, &fpq->processing);
+		list_splice_init(&fpq->processing, &to_end);
+		spin_unlock(&fpq->lock);
+
+		end_requests(fc, &to_end);
+
 		/* Are we the last open device? */
 		if (atomic_dec_and_test(&fc->dev_count)) {
 			WARN_ON(fc->iq.fasync != NULL);


