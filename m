Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91B8C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDD02082C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHpSs+I6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDD02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeHaF7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:59:31 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46480 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeHaF73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:29 -0400
Received: by mail-yb1-f193.google.com with SMTP id y20-v6so330206ybi.13;
        Thu, 30 Aug 2018 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ru9Qz6kW5Z2dkilYGK5da+gwQEIQ16H8/tvKmMoSEbM=;
        b=MHpSs+I62J6Op19vonhV08rs6EraCMW+KPzHndWzozzK76abz4lzjc/WGwXFdpTHH8
         nuo09GdHXH0dPbv9LeZ6i8jw1JdQ9//Yiq2a//47vuYatMTH7h+9eNnGPe/ndIDzNr5U
         QLR6Fbc62U/8y7Dal2RLbFPo1L3Oe+hdxqTxzMyyLCuyKZ8rQeL4un9MJPDm2zrNVC6j
         OPSJ1ZWOPJHIn2eI54bvyKGbRrOIxnmT7QNTJrXGiv4WxGK7Tp4MX2NwcotIgVxUgdFp
         rOEXYedjby9j10x5oYVhFPex9sQ0f1U5Adw9E235V6fLRSbIdud+B7uZWeQ8jpL3NsbX
         kw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ru9Qz6kW5Z2dkilYGK5da+gwQEIQ16H8/tvKmMoSEbM=;
        b=EFzno1cB44vhPRfFgzergobleLf2qoITP4DEaBcUu9jxy+vbuipey2MoSAR860Lk+r
         5dgeqf4iIoP89HjDc3Dxxmn0IFdRwPRwsG6TaZapJoHTCc2fW1dtWg0zKly2X3RN7TSz
         I2Td7ehl1sQ37F4qd+vnQoUi9BdC0fV8O+669vv5l44lYrc4uJMw3eMdQXjc9pNUtIbS
         lODqtlK5f7/sJV1KQ2ASXOU7L8D0iC7rZmP6fYEeudil4/htY3JbKKzsBp5JtFXb9cP+
         ZtsAY2IMTpVeRz82d82mv9Sj7kh+aSyMOGD6EBGqLUeR+Uil0Xp0RAFlZM4wJvsIwIAe
         +Rzw==
X-Gm-Message-State: APzg51DpZOXPD2ruHzEd85j8uWHLIbaH3ebfdfoCERLO5dGIEYzA4L7M
        Ba7MnBfxzo3xM9K0alLWaLk=
X-Google-Smtp-Source: ANB0VdY/nydM4ppgyloEBKKxP7x5D5J6I7AOFZAqMZSZjwanpjU5NsTIXHiKItI5ra+pMsyKG+zC7A==
X-Received: by 2002:a5b:647:: with SMTP id o7-v6mr7686706ybq.443.1535680466364;
        Thu, 30 Aug 2018 18:54:26 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:25 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 12/15] blkcg: cleanup and make blk_get_rl use blkg_lookup_create
Date:   Thu, 30 Aug 2018 21:53:53 -0400
Message-Id: <20180831015356.69796-13-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

blk_get_rl is responsible for identifying which request_list a request
should be allocated to. Try get logic was added earlier, but
semantically the logic was not changed.

This patch makes better use of the bio already having a reference to the
blkg in the hot path. The cold path uses a better fallback of
blkg_lookup_create rather than just blkg_lookup and then falling back to
the q->root_rl. If lookup_create fails with anything but -ENODEV, it
falls back to q->root_rl.

A clarifying comment is added to explain why q->root_rl is used rather
than the root blkg's rl.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 include/linux/blk-cgroup.h | 53 ++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 3eed491e4daa..97cb82029b18 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -537,28 +537,49 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 
 	rcu_read_lock();
 
-	blkcg = bio_blkcg(bio);
-	if (!blkcg)
+	blkg = bio->bi_blkg;
+	if (blkg) {
+		blkcg = bio->bi_blkg->blkcg;
+		if (blkcg == &blkcg_root)
+			goto rl_use_root;
+
+		blkg_get(blkg);
+		return &blkg->rl;
+	}
+
+	while (true) {
 		blkcg = css_to_blkcg(blkcg_css());
+		if (blkcg == &blkcg_root)
+			goto rl_use_root;
 
-	/* bypass blkg lookup and use @q->root_rl directly for root */
-	if (blkcg == &blkcg_root)
-		goto root_rl;
+		blkg = blkg_lookup(blkcg, q);
 
-	/*
-	 * Try to use blkg->rl.  blkg lookup may fail under memory pressure
-	 * or if either the blkcg or queue is going away.  Fall back to
-	 * root_rl in such cases.
-	 */
-	blkg = blkg_lookup(blkcg, q);
-	if (unlikely(!blkg))
-		goto root_rl;
+		if (unlikely(!blkg))
+			blkg = __blkg_lookup_create(blkcg, q);
+
+		if (IS_ERR(blkg)) {
+			if (PTR_ERR(blkg) == -ENODEV) {
+				cpu_relax();
+				continue;
+			} else {
+				goto rl_use_root;
+			}
+		}
+
+		if (blkg_try_get(blkg))
+			break;
+		cpu_relax();
+	}
 
-	if (!blkg_try_get(blkg))
-		goto root_rl;
 	rcu_read_unlock();
 	return &blkg->rl;
-root_rl:
+
+	/*
+	 * Each blkg has its own request_list, however, the root blkcg
+	 * uses the request_queue's root_rl.  This is to avoid most
+	 * overhead for the root blkcg.
+	 */
+rl_use_root:
 	rcu_read_unlock();
 	return &q->root_rl;
 }
-- 
2.17.1

