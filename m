Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E993DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D432146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D432146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeIRE11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:27:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeIRE10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:27:26 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26B02CB2;
        Mon, 17 Sep 2018 22:57:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Marc MERLIN <marc@merlins.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@fb.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 11/70] block,blkcg: use __GFP_NOWARN for best-effort allocations in blkcg
Date:   Tue, 18 Sep 2018 00:41:44 +0200
Message-Id: <20180917211650.163730224@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit e00f4f4d0ff7e13b9115428a245b49108d625f09 upstream.

blkcg allocates some per-cgroup data structures with GFP_NOWAIT and
when that fails falls back to operations which aren't specific to the
cgroup.  Occassional failures are expected under pressure and falling
back to non-cgroup operation is the right thing to do.

Unfortunately, I forgot to add __GFP_NOWARN to these allocations and
these expected failures end up creating a lot of noise.  Add
__GFP_NOWARN.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Marc MERLIN <marc@merlins.org>
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-cgroup.c  |    9 +++++----
 block/cfq-iosched.c |    3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -185,7 +185,8 @@ static struct blkcg_gq *blkg_create(stru
 	}
 
 	wb_congested = wb_congested_get_create(&q->backing_dev_info,
-					       blkcg->css.id, GFP_NOWAIT);
+					       blkcg->css.id,
+					       GFP_NOWAIT | __GFP_NOWARN);
 	if (!wb_congested) {
 		ret = -ENOMEM;
 		goto err_put_css;
@@ -193,7 +194,7 @@ static struct blkcg_gq *blkg_create(stru
 
 	/* allocate */
 	if (!new_blkg) {
-		new_blkg = blkg_alloc(blkcg, q, GFP_NOWAIT);
+		new_blkg = blkg_alloc(blkcg, q, GFP_NOWAIT | __GFP_NOWARN);
 		if (unlikely(!new_blkg)) {
 			ret = -ENOMEM;
 			goto err_put_congested;
@@ -1022,7 +1023,7 @@ blkcg_css_alloc(struct cgroup_subsys_sta
 	}
 
 	spin_lock_init(&blkcg->lock);
-	INIT_RADIX_TREE(&blkcg->blkg_tree, GFP_NOWAIT);
+	INIT_RADIX_TREE(&blkcg->blkg_tree, GFP_NOWAIT | __GFP_NOWARN);
 	INIT_HLIST_HEAD(&blkcg->blkg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&blkcg->cgwb_list);
@@ -1238,7 +1239,7 @@ pd_prealloc:
 		if (blkg->pd[pol->plid])
 			continue;
 
-		pd = pol->pd_alloc_fn(GFP_NOWAIT, q->node);
+		pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q->node);
 		if (!pd)
 			swap(pd, pd_prealloc);
 		if (!pd) {
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -3868,7 +3868,8 @@ cfq_get_queue(struct cfq_data *cfqd, boo
 			goto out;
 	}
 
-	cfqq = kmem_cache_alloc_node(cfq_pool, GFP_NOWAIT | __GFP_ZERO,
+	cfqq = kmem_cache_alloc_node(cfq_pool,
+				     GFP_NOWAIT | __GFP_ZERO | __GFP_NOWARN,
 				     cfqd->queue->node);
 	if (!cfqq) {
 		cfqq = &cfqd->oom_cfqq;


