Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB781C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6095621757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YMornd2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6095621757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeHCQgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:36:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54904 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732083AbeHCQgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PkAIz1NMlr2Je0QUuW4xWCU0s7LKItHJtmmPPwYN1sQ=;
        b=YMornd2oxhk3TtNiDLAxjZXP7zLbyhKuJSicIt5Z6NlCt3oAbkQQNoWrT1KRyuSzs83ODM1ZSntZm45dSB8WrYji8QkbucqHcUvJI6DdWHD6G9ZJ9tfwfb18Hl7oad1+jkZ0RmDT0M8sqB8HwM4TEsBMbe3G1bwnM1ZbKNT4bE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1flbEu-0007ZT-Mu; Fri, 03 Aug 2018 16:39:36 +0200
Date:   Fri, 3 Aug 2018 16:39:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 3/3] net: WireGuard secure network tunnel
Message-ID: <20180803143936.GD27445@lunn.ch>
References: <20180731191102.2434-1-Jason@zx2c4.com>
 <20180731191102.2434-4-Jason@zx2c4.com>
 <20180731132701.522b55e2@xeon-e3>
 <CAHmME9oWYD7TUSkbqAFRFk9kwSWDfC2h-J72gpdxJiw5i1yrXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oWYD7TUSkbqAFRFk9kwSWDfC2h-J72gpdxJiw5i1yrXw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 02:35:40AM +0200, Jason A. Donenfeld wrote:
> On Tue, Jul 31, 2018 at 10:02 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > I just gave this patch to checkpatch.pl...
> On Tue, Jul 31, 2018 at 10:22 PM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> > Please break lines at something reasonable like 100 characters.
> 
> If the long lines really truly are dreadful, I have no problem fixing
> that up for v2.

A very large percentage of the kernel code uses 80 characters maximum.
So anything which does not makes it look different. It makes it not
look like kernel code. It is also not just about styling. If you use
long lines, it makes it easier to use more indentation levels. But
good readable code tends to have lots of little functions with only
one or two levels of indentation, and each function does just one
easily understood thing.

Plus this is pretty much an open invite for kernel newbies to submit
patches fixing up all these warnings. Maybe you would prefer to do it
yourself, so you keep some degree of control over it. Also, such white
space changes make backporting fixes more difficult. So it is better
if you can get this done before it lands in the kernel and backporting
becomes necessary.

> On Tue, Jul 31, 2018 at 10:02 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > +static __always_inline void swap_endian(u8 *dst, const u8 *src, u8 bits)
> > There is a general preference to not force the compile to
> > inline. Leave it to decide.
> 
> I'm aware this is for the most part the case, and I've read the
> variety of threads and documentation of folks explaining why this is a
> good policy. In the particular instance of that function, inlining is
> in fact always the right thing to do. But I'll give it a double check
> to see if the compiler is already figuring that out on its own.

Well, what compiler are you going to check? I think the minimum
version of GCC is now v4.5. So you probably want to check 8.2, 7.3,
6.4, 5.5, 4.9.3 and 4.8. And you might want to check ARM, MIPs, x86
and amd64. So only 24 versions.

More realistically, if you have a strong argument why a particular
function must be inlined, e.g. to avoid a timing attack, make that
argument.

	Andrew
