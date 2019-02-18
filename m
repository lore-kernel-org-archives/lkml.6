Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5323421900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500066;
	bh=xJGo2eYGLla95ljBWJd2nfHolofcaQoa6y+0wUQsDKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ALIKfXjgnk4haAknWcXTTzPqGJzuhk/1gytbqEL35TknW8iyAhhp5/j/EMBdnqgQU
	 icXUqRuN/gv3MeiQhmUNkSPmB5XVCPPtAfoyG9GhEq1/j9vnxOp6k9Assp7yBYILwJ
	 p+kARcy6hiY0uz2r4rYKfiPvzBbHS6Twvb7F92ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfBRO1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730988AbfBROBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:01:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED3F2070D;
        Mon, 18 Feb 2019 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498494;
        bh=xJGo2eYGLla95ljBWJd2nfHolofcaQoa6y+0wUQsDKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqgmeEa1nY3bzbdlxFvWAl4eOHN+N4C2eSqOHzOGa0r1rSGIIc7OU8gEdtZq4+h58
         b2z4rCfc5ioi9+QtbGNtHn7m25k/Cu7OBsLEgmEQ3T4Y4G+D7bzpymWMPI2bu2TzUC
         n6l6XCDJ5v6EmgxKSpRHGlyLBehN3nKxN0hvY+CY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        tj@kernel.org, johannes.berg@intel.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 027/143] timekeeping: Use proper seqcount initializer
Date:   Mon, 18 Feb 2019 14:42:35 +0100
Message-Id: <20190218133530.141605859@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ce10a5b3954f2514af726beb78ed8d7350c5e41c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index fed86b2dfc89..d9837d25dfe0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -39,7 +39,9 @@
 static struct {
 	seqcount_t		seq;
 	struct timekeeper	timekeeper;
-} tk_core ____cacheline_aligned;
+} tk_core ____cacheline_aligned = {
+	.seq = SEQCNT_ZERO(tk_core.seq),
+};
 
 static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
-- 
2.19.1



