Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9731FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B9624B56
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7/n6jSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B9624B56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935071AbeFYTs3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:48:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36704 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934996AbeFYTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:48:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id t3-v6so6149037eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LKtII1UD6euL+L9WiOdbqv9eZt0vnFL0OuzsmpLoWpw=;
        b=I7/n6jSE+y7+oZY2VtrgxXNCT0d9NRee/fF54+roBwYsGHcmlW6VR8jLGF+tXAreV9
         u955TZC6w4a8pT3EhNYNFo1R3iS0jvvQIut5xX+JbE1XRLr6Bj/Bl4eKIjzICEM/1l/U
         cCkSIPN5JYjBeZWQQ5fyzDxwWQ72vbG+QXnj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LKtII1UD6euL+L9WiOdbqv9eZt0vnFL0OuzsmpLoWpw=;
        b=Yf+KecN7pMyFQbKmBD+KFA0FvHWT/Sng1X1s9cPeHHOhtX4zbWe3jdcjq4AG4YBUCg
         WQtkGtdkIRhoMwjTHASlAhIND7Ni4T9CgGAYLFyc8wrCwFrJf85qzgvFIlkva+s0MSHM
         CcqlbfwAVhKcU8ZvXcWeQxK/+l2x2wOLGCfujJY+RuqE9EJ90AOvvl3I2vne6vxd2+HY
         1RhSTpcv8dwKW1JqoTt9oVMrp5Exhv15DKAlt1mlBStN5GvdBTNQl4yCpSgydbVNTNw/
         3COXvH4twTnL477g99RjukU2Zt/BEyB5V8r4ew6SZ0DongZWPnUFJt5aP5YJOSLgW9xa
         fbJQ==
X-Gm-Message-State: APt69E2UKCsWqsSMQu2rpqxy5nVPOD9/78lc5169zBeQMimfJgq5SXDQ
        Z2LPXEsQRdBCCG3zrivOtpvHdw==
X-Google-Smtp-Source: ADUXVKIvyhLR2ZQ392Y7JXntwTv7j/sbdP2JcI6v2bREvarxv7lp2lVT9vziax6PyTRzE4ytRKxOPQ==
X-Received: by 2002:a50:8876:: with SMTP id c51-v6mr12610295edc.146.1529956104500;
        Mon, 25 Jun 2018 12:48:24 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id d11-v6sm17553edh.61.2018.06.25.12.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:48:23 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 3/4] block, bfq: fix service being wrongly set to zero in case of preemption
Date:   Mon, 25 Jun 2018 21:48:05 +0200
Message-Id: <20180625194806.7619-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180625194806.7619-1-paolo.valente@linaro.org>
References: <20180625194806.7619-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If
- a bfq_queue Q preempts another queue, because one request of Q
arrives in time,
- but, after this preemption, Q is not the queue that is set in service,
then Q->entity.service is set to 0 when Q is eventually set in
service. But Q should have continued receiving service with its old
budget (which is why preemption has occurred) and its old service.

This commit addresses this issue by resetting service on queue real
expiration.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 34 ++++++++++++++++++++++++++++------
 block/bfq-wf2q.c    |  6 ------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4fd4f1996498..d579cc8e0db6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1382,18 +1382,30 @@ static bool bfq_bfqq_update_budg_for_activation(struct bfq_data *bfqd,
 		 * remain unchanged after such an expiration, and the
 		 * following statement therefore assigns to
 		 * entity->budget the remaining budget on such an
-		 * expiration. For clarity, entity->service is not
-		 * updated on expiration in any case, and, in normal
-		 * operation, is reset only when bfqq is selected for
-		 * service (see bfq_get_next_queue).
+		 * expiration.
 		 */
 		entity->budget = min_t(unsigned long,
 				       bfq_bfqq_budget_left(bfqq),
 				       bfqq->max_budget);
 
+		/*
+		 * At this point, we have used entity->service to get
+		 * the budget left (needed for updating
+		 * entity->budget). Thus we finally can, and have to,
+		 * reset entity->service. The latter must be reset
+		 * because bfqq would otherwise be charged again for
+		 * the service it has received during its previous
+		 * service slot(s).
+		 */
+		entity->service = 0;
+
 		return true;
 	}
 
+	/*
+	 * We can finally complete expiration, by setting service to 0.
+	 */
+	entity->service = 0;
 	entity->budget = max_t(unsigned long, bfqq->max_budget,
 			       bfq_serv_to_charge(bfqq->next_rq, bfqq));
 	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
@@ -3271,11 +3283,21 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	ref = bfqq->ref;
 	__bfq_bfqq_expire(bfqd, bfqq);
 
+	if (ref == 1) /* bfqq is gone, no more actions on it */
+		return;
+
 	/* mark bfqq as waiting a request only if a bic still points to it */
-	if (ref > 1 && !bfq_bfqq_busy(bfqq) &&
+	if (!bfq_bfqq_busy(bfqq) &&
 	    reason != BFQQE_BUDGET_TIMEOUT &&
-	    reason != BFQQE_BUDGET_EXHAUSTED)
+	    reason != BFQQE_BUDGET_EXHAUSTED) {
 		bfq_mark_bfqq_non_blocking_wait_rq(bfqq);
+		/*
+		 * Not setting service to 0, because, if the next rq
+		 * arrives in time, the queue will go on receiving
+		 * service with this same budget (as if it never expired)
+		 */
+	} else
+		entity->service = 0;
 }
 
 /*
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 58cf38fcee05..dbc07b456059 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1544,12 +1544,6 @@ struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
 		entity = sd->next_in_service;
 		sd->in_service_entity = entity;
 
-		/*
-		 * Reset the accumulator of the amount of service that
-		 * the entity is about to receive.
-		 */
-		entity->service = 0;
-
 		/*
 		 * If entity is no longer a candidate for next
 		 * service, then it must be extracted from its active
-- 
2.16.1

