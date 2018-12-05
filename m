Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF2C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195AF214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195AF214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeLEKEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:04:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32801 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeLEKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:03:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB5A3rlM1231607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Dec 2018 02:03:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB5A3r121231604;
        Wed, 5 Dec 2018 02:03:53 -0800
Date:   Wed, 5 Dec 2018 02:03:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-ce10a5b3954f2514af726beb78ed8d7350c5e41c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bvanassche@acm.org, hpa@zytor.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          bvanassche@acm.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20181128234325.110011-12-bvanassche@acm.org>
References: <20181128234325.110011-12-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Use proper seqcount initializer
Git-Commit-ID: ce10a5b3954f2514af726beb78ed8d7350c5e41c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ce10a5b3954f2514af726beb78ed8d7350c5e41c
Gitweb:     https://git.kernel.org/tip/ce10a5b3954f2514af726beb78ed8d7350c5e41c
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Wed, 28 Nov 2018 15:43:09 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 5 Dec 2018 11:00:09 +0100

timekeeping: Use proper seqcount initializer

tk_core.seq is initialized open coded, but that misses to initialize the
lockdep map when lockdep is enabled. Lockdep splats involving tk_core seq
consequently lack a name and are hard to read.

Use the proper initializer which takes care of the lockdep map
initialization.

[ tglx: Massaged changelog ]

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: tj@kernel.org
Cc: johannes.berg@intel.com
Link: https://lkml.kernel.org/r/20181128234325.110011-12-bvanassche@acm.org

---
 kernel/time/timekeeping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cd02bd38cf2d..c801e25875a3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -45,7 +45,9 @@ enum timekeeping_adv_mode {
 static struct {
 	seqcount_t		seq;
 	struct timekeeper	timekeeper;
-} tk_core ____cacheline_aligned;
+} tk_core ____cacheline_aligned = {
+	.seq = SEQCNT_ZERO(tk_core.seq),
+};
 
 static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
