Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEFBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9EA20892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUQ+Zkp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9EA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeKKI3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 03:29:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeKKI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 03:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7hb6RRmSa7rpl8+hKYmwiC2Nae64nKHW12p1jnX41sQ=; b=PUQ+Zkp6GKTQZw9oOG3hOHcRl
        QafKq5BUwLSHZxW6kex5AoIqMzAZF+hbFGMgg6pqjLIxVwvFqtFOulUtmTELcsA66gPB0Lo4SMa+h
        jfriyAJMSHyjzrAZOM/Wkfmd1TS0dD9rmXLoh7yLBQ4DRM1mZRyzsq/06wMEkD/T7g5N0XYaD33ke
        TYPwPtgtGnIMRExhOWjCKotPRZdg9PSimZNHJg7pNNv0JB9NTNZEJrETpXGgq9kkQDnpOdiJ1FM5L
        IPnw4zoYdet6lLqe3NxdXIwzNiIMHuntC4HOg6I9hocW6/7nXRnBVFTZFGSd7hO1k/idDaUPTDKZl
        m5YUImJXw==;
Received: from [64.114.255.114] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLbyE-0001ji-6g; Sat, 10 Nov 2018 22:43:14 +0000
Received: by worktop (Postfix, from userid 1000)
        id 8A2216E08CB; Sat, 10 Nov 2018 15:20:23 +0100 (CET)
Date:   Sat, 10 Nov 2018 15:20:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 07/12] locking/lockdep: Add support for nested
 terminal locks
Message-ID: <20181110142023.GG3339@worktop.programming.kicks-ass.net>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <1541709268-3766-8-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541709268-3766-8-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:34:23PM -0500, Waiman Long wrote:
> There are use cases where we want to allow 2-level nesting of one
> terminal lock underneath another one. So the terminal lock type is now
> extended to support a new nested terminal lock where it can allow the
> acquisition of another regular terminal lock underneath it.

You're stretching things here... If you're allowing things under it, it
is no longer a terminal lock.

Why would you want to do such a thing?
