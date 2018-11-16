Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB47C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9028E20883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zth/Ym4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9028E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeKQIHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeKQIHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:07:00 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F24C62086A;
        Fri, 16 Nov 2018 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542405172;
        bh=fdf9LE1XIzhfZ6C60W5NHkMAr3+NKq+ArFxGbnrHgug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zth/Ym4JRdYPDHSi5WN3DcFhykZAgvgtUA2Yprdv9xVu3WRqKcOBxQXv71M218MxO
         CML4oGNfSk38n7/MatH/8h3/awNxL2xIOOEirfv7HNhi3dxHgNaCq5MYz82imXwUtU
         d2gwY+Yp/MErR8OZseW/2r94FgEEarERoni35oAw=
Date:   Fri, 16 Nov 2018 13:52:50 -0800
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
Message-ID: <20181116215249.GA27149@gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com>
 <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milan,

On Sat, Oct 20, 2018 at 12:26:20PM +0200, Milan Broz wrote:
> 
> Adiantum (as in your current git branches on kernel.org) can be used for dm-crypt
> without any changes (yes, I played with it :) and with some easy tricks directly
> through cryptsetup/LUKS as well.
> 
> I think we should have this as an alternative to length-preserving wide-block
> cipher modes for FDE.
> 

Yes, dm-crypt can use Adiantum by specifying the cipher as
"capi:adiantum(xchacha12,aes)-plain64".

But, I'm having trouble getting cryptsetup/LUKS to use Adiantum.
Using LUKS1, the following works:

    cryptsetup luksFormat /dev/$partition --cipher='capi:adiantum(xchacha12,aes)-plain64' --key-size 256

However, when possible we'd like people to use 4K sectors for better
performance, which I understand requires using the LUKS2 format along with
cryptsetup v2.0.0+ and Linux v4.12+.  But the following does *not* work:

    cryptsetup luksFormat /dev/$partition --cipher='capi:adiantum(xchacha12,aes)-plain64' --key-size 256 --type luks2 --sector-size 4096

The problem seems to be that when cryptsetup tries to encrypt the keyslot in
luks2_encrypt_to_storage(), it tries to use the algorithm via AF_ALG, but it
incorrectly requests "plain64(capi:adiantum(xchacha12,aes))" which fails.
It should request just "adiantum(xchacha12,aes)".

What are the "easy tricks" you had in mind -- do you mean there's already a way
to use Adiantum with cryptsetup, or do you mean that cryptsetup still needs to
be updated to fully support algorithms using the crypto API syntax?

Thanks,

- Eric
