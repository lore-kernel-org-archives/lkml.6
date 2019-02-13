Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F20222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550071014;
	bh=l5ObBdWDqAB3c0pZKpZ2WxSPHgxCi0uk78WVyRCBjeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AWnnYbKedrAjjJFzYTNm+XzwPeIiT1rIgs0gQE7OHqRyy8j3RrXToTPKYE+5c/YCH
	 kJgaO5Io1afF+oiilLolNuHGNmPD9quy094yApBxDjCi7nuZJRhkf4H6bFxAgUSVBB
	 WB2n1Mo/1GiDpKmHpjjoMJ3uvfvIb09ChIh2luF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391493AbfBMPQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:16:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390416AbfBMPQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:16:52 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AEFB222C2;
        Wed, 13 Feb 2019 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550071012;
        bh=l5ObBdWDqAB3c0pZKpZ2WxSPHgxCi0uk78WVyRCBjeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=it8GogPLQMAq+kteS/XeavJ9Q+I9HvLMXvTWLr4JgXeVJg8e3pfc9asWwcjngALXf
         0Tz4/mg75/xG2FdfVszYqCDz2SF71TomjmqIhd2d8ZQS3DW2ysIzk2Zy6VgiSdoG+h
         LSKW6tiCQEBl1GruD+XLlHBTzvhDgl7FaJBFy7Mc=
Date:   Wed, 13 Feb 2019 16:16:49 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 05/32] locking/lockdep: Prepare valid_state() to handle
 plain masks
Message-ID: <20190213151648.GD8524@lenoir>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-6-frederic@kernel.org>
 <CAHk-=whhGQuMuuBkLBKGL3kM+8j3+TC_xt+QKFCs1qNySBv3-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whhGQuMuuBkLBKGL3kM+8j3+TC_xt+QKFCs1qNySBv3-A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:45:52AM -0800, Linus Torvalds wrote:
> On Tue, Feb 12, 2019 at 9:14 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > +
> > +       while (vectors) {
> > +               long fs = __ffs64(vectors) + 1;
> > +
> > +               vectors >>= fs;
> 
> This is wrong.
> 
> If "vectors" only has the high hit set, you end up with "fs" having
> the value "64".
> 
> And then "vectors >>= fs" is undefined and won't actually do anything
> at all on x86.

Oh! ok didn't know that...

> 
> In general, avoid "ffs()", and the stupid pattern of "__ffs(x)+1".
> 
> Bit numbering starts at 0. "ffs()" is wrong. And you never *ever* just
> add one to a bit number in order to shift by one more bit, exactly
> because of overflow issues.
> 
> So it may look inefficient, but the correct thing to do is
> 
>     long bit = __ffs64(vectors);
>     vectors >>= fs;
>     vectors >>= 1;
> 
> because that actually works.

I see, perhaps I should use for_each_set_bit() that should take care about those
details?

Thanks.
