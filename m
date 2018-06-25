Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF4DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7805226096
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5l+zteD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7805226096
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965136AbeFYT4Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:56:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46344 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965048AbeFYTzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:55:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id l14-v6so9802966wrq.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LKtII1UD6euL+L9WiOdbqv9eZt0vnFL0OuzsmpLoWpw=;
        b=I5l+zteDLPVsIucfXHvKJbeVUX2QkVzZJkmjcFzOeEwhiDrm7k7HmM5BbBlZp6jy+A
         wTz1DXQMlmBSiggKM31vuzIUhd7cVg1xiM+wb3a75usVzAg/u8fKec6D6aGz8Vb/NvDQ
         7t4239dR9gvbXU2j51bysV/9Hiak5Huyvuja4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LKtII1UD6euL+L9WiOdbqv9eZt0vnFL0OuzsmpLoWpw=;
        b=kWu8xtwu292IwT/wXaJoYYp3hXJmlATqD8et+fwle7AvXQoQHUVs7XOIKt20jWv/tg
         unOzqH4G+9UsYdvtfCK2VxUumoS1nj80MaL9Fn001BH2fEBELATHYWHkMzfz3QvGosD6
         hBzmKugOZDZOEO0YJko0EUXkJR02wPJUxVntGQfgr/7zSVks/O7mSJ1Y7pk6RxkzwxqT
         H0in80i+E4zG9Z7g3TNy4POpxusbGX0mb2f4s1z4FHlHvVxgnEMG8QCxFYyoildSsOTJ
         +qD+8zzKtrLTWXyUQzOx/Lp3paWMlMr+im6+0/c6OvIFU2T+6vUBHSrODei/yWH5mbjM
         ZbDA==
X-Gm-Message-State: APt69E31mMcVJVLlDDFobWLMjltyrz3iXGkFwVj35I2k/4TMcJMmxOo0
        TQnhWqWUL/21uXbexj83qhZSYA==
X-Google-Smtp-Source: AAOMgpdEnC/aFz+lNYxN5D5wJHIvw1rZjnGBV0wAoul4y1oRob4qaHfNy7MB4oNH8o4a3HF8tJSoRA==
X-Received: by 2002:adf:ac66:: with SMTP id v93-v6mr3460980wrc.7.1529956553730;
        Mon, 25 Jun 2018 12:55:53 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id n18-v6sm29072897wrj.58.2018.06.25.12.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:55:52 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX RESEND 3/4] block, bfq: fix service being wrongly set to zero in case of preemption
Date:   Mon, 25 Jun 2018 21:55:36 +0200
Message-Id: <20180625195537.7769-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
References: <20180625195537.7769-1-paolo.valente@linaro.org>
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

