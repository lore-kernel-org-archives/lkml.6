Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4814ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660A22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="EUEni3ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660A22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeGRT5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:57:16 -0400
Received: from imap.thunk.org ([74.207.234.97]:58548 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbeGRT5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jJsvc9jUNcZiUABElrprvOKErn6lqVdyU6zjXqkO6Y4=; b=EUEni3ig01CdiI/Bldl9x7Ylxy
        iBIloPX+k5gcVVroprMEZQwBt5XlqrMHwDiK3LWyeWD+camC4FvjGVRieHiVvnDaleekfjRNkPon9
        YRRwXHRHbL7I00pM2vajrudf37U++3pIiYxkbl4vyAmQZt1EjgnYHk9JjvSRBHej5zMI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ffrxT-00062F-Oi; Wed, 18 Jul 2018 19:17:55 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 15DE97A6403; Wed, 18 Jul 2018 15:17:53 -0400 (EDT)
Date:   Wed, 18 Jul 2018 15:17:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
Message-ID: <20180718191752.GG30706@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Yann Droneaud <ydroneaud@opteya.com>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
References: <20180718014344.1309-1-tytso@mit.edu>
 <37046662f2b38f98854abfa1b5868a27c3fa0888.camel@opteya.com>
 <20180718142625.GA5942@thunk.org>
 <822ef031e3589a5cda5972eeeb457bbad69ecde6.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822ef031e3589a5cda5972eeeb457bbad69ecde6.camel@opteya.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 05:29:58PM +0200, Yann Droneaud wrote:
> Sure, but, AFAICT, RDRAND is already in use through arch_get_random_*()
> functions when CONFIG_ARCH_RANDOM is enabled.
> 
> From an outside PoV, there's a conflict: why one would want its kernel
> to use CPU hwrng if one has purposely disabled CONFIG_RANDOM_TRUST_CPU
> ?

Yes, but we use it to mix in RDRAND into the entropy pool.  So we're
not depending solely on RDRAND's output.  The trust model that we're
using is this.  The presumption is that (at least for US-based CPU
manfacturers) the amount of effort needed to add a blatent backdoor
to, say, the instruction scheduler and register management file is
such that it couldn't be done by a single engineer, or even a very
small set of engineers.  Enough people would need to know about it, or
would be able to figure out something untowards was happening, or it
would be obvious through various regression tests, that it would be
obvious if there was a generic back door in the CPU itself.  This is a
good thing, because ultimately we *have* to trust the general purpose
CPU.  If the CPU is actively conspiring against you, there really is
no hope.

However, the RDRAND unit is a small, self-contained thing, which is
*documented* to use an AES whitener (e.g., it does an AES encryption
as its last step).  So presumably, a change to make the RDRAND unit
effectively be:

	AES_ENCRYPT(NSA_KEY, COUNTER++)

Is much easier to hide or introduce.

So that's why people are comfortable using RDRAND mixed into the
output of the entropy pools.  Yes, in theory, if the CPU has
backdoored the XOR instruction if it sees an RDRAND just before it,
you're sunk.  But in if you don't trust the CPU to that level, you
should simply not be using that CPU at all.  Period.

So personally, I probably would never chose to use a CPU that was
manufactured by a company owned or controlled by a PLA general or one
of Putin's Oligarchs.  But I'm not going to tell other people what to
do; they should make their own decisions.

Now, there is one exception to this, and that is the CPU has RDRAND
support, it will use that exclusively for get_random_{u32, u64, int, long}.
But kernel code shouldn't be using this for cryptographic purposes.  If you
need to generate a random key, you should be using get_random_bytes().
get_random_u32, et. al, are designed for things like stack canaries or
TCP sequence numbers.

Regards,

					- Ted
