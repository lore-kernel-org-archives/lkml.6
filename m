Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FC1ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719B2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NsTjpQlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7719B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeISHic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:38:32 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:40745 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISHib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:38:31 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d56da564;
        Wed, 19 Sep 2018 01:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=nlSBR7BDJ1iM6gWgOA5HnSUXLXo=; b=NsTjpQ
        lDdaZzC9yiLzkst5eSCI6NmG64O+bVUP8P5yYx98r2XhatQn2mG3l4TeZFa1Hczg
        He3M1rlR3VbjJ9C9uqNZMGjblADrjImICn/NoHa41IGJ3nbrkbJovGjXavFxp+yf
        C/prlAvaLJSVOerkwV52LBXN9hNpdZ+7mE9Kp/LIbQ66d1ZXqIg/gAl/tsMqU+hC
        D3nvrR5YS/JuUWPuI51spyz3zOHrqkwK8m55L8tkN5iDjnDX5YT9AIxqu93wj3+H
        QalAZbl/zSxAfZ7krIKoolR60GXVLlxVCkHK+UepkNlEDo4Xd/oW3DFTs3hJONP3
        PlrfgfvsuxXymX4Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 561ade05 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 01:45:26 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id p84-v6so3661092oic.4;
        Tue, 18 Sep 2018 19:03:03 -0700 (PDT)
X-Gm-Message-State: APzg51BKe06Eyf3KSeqd6suPFQ9d52Eh8+O22yY4UYWH0BEeAMy3c/8d
        0sr100wfpfXdpdZwuYKLu5EFbmytvfROyCahPH0=
X-Google-Smtp-Source: ANB0VdaKuJWqT0yg1SnXVGKoeacY58ERie2NkviBxSQ1yEaOSnlsTohUb3HFPd/imxUoHSMb2hXPuoo4Aa1DjySO1/c=
X-Received: by 2002:aca:d4cd:: with SMTP id l196-v6mr297834oig.15.1537322582804;
 Tue, 18 Sep 2018 19:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-4-Jason@zx2c4.com>
 <20180919010816.GD74746@gmail.com>
In-Reply-To: <20180919010816.GD74746@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 04:02:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9qOZEBNr0yndDWmfGMwuFSsN16n4KCDUSdHCPtCVe+Afw@mail.gmail.com>
Message-ID: <CAHmME9qOZEBNr0yndDWmfGMwuFSsN16n4KCDUSdHCPtCVe+Afw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/20] zinc: ChaCha20 generic C implementation
 and selftest
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 3:08 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Does this consistently perform as well as an implementation that organizes the
> operations such that the quarterrounds for all columns/diagonals are
> interleaved?  As-is, there are tight dependencies in QUARTER_ROUND() (as well as
> in the existing chacha20_block() in lib/chacha20.c, for that matter), so we're
> heavily depending on the compiler to do the needed interleaving so as to not get
> potentially disastrous performance.  Making it explicit could be a good idea.

It does perform as well, and the compiler outputs good code, even on
older compilers. Notably that's all a single statement (via the comma
operator).

> > +}
> > +
> > +static void chacha20_generic(u8 *out, const u8 *in, u32 len, const u32 key[8],
> > +                          const u32 counter[4])
> > +{
> > +     __le32 buf[CHACHA20_BLOCK_WORDS];
> > +     u32 x[] = {
> > +             EXPAND_32_BYTE_K,
> > +             key[0], key[1], key[2], key[3],
> > +             key[4], key[5], key[6], key[7],
> > +             counter[0], counter[1], counter[2], counter[3]
> > +     };
> > +
> > +     if (out != in)
> > +             memmove(out, in, len);
> > +
> > +     while (len >= CHACHA20_BLOCK_SIZE) {
> > +             chacha20_block_generic(buf, x);
> > +             crypto_xor(out, (u8 *)buf, CHACHA20_BLOCK_SIZE);
> > +             len -= CHACHA20_BLOCK_SIZE;
> > +             out += CHACHA20_BLOCK_SIZE;
> > +     }
> > +     if (len) {
> > +             chacha20_block_generic(buf, x);
> > +             crypto_xor(out, (u8 *)buf, len);
> > +     }
> > +}
>
> If crypto_xor_cpy() is used instead of crypto_xor(), and 'in' is incremented
> along with 'out', then the memmove() is not needed.

Nice idea, thanks. Implemented.

Jason
