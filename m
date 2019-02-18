Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2999C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1vAne1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391545AbfBRRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:42:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbfBRRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wazmGoNtSiaxrHnKqBVW7N6HOF49XHvqZD984DPPNjk=; b=J1vAne1oLcSFoZbhoggDRV2XUU
        R6d3rsNZNobuH9mxXdrtYbcaz0zCzNm4H0PBBlfH8K82K2rv9iqIsjnLpsmoZvXW4fxQ6xmnYEylA
        tUMMYdJQ4C+ZWaG5QGBNsi7O+LWb4ldSbJXeLqxiUp74BXSeyKla2+WsOXopnzWQia82pyHrihOEd
        HN1wVcW0L3o6x8sdwQ+0zD1PyRgu4NoRuS2vxuSw5KWzMrQs1eTzFiJGccQ+tq+hOB+emUrmu9Bpq
        zY8ssvbWe0OHpQASMA80uru7Usiyke8mIEHM0dHbbUrxg6jZi8tcvvoSPgeXyuArEMZotPc6CuT32
        H8UJ5eAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu1-0005yi-2k; Mon, 18 Feb 2019 17:40:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1746620298A72; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173513.946214276@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 01/16] stop_machine: Fix stop_cpus_in_progress ordering
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the entire for loop has stop_cpus_in_progress set.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/stop_machine.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -375,6 +375,7 @@ static bool queue_stop_cpus_work(const s
 	 */
 	preempt_disable();
 	stop_cpus_in_progress = true;
+	barrier();
 	for_each_cpu(cpu, cpumask) {
 		work = &per_cpu(cpu_stopper.stop_work, cpu);
 		work->fn = fn;
@@ -383,6 +384,7 @@ static bool queue_stop_cpus_work(const s
 		if (cpu_stop_queue_work(cpu, work))
 			queued = true;
 	}
+	barrier();
 	stop_cpus_in_progress = false;
 	preempt_enable();
 


