Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0104CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F3426093
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQvYuzhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F3426093
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965100AbeFYTz4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:55:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44122 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965042AbeFYTzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:55:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so13232642wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j7GMIIGaIORm8b6LjrnaeSpizBl5u4j6T5VX4NtEKP0=;
        b=gQvYuzhKyf5+4vtV9Yb7lZ/XQ5uVesz/M1GB+b5Jdp8aqoEPm4/wzV35RD06fmYjKO
         ouw7xTWeDmnX/QIsWP443pkQDhBZ3IrUzXXb4btWoMYol7Q3cljstUEVHOuDtfUXUKjT
         d9bdCvxgF7+cOhRi5t3UjFLRMYi8ixOYw5RLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j7GMIIGaIORm8b6LjrnaeSpizBl5u4j6T5VX4NtEKP0=;
        b=JPfgJPiTywQ7o0lBE4aRHs+ehyQP4AiTjW5V7UlTXVQR/CDIbU5vIW2vor+Ho7X5Ou
         V+m1o+mpvZSOmt5w1+htf06At/fxrJbzw4W/1PUVo6AeluXqUMei4BEUr318ZSDBrVG/
         IefV5ieBpq5ehaNAuOA2qBjfEiYsJcxUczr1rZl8Qgl8T27CY0zAjVNRUSMal2wuy3kO
         tk0X0Vtle1ubYfgpiNXBkSFprIFEEj8G3jzsOi1q+CIJVy4CVv1HOJg7JSE6IIX/Rbm3
         khqb9zgaLabz3MBTKEBdd4AxgpZALMisN2ZR5BVhmhBQSYr1kbcezzBXorIjE+uswHA7
         5JJg==
X-Gm-Message-State: APt69E2SdsB6OI+3lJO5LsIMs72CJB3MW2TY1l65gBP4oKwzD+5QQ7VP
        mcmsb2WQbuIabrZZVhC2A6F5xw==
X-Google-Smtp-Source: AAOMgpf/fsAM/uTMn9KpZ9A8E+o8Xf9hL7VkpBuq6fYjPTpZN1fOygoa/xH3/L6cRK0nxcL/COmnyQ==
X-Received: by 2002:adf:88e3:: with SMTP id g32-v6mr4282569wrg.62.1529956552337;
        Mon, 25 Jun 2018 12:55:52 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id n18-v6sm29072897wrj.58.2018.06.25.12.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:55:51 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX RESEND 2/4] block, bfq: do not expire a queue that will deserve dispatch plugging
Date:   Mon, 25 Jun 2018 21:55:35 +0200
Message-Id: <20180625195537.7769-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
References: <20180625195537.7769-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some bfq_queues, BFQ plugs I/O dispatching when the queue becomes
idle, and keeps the plug until a new request of the queue arrives, or
a timeout fires. BFQ does so either to boost throughput or to preserve
service guarantees for the queue.

More precisely, for such a queue, plugging starts when the queue
happens to have either no request enqueued, or no request in flight,
that is, no request already dispatched but not yet completed.

On the opposite end, BFQ may happen to expire a queue with no request
enqueued, without doing any plugging, if the queue still has some
request in flight. Unfortunately, such a premature expiration causes
the queue to lose its chance to enjoy dispatch plugging a moment
later, i.e., when its in-flight requests finally get completed. This
breaks service guarantees for the queue.

This commit prevents BFQ from expiring an empty queue if the latter
still has in-flight requests.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3f32e88c7e9b..4fd4f1996498 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3597,8 +3597,14 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 
 	bfq_log_bfqq(bfqd, bfqq, "select_queue: already in-service queue");
 
+	/*
+	 * Do not expire bfqq for budget timeout if bfqq may be about
+	 * to enjoy device idling. The reason why, in this case, we
+	 * prevent bfqq from expiring is the same as in the comments
+	 * on the case where bfq_bfqq_must_idle() returns true, in
+	 * bfq_completed_request().
+	 */
 	if (bfq_may_expire_for_budg_timeout(bfqq) &&
-	    !bfq_bfqq_wait_request(bfqq) &&
 	    !bfq_bfqq_must_idle(bfqq))
 		goto expire;
 
@@ -4674,8 +4680,32 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 	 * or if we want to idle in case it has no pending requests.
 	 */
 	if (bfqd->in_service_queue == bfqq) {
-		if (bfqq->dispatched == 0 && bfq_bfqq_must_idle(bfqq)) {
-			bfq_arm_slice_timer(bfqd);
+		if (bfq_bfqq_must_idle(bfqq)) {
+			if (bfqq->dispatched == 0)
+				bfq_arm_slice_timer(bfqd);
+			/*
+			 * If we get here, we do not expire bfqq, even
+			 * if bfqq was in budget timeout or had no
+			 * more requests (as controlled in the next
+			 * conditional instructions). The reason for
+			 * not expiring bfqq is as follows.
+			 *
+			 * Here bfqq->dispatched > 0 holds, but
+			 * bfq_bfqq_must_idle() returned true. This
+			 * implies that, even if no request arrives
+			 * for bfqq before bfqq->dispatched reaches 0,
+			 * bfqq will, however, not be expired on the
+			 * completion event that causes bfqq->dispatch
+			 * to reach zero. In contrast, on this event,
+			 * bfqq will start enjoying device idling
+			 * (I/O-dispatch plugging).
+			 *
+			 * But, if we expired bfqq here, bfqq would
+			 * not have the chance to enjoy device idling
+			 * when bfqq->dispatched finally reaches
+			 * zero. This would expose bfqq to violation
+			 * of its reserved service guarantees.
+			 */
 			return;
 		} else if (bfq_may_expire_for_budg_timeout(bfqq))
 			bfq_bfqq_expire(bfqd, bfqq, false,
-- 
2.16.1

