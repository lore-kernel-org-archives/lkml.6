Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7D8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE97720989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDJO/dU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE97720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbeKTFx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeKTFx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:53:28 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFD52075B;
        Mon, 19 Nov 2018 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542655705;
        bh=jgpIpAM0rs970Ruia3VshFPvXqgVqIfGCBdkhUciuv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDJO/dU6EqoDmCmLfMGp3MWJSXQYOh0l+xeTcSPKIkaMHp0996o6oI8jhSNQOM1K8
         66W3ftBFsDFM0478UkPYALhM8A0z5y58E/kcyL51Kk1cJB0QL73GI2d9PkUgL2xl+B
         AKErCIvVyOTpO8EIfH0t8EG+DqkO89/VmnAntRHE=
Date:   Mon, 19 Nov 2018 11:28:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
Message-ID: <20181119192821.GA258711@gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com>
 <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
 <20181116215249.GA27149@gmail.com>
 <56883f08-26cb-ecef-5698-1c2948714773@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56883f08-26cb-ecef-5698-1c2948714773@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milan,

On Sat, Nov 17, 2018 at 11:29:23AM +0100, Milan Broz wrote:
> On 16/11/2018 22:52, Eric Biggers wrote:
> > Hi Milan,
> > 
> > On Sat, Oct 20, 2018 at 12:26:20PM +0200, Milan Broz wrote:
> >>
> >> Adiantum (as in your current git branches on kernel.org) can be used for dm-crypt
> >> without any changes (yes, I played with it :) and with some easy tricks directly
> >> through cryptsetup/LUKS as well.
> >>
> >> I think we should have this as an alternative to length-preserving wide-block
> >> cipher modes for FDE.
> >>
> > 
> > Yes, dm-crypt can use Adiantum by specifying the cipher as
> > "capi:adiantum(xchacha12,aes)-plain64".
> > 
> > But, I'm having trouble getting cryptsetup/LUKS to use Adiantum.
> > Using LUKS1, the following works:
> > 
> >     cryptsetup luksFormat /dev/$partition --cipher='capi:adiantum(xchacha12,aes)-plain64' --key-size 256
> > 
> > However, when possible we'd like people to use 4K sectors for better
> > performance, which I understand requires using the LUKS2 format along with
> > cryptsetup v2.0.0+ and Linux v4.12+.  But the following does *not* work:
> > 
> >     cryptsetup luksFormat /dev/$partition --cipher='capi:adiantum(xchacha12,aes)-plain64' --key-size 256 --type luks2 --sector-size 4096
> 
> Hi Eric,
> 
> actually I planned to test it and then reply to these patches with example cryptsetup
> commands, but did not have time for it yet.
> So thanks for a reminder ;-)
> 
> Recent cryptsetup supports sector-size even for plain device.
> 
> You actually do not need to use capi: prefix, Adiantum is a composition,
> so "xchacha20,aes-adiantum-plain64" works as well (and it should work even for old cryptsetup).
> (It is ugly, but it should be compatible.)

Okay, good to know the "capi:" prefix is not needed.
That makes things slightly easier for us.

> 
> # cryptsetup open --type plain -c xchacha20,aes-adiantum-plain64 -s 256 --sector-size 4096 /dev/sdb test
> 
> For LUKS and benchmark, Adiantum need to use 32 bytes IV. And we have these parameter,
> unfortunately, hardcoded...
> (I guess there is already a way how to get this dynamically from userspace crypto API now.)
> 
> So, I already added patch to devel branch patch for benchmark to support Adiantum few days ago
> https://gitlab.com/cryptsetup/cryptsetup/commit/bce567db461e558af7d735c694a50146db899709
> 
> This allows trivial benchmark (but it just encrypts one big blob of data):
> 
> #  cryptsetup benchmark -c xchacha20,aes-adiantum -s 256
> # Tests are approximate using memory only (no storage IO).
> #            Algorithm |       Key |      Encryption |      Decryption
> xchacha20,aes-adiantum        256b       146.6 MiB/s       148.0 MiB/s
> ...
> 
> # ./cryptsetup benchmark -c xchacha12,aes-adiantum -s 256
> xchacha12,aes-adiantum        256b       181.7 MiB/s       184.6 MiB/s

Note that Adiantum benchmarks on x86 are misleading at the moment, since the
initial kernel patchset doesn't include SSE2 and AVX2 optimized XChaCha and
NHPoly1305.  To start, only C and arm32 NEON implementations are included.
Hence, on x86 Adiantum will appear much slower than it should be.  But I'm
planning to add the x86 and arm64 implementations, so it will get much faster.

> 
> For LUKS2, we need a similar change to cryptoAPI IV size (unfortunately it does not
> fallback to old keyslot handling, so LUKS2 does not work currently now).
> 
> I quickly added a workaround that fallbacks to default keyslot encryption for keyslots
> in this case
> https://gitlab.com/cryptsetup/cryptsetup/commit/29e87add5aac9d5eb0087881146988d9c4280915
> 
> then you can use LUKS2
> # cryptsetup luksFormat --type luks2 --sector-size 4096 -c xchacha20,aes-adiantum-plain64 -s 256 /dev/sdb
> 
> (Example above will encrypt keyslots with AES-XTS and use Aviantum for data only.)
> 
> So, unfortunately yes, we need some small changes in cryptsetup for LUKS;
> plain mode should work out of the box (with the syntax above).

I think that when using AF_ALG, cryptsetup should get the IV size from
/proc/crypto, or else have it hardcoded that "adiantum" uses 32-byte IVs.
(Actually Adiantum can formally can use any size IV, but we had to choose a
fixed size for Linux's crypto API.)

Getting the IV size via CRYPTO_MSG_GETALG via NETLINK_CRYPTO is also an option,
but that requires the kconfig option CONFIG_CRYPTO_USER which isn't guaranteed
to be enabled even if CONFIG_CRYPTO_USER_API_SKCIPHER is.

Also: why is cryptsetup's default keyslot encryption AES-128-XTS instead of
AES-256-XTS?  People can choose a cipher with a 256-bit key strength such as
AES-256-XTS or Adiantum, so the keyslots should use at least that strength too.

Thanks,

- Eric
