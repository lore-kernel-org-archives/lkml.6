Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC05ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC9920863
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iCULPbVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC9920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeGPOCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:02:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeGPOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EGT05FnECGwl2Synm7BCCnxAJstO9xLqPg8u8x3pVj0=; b=iCULPbVZdJXPSYPVIoiaVY0PT
        Pn6S5cX37tRCWTy7YNci4Ba0THK4IFQldLNlBYVilijcS6HpjuiSP7+CPsKIRMjiJ1DhSinuIGrSJ
        OZ3FM19jS1ZtwOy3mIU3l2Il/Yg7oMabTJbaU/BLgxU7D/TH6TVCQb6qUxmBrry9fveuENd+6KSwU
        9d0zfPHOujx5Pm4VqDtEEahMVMVGlPNLApLx8q+VHn8bFbSW7GMP3XDfpZ97fZRCy/PqI9+/e6qN8
        rxV5nyvtLnQxfb5ufJvqpWGiA/lwTpLF+NyvBSqac7O8bHq4cyj9lsMGh9jdpOUVpFm7rdwLLmAHv
        r+IKKRz2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff3ee-0006pr-3q; Mon, 16 Jul 2018 13:35:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E2E220277352; Mon, 16 Jul 2018 15:35:06 +0200 (CEST)
Date:   Mon, 16 Jul 2018 15:35:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, baoyou.xie@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/cputime: Ensure accurate utime and stime ratio
 in cputime_adjust()
Message-ID: <20180716133506.GB2494@hirez.programming.kicks-ass.net>
References: <20180709145843.126583-1-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709145843.126583-1-xlpang@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:58:43PM +0800, Xunlei Pang wrote:
> If users access "/proc/pid/stat", the utime and stime ratio in the
> current SAMPLE period are excepted, but currently cputime_adjust()
> always calculates with the ratio of the WHOLE lifetime of the process.
> 
> This results in inaccurate utime and stime in "/proc/pid/stat". For
> example,  a process runs for a while with "50% usr, 0% sys", then
> followed by "100% sys". For later while, the following is excepted:
>   0.0 usr,  100.0 sys
> but we got:
>   10.0 usr,  90.0 sys
> 
> This patch uses the accurate ratio in cputime_adjust() to address the
> issue. A new task_cputime type field is added in prev_cputime to record
> previous task_cputime so that we can get the elapsed times as the accurate
> ratio.

This still does not explain anything...
