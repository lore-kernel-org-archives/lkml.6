Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32655C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F3826096
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FElmUAAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F3826096
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965117AbeFYT4A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:56:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42522 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965094AbeFYTz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:55:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id w10-v6so14865858wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v6cDwd+/4eCmk1MGKxYMdFTnaz1gvwnSx0DFbMN/pjg=;
        b=FElmUAAnN+fKF7otS+Y51Dvw5/gIlaGZ1rJi8U+p8MnWXEEHAiKpNeQjNDVZID1Aw5
         BlKhhr/Dsm82A5X9drgQfgsT4n2JzlB5QaBp78kij8Sm5/ZVwwqAtVW25dNbjzTUb4Hv
         pdO/dQIyUyxoZeYKl3hCH0Hvc0cZ0nYAWoyg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v6cDwd+/4eCmk1MGKxYMdFTnaz1gvwnSx0DFbMN/pjg=;
        b=poNDPlzIoYIJzGyy4wy9pNU0+vJqLqcPS3t1UXAoZE4LsNR+1k/Xdyqb5ToR8GEnnq
         d/H6j0eKdgVdnu0nKINSk/v9C3x/ZxIvU/b1l4I3OWpXriO2gDBmickoKaGDVqJDs7Jh
         H/H1rJ3cK+Y7gqtQY2IsLnwdec4K/SkzwTg625E+jUCldz7RPV4yT33aUj0Ne3QzLVfN
         hZiy9AT5hrTGTkJOQVUTQPN7r9t1tsrc4Awe67wH1ftJs5RSA0tMP9vbrDzsgwRoaTSr
         zw1zQACgBFpyQWvD8EpIHBdNZmpF/3GY7Gt8R4oe1GLlfPZ7IwlPnf/rm6Uf4BDssLuk
         fT1Q==
X-Gm-Message-State: APt69E2C1IX+KtGCe3dFGslnYFNeHlyDN9gCCGQ9f0g0kzrLmUVqrfPx
        zfsZCEBH3ZnfGw/ze0IxHKimFw==
X-Google-Smtp-Source: AAOMgpd2j2pPyApYQ7KKUPQTiKEDIS0kZBBoJo7mts5eIsKnqef1HURLvJXu2F/db1LC6OQB+7r2JA==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr11730299wrd.61.1529956555025;
        Mon, 25 Jun 2018 12:55:55 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id n18-v6sm29072897wrj.58.2018.06.25.12.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:55:54 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX RESEND 4/4] block, bfq: give a better name to bfq_bfqq_may_idle
Date:   Mon, 25 Jun 2018 21:55:37 +0200
Message-Id: <20180625195537.7769-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
References: <20180625195537.7769-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual goal of the function bfq_bfqq_may_idle is to tell whether
it is better to perform device idling (more precisely: I/O-dispatch
plugging) for the input bfq_queue, either to boost throughput or to
preserve service guarantees. This commit improves the name of the
function accordingly.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d579cc8e0db6..41d9036b1822 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -634,7 +634,7 @@ static bool bfq_differentiated_weights(struct bfq_data *bfqd)
  * The following function returns true if every queue must receive the
  * same share of the throughput (this condition is used when deciding
  * whether idling may be disabled, see the comments in the function
- * bfq_bfqq_may_idle()).
+ * bfq_better_to_idle()).
  *
  * Such a scenario occurs when:
  * 1) all active queues have the same weight,
@@ -3355,7 +3355,7 @@ static bool bfq_may_expire_for_budg_timeout(struct bfq_queue *bfqq)
  * issues taken into account are not trivial. We discuss these issues
  * individually while introducing the variables.
  */
-static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
+static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 {
 	struct bfq_data *bfqd = bfqq->bfqd;
 	bool rot_without_queueing =
@@ -3588,19 +3588,19 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 }
 
 /*
- * If the in-service queue is empty but the function bfq_bfqq_may_idle
+ * If the in-service queue is empty but the function bfq_better_to_idle
  * returns true, then:
  * 1) the queue must remain in service and cannot be expired, and
  * 2) the device must be idled to wait for the possible arrival of a new
  *    request for the queue.
- * See the comments on the function bfq_bfqq_may_idle for the reasons
+ * See the comments on the function bfq_better_to_idle for the reasons
  * why performing device idling is the best choice to boost the throughput
- * and preserve service guarantees when bfq_bfqq_may_idle itself
+ * and preserve service guarantees when bfq_better_to_idle itself
  * returns true.
  */
 static bool bfq_bfqq_must_idle(struct bfq_queue *bfqq)
 {
-	return RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_may_idle(bfqq);
+	return RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_better_to_idle(bfqq);
 }
 
 /*
@@ -3686,7 +3686,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	 * may idle after their completion, then keep it anyway.
 	 */
 	if (bfq_bfqq_wait_request(bfqq) ||
-	    (bfqq->dispatched != 0 && bfq_bfqq_may_idle(bfqq))) {
+	    (bfqq->dispatched != 0 && bfq_better_to_idle(bfqq))) {
 		bfqq = NULL;
 		goto keep_queue;
 	}
@@ -4734,7 +4734,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 					BFQQE_BUDGET_TIMEOUT);
 		else if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
 			 (bfqq->dispatched == 0 ||
-			  !bfq_bfqq_may_idle(bfqq)))
+			  !bfq_better_to_idle(bfqq)))
 			bfq_bfqq_expire(bfqd, bfqq, false,
 					BFQQE_NO_MORE_REQUESTS);
 	}
-- 
2.16.1

