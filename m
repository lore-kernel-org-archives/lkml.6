Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D832C4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134D820880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF2XliIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134D820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeILXkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeILXkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:40:32 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DDD820854;
        Wed, 12 Sep 2018 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536777286;
        bh=pge98TJPPolDJ8DTUt2rNC12zELDyGW2I7GUqcQLE+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DF2XliIx58Chsn1zS+fgGom+9KfqXXDOtZzgm/9hAxBo2ReIq+2ogcYcJBpgawARF
         2Tz+i7+b+8NPlAHsJQRJGHP8HWJFkIoYiAf1nQgT545N2l7iFHO/M6Cc1VkcREI4C+
         uztEwKe1Prc6A7lEWmtsIy8/oU60s0SRJ/avaMw8=
Date:   Wed, 12 Sep 2018 11:34:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography
 library
Message-ID: <20180912183444.GB222557@gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <20180911220849.GC81235@gmail.com>
 <CAHmME9rxrC+CAR-xoXd-bZO1HYZ+TjvT_K4xgQwWXE53zi61xQ@mail.gmail.com>
 <CAKv+Gu9ZjX3A4bHHgRAkJtr+SKwti+d3dwE0fhGtmeQB_refqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9ZjX3A4bHHgRAkJtr+SKwti+d3dwE0fhGtmeQB_refqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 08:19:21PM +0200, Ard Biesheuvel wrote:
> On 12 September 2018 at 20:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Hi Eric,
> >
> > On Wed, Sep 12, 2018 at 12:08 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >> I'd strongly prefer the assembly to be readable too.  Jason, I'm not sure if
> >> you've actually read through the asm from the OpenSSL implementations, but the
> >> generated .S files actually do lose a lot of semantic information that was in
> >> the original .pl scripts.
> >
> > The thing to keep in mind is that the .S was not directly and blindly
> > generated from the .pl. We started with the output of the .pl, and
> > then, particularly in the case of x86_64, worked with it a lot, and
> > now it's something a bit different. We've definitely spent a lot of
> > time reading that assembly.
> >
> 
> Can we please have those changes as a separate patch? Preferably to
> the .pl file rather than the .S file, so we can easily distinguish the
> code from upstream from the code that you modified.
> 
> > I'll see if I can improve the readability with some register name
> > remapping on ARM. No guarantees, but I'll play a bit and see if I can
> > make it a bit better.
> >
> > Jason

FWIW, yesterday I made a modified version of poly1305-armv4.pl that generates an
asm file that works in kernel mode.  The changes are actually pretty small, and
I think we can get them upstream into OpenSSL like they were for sha256-armv4.pl
and sha512-armv4.pl.  I'll start a thread with Andy Polyakov and you two.

But I don't have time to help with all the many OpenSSL asm files Jason is
proposing, just maybe poly1305-armv4 and chacha-armv4 for now.

- Eric
