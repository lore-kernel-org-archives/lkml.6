Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LUCRATIVE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36CAC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9994F2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kM1EsQuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfA2LHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33676 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfA2LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so12685267wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWB7QVcaljANFueMNZpw7vbeVw33aKruWnTjcF4CgUA=;
        b=kM1EsQuHwH9AJMB8rxg28Ik28/xZAi7sJvABLEcNMGaHmqVDqRJJR82Tjy6I/OcK93
         inMy91trQkSDaTol6pj/Aau2E+kAh+mmQ/PWw1ScIHdN1+JKhHr4oonLBu07wLNa0rgC
         zGrqDdox+p4OWTyHWlKNcD6uirgyB/rljFY6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWB7QVcaljANFueMNZpw7vbeVw33aKruWnTjcF4CgUA=;
        b=FWFssse5gPiWjdb5aGLcNFNW/0skxII6L6TrRdRnHn0nVOcWxkVJ6wmou1JpCAtSh0
         BGnE9OkZmdwE0PYvwH5s72qzhNNJ6dVCiGSqkVbvIKdL413nB+SAhJvVkEtrmcio4tkc
         M1f8vmY7ywg6Kn30AlPAZDdaGxltIeR9kF8ZKMa5mMFV0BV6Fmh5vWFNSxz6ivdVhaHg
         PIWFQ5UQkLtPltMjq72SEkVKJio7n4ndd/lbVs70rLX/URuAuA5SNDXR3brWYCU+Ra8P
         LNi1Zcga81SPD3TUVbTtCUJOHX61FWBLEQjYo2paxSgKdyF1pJtoV8A8B+lwNUYlBNkx
         htZA==
X-Gm-Message-State: AJcUukfuTd+ZbDUc4cZ4IuH1M447yGLoh32M/qyaUrLooSoaNrXGoXE9
        XjFyQwNso/KEuJiCvu1ROHe0wg==
X-Google-Smtp-Source: ALg8bN4r+l2h5vyRlM8a4/dsCDbGHig07s0B4F29lFDOYmG80sptM9G+9xr4WEhNYLlUjncMA+2Hag==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr20309254wmb.153.1548760026112;
        Tue, 29 Jan 2019 03:07:06 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:05 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 07/14] block, bfq: do not plug I/O of in-service queue when harmful
Date:   Tue, 29 Jan 2019 12:06:31 +0100
Message-Id: <20190129110638.12652-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the in-service bfq_queue is sync and remains temporarily idle, then
I/O dispatching (from other queues) may be plugged. It may be dome for
two reasons: either to boost throughput, or to preserve the bandwidth
share of the in-service queue. In the first case, if the I/O of the
in-service queue, when it finally arrives, consists only of one small
I/O request, then it makes sense to plug even the I/O of the
in-service queue. In fact, serving such a small request immediately is
likely to lower throughput instead of boosting it, whereas waiting a
little bit is likely to let that request grow, thanks to request
merging, and become more profitable in terms of throughput (this is
likely to happen exactly because the I/O of the queue has been
detected to boost throughput).

On the opposite end, if I/O dispatching is being plugged only to
preserve the bandwidth of the in-service queue, then it would be
better not to plug also the I/O of the in-service queue, because such
a plugging is likely to cause only loss of bandwidth for the queue.

Unfortunately, no distinction is made between the two cases, and the
I/O of the in-service queue is always plugged in case just a small I/O
request arrives. This commit draws this missing distinction and does
not perform harmful plugging.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2756f4b1432b..a6fe60114ade 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4599,28 +4599,31 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bool budget_timeout = bfq_bfqq_budget_timeout(bfqq);
 
 		/*
-		 * There is just this request queued: if the request
-		 * is small and the queue is not to be expired, then
-		 * just exit.
+		 * There is just this request queued: if
+		 * - the request is small, and
+		 * - we are idling to boost throughput, and
+		 * - the queue is not to be expired,
+		 * then just exit.
 		 *
 		 * In this way, if the device is being idled to wait
 		 * for a new request from the in-service queue, we
 		 * avoid unplugging the device and committing the
-		 * device to serve just a small request. On the
-		 * contrary, we wait for the block layer to decide
-		 * when to unplug the device: hopefully, new requests
-		 * will be merged to this one quickly, then the device
-		 * will be unplugged and larger requests will be
-		 * dispatched.
+		 * device to serve just a small request. In contrast
+		 * we wait for the block layer to decide when to
+		 * unplug the device: hopefully, new requests will be
+		 * merged to this one quickly, then the device will be
+		 * unplugged and larger requests will be dispatched.
 		 */
-		if (small_req && !budget_timeout)
+		if (small_req && idling_boosts_thr_without_issues(bfqd, bfqq) &&
+		    !budget_timeout)
 			return;
 
 		/*
-		 * A large enough request arrived, or the queue is to
-		 * be expired: in both cases disk idling is to be
-		 * stopped, so clear wait_request flag and reset
-		 * timer.
+		 * A large enough request arrived, or idling is being
+		 * performed to preserve service guarantees, or
+		 * finally the queue is to be expired: in all these
+		 * cases disk idling is to be stopped, so clear
+		 * wait_request flag and reset timer.
 		 */
 		bfq_clear_bfqq_wait_request(bfqq);
 		hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
-- 
2.20.1

