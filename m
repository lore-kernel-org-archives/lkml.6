Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC6C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEE021728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucs7vjer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEE021728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeHOABf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbeHOABe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:01:34 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BF321723;
        Tue, 14 Aug 2018 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534281152;
        bh=ZVuNt8pYAOOXAKJRwGDv1EKA/T/jmYLHc7N/KOkYK58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucs7vjerpBqsdkEzMZ4trLZW1oGZgjWntrJeAiDwlvhZ5tFlqgBRWqY3kWe14K4JQ
         JtWCBF7DcMFUlqKUSla1p7ygtOoOT2FuNUV8TKFrqp0EwI4cWKiuw4Y5duz7gUXYoL
         cQ5OoZ/m53wfovJKpgAOY0zHa02ykZbEYRnxsB6A=
Date:   Tue, 14 Aug 2018 14:12:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "Daniel J . Bernstein" <djb@cr.yp.to>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
Message-ID: <20180814211229.GB24575@gmail.com>
References: <20180801072246.GA15677@sol.localdomain>
 <CAHmME9pbwj0RaX4YM9epGOSgDRNUt=GA4UzO_iKcW=Md7kG6JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pbwj0RaX4YM9epGOSgDRNUt=GA4UzO_iKcW=Md7kG6JQ@mail.gmail.com>
User-Agent: Mutt/1.10.1+60 (20b17ca5) (2018-08-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 04:33:50AM +0200, Jason A. Donenfeld wrote:
> 
> > Also, earlier when I tested OpenSSL's ChaCha NEON implementation on ARM
> > Cortex-A7 it was actually quite a bit slower than the one in the Linux
> > kernel written by Ard Biesheuvel... I trust that when claiming the
> > performance of all implementations you're adding is "state-of-the-art
> > and unrivaled", you actually compared them to the ones already in the
> > Linux kernel which you're advocating replacing, right? :-)
> 
> Yes, I have, and my results don't corroborate your findings. It will
> be interesting to get out a wider variety of hardware for comparisons.
> I suspect, also, that if the snarky emoticons subside, AndyP would be
> very interested in whatever we find and could have interest in
> improving implementations, should we actually find performance
> differences.
> 

On ARM Cortex-A7, OpenSSL's ChaCha20 implementation is 13.9 cpb (cycles per
byte), whereas Linux's is faster: 11.9 cpb.  I've also recently improved the
Linux implementation to 11.3 cpb and would like to send out a patch soon...
I've also written a scalar ChaCha20 implementation (no NEON instructions!) that
is 12.2 cpb on one block at a time on Cortex-A7, taking advantage of the free
rotates; that would be useful for the single permutation used to compute
XChaCha's subkey, and also for the ends of messages.

The reason Linux's ChaCha20 NEON implementation is faster than OpenSSL's is that
Linux's does 4 blocks at once using NEON instructions, and the words are
de-interleaved so the rows don't need to be shifted between each round.
OpenSSL's implementation, on the other hand, only does 3 blocks at once with
NEON instructions and has to shift the rows between each round.  OpenSSL's
implementation also does a 4th block at the same time using regular ARM
instructions, but that doesn't help on Cortex-A7; it just makes it slower.

I understand there are tradeoffs, and different implementations can be faster on
different CPUs.  Just know that from my point of view, switching to the OpenSSL
implementation actually introduces a performance regression, and we care a *lot*
about this since we need ChaCha to be absolutely as fast as possible for HPolyC
disk encryption.  So if your proposal goes in, I'd likely need to write a patch
to get the old performance back, at least on Cortex-A7...

Also, I don't know whether Andy P. considered the 4xNEON implementation
technique.  It could even be fastest on other ARM CPUs too, I don't know.

- Eric
