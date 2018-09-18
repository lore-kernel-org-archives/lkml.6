Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4165ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5122146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lt26I3wJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5122146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeIROCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:02:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48116 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbeIROCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HG5pVcepxQN629X8V7hoyBkBwLrtFAJyhvA4se7CUsg=; b=Lt26I3wJbL4vC5nE+nKKj2p3d
        aLx892kRv1tq4P7x9qgJnOdWuGfxbCFIDp6CpIgiW6MYKfVUuvdNxanwaf4GNzmNAWwhSEGTU6nFW
        dJyQw2iblsI3FoCBpxs8GNyP8kX65OvKxJpYVWDqmF4e3UfAUxvqzS9/mQKGDKDKnry0FTJg6a/Mj
        RZplKFHpYZmsLx7rMiN/AEuB1GPaNMR/GYEWKwj0vp+oMxHlSbGcCGbZdYWJGBVd0Gd9o5BQ4Nuu+
        3KmWEukQNr01e4z7N9GN693NH+gOm3PXE8A+0IRS9u6/CKwcvCSWDfcEWzxxZ9TqkJipAU2pzKjsS
        YNUu0fWZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2BPO-0000vj-Kk; Tue, 18 Sep 2018 08:30:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B48D9202C1A35; Tue, 18 Sep 2018 10:30:55 +0200 (CEST)
Date:   Tue, 18 Sep 2018 10:30:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Message-ID: <20180918083055.GJ24106@hirez.programming.kicks-ass.net>
References: <20180914125006.349747096@linutronix.de>
 <20180914125118.909646643@linutronix.de>
 <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
 <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 09:52:26AM +0200, Thomas Gleixner wrote:
> On Mon, 17 Sep 2018, John Stultz wrote:
> > On Mon, Sep 17, 2018 at 12:25 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > > Also, I'm not entirely convinced that this "last" thing is needed at
> > > all.  John, what's the scenario under which we need it?
> > 
> > So my memory is probably a bit foggy, but I recall that as we
> > accelerated gettimeofday, we found that even on systems that claimed
> > to have synced TSCs, they were actually just slightly out of sync.
> > Enough that right after cycles_last had been updated, a read on
> > another cpu could come in just behind cycles_last, resulting in a
> > negative interval causing lots of havoc.
> > 
> > So the sanity check is needed to avoid that case.
> 
> Your memory serves you right. That's indeed observable on CPUs which
> lack TSC_ADJUST.

But, if the gtod code can observe this, then why doesn't the code that
checks the sync?
