Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DA8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFC42083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SqqaZXAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFC42083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbeGKLAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:00:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34318 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732376AbeGKLAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fZlr3VHMLyGK9cgREmlen4OCHCy1Zl/a8jZmAiVpPrc=; b=SqqaZXARGvToXpVzhXIBM/KHw
        WJqCatu2ICC+4UBNl9dtP6ElCe8pfgyNOX22yP/JBvEdsqlcBxhdAVNdS6/q2q9dGesLzwkFn5G44
        Jb13F0VBVLITGNkxFZLn+jAwwN4nGoF4WxcOSfiK3qP1bUjk8aKr4MnMI6QDD1kmxT+K15pNbNNEb
        A4tMIbLoL69HTpPaA8DYI1+/oDE9B59/7NHWMoSsboUZTFb/hEMPQSONSQu6DCSqdVXdukQRnBdTh
        qmBB8ZzyTTkb3siufNKn4xWUhZRXBJNdZmOdaADscbA3QESMngVKTcRt2EXlK+WgXQWbbCo+sfiEt
        Wr8AICI6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdCmj-00073q-6Z; Wed, 11 Jul 2018 10:55:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11DB420289CB2; Wed, 11 Jul 2018 12:55:46 +0200 (CEST)
Date:   Wed, 11 Jul 2018 12:55:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Paul Burton' <paul.burton@mips.com>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180711105546.GB2476@hirez.programming.kicks-ass.net>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
 <20180710093637.GF2476@hirez.programming.kicks-ass.net>
 <20180710105437.GT2512@hirez.programming.kicks-ass.net>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
 <20180710171040.f3gyyh524xlsqv4j@pburton-laptop>
 <1a072b07261b46d88938f0f709f54d42@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a072b07261b46d88938f0f709f54d42@AcuMS.aculab.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:04:52AM +0000, David Laight wrote:
> I also suspect that 'write starvation' is also common - after all the
> purpose of the store buffer is to do reads in preference to writes in
> order to reduce the cpu stalls waiting for the memory bus (probably
> the cpu to cache interface).
> 
> I think your example is just:
> 	*(volatile int *)xxx = 1;
> 	while (!*(volatile int *)yyy) continue;
> running on two cpu with xxx and yyy swapped?

Yep. And Linux has been relying on that working for (afaict) basically
forever.

> You need a stronger bus cycle in there somewhere.

Since all spin-wait loops _should_ have cpu_relax() that is the natural
place to put it.

