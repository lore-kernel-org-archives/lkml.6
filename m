Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6666620857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iFUStUUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6666620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeIEPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:55:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIEPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=60FFTjpjM9BOC3dcIh/N45W5EwKP1KyUjlzkmRei4So=; b=iFUStUUTZ0hB86EJzf29zbOLdE
        lWvC9A/BGyHOR2lYYy3fCQCJgN7unXR/QSIQaYVo6rVkBt+4yAk7OJ5st8YdvpHvypesiv5rIWKLl
        9RuFkxeH6dGiFEk81GlWRU+3x9CnmqXb39Tu2LuHb15N9UZn475vHfWt1vtAPF6rFMvUsyMVkCVjR
        66EwKqAm3BzfCvkbXXST9VzaEpDKYAiXTy7ELWWESTyYG2njLmEw+Fxe/RTUHqgBOGLh4ZZKbd8xg
        Agwr1eccF6t9o1g1AyJOYIhveYavHGbzfI+DiZJA7a1o+3FbygcuyI0aUcihMQUOQC5LGCbjywhuM
        DI8zZrfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxVw7-0004KO-CA; Wed, 05 Sep 2018 11:25:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 014A8202AFE0E; Wed,  5 Sep 2018 13:25:24 +0200 (CEST)
Date:   Wed, 5 Sep 2018 13:25:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/debug: use symbolic names for task state constants
Message-ID: <20180905112524.GU24082@hirez.programming.kicks-ass.net>
References: <20180905093636.24068-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180905093636.24068-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:36:36AM +0200, Uwe Kleine-König wrote:
> include/trace/events/sched.h includes <linux/sched.h> (via
> <linux/sched/numa_balancing.h>) and so knows about the TASK_* constants
> used to interpret .prev_state. So instead of duplicating the magic
> numbers make use of the defined macros to ease understanding the
> mapping from state bits to letters which isn't completely intuitive for
> an outsider.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  include/trace/events/sched.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 0be866c91f62..f07b270d4fc4 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -159,9 +159,14 @@ TRACE_EVENT(sched_switch,
>  
>  		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
>  		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
> -				{ 0x01, "S" }, { 0x02, "D" }, { 0x04, "T" },
> -				{ 0x08, "t" }, { 0x10, "X" }, { 0x20, "Z" },
> -				{ 0x40, "P" }, { 0x80, "I" }) :
> +				{ TASK_INTERRUPTIBLE, "S" },
> +				{ TASK_UNINTERRUPTIBLE, "D" },
> +				{ __TASK_STOPPED, "T" },
> +				{ __TASK_TRACED, "t" },
> +				{ EXIT_DEAD, "X" },
> +				{ EXIT_ZOMBIE, "Z" },
> +				{ TASK_PARKED, "P" },
> +				{ TASK_DEAD, "I" }) :
>  		  "R",

Steve, does this work?
