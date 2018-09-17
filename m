Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7A1ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878712088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZZXOqQlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878712088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbeIRENL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:13:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeIRENL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kj+du2oOrmctzDfUxB2Dz8cDyOdqlIK2iSNcj1sQfaY=; b=ZZXOqQlByk9Kd66+aigX4S/7E
        5FNOXcfPUPaa4YlR6zn+WOSt/pz6M2kiNEdfkHUBzsgztAGSC8nwfDhleOg73aPMQffDrebb66j/U
        PwRD0OCjT+zFvukxfLqLmT/OQoLrYpyB1ZMfFSdM1ojvt8D/qp480CNm9znY1LNU405Skn8qlMSfQ
        +v4wiTKGpBjopGkLCTPHZTa5wksUYOx5BLc5Y5G0JAJY1h4Vm9as/zhs51GMFgLptT5JcqRzRck3i
        rA3yqAuMUMf6JXIf2lnmY7dbHMYtOgVtnRFN4aaG2lPHVEd9Xbf2WH0SAtpSh69HkXJ4OU1kFU7gy
        3tbCC86kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g22F9-0005go-RY; Mon, 17 Sep 2018 22:43:48 +0000
Received: by worktop (Postfix, from userid 1000)
        id 8E2A86E0A92; Tue, 18 Sep 2018 00:43:44 +0200 (CEST)
Date:   Tue, 18 Sep 2018 00:43:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, dhaval.giani@oracle.com,
        steven.sistare@oracle.com
Subject: Re: [RFC PATCH 2/2] pipe: use pipe busy wait
Message-ID: <20180917224344.GB3284@worktop.programming.kicks-ass.net>
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
 <20180830202458.32579-3-subhra.mazumdar@oracle.com>
 <20180907122557.GY24106@hirez.programming.kicks-ass.net>
 <304ffc06-1ab9-19d5-d5ca-e63e2abe2900@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <304ffc06-1ab9-19d5-d5ca-e63e2abe2900@oracle.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:05:40PM -0700, Subhra Mazumdar wrote:
> On 09/07/2018 05:25 AM, Peter Zijlstra wrote:

> >Why not just busy wait on current->state ? A little something like:
> >
> >diff --git a/fs/pipe.c b/fs/pipe.c
> >index bdc5d3c0977d..8d9f1c95ff99 100644
> >--- a/fs/pipe.c
> >+++ b/fs/pipe.c
> >@@ -106,6 +106,7 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
> >  void pipe_wait(struct pipe_inode_info *pipe)
> >  {
> >  	DEFINE_WAIT(wait);
> >+	u64 start;
> >  	/*
> >  	 * Pipes are system-local resources, so sleeping on them
> >@@ -113,7 +114,15 @@ void pipe_wait(struct pipe_inode_info *pipe)
> >  	 */
> >  	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
> >  	pipe_unlock(pipe);
> >-	schedule();
> >+
> >+	preempt_disable();
> >+	start = local_clock();
> >+	while (!need_resched() && current->state != TASK_RUNNING &&
> >+			(local_clock() - start) < pipe->poll_usec)
> >+		cpu_relax();
> >+	schedule_preempt_disabled();
> >+	preempt_enable();
> >+
> >  	finish_wait(&pipe->wait, &wait);
> >  	pipe_lock(pipe);
> >  }

> This will make the current thread always spin and block as it itself does
> the state change to TASK_RUNNING in finish_wait.

Nah, the actual wakeup will also do that state change. The one in
finish_wait() is for the case where the wait condition became true
without wakeup, such that we don't 'leak' the INTERRUPTIBLE state.
