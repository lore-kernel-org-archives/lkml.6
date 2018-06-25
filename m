Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195BAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96F624D9F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISXAMyz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96F624D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935119AbeFYTsz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:48:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39550 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934970AbeFYTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:48:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so6142283eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j7GMIIGaIORm8b6LjrnaeSpizBl5u4j6T5VX4NtEKP0=;
        b=ISXAMyz9HG6X03+UdeNNU20+QgDeyaDqi+YBQBdK8+sHi72oOUZ/a02YoFUn1nlpYb
         1xHA+/a6/qy7i6I/Is/IVe6y+g5hDKXgIIwDrByr/Xag9f0qFxLY+QOYQXdwaRA/wk3R
         nlIiR6W7//92ZEu1fsbsPx7G3HyBEmbNhzduo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j7GMIIGaIORm8b6LjrnaeSpizBl5u4j6T5VX4NtEKP0=;
        b=Qx0sVmAbwWG9PWU2v9Bhf8/G99qbZruE9wKi2I/ofgZAOo//3dGUeKCFd2vYem+YfK
         4qIEAhsvoImp7o7W4NJ1G5V6j/GRtTigT6RGE1Ao0KFYGD1jHVdVHQtT45dNYq0FoSgS
         +liHVYQTFdzFVTCAilqbj6qiobmQHDgsvIA3HHASImLWBieFLSwF687wQ4L2Gl4MqLC1
         ix5g+JMNgFcj68UVQTN92842yVemak5Hds1lNL0N99idcpc3mWb3i7hCEIvpDylZt/Ca
         ZrhzDfCrTIAQtEFTPkI6+8y7et0JCqlQa04QdzUHPqX+qrD5dU0BmC9Rwsm7T/5FCqfZ
         5MAg==
X-Gm-Message-State: APt69E137PnwdJhf2aehc6uT9ESp1C0cFSihvm/GGhElplHymKaTvPnT
        8ZpXO4CnhzDECHFCRzoJfcsuYg==
X-Google-Smtp-Source: ADUXVKJh52zOIELRCuMdsbGRf6ecEdowqEX6rlI4EBwK5HdiSlDKtQhz6vePPx4Zrx4SzqtSZZpE9w==
X-Received: by 2002:aa7:d992:: with SMTP id u18-v6mr12610229eds.300.1529956102893;
        Mon, 25 Jun 2018 12:48:22 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id d11-v6sm17553edh.61.2018.06.25.12.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:48:22 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 2/4] block, bfq: do not expire a queue that will deserve dispatch plugging
Date:   Mon, 25 Jun 2018 21:48:04 +0200
Message-Id: <20180625194806.7619-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180625194806.7619-1-paolo.valente@linaro.org>
References: <20180625194806.7619-1-paolo.valente@linaro.org>
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

