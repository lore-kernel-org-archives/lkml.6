Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F82DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE2C21545
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5r+QLnhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE2C21545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbeIUI7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:59:46 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40761 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIUI7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=3j2QySAFHtDQaPPWeq4lDGbGd4vQAVpGQ3t1XKx/6r4=;
        b=5r+QLnhJV2pW4+RlfEOBlYkA7nVwdnMSWYYVj7IeQU0WwVSBAFGHlbzGeG6AXLtByL5wuIFrn4nQodJYAP3RXnVYq6Fs2Ni99/NIDuivnU4wZShn04VoSYpUL5wyCXnKqh/P0wUvXI7QMhn6DRgUqCqYeID3jBcdiVnt8ua5EbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g3BsF-00037K-C0; Fri, 21 Sep 2018 05:12:55 +0200
Date:   Fri, 21 Sep 2018 05:12:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography
 library
Message-ID: <20180921031255.GB11109@lunn.ch>
References: <20180918161646.19105-1-Jason@zx2c4.com>
 <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
 <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
 <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 02:11:43AM +0200, Jason A. Donenfeld wrote:
> Hey Arnd,
> 
> On Thu, Sep 20, 2018 at 6:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Right, if you hit a stack requirement like this, it's usually the compiler
> > doing something bad, not just using too much stack but also generating
> > rather slow object code in the process. It's better to fix the bug by
> > optimizing the code to not spill registers to the stack.
> >
> > In the long run, I'd like to reduce the stack frame size further, so
> > best assume that anything over 1024 bytes (on 32-bit) or 1280 bytes
> > (on 64-bit) is a bug in the code, and stay below that.
> >
> > For prototyping, you can just mark the broken functions individually
> > by setting the warning limit for a specific function that is known to
> > be misoptimized by the compiler (with a comment about which compiler
> > and architectures are affected), but not override the limit for the
> > entire file.
> 
> Thanks for the explanation. Fortunately in my case, the issues were
> trivially fixable to get it under 1024/1280. (By the way, why does
> 64-bit have a slightly larger stack frame? To account for 32 pointers
> taking double the space or something?) That will be rectified in v6.

Hi Jason

Do you any stack usage information?

A VPN can be at the bottom of some deep stack calls. Swap on NFS over
the VPN? If you have one frame of 1K, you might be O.K. But if you
have a few of these, i can see there might be issues of overflowing
the stack.

    Andrew
