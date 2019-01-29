Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6D9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA6D2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtSOU/Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfA2LHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37843 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfA2LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so17260894wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqztSqIPzKKBWIFY2MqAio0w3pO/+CETJ20qHxYP8sU=;
        b=dtSOU/WkVIhSYUqeW3JTn3QUufABzxHPLxowScogLO1dE4ZwITfBQdRm0f+ZtddNKB
         UXUi1A/1zNrj6MnKUUu6LpqcGQ1WdyfuVgpmnqma4bCJGWtcxZaEfLgdfbanuGNMHgWo
         vhkVrylJKJu+zYCvMj/ntuM4/9rogp/gl39Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqztSqIPzKKBWIFY2MqAio0w3pO/+CETJ20qHxYP8sU=;
        b=JLOuJn9TGrvoRmlFYHxHUKB5sjjks4jJOBX9exDsRzzlIBXeQ6fmQqbqVLuFYCQRTl
         hbbqDegRWJtIR+1LG3qMF7mVHrN0rAMRnQKViTzOS7W45hrBfn+sP/s017LDuQsoXQV8
         wWzYbdirXvTAOQ3y3Nm/CH40D8AHVMCbbtN0nmLCyKdFzk9eaRFrFcJ3e5KL+FdeiLhb
         ZrOO0awaRS378kPRvGPQOetn+hpQHOhRw6XnkIvEK1PTpgyrCDv6lG3bV55aBeUAWRyO
         D8orWA/fcSH4um2Xs0goKRfX1dKrkIZNofUrynJXSXoGP9stjsrt34DeeAyebMYBICBb
         80KQ==
X-Gm-Message-State: AJcUukfqXGzfgLebIfYdXZfPbBO26oGf0tfCCwoK9xVkBgX+QomtaBJE
        f7Ip4E+TgqpF77eonoystcTkVA==
X-Google-Smtp-Source: ALg8bN700krUAVlb9TYy54/s/Am6FyVeMUw5idUjzm72ZYoxaexT8Ki6r4Ds4SZLdVhuJamsIraEfg==
X-Received: by 2002:a1c:c87:: with SMTP id 129mr19704056wmm.116.1548760018406;
        Tue, 29 Jan 2019 03:06:58 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:06:57 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 01/14] block, bfq: do not consider interactive queues in srt filtering
Date:   Tue, 29 Jan 2019 12:06:25 +0100
Message-Id: <20190129110638.12652-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The speed at which a bfq_queue receives I/O is one of the parameters
by which bfq decides whether the queue is soft real-time (i.e.,
whether the queue contains the I/O of a soft real-time
application). In particular, when a bfq_queue remains without
outstanding I/O requests, bfq computes the minimum time instant, named
soft_rt_next_start, at which the next request of the queue may arrive
for the queue to be deemed as soft real time.

Unfortunately this filtering may cause problems with a queue in
interactive weight raising. In fact, such a queue may be conveying the
I/O needed to load a soft real-time application. The latter will
actually exhibit a soft real-time I/O pattern after it finally starts
doing its job. But, if soft_rt_next_start is updated for an
interactive bfq_queue, and the queue has received a lot of service
before remaining with no outstanding request (likely to happen on a
fast device), then soft_rt_next_start is assigned such a high value
that, for a very long time, the queue is prevented from being possibly
considered as soft real time.

This commit removes the updating of soft_rt_next_start for bfq_queues
in interactive weight raising.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index cd307767a134..c7a4a15c7c19 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3274,16 +3274,32 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 		 * requests, then the request pattern is isochronous
 		 * (see the comments on the function
 		 * bfq_bfqq_softrt_next_start()). Thus we can compute
-		 * soft_rt_next_start. If, instead, the queue still
-		 * has outstanding requests, then we have to wait for
-		 * the completion of all the outstanding requests to
-		 * discover whether the request pattern is actually
-		 * isochronous.
+		 * soft_rt_next_start. And we do it, unless bfqq is in
+		 * interactive weight raising. We do not do it in the
+		 * latter subcase, for the following reason. bfqq may
+		 * be conveying the I/O needed to load a soft
+		 * real-time application. Such an application will
+		 * actually exhibit a soft real-time I/O pattern after
+		 * it finally starts doing its job. But, if
+		 * soft_rt_next_start is computed here for an
+		 * interactive bfqq, and bfqq had received a lot of
+		 * service before remaining with no outstanding
+		 * request (likely to happen on a fast device), then
+		 * soft_rt_next_start would be assigned such a high
+		 * value that, for a very long time, bfqq would be
+		 * prevented from being possibly considered as soft
+		 * real time.
+		 *
+		 * If, instead, the queue still has outstanding
+		 * requests, then we have to wait for the completion
+		 * of all the outstanding requests to discover whether
+		 * the request pattern is actually isochronous.
 		 */
-		if (bfqq->dispatched == 0)
+		if (bfqq->dispatched == 0 &&
+		    bfqq->wr_coeff != bfqd->bfq_wr_coeff)
 			bfqq->soft_rt_next_start =
 				bfq_bfqq_softrt_next_start(bfqd, bfqq);
-		else {
+		else if (bfqq->dispatched > 0) {
 			/*
 			 * Schedule an update of soft_rt_next_start to when
 			 * the task may be discovered to be isochronous.
@@ -4834,11 +4850,14 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 	 * isochronous, and both requisites for this condition to hold
 	 * are now satisfied, then compute soft_rt_next_start (see the
 	 * comments on the function bfq_bfqq_softrt_next_start()). We
-	 * schedule this delayed check when bfqq expires, if it still
-	 * has in-flight requests.
+	 * do not compute soft_rt_next_start if bfqq is in interactive
+	 * weight raising (see the comments in bfq_bfqq_expire() for
+	 * an explanation). We schedule this delayed update when bfqq
+	 * expires, if it still has in-flight requests.
 	 */
 	if (bfq_bfqq_softrt_update(bfqq) && bfqq->dispatched == 0 &&
-	    RB_EMPTY_ROOT(&bfqq->sort_list))
+	    RB_EMPTY_ROOT(&bfqq->sort_list) &&
+	    bfqq->wr_coeff != bfqd->bfq_wr_coeff)
 		bfqq->soft_rt_next_start =
 			bfq_bfqq_softrt_next_start(bfqd, bfqq);
 
-- 
2.20.1

