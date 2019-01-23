Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF9C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B88921726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L46xQ4ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfAWIOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:14:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfAWIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LM0TRPhOtdJu7kyeGTHBk/hYwa0ZnnKXtESkz7gLYdw=; b=L46xQ4ub7A/o2hN/RjUcK/yXe
        1PQLQ2356gqjcPqTkmkiJPDQlRgINkGfpKTD2z2p8CqKnKY8wwMAV3suKPAPohhxBmEm/bUWmrSoP
        SZDd7M4vlnQHVcWuJgtFJl3PntqT7qq3VS9oXKKVEJbKWdY/CiZCRfva2n5sicRIN7rIBfVhZDYyx
        ifdzabzbmBm+ZlsOzd6VxPUmXyZfkyhnfSrs5vLJGjYSgJpxde8WqG6sE0lVSJG2PbRBkQsuTNXC/
        3Q1nlxkSg6d6v8YKmEIZk8BRHPwuVIzhH5bcdt9heAMpU4Qw9c0jth9EQHKwu68M7vrbJiv2yueA1
        u3WSG12FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmDgJ-0002nH-Qg; Wed, 23 Jan 2019 08:14:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D0872042CFC4; Wed, 23 Jan 2019 09:14:41 +0100 (CET)
Date:   Wed, 23 Jan 2019 09:14:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] qspinlock: no need to check return value of
 debugfs_create functions
Message-ID: <20190123081441.GE17749@hirez.programming.kicks-ass.net>
References: <20190122152151.16139-44-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-44-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:21:43PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

So I've seen you do a fair number of these patches; but I don't
fully understand.

The existing code rolls back the created files such that we either have
all files or none at all. Why is this wrong?

It for some daft reason one of the debugfs calls fails (imagine this was
a module and we did modprobe while under memory pressure), why should we
present a partial interface to the 'user' ?

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/locking/qspinlock_stat.h | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
> index 42d3d8dc8f49..766fa0c8c115 100644
> --- a/kernel/locking/qspinlock_stat.h
> +++ b/kernel/locking/qspinlock_stat.h
> @@ -213,9 +213,6 @@ static int __init init_qspinlock_stat(void)
>  	struct dentry *d_qstat = debugfs_create_dir("qlockstat", NULL);
>  	int i;
>  
> -	if (!d_qstat)
> -		goto out;
> -
>  	/*
>  	 * Create the debugfs files
>  	 *
> @@ -224,20 +221,13 @@ static int __init init_qspinlock_stat(void)
>  	 * performance.
>  	 */
>  	for (i = 0; i < qstat_num; i++)
> -		if (!debugfs_create_file(qstat_names[i], 0400, d_qstat,
> -					 (void *)(long)i, &fops_qstat))
> -			goto fail_undo;
> +		debugfs_create_file(qstat_names[i], 0400, d_qstat,
> +				    (void *)(long)i, &fops_qstat);
>  
> -	if (!debugfs_create_file(qstat_names[qstat_reset_cnts], 0200, d_qstat,
> -				 (void *)(long)qstat_reset_cnts, &fops_qstat))
> -		goto fail_undo;
> +	debugfs_create_file(qstat_names[qstat_reset_cnts], 0200, d_qstat,
> +			    (void *)(long)qstat_reset_cnts, &fops_qstat);
>  
>  	return 0;
> -fail_undo:
> -	debugfs_remove_recursive(d_qstat);
> -out:
> -	pr_warn("Could not create 'qlockstat' debugfs entries\n");
> -	return -ENOMEM;
>  }
>  fs_initcall(init_qspinlock_stat);
>  
> -- 
> 2.20.1
> 
