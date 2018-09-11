Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B9620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B9620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeIKT4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:56:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKT4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:56:08 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0061FEDB;
        Tue, 11 Sep 2018 14:56:26 +0000 (UTC)
Date:   Tue, 11 Sep 2018 16:56:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography
 library
Message-ID: <20180911145624.GA21635@kroah.com>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:08:56PM +0200, Ard Biesheuvel wrote:
> > As Zinc is simply library code, its config options are un-menued, with
> > the exception of CONFIG_ZINC_DEBUG, which enables various selftests and
> > BUG_ONs.
> >
> 
> In spite of the wall of text, you fail to point out exactly why the
> existing AEAD API in unsuitable, and why fixing it is not an option.
> 
> As I pointed out in a previous version, I don't think we need a
> separate crypto API/library in the kernel, and I don't think you have
> convinced anyone else yet either.

Um, then why do people keep sprinkling new crypto/hash code all around
the kernel tree?  It's because what we have as a crypto api is complex
and is hard to use for many in-kernel users.

Something like this new interface (zinc) is a much "saner" api for
writing kernel code that has to interact with crypto/hash primitives.

I see no reason why the existing crypto code can be redone to use the
zinc crypto primitives over time, making there only be one main location
for the crypto algorithms.  But to do it the other way around is pretty
much impossible given the complexities in the existing api that has been
created over time.

Not to say that the existing api is not a viable one, but ugh, really?
You have to admit it is a pain to try to use in any "normal" type of
"here's a bytestream, go give me a hash" type of method, right?

Also there is the added benefit that the crypto primitives here have
been audited by a number of people (so Jason stated), and they are
written in a way that the crypto community can more easily interact and
contribute to.  Which is _way_ better than what we have today.

So this gets my "stamp of approval" for whatever it is worth :)

thanks,

greg k-h
