Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA976C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B908214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="aK9yeqbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfAISTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:19:02 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:31530 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfAISTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547057939;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=p/Xb2WrPLDUmNRmCJ6VKjd0OUIzYPuko8yOedvGeWIs=;
        b=aK9yeqbTBVWcKgyDSQeCmnjpnHBKS4QFdRQ37WYZm6uDN6iM2OAHo0HqD5PshLSQEc
        gt8eA3Tn06SQXXJ+EfJbsRfbvypupT9UbpZpI4KikcvWrDNnFPybEgchjUMfWVsHewdk
        8XvGgwgjhvRW/cjRm00Xp95iE7zXOyZWkJUFFI/QttbNP3iU5O/kZqp/39ZP15k18RSu
        BEgMAgzMwYdivtWOz5Cmbz/E7NCzz7pzA6L7Oqe/TzWO/9GFPBC4ITB+3qn3XLQzY5Mc
        HTrsGJQvA4ApFXAIhI97uL9WaEgJ+sbATBfb8E2HsZxbYibZKYJVGmLyAyXBKlD2ES6V
        piTg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaLvSbdkg="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv09IIDSNk
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 19:18:13 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date:   Wed, 09 Jan 2019 19:18:13 +0100
Message-ID: <2049180.FbvvROCS3Z@tauon.chronox.de>
In-Reply-To: <20190109173454.GB249140@gmail.com>
References: <20190103143227.9138-1-jlee@suse.com> <2344329.gmPllosFfp@tauon.chronox.de> <20190109173454.GB249140@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 18:34:55 CET schrieb Eric Biggers:

Hi Eric,

> That would not meet my performance requirements as I want to precompute
> HKDF-Extract, and then do HKDF-Expand many times.  Also the HKDF-Expand part
> should be thread-safe and not require allocating memory, especially not a
> whole crypto_shash tfm every time.
> 
> So presumably with crypto_rng, crypto_rng_reset() would need to take the
> input keyring material and salt and do HKDF-Extract (like my
> fscrypt_init_hkdf()), and crypto_rng_generate() would need to take the
> application-specific info string and do HKDF-Expand (like my
> fscrypt_hkdf_expand()).

Great, that was the idea I had in mind as well. Maybe the example was not 
right to convey that. Let me work on that.
> 
> It is ugly though.  Please also consider just having simple crypto_hkdf_*()
> helper functions which wrap a HMAC tfm along the lines of my patch, rather
> than shoehorning it into the crypto_rng API.
> 
> - Eric



Ciao
Stephan


