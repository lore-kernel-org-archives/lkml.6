Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B1EC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4EA2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQXZq2TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4EA2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeJKXS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:18:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52700 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeJKXS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MGsDKF+/ulhMEcc0MF1/+3/OYew2cgsVbA1+fXKq7Uk=; b=sQXZq2TLM15Mj3+nfOOuvq7C4
        f7Bo3OF2/0ZvvneAd3sVVLv9OWP7qrGsbidZS0ovYqhwtlzBnn+jVD9MeAsuFfW4ymstjLwxgA4xF
        OglLkKHIboG3pLJx80ROdwFAicJAAMcOU1tqSjr5O0LWB0aAhjJsGajIKqPl6dRUj7cUP4CwlSJU/
        VGHjRp1ffVJsHIM3MryNNb4yfWHNG32Z5T4rbnwWy2yFExl63CqwAtFZw5h6liGjbJxei+8F/rV3B
        8dndlOsUff2+tVMu50ALWXylYBth8RvdsIXe9Thy6A5VNYhgw0DCnZi09QxKaWuY7SZ55b3P79jN6
        EkvwxBJOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAdER-00052K-OR; Thu, 11 Oct 2018 15:50:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F6C420298568; Thu, 11 Oct 2018 17:50:34 +0200 (CEST)
Date:   Thu, 11 Oct 2018 17:50:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86/percpu: Fix this_cpu_read()
Message-ID: <20181011155034.GC9867@hirez.programming.kicks-ass.net>
References: <20181011103825.023036082@infradead.org>
 <20181011104019.748208519@infradead.org>
 <CANn89iKxTMRr_XSC4xHD-etoU9kF6nN7yzQP4AEfYeNKjQLTPQ@mail.gmail.com>
 <CANn89iJsD=rKTjiGF_EEoSh9WmiifOjxu2mcqSv8Sx-NT7zixQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJsD=rKTjiGF_EEoSh9WmiifOjxu2mcqSv8Sx-NT7zixQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:24:49AM -0700, Eric Dumazet wrote:
> On Thu, Oct 11, 2018 at 8:02 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Thu, Oct 11, 2018 at 3:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Eric reported that a sequence count loop using this_cpu_read() got
> > > optimized out. This is wrong, this_cpu_read() must imply READ_ONCE()
> > > because the interface is IRQ-safe, therefore an interrupt can have
> > > changed the per-cpu value.
> > >
> > > Fixes: 59eaef78bfea ("x86/tsc: Remodel cyc2ns to use seqcount_latch()")
> > > Reported-by: Eric Dumazet <edumazet@google.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> >
> > Acked-by: Eric Dumazet <edumazet@google.com>
> 
> Actually the Fixes: tag seems funky.
> 
> Bug was not added by 59eaef78bfea
> 
> Your patch probably needs to be backported to older versions of linux,
> just to be safe, since
> we might have other places where authors relied on this_cpu_read()
> semantic (different than this_cpu_read_stable())

Right; it goes back a long long way... is:

  7c3576d261ce ("[PATCH] i386: Convert PDA into the percpu section")

early enough? That introduces percpu_from_op(), but arguably the
pda_from_op() it replaces was buggy already.
