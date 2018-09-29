Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CEC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAC7206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K2YUaQyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAC7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeI2JGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:06:55 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57477 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeI2JGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:06:54 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 72608233;
        Sat, 29 Sep 2018 02:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=MsjPlVNHvEQq3hckMbNmcjdwyww=; b=K2YUaQ
        ybDBADnUBypmuBvnPAovCw8H/nQAeTg28eFtA+EG67ZjIDSiyPOqnktHosobfPCR
        uZLRBRDVdzI1luj1of+7GMrmOPZ38qdScQemJNKOxRR+AMALF/3rYQO+8+sUhX2e
        3Q3Ez2n67xp/uUBc1HwGSlownXp9JoTbAfgKTB6+ssR9lHwOsObYM5KtVFgLHBUx
        0oGQX/LJmvknSOG4Q1vPD9wQxLuJo/QhU4itzzAYW0udkwkH6jh+MQf9u1Ex60Gz
        J3HfeW956I4kzH57xmizCMPKA/Usivdep4zSbqCflFpNyt2DG8O/iMGEeMfq1rmO
        7jDYaK/FAebK36ig==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f469b0e0 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 29 Sep 2018 02:21:24 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id k64-v6so7003390oia.13;
        Fri, 28 Sep 2018 19:40:15 -0700 (PDT)
X-Gm-Message-State: ABuFfog7i4267NCgd2Dtnqt7q9J8bRhTfFkZh7KzDkWKVW2l0EItrl6J
        vLQyfqOTQ4kvh52rYSSgPPZlu4094s81Dr1zYhA=
X-Google-Smtp-Source: ACcGV62AwyhENU4zOl+bysT9f5zuaw8TU691KCX/J61ZHb5awxZcmd80pcELh4vNn8U+TUEpuzjN8CftiIXH3ZColAc=
X-Received: by 2002:aca:d489:: with SMTP id l131-v6mr607985oig.15.1538188814760;
 Fri, 28 Sep 2018 19:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180927182944.GA22921@gmail.com>
 <20180927213537.GA27576@zx2c4.com> <20180928011726.GA98113@gmail.com>
 <20180928023546.GA20765@zx2c4.com> <20180928045542.GA545@zzz.localdomain>
 <CAHmME9rJ4CewfDEqWh00ZowjWg9TaYpksVSzKSSxoKya-M8_LA@mail.gmail.com> <CAKv+Gu-8eiMkrJtpnMKzT=m9zGvY5qHVAmLM_rFA3gxk2gV-zw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-8eiMkrJtpnMKzT=m9zGvY5qHVAmLM_rFA3gxk2gV-zw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 29 Sep 2018 04:40:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9pPTxx5JP+8WQ0jLVBXxJmRKy2=z5YOSx_ar7JZqBQ1CA@mail.gmail.com>
Message-ID: <CAHmME9pPTxx5JP+8WQ0jLVBXxJmRKy2=z5YOSx_ar7JZqBQ1CA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Willy Tarreau <w@1wt.eu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Willy]

Hi Ard,

On Fri, Sep 28, 2018 at 7:47 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On 28 September 2018 at 07:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > WireGuard is indeed quite opinionated in its primitive choices, but I
> > don't think it'd be wise to apply the same design to Zinc. There are
> > APIs where the goal is to have a limited set of high-level functions,
> > and have those implemented in only a preferred set of primitives. NaCl
> > is a good example of this -- functions like "crypto_secretbox" that
> > are actually xsalsapoly under the hood. Zinc doesn't intend to become
> > an API like those, but rather to provide the actual primitives for use
> > cases where that specific primitive is used. Sometimes the kernel is
> > in the business of being able to pick its own crypto -- random.c, tcp
> > sequence numbers, big_key.c, etc -- but most of the time the kernel is
> > in the business of implementing other people's crypto, for specific
> > devices/protocols/diskformats. And for those use cases we need not
> > some high-level API like NaCl, but rather direct access to the
> > primitives that are required to implement those drivers. WireGuard is
> > one such example, but so would be Bluetooth, CIFS/SMB, WiFi, and so
> > on. We're in the business of writing drivers, after all. So, no, I
> > don't think I'd knock down the addition of a primitive because of a
> > simple preference for a different primitive, if it was clearly the
> > case that the driver requiring it really benefited from having
> > accessible via the plain Zinc function calls. Sorry if I hadn't made
> > this clear earlier -- I thought Ard had asked more or less the same
> > thing about DES and I answered accordingly, but maybe that wasn't made
> > clear enough there.
> >
>
> CRC32 is another case study that I would like to bring up:
> - the current status is a bit of a mess, where we treat crc32() and
> crc32c() differently - the latter is exposed by libcrc32.ko as a
> wrapper around the crypto API, and there is some networking code (SCTP
> iirc) that puts another kludge on top of that to ensure that the code
> is not used before the module is loaded
> - we have C versions, scalar hw instruction based versions and
> carryless multiplication based versions for various architectures
> - on ST platforms, we have a synchronous hw accelerator that is 10x
> faster than C code on the same platform.
>
> AFAICT none of its current users rely on the async interface or
> runtime dispatch of the 'hash'.

I've added Willy to the CC, as we were actually discussing the crc32
case together two days ago. If my understanding was correct, he seemed
to think it'd be pretty useful too.

It seems like unifying the crc32 implementations at some point would
make sense, and since there's no usage of these as part of the crypto
api, providing crc32 via a vanilla function call seems reasonable.
It's not clear that on some strict formal level, crc32 belongs
anywhere near Zinc, since it's not _exactly_ in the same category...
But one could broaden the scope a bit and make the argument that this
general idea of accepting some bytes, doing some "pure" arithmetic
operations from a particular discipline on them in slightly different
ways depending on the architecture, and then returning some other
bytes, is what in essence is happening with these all of these
function calls, no matter their security or intended use; so if crc32
would benefit from being implemented using the exact same design
patterns, then it might as well be grouped in with the rest of Zinc.
On the other hand, this might be a bit of a slippery slope ("are
compression functions next?"), and a libcrc32.ko could just as well
exist as a standalone thing. I can see it both ways and some other
arguments too, but also this might form a good setting for some much
needed cleanup of the crc32. So that's definitely something we can
consider.

Regarding the synchronous ST driver: I'll give it a thorough read
through, but I do wonder off the bat if actually it'd be possible to
incorporate that into the Zinc paradigm in a fairly non-intrusive way.
I'll give that some thought and play around a bit with it.

Jason
