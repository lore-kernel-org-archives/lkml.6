Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB6C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE4A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fI9muOfi";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fI9muOfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE4A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeKBCrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:47:33 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:51891 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbeKBCrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:47:32 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id ABECF20F05;
        Thu,  1 Nov 2018 20:43:32 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id LYuBW6zPJP-hWJCMSuC;
        Thu, 01 Nov 2018 20:43:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541094212; bh=eRU2kFacb0z8kYcguZg7DOd1aIqte4oGyyswvwLMlp0=;
        h=Subject:From:To:Date:Message-ID;
        b=fI9muOfiBHcNcEHFycuNKwcAtHMZexjUWhLFreLvfcKuUd0QNV+mZz1Y5ZQiCM2zQ
         X+TzkI8BNdujqJr1riHlR3YFjjlVGp6T6u9nlx7chqY7IouXC45/I6ChkWtsP2eAgP
         0SBuiNhlsEV0ncFE/2LrWK4X+2nNejE4/FIcb7Ps=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:2501:1cc0:44e4:e39a])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id t5zWZvkUa8-hWoaoSJm;
        Thu, 01 Nov 2018 20:43:32 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541094212; bh=eRU2kFacb0z8kYcguZg7DOd1aIqte4oGyyswvwLMlp0=;
        h=Subject:From:To:Date:Message-ID;
        b=fI9muOfiBHcNcEHFycuNKwcAtHMZexjUWhLFreLvfcKuUd0QNV+mZz1Y5ZQiCM2zQ
         X+TzkI8BNdujqJr1riHlR3YFjjlVGp6T6u9nlx7chqY7IouXC45/I6ChkWtsP2eAgP
         0SBuiNhlsEV0ncFE/2LrWK4X+2nNejE4/FIcb7Ps=
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH RFC] block,
 bfq: set default slice_idle to zero for non-rotational devices
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Nov 2018 20:43:30 +0300
Message-ID: <154109421062.925711.4117729151502021084.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With default 8ms idle slice BFQ is up to 10 times slower than CFQ
for massive random read workloads for common SATA SSD.

For now zero idle slice gives better out of box experience.
CFQ employs this since commit 41c0126b3f22 ("block: Make CFQ default
to IOPS mode on SSDs")

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/block/bfq-iosched.txt |   12 +++++++-----
 block/bfq-iosched.c                 |    8 ++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 8d8d8f06cab2..c4a0f8998ce6 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -307,11 +307,13 @@ slice_idle
 ----------
 
 This parameter specifies how long BFQ should idle for next I/O
-request, when certain sync BFQ queues become empty. By default
-slice_idle is a non-zero value. Idling has a double purpose: boosting
-throughput and making sure that the desired throughput distribution is
-respected (see the description of how BFQ works, and, if needed, the
-papers referred there).
+request, when certain sync BFQ queues become empty.
+
+By default slice_idle is a non-zero value for rotational devices.
+
+Idling has a double purpose: boosting throughput and making sure that
+the desired throughput distribution is respected (see the description
+of how BFQ works, and, if needed, the papers referred there).
 
 As for throughput, idling can be very helpful on highly seeky media
 like single spindle SATA/SAS disks where we can cut down on overall
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6075100f03a5..d19e70a26ff0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -177,8 +177,8 @@ static const int bfq_back_max = 16 * 1024;
 /* Penalty of a backwards seek, in number of sectors. */
 static const int bfq_back_penalty = 2;
 
-/* Idling period duration, in ns. */
-static u64 bfq_slice_idle = NSEC_PER_SEC / 125;
+/* Idling period duration, in ns. Zero for non-rotational devices. */
+static u64 bfq_slice_idle[2] = { NSEC_PER_SEC / 125, 0 };
 
 /* Minimum number of assigned budgets for which stats are safe to compute. */
 static const int bfq_stats_min_budgets = 194;
@@ -3044,7 +3044,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  */
 			*delta_ms = BFQ_MIN_TT / NSEC_PER_MSEC;
 		else /* charge at least one seek */
-			*delta_ms = bfq_slice_idle / NSEC_PER_MSEC;
+			*delta_ms = bfq_slice_idle[0] / NSEC_PER_MSEC;
 
 		return slow;
 	}
@@ -5431,7 +5431,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->bfq_fifo_expire[1] = bfq_fifo_expire[1];
 	bfqd->bfq_back_max = bfq_back_max;
 	bfqd->bfq_back_penalty = bfq_back_penalty;
-	bfqd->bfq_slice_idle = bfq_slice_idle;
+	bfqd->bfq_slice_idle = bfq_slice_idle[blk_queue_nonrot(bfqd->queue)];
 	bfqd->bfq_timeout = bfq_timeout;
 
 	bfqd->bfq_requests_within_timer = 120;

