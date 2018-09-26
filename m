Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E71C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABBA21531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVdga3UB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABBA21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeIZXvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeIZXvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:51:23 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51112152F;
        Wed, 26 Sep 2018 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537983442;
        bh=xuJZE6SN+NcWwElZWRzB3oyL2/JpmUCDXZQaipOqLls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVdga3UBZCklH/UCt1IIxGHpZXa/NNhrkl5Fn4gsUOnMVFLrS5cWEOMBgXQVUIXiF
         w+aXfBWX/dbIOZZS6lMxbdH1D/SSu1pFlLaWvfPVxxuovB311Pn+0BCfgjVKthrnFR
         l4fnHCb8dy4GY0x2HEOzv6fiLbuvTiOMQyOkX7Nk=
Date:   Wed, 26 Sep 2018 10:37:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64
 implementations
Message-ID: <20180926173720.GA248906@gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:41:12PM +0200, Jason A. Donenfeld wrote:
> On Wed, Sep 26, 2018 at 4:02 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > I don't think it makes sense to keep
> > it simple now and add the complexity later (and the same concern
> > applies to async support btw).
> 
> Ugh, no. I don't want to add needless complexity, period. Zinc is
> synchronous, not asynchronous. It provides software implementations.
> That's what it does. While many of your reviews have been useful, many
> of your comments indicate some desire to change and mold the purpose
> and focus of Zinc away from Zinc's intents. Stop that. It's not going
> to become a bloated mess of "things Ard wanted and quipped about on
> LKML." Things like these only serve to filibuster the patchset
> indefinitely. But maybe that's what you'd like all along? Hard to
> tell, honestly. So, no, sorry, Zinc isn't gaining an async interface
> right now.

Can you please stop accusing Ard of "filibustering" your patchset?  Spending too
long in non-preemptible code is a real problem even on non-RT systems.
syzkaller has been reporting bugs where the kernel spins too long without any
preemption points, both in crypto-related code and elsewhere in the kernel.  So
we've had to add explicit preemption points to address those, as otherwise users
can lock up all CPUs for tens of seconds.  The issue being discussed here is
basically the same except here preemption is being explicitly disabled via
kernel_neon_begin(), so it becomes a problem even on non-CONFIG_PREEMPT kernels.

It's much better to address this problem (which is a regression from the current
skcipher API which only maps a page at a time) up front rather than have to rush
to patch it after the fact once the syzbot reports start coming in.

- Eric
