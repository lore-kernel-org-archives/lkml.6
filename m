Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29137C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D589820C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hy4r/kfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D589820C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbeHPTvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:51:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37595 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbeHPTvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:51:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so4756971wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyZHAK8ZrpQtkw3weKOOEv6ell+gZqXbA4ONipLRAF4=;
        b=hy4r/kfdZPm+yqODJPunTxDsg5mue4mKmETW3Vw9NOCtlXc1ialmJEye/UWWyrYrBM
         +Wt8A+882lWG5AQk25HH2rxZFhVQH9J59Uqn8y4uoYbxKBFdZTJbZTohU69B0HOTHqgd
         WxAtxKPPbusR39V4+1FZfXujWLFoT34IVbrtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pyZHAK8ZrpQtkw3weKOOEv6ell+gZqXbA4ONipLRAF4=;
        b=C290/zrKJHHlsOY6dUH9uJlGv74ccVkWgldLyRRo1B2SboddRlk3pHQH3EDpzYO/1/
         k0s2yrFa6dgBEh73rxphH2k2SvF0JB84BLcGJJfQILLQ6xUnnxcsGEAEyup0EDdOKlf6
         zHROXi1bU1Gl9DxdmBNKI4G7PBtJ3w44uzC1z2plkz1azUii1nsqqaE7a29HfCbKFHb5
         buKsXAXDrclP5ZuWyOqQ/ZPUvq3m0fDOvHxc4Qp0WYi2MqHOePUi+ahUQ7i9HJWiTNo0
         vj6/yMPGw5U4jFSP2IszUd5bF0qkoQhO8sfU4SvhfMYNJxsU7oU4mFTp90uJUFvNbUX0
         18sA==
X-Gm-Message-State: AOUpUlG/KMP0JKNsc3bN7ZGaecLgiXR8hAU+HYE8X+8seG9zrQZ+Vgs9
        Pj0/EV9J/ejH2D0W0nP8nJkRkg==
X-Google-Smtp-Source: AA+uWPzcnKeeMkn4qq6gNXMTsm+xJXXxCGErS7gxz5c6zWSflh6ZSCAlK+QcuV4hcNGULGaW4/rq2A==
X-Received: by 2002:a5d:51cf:: with SMTP id n15-v6mr20603741wrv.107.1534438319542;
        Thu, 16 Aug 2018 09:51:59 -0700 (PDT)
Received: from localhost.localdomain (146-241-5-103.dyn.eolo.it. [146.241.5.103])
        by smtp.gmail.com with ESMTPSA id o3-v6sm30036180wrj.31.2018.08.16.09.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 09:51:58 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 3/4] block, bfq: reduce write overcharge
Date:   Thu, 16 Aug 2018 18:51:17 +0200
Message-Id: <20180816165118.17402-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180816165118.17402-1-paolo.valente@linaro.org>
References: <20180816165118.17402-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a sync request is dispatched, the queue that contains that
request, and all the ancestor entities of that queue, are charged with
the number of sectors of the request. In constrast, if the request is
async, then the queue and its ancestor entities are charged with the
number of sectors of the request, multiplied by an overcharge
factor. This throttles the bandwidth for async I/O, w.r.t. to sync
I/O, and it is done to counter the tendency of async writes to steal
I/O throughput to reads.

On the opposite end, the lower this parameter, the stabler I/O
control, in the following respect.  The lower this parameter is, the
less the bandwidth enjoyed by a group decreases
- when the group does writes, w.r.t. to when it does reads;
- when other groups do reads, w.r.t. to when they do writes.

The fixes "block, bfq: always update the budget of an entity when
needed" and "block, bfq: readd missing reset of parent-entity service"
improved I/O control in bfq to such an extent that it has been
possible to revise this overcharge factor downwards.  This commit
introduces the resulting, new value.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 62efc1b97afb..653100fb719e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -187,11 +187,25 @@ static const int bfq_stats_min_budgets = 194;
 static const int bfq_default_max_budget = 16 * 1024;
 
 /*
- * Async to sync throughput distribution is controlled as follows:
- * when an async request is served, the entity is charged the number
- * of sectors of the request, multiplied by the factor below
+ * When a sync request is dispatched, the queue that contains that
+ * request, and all the ancestor entities of that queue, are charged
+ * with the number of sectors of the request. In constrast, if the
+ * request is async, then the queue and its ancestor entities are
+ * charged with the number of sectors of the request, multiplied by
+ * the factor below. This throttles the bandwidth for async I/O,
+ * w.r.t. to sync I/O, and it is done to counter the tendency of async
+ * writes to steal I/O throughput to reads.
+ *
+ * The current value of this parameter is the result of a tuning with
+ * several hardware and software configurations. We tried to find the
+ * lowest value for which writes do not cause noticeable problems to
+ * reads. In fact, the lower this parameter, the stabler I/O control,
+ * in the following respect.  The lower this parameter is, the less
+ * the bandwidth enjoyed by a group decreases
+ * - when the group does writes, w.r.t. to when it does reads;
+ * - when other groups do reads, w.r.t. to when they do writes.
  */
-static const int bfq_async_charge_factor = 10;
+static const int bfq_async_charge_factor = 3;
 
 /* Default timeout values, in jiffies, approximating CFQ defaults. */
 const int bfq_timeout = HZ / 8;
@@ -853,16 +867,7 @@ static unsigned long bfq_serv_to_charge(struct request *rq,
 	if (bfq_bfqq_sync(bfqq) || bfqq->wr_coeff > 1)
 		return blk_rq_sectors(rq);
 
-	/*
-	 * If there are no weight-raised queues, then amplify service
-	 * by just the async charge factor; otherwise amplify service
-	 * by twice the async charge factor, to further reduce latency
-	 * for weight-raised queues.
-	 */
-	if (bfqq->bfqd->wr_busy_queues == 0)
-		return blk_rq_sectors(rq) * bfq_async_charge_factor;
-
-	return blk_rq_sectors(rq) * 2 * bfq_async_charge_factor;
+	return blk_rq_sectors(rq) * bfq_async_charge_factor;
 }
 
 /**
-- 
2.16.1

