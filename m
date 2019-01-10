Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A678C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B90214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547161279;
	bh=OlT6NhEtYojy9FEGQlWdAZqJtHPp9nCUnKUyJ5VzcZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qWaDs9eKKUKRsrP1EK7Iag5Dyj/ll4Bs/w5x94lgZcgI30UP3cRH/Og7UxX68O5k2
	 0VPtANQPDhjNRAedtx+Ps2mEncgc9b22LLkXVwA5VLiAbuv8aqI97fzBxlhV2OfSDq
	 g4aM/UBqau9WZDy3WcFMzTA89cVwfXE1F9m51cCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfAJXBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfAJXBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:01:17 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74937208E3;
        Thu, 10 Jan 2019 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547161276;
        bh=OlT6NhEtYojy9FEGQlWdAZqJtHPp9nCUnKUyJ5VzcZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uA13TDL6N9k+0c49KAHk8lno9N/jVyG6i+RsLsOdsvUs+3v+lGZe5x5ZVzZe94FGt
         uD/Heau29qve86oj/A5NTku7vp4dDj/qWbTxY2AxusBtoSe6isQD69LKg8BeO9ovB6
         ySwEoj3PnNshs65LMkSRZEGu6ATku/SmoDHlv0eI=
Date:   Thu, 10 Jan 2019 15:01:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     David Howells <dhowells@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: Bug report: unaligned access with ext4 encryption
Message-ID: <20190110230114.GF149637@gmail.com>
References: <20190103171659.GA208343@gmail.com>
 <20181230162906.GI27785@darkstar.musicnaut.iki.fi>
 <17391.1546622882@warthog.procyon.org.uk>
 <20190110222928.GB22416@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110222928.GB22416@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:29:28AM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Jan 04, 2019 at 05:28:02PM +0000, David Howells wrote:
> > Eric Biggers <ebiggers@kernel.org> wrote:
> > > Hi Aaro, thanks for the bug report!  I think you're on the right track; it makes
> > > much more sense to have the keyrings subsystem store the payload with better
> > > alignment, than to work around the 2-byte alignment in fscrypt.
> > > 
> > > But how about '__aligned(__alignof__(u64))' instead?  4 bytes may not be enough.
> > > 
> > > David, what do you think?
> > 
> > Does that even work?
> 
> That should work.
> 
> > Might be better to just insert 6 bytes of padding with a comment, but yes I
> > agree that it's probably better to align it to at least machine word size.
> 
> Padding is fragile, e.g. if struct rcu_head changes. Using __aligned should
> make it always right automatically.
> 
> A.

I agree that __aligned is better.  It should work; see 'struct crypto_tfm' in
include/linux/crypto.h for another example of a struct that uses __aligned on a
flexible array at the end.

Aaro, can you send a formal patch?  If you don't I'll do so, but I figure I'll
ask first.

Thanks,

- Eric
