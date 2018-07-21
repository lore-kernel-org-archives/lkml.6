Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51250ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034E620854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSI+rYAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034E620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeGUSdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:33:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeGUSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qqHZ1tmYyQlfKnOjtWILjjT/7+YApylQwftxJuYudkE=; b=SSI+rYAVRq7DARRrptasW7xWI
        Zrvt+icLCV+C6g4GiLEikDg1MPazIuQ2OGxVXtrVQ8HXIR4KTqLfyrdjKe/v6udE2IJtw+L3RJOSX
        mh6huqCty5IVNSJF5vyyygil5rtVGudNYoCT7j3WyP9w0hkIjFFZ66nBE23oip+/J03Cm637mScFR
        2rib/gNYMUVZj6RckLU1Dq6fKhDphj2uWj8h0tIbp1AnAaQd/BW697VZXa6I5gLTzkYLyvUIa7jRZ
        isS9X7lH7+Chy1OpkJYLjBwIU/6b+Y3Bk+mg7rJmF9/+fH5K2jS76hZn1cKtE9mFxETeVi2l6gVz2
        OMNkNEDNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgvr8-0004af-1S; Sat, 21 Jul 2018 17:39:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61D7620275F37; Sat, 21 Jul 2018 19:39:44 +0200 (CEST)
Date:   Sat, 21 Jul 2018 19:39:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jbaron@akamai.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-ID: <20180721173944.GV2494@hirez.programming.kicks-ass.net>
References: <20180720172956.2883-1-dave@stgolabs.net>
 <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
 <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
 <20180720134429.1ba61018934b084bb2e17bdb@linux-foundation.org>
 <20180721172120.kbdu4euc2wn4xzgf@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721172120.kbdu4euc2wn4xzgf@linux-r8p5>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 10:21:20AM -0700, Davidlohr Bueso wrote:
> On Fri, 20 Jul 2018, Andrew Morton wrote:
> 
> > We could open-code it locally.  Add a couple of
> > WARN_ON_ONCE(irqs_disabled())?  That might need re-benchmarking with
> > Xen but surely just reading the thing isn't too expensive?
> 
> We could also pass on the responsibility to lockdep and just use
> lockdep_assert_irqs_disabled(). But I guess that would be less effective
> than to just open code it in epoll without lockdep -- note that over 80
> places in the kernel do this.

The lockdep thing is relatively recent. I think someone proposed to go
replace a bunch of the open-coded ones at some point.
