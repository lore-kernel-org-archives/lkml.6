Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86714C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4776E2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yr48kkru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfAGNwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:52:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37880 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfAGNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cuikh8AR77ogAraE1WdLIkp6L7qIncpOsu0K38KKF84=; b=yr48kkru1MTWM40RKlC+s/78Y
        bUdIMguAtN2t0zplnmU2tHyh4X+hmHKiCpaywJJxeMMtrZcCj+sti/wXO+g7jDjy2jXupbvKGDZyE
        UjbYeMjT+1Drjg4MAYHFkP8kLxEhIFhsnTG5RfxIYATLRBaaZtlM2ZpZTmEKQPu8KUthmDb8dDVIy
        Xuv6F6EVCHVG/hFRAEG84HallGUbZEVYHOC2zGQHijKOnF7tvveHK/Tp4pfm+Nil7KFKKR6P9Nqg2
        JDN+iXk4dl+inK9EM7aiI8nrMxl0JIWNgLL053kUk5YIjXy+VGu5U0UhnYMtIMtgnBAzW0duXvs1e
        FH3M0R5/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggVKD-0005RN-9z; Mon, 07 Jan 2019 13:52:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4ADA236FC599; Mon,  7 Jan 2019 14:52:15 +0100 (CET)
Date:   Mon, 7 Jan 2019 14:52:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, gkohli@codeaurora.org
Subject: Re: kernel BUG at kernel/sched/core.c:3490!
Message-ID: <20190107135215.GG14122@hirez.programming.kicks-ass.net>
References: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 12:44:35AM -0500, Qian Cai wrote:
> Running some mmap() workloads to put the system on low memory situation with
> swapping and OOM, and then it trigger this BUG(),
> 
> void __noreturn do_task_dead(void)
> {
>         /* Causes final put_task_struct in finish_task_switch(): */
>         set_special_state(TASK_DEAD);
> 
>         /* Tell freezer to ignore us: */
>         current->flags |= PF_NOFREEZE;
> 
>         __schedule(false);
>         BUG();
> 
>         /* Avoid "noreturn function does return" - but don't continue if BUG()
> is a NOP: */
>         for (;;)
>                 cpu_relax();
> }

This would mean that we somehow loose the TASK_DEAD state before hitting
schedule(), but that is something that should be avoided by
set_special_state(), which is supposed to serialize against concurrent
wake-ups.

Also see commit: b5bf9a90bbeb ("sched/core: Introduce set_special_state()")

How readily does this reproduce?
