Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9745EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4348A20673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VbneHFr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4348A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbeGIJBr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:01:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeGIJBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x3Okx+kzlcXDnImI6WYyQ0rHnxrrMiafnZefmTC0SYo=; b=VbneHFr5oX8SD2L5p/Chm8o9n
        U23HvjOtB0dl2vbAF0zUMOepbOVMqj/SUkdepDyBpPIfTG7XGsuLpTtiu4iKcDcR5uLRhw2eGQ/ai
        jSeHfPzz+1rnh77snoMi4wne8+U9GkFwbIwbygMwHRcIx6Nbw/c5zNWgUgWyeUED23Vdglol4KfM8
        F1QFqP/SZt/5TmMxzHy75U8//uGlxw7hQgZBGDb++cSBIgIFf0PKQqkxnUT0oDZXyHOlFJdW7Twd/
        q31K7z1LSJoVGnEp023SGVsRVnfVixna+fzkbbMV/1hNIUT8rr0/DA4ldXudxqVr+k3VQ8ErSJznN
        uop+NGmew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcS3D-0005Yq-Br; Mon, 09 Jul 2018 09:01:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBBD52028932D; Mon,  9 Jul 2018 11:01:41 +0200 (CEST)
Date:   Mon, 9 Jul 2018 11:01:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/core: remove get_cpu() from sched_fork()
Message-ID: <20180709090141.GE2476@hirez.programming.kicks-ass.net>
References: <20180706130615.g2ex2kmfu5kcvlq6@linutronix.de>
 <20180706131808.GM2494@hirez.programming.kicks-ass.net>
 <20180706133200.a5n47p6utvil4bvf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706133200.a5n47p6utvil4bvf@linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:32:00PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-06 15:18:08 [+0200], Peter Zijlstra wrote:
> > On Fri, Jul 06, 2018 at 03:06:15PM +0200, Sebastian Andrzej Siewior wrote:
> > > Based on this it is possible to remove get_cpu() and use
> > > smp_processor_id() for the `cpu' variable without breaking anything.
> > 
> > Almost.. I think, see init_task_preempt_count().
> 
>  #define init_task_preempt_count(p) do { \
>          task_thread_info(p)->preempt_count = FORK_PREEMPT_COUNT; \
>  } while (0)
> 
> and task_thread_info() references p only. It looks good, what did I
> miss?

Argh, dammit, I read that with p == current :/

Then yes, looks ok.
