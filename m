Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF98C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3C32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WHl4gD55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3C32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeIGRGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:06:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55692 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeIGRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3pmzCNIJYHlas3PvLTKDHQ/B7mXZHynNkyFh50XKbKQ=; b=WHl4gD55xzcf6nsbA24/6AkS2
        GNR1Udfp2NrtoO4ww2+xLKprPheQBjH11M4FKcmy/ws5Bjk0nFppSrY7tmP3Gtm/mnK3bwc16nNgc
        SzP2SUbceumTD3yjfUffCY60AX55gplqSs1eZj/lf8+NQC3ZmxqrUNgq5vg4jmtHaz/yE1Q2RUcaq
        GN4H/kqWnfwEBaiPboryX7utLxDgs5q2uGxybqehgvaFqvUSnZnuP9bZgS7/Tjh67zvYQUVVzJsIA
        rgfMhTLnZ4YL5SK6zj/w2+NaKrWfDbhIzMpAFYaYdlYwoY6r+QUu0AaGTOs05U7wAJxIrTx7IlnpW
        JBpFTxK0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyFpo-0001my-Bx; Fri, 07 Sep 2018 12:26:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A649E20210312; Fri,  7 Sep 2018 14:25:57 +0200 (CEST)
Date:   Fri, 7 Sep 2018 14:25:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, dhaval.giani@oracle.com,
        steven.sistare@oracle.com
Subject: Re: [RFC PATCH 2/2] pipe: use pipe busy wait
Message-ID: <20180907122557.GY24106@hirez.programming.kicks-ass.net>
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
 <20180830202458.32579-3-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830202458.32579-3-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:24:58PM -0700, subhra mazumdar wrote:
> +void pipe_busy_wait(struct pipe_inode_info *pipe)
> +{
> +	unsigned long wait_flag = pipe->pipe_wait_flag;
> +	unsigned long start_time = pipe_busy_loop_current_time();
> +
> +	pipe_unlock(pipe);
> +	preempt_disable();
> +	for (;;) {
> +		if (pipe->pipe_wait_flag > wait_flag) {
> +			preempt_enable();
> +			pipe_lock(pipe);
> +			return;
> +		}
> +		if (pipe_busy_loop_timeout(pipe, start_time))
> +			break;
> +		cpu_relax();
> +	}
> +	preempt_enable();
> +	pipe_lock(pipe);
> +	if (pipe->pipe_wait_flag > wait_flag)
> +		return;
> +	pipe_wait(pipe);
> +}
> +
> +void wake_up_busy_poll(struct pipe_inode_info *pipe)
> +{
> +	pipe->pipe_wait_flag++;
> +}

Why not just busy wait on current->state ? A little something like:

diff --git a/fs/pipe.c b/fs/pipe.c
index bdc5d3c0977d..8d9f1c95ff99 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -106,6 +106,7 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 void pipe_wait(struct pipe_inode_info *pipe)
 {
 	DEFINE_WAIT(wait);
+	u64 start;
 
 	/*
 	 * Pipes are system-local resources, so sleeping on them
@@ -113,7 +114,15 @@ void pipe_wait(struct pipe_inode_info *pipe)
 	 */
 	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
 	pipe_unlock(pipe);
-	schedule();
+
+	preempt_disable();
+	start = local_clock();
+	while (!need_resched() && current->state != TASK_RUNNING &&
+			(local_clock() - start) < pipe->poll_usec)
+		cpu_relax();
+	schedule_preempt_disabled();
+	preempt_enable();
+
 	finish_wait(&pipe->wait, &wait);
 	pipe_lock(pipe);
 }
