Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D017DC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934812146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934812146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeIMEfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:35:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMEfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:35:15 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E741D10;
        Wed, 12 Sep 2018 23:28:29 +0000 (UTC)
Date:   Wed, 12 Sep 2018 16:28:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/9] sched: loadavg: consolidate LOAD_INT, LOAD_FRAC,
 CALC_LOAD
Message-Id: <20180912162828.ae336d83e8c467345e70de17@linux-foundation.org>
In-Reply-To: <20180828172258.3185-5-hannes@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
        <20180828172258.3185-5-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 13:22:53 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> There are several definitions of those functions/macros in places that
> mess with fixed-point load averages. Provide an official version.

missed blk-iolatency.c for some reason?


--- a/block/blk-iolatency.c~sched-loadavg-consolidate-load_int-load_frac-calc_load-fix
+++ a/block/blk-iolatency.c
@@ -139,7 +139,7 @@ struct iolatency_grp {
 #define BLKIOLATENCY_MAX_WIN_SIZE NSEC_PER_SEC
 /*
  * These are the constants used to fake the fixed-point moving average
- * calculation just like load average.  The call to CALC_LOAD folds
+ * calculation just like load average.  The call to calc_load() folds
  * (FIXED_1 (2048) - exp_factor) * new_sample into lat_avg.  The sampling
  * window size is bucketed to try to approximately calculate average
  * latency such that 1/exp (decay rate) is [1 min, 2.5 min) when windows
@@ -503,7 +503,7 @@ static void iolatency_check_latencies(st
 	lat_info = &parent->child_lat;
 
 	/*
-	 * CALC_LOAD takes in a number stored in fixed point representation.
+	 * calc_load() takes in a number stored in fixed point representation.
 	 * Because we are using this for IO time in ns, the values stored
 	 * are significantly larger than the FIXED_1 denominator (2048).
 	 * Therefore, rounding errors in the calculation are negligible and
@@ -512,7 +512,7 @@ static void iolatency_check_latencies(st
 	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
 			div64_u64(iolat->cur_win_nsec,
 				  BLKIOLATENCY_EXP_BUCKET_SIZE));
-	CALC_LOAD(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat.mean);
+	calc_load(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat.mean);
 
 	/* Everything is ok and we don't need to adjust the scale. */
 	if (stat.mean <= iolat->min_lat_nsec &&
_

