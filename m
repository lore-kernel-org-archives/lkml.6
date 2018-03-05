Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934970AbeCEMtC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:49:02 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:39702 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934877AbeCEMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:48:59 -0500
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] block, bfq: keep peak_rate estimation within range 1..2^32-1
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>, linux-kernel@vger.kernel.org
Date: Mon, 05 Mar 2018 15:48:53 +0300
Message-ID: <152025413365.161046.7757556276366364549.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rate should never overflow or become zero because it is used as divider.
This patch accumulates it with saturation.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/bfq-iosched.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index aeca22d91101..a236c8d541b5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2546,7 +2546,8 @@ static void bfq_reset_rate_computation(struct bfq_data *bfqd,
 
 static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
 {
-	u32 rate, weight, divisor;
+	u32 weight, divisor;
+	u64 rate;
 
 	/*
 	 * For the convergence property to hold (see comments on
@@ -2634,9 +2635,10 @@ static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
 	 */
 	bfqd->peak_rate *= divisor-1;
 	bfqd->peak_rate /= divisor;
-	rate /= divisor; /* smoothing constant alpha = 1/divisor */
+	do_div(rate, divisor);	/* smoothing constant alpha = 1/divisor */
 
-	bfqd->peak_rate += rate;
+	/* rate should never overlow or become zero */
+	bfqd->peak_rate = clamp_t(u64, rate + bfqd->peak_rate, 1, U32_MAX);
 	update_thr_responsiveness_params(bfqd);
 
 reset_computation:
