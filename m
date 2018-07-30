Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4785D20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="muhMsC2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4785D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeG3ObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:31:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44034 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbeG3ObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E1RGgLR8ko9nzdt9+1oZFeyhpxAbM3Q1sK959GT1UfQ=; b=muhMsC2QSDkwPvhKlKsjxFSqRh
        aFV53WxHKQpyP8OMyfuq2k6JgmT2B1vvReetqmONKd2gMPLJguzi6p+LCehJGnoHbe8x6QIJm6Gd9
        EluKTLe0BDq0Dzw9hlzvBylcCG0SBgm3GznH3I04JA18OLUaZeEOUuEWASwFGRUH0XkQDIb3b/gui
        CQ4W8Lm0xy20+bBLz/ALjaz2PV7P4rqiFDMJDCtcE5ZalRNMs6vG+QZl1YlOvAqag9qCyh4D8VgBu
        ToNR0EuAjyD/rxRYmcsJZ4yf+dtoA4kfF7HWMipzQP2UEa1ol1y/loNuIR3u59n9hAvw24Nw+LAKp
        bamL6dBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk7ia-0006NP-Nb; Mon, 30 Jul 2018 12:56:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5328A2026873D; Mon, 30 Jul 2018 14:56:06 +0200 (CEST)
Date:   Mon, 30 Jul 2018 14:56:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "weiqi (C)" <weiqi4@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: [Question] load balance move tasks not suitable ?
Message-ID: <20180730125606.GP2476@hirez.programming.kicks-ass.net>
References: <6e782fa5-de1d-93a9-ed11-5b43b65b20c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e782fa5-de1d-93a9-ed11-5b43b65b20c9@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 08:08:55PM +0800, weiqi (C) wrote:
> Hi Peter,
> 
> After  Commits 5d6523ebd(sched: Fix load-balance wreckage)，

That's a _6_ year old patch... and I can barely remember last week.

> The jugement whether imbalance reached changed from twice to one-half.
> 
> from
> 
> (1) if((load * 2)> rem_load_move)
>         goto next;
> 
> to
> 
> (2) if((load / 2)> env-> load_move)
>         goto next;
> 
> I'm confused about this change.
> 
> "load*2" may be more appropriate, because if a task whose load more than
> env->imbalance is moved from high load cpu to low load cpu,
> 
> will make more imbalance.

It basically goes back to what it was before (see 367456c), in that
patch I (inadvertently) replaced (load.weight >> 1) with (load * 2)
instead of (load / 2).

I'm not entirely sure I can explain that logic at this time. Doing
software archeology on it might clarify where it came from.
