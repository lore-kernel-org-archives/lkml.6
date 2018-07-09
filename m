Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8EFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E7320877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A/7kI5a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E7320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGIQDq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:03:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbeGIQDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rsEKTRqBDPFhgQk3zHw0gYVc8aaSv6RlDdPMeo2YK5Y=; b=A/7kI5a4HWq00a4x5iyyYqnZc
        3Q5jAxigsEPx5vz/FWi/toUZU8+XbtdjThSKxoexHUCocW2e2EbqHVJvlnv41HuiITRNF6Y5JUOYN
        ylNkGd+KmiaHw/3zS9XH5w1bXWn4lHKTIrTXU59uAX0XSLUk1BjC61sD95s0VECNdLHCX9X3xBhtB
        xvkv4qs5UUK3Ttem0W9u24aFEcKftmPb3PnmrABPZb2Dn9lwZGhDQdFuuOR36UHWcdKH6ZEagNrfc
        suCu/rJ6q5+RAdGeRWR8kSbkzhfxeNV+Z4slLDSHgk2Mjj0/JfiRoPedHF6RJllCwq7IMU8xgPIjW
        fQq7iKxTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcYdc-0003Nf-7J; Mon, 09 Jul 2018 16:03:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AB6720289331; Mon,  9 Jul 2018 18:03:42 +0200 (CEST)
Date:   Mon, 9 Jul 2018 18:03:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 11/12] sched: use for_each_if in topology.h
Message-ID: <20180709160342.GA2476@hirez.programming.kicks-ass.net>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch>
 <20180709103656.GH2476@hirez.programming.kicks-ass.net>
 <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
 <20180709151258.GV2476@hirez.programming.kicks-ass.net>
 <20180709155204.GD3008@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709155204.GD3008@phenom.ffwll.local>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:52:04PM +0200, Daniel Vetter wrote:
> for_each_something(foo)
> 	if (foo->bla)
> 		call_bla(foo);
> 	else
> 		call_default(foo);
> 
> Totally contrived, but this complains. Liberally sprinkling {} also shuts
> up the compiler, but it's a bit confusing given that a plain for {;;} is
> totally fine. And it's confusing since at first glance the compiler
> complaining about nested if and ambigous else doesn't make sense since
> clearly there's only 1 if there.

Ah, so the pattern the compiler tries to warn about is:

	if (foo)
		if (bar)
			/* stmts1 */
		else
			/* stmts2 *

Because it might not be immediately obvious with which if the else goes.
Which is fair enough I suppose.

OK, ACK.

