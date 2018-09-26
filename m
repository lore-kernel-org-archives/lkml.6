Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B2420843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zs5rjHGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B2420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeIZUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:49:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46322 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeIZUto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=4lNDk2Damm3eF7pXdfWI+NlmCC5OyVOA7lyOShtZc+k=;
        b=zs5rjHGbI//5YVaa+EFPY1qGdMibaJ3qY6XwjHW7aBCIEiYHKEX0HdI+klCvqoDWKkuMaT5ECISpgOP2BSX0qC9VU2PHYUW7km3aVmlIa8ghrC3wjA+NVzxqjEAnzQ1KToJqT28AZ9gtrgiXlIKE2ytr3w3nO4nYWDojK8iWvlM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g5AvG-0008IT-60; Wed, 26 Sep 2018 16:36:14 +0200
Date:   Wed, 26 Sep 2018 16:36:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Samuel Neves <sneves@dei.uc.pt>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64
 implementations
Message-ID: <20180926143614.GL1676@lunn.ch>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also, this still has unbounded worst case scheduling latency, given
> > that the outer library function passes its entire input straight into
> > the NEON routine.
> 
> The vast majority of crypto routines in arch/*/crypto/ follow this
> same exact pattern, actually. I realize a few don't -- probably the
> ones you had a hand in :) -- but I think this is up to the caller to
> handle. I made a change so that in chacha20poly1305.c, it calls
> simd_relax after handling each scatter-gather element, so a
> "construction" will handle this gracefully. But I believe it's up to
> the caller to decide on what sizes of information it wants to pass to
> primitives. Put differently, this also hasn't ever been an issue
> before -- the existing state of the tree indicates this -- and so I
> don't anticipate this will be a real issue now. And if it becomes one,
> this is something we can address *later*, but certainly there's no use
> of adding additional complexity to the initial patchset to do this
> now.

Hi Jason

This is not my area of expertise, so you should verify what i'm say
here...

My guess is, IPSEC will mostly ask the crypto code to work on 1500
byte full MTU packets and 64 byte TCP ACK packets. Disk encryption i
guess works on 4K blocks. So these requests are all quite small,
keeping the latency reasonably bounded.

The wireguard interface claims it is GSO capable. This means the
network stack will pass it big chunks of data and leave it to the
network interface to perform the segmentation into 1500 byte MTU
frames on the wire. I've not looked at how wireguard actually handles
these big chunks. But to get maximum performance, it should try to
keep them whole, just add a header and/or trailer. Will wireguard pass
these big chunks of data to the crypto code? Do we now have 64K blocks
being worked on? Does the latency jump from 4K to 64K? That might be
new, so the existing state of the tree does not help you here.

   Andrew
