Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2721C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E63E2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xfvI+0xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E63E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI1VZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:25:31 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48708 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeI1VZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8p7gmvve/5J6P4WOrn5cgWCYYH8eMqcrnbPKjwPq4+w=;
        b=xfvI+0xesghkWJrNfgm8VdimdUQcku+0LCuXBaxzyhC3RJtA+CDko8h139P2OZDbycXAbsy0ZkLvAvJLzwpenMomoFzYYTgKojsyq8Gz07TuaeweRvWwpVmc7a2fbBzsvBBwMiIGIghaMwPolOsAwkCsQkELqRBYR7GHt93xK4k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g5uGb-0005K4-Al; Fri, 28 Sep 2018 17:01:17 +0200
Date:   Fri, 28 Sep 2018 17:01:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
Message-ID: <20180928150117.GA19396@lunn.ch>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-24-Jason@zx2c4.com>
 <20180927011526.GB1193@lunn.ch>
 <CAHmME9q7WRGF3TTRhhy0i_EB4ad2DaSD=tnHM92zfV4Cckyw=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9q7WRGF3TTRhhy0i_EB4ad2DaSD=tnHM92zfV4Cckyw=A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:37:03AM +0200, Jason A. Donenfeld wrote:
> Hi Andrew,
> 
> Thanks for following up with this.
> 
> On Thu, Sep 27, 2018 at 3:15 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > I know you have been concentrating on the crypto code, so i'm not
> > expecting too many changes at the moment in the network code.
> 
> I should be addressing things in parallel, actually, so I'm happy to
> work on this.
> 
> > WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()
> > #2984: FILE: drivers/net/wireguard/noise.c:293:
> > +       BUG_ON(first_len > BLAKE2S_HASH_SIZE || second_len > BLAKE2S_HASH_SIZE ||
> 
> I was actually going to ask you about this, because it applies
> similarly in another context too that I'm trying to refine. The above
> function you quote has the following properties:

We have the above case, and we have the general case. The general case
is, only use BUG_ON() when you know things have already gone bad and
there is no recovery for the machine. I doubt that ever applies to
wireguard. So i expect all the BUG_ON() to be removed. This is
something which Linus keeps ranting about....

In this case:

You have it inside a #ifdef. Meaning you don't really care, you can
keep going anyway if debugging is turned of. So just turn it into a
WARN_ON() so you get the splat, but the kernel keeps running.

You have some other options. first_len, second_len, third_len are all
parameter coming from #defines. As you suggested, you could do
BUILD_BUG_ON(), but you have to do it at the caller. Which is fine,
this is debug code, not user input validation code...

        BUILD_BUG_ON(NOISE_HASH_LEN > BLAKE2S_HAS_SIZE)
        BUILD_BUG_ON(NOISE_SYMMETRIC_KEY_LEN > BLAKE2S_HAS_SIZE)
        BUILD_BUG_ON(NOISE_PUBLIC_KEY_LEN > BLAKE2S_HAS_SIZE)
        kdf(chaining_key, key, NULL, dh_calculation, NOISE_HASH_LEN,
            NOISE_SYMMETRIC_KEY_LEN, 0, NOISE_PUBLIC_KEY_LEN, chaining_key);

> > WARNING: Macros with flow control statements should be avoided
> > #5471: FILE: drivers/net/wireguard/selftest/allowedips.h:456:
> > +#define init_peer(name) do {                                               \
> > +               name = kzalloc(sizeof(*name), GFP_KERNEL);                 \
> > +               if (unlikely(!name)) {                                     \
> > +                       pr_info("allowedips self-test: out of memory\n");  \
> > +                       goto free;                                         \
> > +               }                                                          \
> > +               kref_init(&name->refcount);                                \
> > +       } while (0)
> 
> This is part of a debugging selftest, where I'm initing a bunch of
> peers one after another, and this macro helps keep the test clear
> while offloading the actual irrelevant coding part to this macro. The
> test itself then just has code like:

Please don't focus on just the examples i give you. Look at the bigger
issue. We cannot see the woods for the trees. checkpatch is giving out
lots of warnings. There are so many, it is hard to see the interesting
ones from the simple ones where you need to add an extra space, or add
missing {}.

If checkpatch was just issues one or two warnings about a goto in a
macro, and nothing else, i probably would let it pass. This is bad,
but it is not terrible. I personally have fallen into a trap caused by
a goto in a macro. I changed the locking, not knowing about the goto,
causing an error path not to unlock the lock. It took a while, but
eventually the error happened, and soon after the machine
deadlocked. At the time static checkers did not expand macros, so they
did not detect the issue.

> On a slightly related note, out of curiosity, any idea what's up with
> the future of LTO in the kernel?

Sorry, i've no idea. Not my corner of the kernel.

> It sounds like that'd be nice to have
> on a module-by-module basis. IOW, I'd love to LTO all of my .c files
> in wireguard together, and then only ever expose mod_init/exit and
> whatever I explicitly EXPORT_SYMBOL

The namespace is more than just about the linker. I see an Opps stack
trace with wg_ symbols, i know i need to talk to Jason. Without any
prefix, i have to go digging into the code to find out who i need to
talk to. This is one reason why often every symbol has the prefix, not
just the global scope ones. Go look at other code in driver/net. You
will find that most drivers use a prefix everywhere, both local and
global.

     Andrew
