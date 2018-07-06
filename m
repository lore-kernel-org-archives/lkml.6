Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47EBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8839223FE1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mvg5kyk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8839223FE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbeGFJkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:40:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeGFJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FvrJgYCNVm63G4YkPJd5KxHy3P3Q6xrdfoHoovO4fXs=; b=mvg5kyk1pD1gcOkHpvevH/LJa
        YPRSQ+T7WXkdLhAsCcGVB+KjtvrWGgTQ099eFx2emHcA88QkW2s7OTvNXwfkyNqRypYZw+Z+QdLoD
        9D8EYGVl4uz24sh1QZEuoX1qQwP8RJVUyznAYDkt2RjZlwDL8FuOmpjCJG/kSefrHhWxFTUZXtUJG
        VmTcWg4g6cziGahFs2xJ3FuuAaljetRn8BJ9p4ztr6DZn+jO+G2eWqx0iSHsV6W95O0adz7RjHzeq
        g9JlvAlUme1U5a1p9Ap1f2iv1PaT8hFOo0sdDLs1X+AXcjnmGbKbF9ahjKf8jKhW9Nt5Qq9Kl4MQY
        5d5zO1SIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbNDD-00089N-8T; Fri, 06 Jul 2018 09:39:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64B812028932E; Fri,  6 Jul 2018 11:39:32 +0200 (CEST)
Date:   Fri, 6 Jul 2018 11:39:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706093932.GT2476@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180705180503.GH2530@hirez.programming.kicks-ass.net>
 <20180706060740.GB8707@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706060740.GB8707@guoren>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:07:40PM +0800, Guo Ren wrote:

> > Please explain those mb()'s... I'm thinking you meant to use smp_mb().
> Yes, smp_mb(). Current smp_mb()&mb() is the same: sync.is.
> 
> In next version patch, I'll seperate smp_mb() and mb() and use ld/st.barrier
> instead of sync.is. Sync.is is expensive that it flush cpu's pipeline.

I'll second my own call for documentation, because now there's three
memory ordering instructions:

 "SYNC", "SYNC.IS" and "LD/ST.BARRIER"

None of which have yet been explained.
