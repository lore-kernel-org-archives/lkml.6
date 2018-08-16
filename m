Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDE92147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDE92147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbeHPVqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:46:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeHPVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:46:09 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C057CE8;
        Thu, 16 Aug 2018 18:45:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Lee Tibbert <lee.tibbert@gmail.com>,
        Mirko Montanari <mirkomontanari91@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 17/22] block, bfq: fix wrong init of saved start time for weight raising
Date:   Thu, 16 Aug 2018 20:45:18 +0200
Message-Id: <20180816171625.072831365@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171622.831964729@linuxfoundation.org>
References: <20180816171622.831964729@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Valente <paolo.valente@linaro.org>

commit 4baa8bb13f41307f3eb62fe91f93a1a798ebef53 upstream.

This commit fixes a bug that causes bfq to fail to guarantee a high
responsiveness on some drives, if there is heavy random read+write I/O
in the background. More precisely, such a failure allowed this bug to
be found [1], but the bug may well cause other yet unreported
anomalies.

BFQ raises the weight of the bfq_queues associated with soft real-time
applications, to privilege the I/O, and thus reduce latency, for these
applications. This mechanism is named soft-real-time weight raising in
BFQ. A soft real-time period may happen to be nested into an
interactive weight raising period, i.e., it may happen that, when a
bfq_queue switches to a soft real-time weight-raised state, the
bfq_queue is already being weight-raised because deemed interactive
too. In this case, BFQ saves in a special variable
wr_start_at_switch_to_srt, the time instant when the interactive
weight-raising period started for the bfq_queue, i.e., the time
instant when BFQ started to deem the bfq_queue interactive. This value
is then used to check whether the interactive weight-raising period
would still be in progress when the soft real-time weight-raising
period ends.  If so, interactive weight raising is restored for the
bfq_queue. This restore is useful, in particular, because it prevents
bfq_queues from losing their interactive weight raising prematurely,
as a consequence of spurious, short-lived soft real-time
weight-raising periods caused by wrong detections as soft real-time.

If, instead, a bfq_queue switches to soft-real-time weight raising
while it *is not* already in an interactive weight-raising period,
then the variable wr_start_at_switch_to_srt has no meaning during the
following soft real-time weight-raising period. Unfortunately the
handling of this case is wrong in BFQ: not only the variable is not
flagged somehow as meaningless, but it is also set to the time when
the switch to soft real-time weight-raising occurs. This may cause an
interactive weight-raising period to be considered mistakenly as still
in progress, and thus a spurious interactive weight-raising period to
start for the bfq_queue, at the end of the soft-real-time
weight-raising period. In particular the spurious interactive
weight-raising period will be considered as still in progress, if the
soft-real-time weight-raising period does not last very long. The
bfq_queue will then be wrongly privileged and, if I/O bound, will
unjustly steal bandwidth to truly interactive or soft real-time
bfq_queues, harming responsiveness and low latency.

This commit fixes this issue by just setting wr_start_at_switch_to_srt
to minus infinity (farthest past time instant according to jiffies
macros): when the soft-real-time weight-raising period ends, certainly
no interactive weight-raising period will be considered as still in
progress.

[1] Background I/O Type: Random - Background I/O mix: Reads and writes
- Application to start: LibreOffice Writer in
http://www.phoronix.com/scan.php?page=news_item&px=Linux-4.13-IO-Laptop

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Lee Tibbert <lee.tibbert@gmail.com>
Tested-by: Mirko Montanari <mirkomontanari91@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bfq-iosched.c |   50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1203,6 +1203,24 @@ static unsigned int bfq_wr_duration(stru
 	return dur;
 }
 
+/*
+ * Return the farthest future time instant according to jiffies
+ * macros.
+ */
+static unsigned long bfq_greatest_from_now(void)
+{
+	return jiffies + MAX_JIFFY_OFFSET;
+}
+
+/*
+ * Return the farthest past time instant according to jiffies
+ * macros.
+ */
+static unsigned long bfq_smallest_from_now(void)
+{
+	return jiffies - MAX_JIFFY_OFFSET;
+}
+
 static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq,
 					     unsigned int old_wr_coeff,
@@ -1217,7 +1235,19 @@ static void bfq_update_bfqq_wr_on_rq_arr
 			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
 			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
 		} else {
-			bfqq->wr_start_at_switch_to_srt = jiffies;
+			/*
+			 * No interactive weight raising in progress
+			 * here: assign minus infinity to
+			 * wr_start_at_switch_to_srt, to make sure
+			 * that, at the end of the soft-real-time
+			 * weight raising periods that is starting
+			 * now, no interactive weight-raising period
+			 * may be wrongly considered as still in
+			 * progress (and thus actually started by
+			 * mistake).
+			 */
+			bfqq->wr_start_at_switch_to_srt =
+				bfq_smallest_from_now();
 			bfqq->wr_coeff = bfqd->bfq_wr_coeff *
 				BFQ_SOFTRT_WEIGHT_FACTOR;
 			bfqq->wr_cur_max_time =
@@ -2896,24 +2926,6 @@ static unsigned long bfq_bfqq_softrt_nex
 		   jiffies + nsecs_to_jiffies(bfqq->bfqd->bfq_slice_idle) + 4);
 }
 
-/*
- * Return the farthest future time instant according to jiffies
- * macros.
- */
-static unsigned long bfq_greatest_from_now(void)
-{
-	return jiffies + MAX_JIFFY_OFFSET;
-}
-
-/*
- * Return the farthest past time instant according to jiffies
- * macros.
- */
-static unsigned long bfq_smallest_from_now(void)
-{
-	return jiffies - MAX_JIFFY_OFFSET;
-}
-
 /**
  * bfq_bfqq_expire - expire a queue.
  * @bfqd: device owning the queue.


