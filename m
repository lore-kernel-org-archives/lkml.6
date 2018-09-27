Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFB1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EE9215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+DZ8Oj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EE9215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeI1AtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:49:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbeI1AtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:49:21 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DAB9215E4;
        Thu, 27 Sep 2018 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538072986;
        bh=tzxX2xtoeD9fkRTxeeP7bDpgid35QhsFaNnrGrs1SSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+DZ8Oj0AqaMvk0gbKg1Yt+JmZM4OzjNNWEjPWDXk3mYBlQi/enNiZmjnMjhqQR2z
         ccJLG6SeMuOXxFBdCrCeTZIWRSWDJ4oEJrx+lN18rejjr4eQwkYrgNHBdN+E0BR5Pc
         V5STm129qQdjPq2u1Mi8c5E4/zBZzwDVJc4eR4pk=
Date:   Thu, 27 Sep 2018 11:29:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
Message-ID: <20180927182944.GA22921@gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925145622.29959-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 04:55:59PM +0200, Jason A. Donenfeld wrote:
> 
> It is intended that this entire patch series enter the kernel through
> DaveM's net-next tree. Subsequently, WireGuard patches will go through
> DaveM's net-next tree, while Zinc patches will go through Greg KH's tree.
> 

Why is Herbert Xu's existing crypto tree being circumvented, especially for
future patches (the initial merge isn't quite as important as that's a one-time
event)?  I like being able to check out cryptodev to test upcoming crypto
patches.  And currently, changes to APIs, algorithms, tests, and implementations
all go through cryptodev, which is convenient for crypto developers.

Apparently, you're proposing that someone adding a new algorithm will now have
to submit the API portion to one maintainer (Herbert Xu) and the implementation
portion to another maintainer (you), and they'll go through separate git trees.
That's inconvenient for developers, and it seems that in practice you and
Herbert will be stepping on each other's toes a lot.

Can you please reach some kind of sane agreement with Herbert so that the
development process isn't fractured into two?  Perhaps you could review patches,
but Herbert could still apply them?

I'm also wondering about the criteria for making additions and changes to
"Zinc".  You mentioned before that one of the "advantages" of Zinc is that it
doesn't include "cipher modes from 90s cryptographers" -- what does that mean
exactly?  You've also indicated before that you don't want people modifying the
Poly1305 implementations as they are too error-prone.  Yet apparently it's fine
to change them yourself, e.g. when you added the part that converts the
accumulator from base 26 to base 32.  I worry there may be double standards
here, and useful contributions could be blocked or discouraged in the future.
Can you please elaborate on your criteria for contributions to Zinc?

Also, will you allow algorithms that aren't up to modern security standards but
are needed for compatibility reasons, e.g. MD5, SHA-1, and DES?  There are
existing standards, APIs, and data formats that use these "legacy" algorithms;
so implementations of them are often still needed, whether we like it or not.

And does it matter who designed the algorithms, e.g. do algorithms from Daniel
Bernstein get effectively a free pass, while algorithms from certain countries,
governments, or organizations are not allowed?  E.g. wireless driver developers
may need the SM4 block cipher (which is now supported by the crypto API) as it's
specified in a Chinese wireless standard.  Will you allow SM4 in Zinc?  Or will
people have to submit some algorithms to Herbert and some to you due to
disagreements about what algorithms should be included?

- Eric
