Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A8BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83AA20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="26JkJPe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83AA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeIFRcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:32:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbeIFRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vNBcT9Tk9g5QhVj6Cf6Vh/U2nJjh2M2XFL0k4EV5HTo=; b=26JkJPe/gkG4gGlqQe2khzEbP
        /p3P0UaZcOECiYnKbO1ZZl2SbjK5YFJjbnOVxS0b0TNGLxwDpCZtiFn4RW1+afYLw9EXecOefmeKI
        A5D9Sct/dRCCQMQTvHoEUALzwHLyOBz307A8DxzKAlUOglSnxY0kgVK+Lbc3zZZiqhxoEWdoNSTmh
        Ti4r1SeQKn6ya/GurMBtquujPHbBnLObOmd2wz+k3/sI9wgkBCkQXdkKmfJmVV3gKacCaNixCKNr5
        62AdaGMgvXu2eBpYkfNk+4nW01z6/h+ZWZqsCxBcZ+yVvtkD6fYmyXSWETQ9p2Ejx2ghEHJjx1Kco
        t9jRx+Cpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxtpu-0002QS-S3; Thu, 06 Sep 2018 12:56:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A1F220210301; Thu,  6 Sep 2018 14:56:37 +0200 (CEST)
Date:   Thu, 6 Sep 2018 14:56:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: stop_machine() soft lockup
Message-ID: <20180906125637.GJ24082@hirez.programming.kicks-ass.net>
References: <20180904190322.GA21835@centauri.lan>
 <20180905084241.GS24082@hirez.programming.kicks-ass.net>
 <20180905114749.GA5345@centauri.lan>
 <20180905131410.GY24082@hirez.programming.kicks-ass.net>
 <20180905134553.GB5345@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905134553.GB5345@centauri.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 03:45:53PM +0200, Niklas Cassel wrote:

> However, I just managed to get this lockdep splat when booting without
> earlycon and ftrace=irqsoff
> I'm not sure that it is related, but I'm planning on looking into it anyway:

That looks like your generic printk is crap splat.

I tend to use this patch-set:

  https://lkml.kernel.org/r/20170928121823.430053219@infradead.org

and have (on x86):

  earlyprintk=serial,ttyS0,115200 force_early_printk debug ignore_loglevel

That results in a printk that does pure UART bit-banging and works from
any context without issue.
