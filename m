Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13001C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D306F20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547055299;
	bh=XCMs1JHLKW8yUEThiH5H4LK1zaopKG2S5ef0xFv4hC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B58gmGdcDjtvOr+njK8A4VY5/kbst6t4m/kRP9cRhgPlELY3RGNcfWrjv2qWccZ+/
	 vqESCEOqdvsb7KY7M5HqPRXYBm+fLFhzAbGOqFQ2wQe7TJYnxNC5QGtuyoDS9XOEET
	 8g9XHUongg91qUC6FGtz2TqlhlT1u4yy42iTMKYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfAIRe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfAIRe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:34:58 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D055206BB;
        Wed,  9 Jan 2019 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547055297;
        bh=XCMs1JHLKW8yUEThiH5H4LK1zaopKG2S5ef0xFv4hC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVjxO7sH1XLw16NC/hIOJg64WVq5Rgo87CrLQhYdrxGZuSmuMYaBVXT4gcZj8KgPd
         Ab56kcbpQTk2xHTrYlm3gaTPKMOToWx+z0pZGkEBBGTuXv9TGYQxPIlweh5tElQXxO
         vrx9qu0OW4MKDhEdRGXf8gZYbXG3C57X3wPS2E+M=
Date:   Wed, 9 Jan 2019 09:34:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephan Mueller <smueller@chronox.de>
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
Message-ID: <20190109173454.GB249140@gmail.com>
References: <20190103143227.9138-1-jlee@suse.com>
 <1894062.aDvIuj92vB@tauon.chronox.de>
 <20190109082103.GA8586@sol.localdomain>
 <2344329.gmPllosFfp@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2344329.gmPllosFfp@tauon.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:17:45AM +0100, Stephan Mueller wrote:
> Am Mittwoch, 9. Januar 2019, 09:21:04 CET schrieb Eric Biggers:
> 
> Hi Eric,
> > 
> > FWIW, it's been very slow going since I've been working on other projects
> > and I also need to be very sure to get the API changes right, but I still
> > plan to change the KDF in fscrypt (a.k.a. ext4/f2fs/ubifs encryption) to
> > HKDF-SHA512 as part of a larger set of improvements to how fscrypt
> > encryption keys are managed. I sent the last patchset a year ago
> > (https://marc.info/?l=linux-fsdevel&m=150879493206257) but I'm working to
> > revive it.  In the work-in-progress version in my git tree, this is the
> > commit that adds a HKDF implementation as fs/crypto/hkdf.c:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=e8a78767131c9717ee838f0c4e307948d65a4427
> > It basically just wraps a crypto_shash for "hmac(sha512)".
> > 
> > I'd be fine with using a common implementation instead, provided that it
> > gives the same functionality, including supporting user-specified salt and
> > application-specific info strings, and isn't slower or more complex to use.
> > 
> > (This comment is solely on the tangential discussion about KDF
> > implementations; I've not looked at the hibernation image encryption stuff
> > yet.)
> 
> Thanks for the clarification. I have started a generic HKDF implementation for 
> the kernel crypto API which lead to the questions above. I would then also try 
> to provide a HKDF proposal.
> 
> To use the (H)KDF, I currently envision 2 calls apart from alloc/free. The 
> following code would serve as an example.
> 
>  * Example without proper error handling:
>  *      char *keying_material = "\x00\x11\x22\x33\x44\x55\x66\x77";
>  *      char *label_context = "\xde\xad\xbe\xef\x00\xde\xad\xbe\xef";
>  *      kdf = crypto_alloc_rng(name, 0, 0);
>  *      crypto_rng_reset(kdf, keying_material, 8);
>  *      crypto_rng_generate(kdf, label_context, 9, outbuf, outbuflen);
> 
> That hopefully should be simple enough.
> 
> For HKDF, as mentioned, I would envision to use a struct instead of a char * 
> for the label_context to communicate IKM, Salt, and the label/info 
> information.
> 
> Ciao
> Stephan
> 

That would not meet my performance requirements as I want to precompute
HKDF-Extract, and then do HKDF-Expand many times.  Also the HKDF-Expand part
should be thread-safe and not require allocating memory, especially not a whole
crypto_shash tfm every time.

So presumably with crypto_rng, crypto_rng_reset() would need to take the input
keyring material and salt and do HKDF-Extract (like my fscrypt_init_hkdf()), and
crypto_rng_generate() would need to take the application-specific info string
and do HKDF-Expand (like my fscrypt_hkdf_expand()).

It is ugly though.  Please also consider just having simple crypto_hkdf_*()
helper functions which wrap a HMAC tfm along the lines of my patch, rather than
shoehorning it into the crypto_rng API.

- Eric
