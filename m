Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 170ECC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0BB20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fvxXu+qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0BB20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933961AbeFLIjx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:39:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933363AbeFLIjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sOVzzgKheFZg4EU5xbvDIiU2Z37jMsdHbaX2TWldU7M=; b=fvxXu+qHc9i/9KbRNmxM7i7zH4
        F9dfHH5hXqfQvASBNBExtv7Hq3AcJT78qhlmf+8DBId5NpPHo8w0ovPcsw8tWpGRFKcM3aV2hKYXH
        RQvvGXk10/2YVhp3TCTV5yjfVe68S4yZyE4sWVpTrBTHKlaGsys/5lazS2jAVgRG7/AqhwiruIZmI
        L8p3XjEs/9cVcz8WGwC+ukOxvoiWg8e7xB02oN+RpiME2zoZIbFVeA0fKA2npwJJEmNdn4+wUa2GX
        FT9dGqpMeIOc3sBkTEGtaP0JaREk0kcuz07V3MdLDUYHxyiwfMG8KEmCxV5Dl/PAJo+YXsVuKPr3R
        aGcv+7LQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSepu-0001z2-UI; Tue, 12 Jun 2018 08:39:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7706D201EA7C9; Tue, 12 Jun 2018 10:39:28 +0200 (CEST)
Message-Id: <20180612083909.157076812@infradead.org>
User-Agent: quilt/0.63-1
Date:   Tue, 12 Jun 2018 10:34:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, bigeasy@linutronix.de, oleg@redhat.com,
        paulmck@linux.vnet.ibm.com, pbonzini@redhat.com
Subject: [PATCH 1/3] sched/swait: Remove __prepare_to_swait
References: <20180612083449.100099222@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-swait-0.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no public user of this API, remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/swait.h |    1 -
 kernel/sched/swait.c  |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -161,7 +161,6 @@ extern void swake_up(struct swait_queue_
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
 
-extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
 extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
 
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -69,7 +69,7 @@ void swake_up_all(struct swait_queue_hea
 }
 EXPORT_SYMBOL(swake_up_all);
 
-void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
+static void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	wait->task = current;
 	if (list_empty(&wait->task_list))


