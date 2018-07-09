Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B725C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30162084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V62NjIcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30162084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754424AbeGIIbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:31:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46796 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeGIIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=43/LVUTIoqKqh94DZs5o9ApF7EbXWFlzTgDNEVRzL+M=; b=V62NjIcSS0LoLU5uK+oMSIYqB
        B4+mKvb+goAONBpEhqb8u8XBRt9UCAN01q9Q20aQN3OuYR0WarJ9RusOm49Zij7Kfxx6DYrzX+9wW
        jHqoV6OCNpGuPTxOVq0kAA2U4xOeVyyhv/8Is/fRZqB/vsOQyzFItGdM1MM+rI2/bBDW2jFwrLWlS
        ehF+XrRb/2F6Z3iiB4RwJdT1b5c3AvxVxfOiwMYD6ju/EVVk4g/+MRxDPp+kYkkFAqYP1oR05inaH
        hBclYI4ropkcezcOQv6mSE5GwQ5LAEo7qFvrNXFBER3CzrPVrq7Quwtg1d2XVukT5SwNjZ0nGk/hm
        3ru6b8vyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcRZq-0004hf-2d; Mon, 09 Jul 2018 08:31:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BEB52028932D; Mon,  9 Jul 2018 10:31:18 +0200 (CEST)
Date:   Mon, 9 Jul 2018 10:31:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] locking/lockdep: Report comm/pid/timestamp information
Message-ID: <20180709083118.GA2476@hirez.programming.kicks-ass.net>
References: <20180709005725.18184-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709005725.18184-1-erosca@de.adit-jv.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:57:25AM +0200, Eugeniu Rosca wrote:
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 6fc77d4dbdcd..eeed7ea2e198 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -186,6 +186,10 @@ struct lock_list {
>  	struct list_head		entry;
>  	struct lock_class		*class;
>  	struct stack_trace		trace;
> +	unsigned long long		ts;
> +	char				comm[16];
> +	pid_t				pid;
> +	int				cpu;
>  	int				distance;
>  
>  	/*

Yeah, not going to happen. You grow that structure from 64 bytes to 96
bytes and with that grow the static footprint of the kernel by 512k (in
the very best case) possibly again breaking things like sparc (which
have a strict limit on the kernel image size).

And all that for data that I've never needed and never even considered
useful when looking at lockdep output.
