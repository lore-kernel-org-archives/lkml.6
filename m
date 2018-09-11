Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45355C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AE320866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O2qCxA5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AE320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeILEb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:31:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59566 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeILEb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=xrJmQ9vMPijmrcl7V6ihDQimgZs4Pp6L6sh/osFv37c=;
        b=O2qCxA5/oqnJ8mu+nns6YZMLmRLGpZCLD9xUT5OoVFCzrv9HMarrtagyj0bA2vFMWFe1eXx/33IBP9YZoOAFUX8KuUnGQ7xqNEt0+TU3FZZyl66LGALP6bMQpTlYlJu+7VU2UpLLAnHqRl5LZ+u27jDAK/dzlRuJ9xVzIFgwvvE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fzs6p-0003F7-Ik; Wed, 12 Sep 2018 01:30:15 +0200
Date:   Wed, 12 Sep 2018 01:30:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography
 library
Message-ID: <20180911233015.GD11474@lunn.ch>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <20180911145624.GA21635@kroah.com>
 <20180911214737.GA81235@gmail.com>
 <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:02:52PM -0600, Jason A. Donenfeld wrote:
> On Tue, Sep 11, 2018 at 3:47 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > Of course, the real problem is that even after multiple revisions of this
> > patchset, there's still no actual conversions of the existing crypto API
> > algorithms over to use the new implementations.  "Zinc" is still completely
> > separate from the existing crypto API.
> 
> No this is not, "the real problem [...] after multiple revisions"
> because I've offered to do this and stated pretty clearly my intent to
> do so. But, as I've mentioned before, I'd really prefer to land this
> series through net-next

Hi Jason

Just as an FYI:

1) I don't think anybody in netdev has taken a serious look at the
network code yet. There is little point until the controversial part
of the code, Zinc, has been sorted out.

2) I personally would be surprised if DaveM took this code without
having an Acked-by from the crypto subsystem people. In the same way,
i doubt the crypto people would take an Ethernet driver without having
DaveM's Acked-by.

       Andrew
