Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE30C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FAB20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iTx0Df8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfANKWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:22:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bxkTnJx2ceAX8K5kersQk7t4n/UQEPJI29wphVIz808=; b=iTx0Df8cQ26qLeQXkOAlcgl6R
        S2nzh31CdDuB970VvEDUWiwBW5xA1/4XMZRIYQfWaBXIPctv1Oh8o6eORzQ2NCcZ2aiakvHxPtKov
        QDaWujMi7FJzuy52oerT/t1DRQ3sWQg99IplBuXO9NjqenPNZWhIS8q4lyyHrAly3odk8jk71RfYM
        VNuYVniepN5psaUaTbiQbXavkl44rAV3gREv6vZpgTgTluXk+FJfFBDrfHuj5yAjuy+J9JvqpiwGk
        hj3HI3zuIMkCDWk4AbOLKye8cp/bmldHJz5YUVqVAM7C5JvklIYE6Lft5Djf6BJIaCXfyjqaqYuD0
        JiVLSdVbQ==;
Received: from [89.200.46.118] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gizNy-0000ZP-4j; Mon, 14 Jan 2019 10:22:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E89C981766; Mon, 14 Jan 2019 11:21:37 +0100 (CET)
Date:   Mon, 14 Jan 2019 11:21:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, axboe@kernel.dk, dennis@kernel.org,
        dennisszhou@gmail.com, mingo@redhat.com, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 5/5] psi: introduce psi monitor
Message-ID: <20190114102137.GB14054@worktop.programming.kicks-ass.net>
References: <20190110220718.261134-1-surenb@google.com>
 <20190110220718.261134-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110220718.261134-6-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 02:07:18PM -0800, Suren Baghdasaryan wrote:
> +/*
> + * psi_update_work represents slowpath accounting part while
> + * psi_group_change represents hotpath part.
> + * There are two potential races between these path:
> + * 1. Changes to group->polling when slowpath checks for new stall, then
> + *    hotpath records new stall and then slowpath resets group->polling
> + *    flag. This leads to the exit from the polling mode while monitored
> + *    states are still changing.
> + * 2. Slowpath overwriting an immediate update scheduled from the hotpath
> + *    with a regular update further in the future and missing the
> + *    immediate update.
> + * Both races are handled with a retry cycle in the slowpath:
> + *
> + *    HOTPATH:                         |    SLOWPATH:
> + *                                     |
> + * A) times[cpu] += delta              | E) delta = times[*]
> + * B) start_poll = (delta[poll_mask] &&|    if delta[poll_mask]:
> + *      cmpxchg(g->polling, 0, 1) == 0)| F)   polling_until = now +
> + *                                     |              grace_period
> + *                                     |    if now > polling_until:
> + *    if start_poll:                   |      if g->polling:
> + * C)   mod_delayed_work(1)            | G)     g->polling = polling = 0
> + *    else if !delayed_work_pending(): | H)     goto SLOWPATH
> + * D)   schedule_delayed_work(PSI_FREQ)|    else:
> + *                                     |      if !g->polling:
> + *                                     | I)     g->polling = polling = 1
> + *                                     | J) if delta && first_pass:
> + *                                     |      next_avg = calculate_averages()
> + *                                     |      if polling:
> + *                                     |        next_poll = poll_triggers()
> + *                                     |    if (delta && first_pass) || polling:
> + *                                     | K)   mod_delayed_work(
> + *                                     |          min(next_avg, next_poll))
> + *                                     |      if !polling:
> + *                                     |        first_pass = false
> + *                                     | L)     goto SLOWPATH
> + *
> + * Race #1 is represented by (EABGD) sequence in which case slowpath
> + * deactivates polling mode because it misses new monitored stall and hotpath
> + * doesn't activate it because at (B) g->polling is not yet reset by slowpath
> + * in (G). This race is handled by the (H) retry, which in the race described
> + * above results in the new sequence of (EABGDHEIK) that reactivates polling
> + * mode.
> + *
> + * Race #2 is represented by polling==false && (JABCK) sequence which
> + * overwrites immediate update scheduled at (C) with a later (next_avg) update
> + * scheduled at (K). This race is handled by the (L) retry which results in the
> + * new sequence of polling==false && (JABCKLEIK) that reactivates polling mode
> + * and reschedules next polling update (next_poll).
> + *
> + * Note that retries can't result in an infinite loop because retry #1 happens
> + * only during polling reactivation and retry #2 happens only on the first
> + * pass. Constant reactivations are impossible because polling will stay active
> + * for at least grace_period. Worst case scenario involves two retries (HEJKLE)
> + */

I'm having a fairly hard time with this. There's a distinct lack of
memory ordering, and a suspicious mixing of atomic ops (cmpxchg) and
regular loads and stores (without READ_ONCE/WRITE_ONCE even).

Please clarify.

(also, you look to have a whole bunch of line-breaks that are really not
needed; concattenated the line would not be over 80 chars).
