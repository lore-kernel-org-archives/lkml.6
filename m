Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D70206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D70206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeIHCl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:41:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40554 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeIHBzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:55:35 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9032F07;
        Fri,  7 Sep 2018 21:12:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alexandru Moise <00moses.alexander00@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 016/145] blkcg: Introduce blkg_root_lookup()
Date:   Fri,  7 Sep 2018 23:08:02 +0200
Message-Id: <20180907210904.883199291@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
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

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 6bad9b210a228d2fe0e0efe26d9b115348529cee upstream.

This new function will be used in a later patch to verify whether a
queue has been dissociated from the cgroup controller before being
released.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/blk-cgroup.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -296,6 +296,23 @@ static inline struct blkcg_gq *blkg_look
 }
 
 /**
+ * blkg_lookup - look up blkg for the specified request queue
+ * @q: request_queue of interest
+ *
+ * Lookup blkg for @q at the root level. See also blkg_lookup().
+ */
+static inline struct blkcg_gq *blkg_root_lookup(struct request_queue *q)
+{
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+	blkg = blkg_lookup(&blkcg_root, q);
+	rcu_read_unlock();
+
+	return blkg;
+}
+
+/**
  * blkg_to_pdata - get policy private data
  * @blkg: blkg of interest
  * @pol: policy of interest
@@ -737,6 +754,7 @@ struct blkcg_policy {
 #ifdef CONFIG_BLOCK
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
+static inline struct blkcg_gq *blkg_root_lookup(struct request_queue *q) { return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_drain_queue(struct request_queue *q) { }
 static inline void blkcg_exit_queue(struct request_queue *q) { }


