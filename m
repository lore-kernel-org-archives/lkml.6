Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA4ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4E62146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4E62146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeIREey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbeIREew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:52 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D880BC77;
        Mon, 17 Sep 2018 23:05:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 107/126] rhashtable: reorganize struct rhashtable layout
Date:   Tue, 18 Sep 2018 00:42:35 +0200
Message-Id: <20180917211710.991475116@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

While under frags DDOS I noticed unfortunate false sharing between
@nelems and @params.automatic_shrinking

Move @nelems at the end of struct rhashtable so that first cache line
is shared between all cpus, because almost never dirtied.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e5d672a0780d9e7118caad4c171ec88b8299398d)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/rhashtable.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -152,25 +152,25 @@ struct rhashtable_params {
 /**
  * struct rhashtable - Hash table handle
  * @tbl: Bucket table
- * @nelems: Number of elements in table
  * @key_len: Key length for hashfn
- * @p: Configuration parameters
  * @max_elems: Maximum number of elements in table
+ * @p: Configuration parameters
  * @rhlist: True if this is an rhltable
  * @run_work: Deferred worker to expand/shrink asynchronously
  * @mutex: Mutex to protect current/future table swapping
  * @lock: Spin lock to protect walker list
+ * @nelems: Number of elements in table
  */
 struct rhashtable {
 	struct bucket_table __rcu	*tbl;
-	atomic_t			nelems;
 	unsigned int			key_len;
-	struct rhashtable_params	p;
 	unsigned int			max_elems;
+	struct rhashtable_params	p;
 	bool				rhlist;
 	struct work_struct		run_work;
 	struct mutex                    mutex;
 	spinlock_t			lock;
+	atomic_t			nelems;
 };
 
 /**


