Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2431620878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3LI+1T4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2431620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeGIOLR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:11:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54564 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeGIOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bb5puVf1ePcEk/+oaN+IrMvR53eFoeYwM5IRGcOnl3A=; b=3LI+1T4ajocQl7pkk8F2Sbz3Q
        wBhKHDNGORFob9RkxzPP3KMiZBZ9Wqu7z3kEA7w+CyhQgCPCCb58wzEThYSqHmBckzEL/v0xsS5pe
        7J69nNo9Rys5fafmTCQ7RVytuxnAkoImH5EjVYGsjR4CzvxvdhlOpV0rvy4lfS8erW6E1c1AYjhdJ
        9CyHC/gHuoPyuKMu8If/QhSYuyVmFRG1P/IRtyAX3fctrf2qu34Qb6kynT9P0zuAjtmQTJF/GKjmW
        2hDzQH+39b022e2xVsKwki0G+HkaQ2hu3LbdorEn0qx41WEWkLYFmlQ+4oNkKbEg9CUTiCt0gZpg6
        VYdSLsegA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcWsU-0001Jb-5X; Mon, 09 Jul 2018 14:10:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D71902029764D; Mon,  9 Jul 2018 16:10:56 +0200 (CEST)
Date:   Mon, 9 Jul 2018 16:10:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709141056.GR2512@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709140717.GR2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:07:17PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 04:45:50PM +0300, Alexey Brodkin wrote:
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -24,8 +24,12 @@ struct devres_node {
> >  
> >  struct devres {
> >  	struct devres_node		node;
> > -	/* -- 3 pointers */
> > -	unsigned long long		data[];	/* guarantee ull alignment */
> > +	/*
> > +	 * data[] must be 64 bit aligned even on 32 bit architectures
> > +	 * because it might be accessed by instructions that require
> > +	 * aligned memory arguments such as atomic64_t.
> > +	 */
> > +	u8 __aligned(8)			data[];
> >  };
> 
> Seeing that this ends up in a semi generic allocation thing, I don't
> feel this should be different from ARCH_KMALLOC_MINALIGN.

In fact, since alloc_dr() uses kmalloc() to allocate the entire thing,
it is impossible to guarantee a larger alignment than kmalloc does.
