Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746F6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1613A20858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="2W8CPcie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1613A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeIYUwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:52:45 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41637 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbeIYUwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:52:45 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e61ba769;
        Tue, 25 Sep 2018 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=WfukFyGDauAsaUpnw8gphCsgXcQ=; b=2W8CPc
        ievoAAQ/ZSt0tIKw7DoLh5Xv9Lcjcevn7UEC/un01diO1H52m+sOAjIEIuLVAJfD
        9YoRqymK4c5HDmaLKJdCgLsGiXGbSEqSPbDggysNEEqKcqeQBQ796mOE2VMZhOhh
        cUbo2qzgUrRbuPL1fpOOfPNBgekIn1WDUw8mfIESmzrAauVAJ1qTIHJkO5L8IJF5
        dR+z96AT29C00NRuEQ/w9Mocib0FbAOPbJ3MI1LxFwundUHj5y3hCwllqSpUM6ZA
        hKu4XqkXMtAEuM4CQKn2gIht5qBxTMTuMkhsTpfOU9yez7FJ1I9Le0zYAqhhFlGO
        R4+jb/FV8pFq4U8Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3e1eca65 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 25 Sep 2018 14:26:26 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id n1-v6so1699602oic.4;
        Tue, 25 Sep 2018 07:44:51 -0700 (PDT)
X-Gm-Message-State: ABuFfogr00TH9hYJM5GQdwCFjM11+DHWgo5jhyMJA0/R+iccLgpB7nd6
        DTodZXjV6DeKkTBuqGehdRbOKgyAMRDDitYJ20E=
X-Google-Smtp-Source: ACcGV61BtTXX1Omd4gwRSCUgufAkhSvjrmxNxOqDZMy3gPQ3HaDOY02yTIUTa0bb//4zNKhdFPAkYbkWgDGtNYgDSvU=
X-Received: by 2002:aca:ce4c:: with SMTP id e73-v6mr804188oig.225.1537886690836;
 Tue, 25 Sep 2018 07:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu_Wsp7s31KowyA20ag4t=VyiPLLhzg1ySp31sOFvo7FQQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_Wsp7s31KowyA20ag4t=VyiPLLhzg1ySp31sOFvo7FQQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Sep 2018 16:44:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9oG6HSUV+UcohTbnt2VxVR8CQ2vFOZ8JSPb_uCoYcuy+g@mail.gmail.com>
Message-ID: <CAHmME9oG6HSUV+UcohTbnt2VxVR8CQ2vFOZ8JSPb_uCoYcuy+g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

Hey Ard,

On Tue, Sep 25, 2018 at 12:25 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Kees is currently dealing with VLA uses in crypto API skcipher
> invocations [0] that don't benefit from its async capabilities nor
> from the runtime resolution of cipher name strings, given that they
> always select the same one.
>
> drivers/net/ppp/ppp_mppe.c: "ecb(arc4)"
> drivers/usb/wusbcore/crypto.c: "cbc(aes)"
> net/ceph/crypto.c: "cbc(aes)"
> net/mac802154/llsec.c: "ctr(aes)"
> net/rxrpc/rxkad.c: "pcbc(fcrypt)"
> net/rxrpc/rxkad.c: "pcbc(fcrypt)"
> net/sunrpc/auth_gss/gss_krb5_mech.c: "cbc(des)"
> net/sunrpc/auth_gss/gss_krb5_mech.c: "ecb(arc4)"
> net/sunrpc/auth_gss/gss_krb5_mech.c: "cbc(des3_ede)"
> net/sunrpc/auth_gss/gss_krb5_mech.c: "cts(cbc(aes))"
> net/sunrpc/auth_gss/gss_krb5_mech.c: "cts(cbc(aes))"
> net/wireless/lib80211_crypt_tkip.c: "ecb(arc4)"
> net/wireless/lib80211_crypt_wep.c: "ecb(arc4)"
>
> To me, these are prime candidates for moving into your library [at
> some point]. I guess AES should be non-controversial, but moving the
> others is actually more important in my view, since we will be able to
> stop exposing them via the crypto API in that case. Any thoughts?

In order of priority, I'll probably tackle lib/ first and then the
cases like you mentioned after. Indeed AES is an obvious candidate.
For the others, we'll evaluate them on a case-by-case basis. For
example, Ted T'so's "halfmd4" algorithm was moved from lib/ directly
into that portion of the ext4 driver, since it's some "half"-baked
random crypto that should only be used in that one place and then
never again. On the other hand, it seems likely RC4 and DES are used
multiple places, and so we'll have to carefully evaluate these. We can
also discuss this in November and see where thoughts are at that time.

> Also, you haven't yet responded to my question about WireGuard's
> limitation to synchronous encryption, or whether and how you expect to
> support asynchronous accelerators for ChaCha20/Poly1305 in the future.
> This shouldn't impede adoption of this series, but this is something
> that is going to come up sooner than you think, and so I would like to
> understand whether this means your library will grow asynchronous
> interfaces as well, or whether it will be moved to the crypto API.

I have no concrete plans to introduce an asynchronous interface to
Zinc at this time, but that could change at some later date. At the
moment however, I prefer for it to be just a simple collection of
software ciphers, just as the description reads. Regarding hardware
acceleration in WireGuard: I've actually been talking to some people
interested in producing these types of ASICs lately, and hopefully
something cool will come out of it. It's not obvious, however, that
this _must_ imply an asynchronous interface, even though that may very
well seem like the intuitive thing. This is, as well, a discussion for
the future indeed.

> (Also, I'd like to know whether the RFC7539 construction of ChaCha20
> and Poly1305 is compatible with WireGuard's)

WireGuard uses 64-bit nonces, but since they're both little-endian,
and because of the maximum size of a series of IP fragments (namely,
less than 2^32), they're "compatible".

Jason
