Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37118C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0400120821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ASbMHLsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfAIG6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:58:32 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58004 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729209AbfAIG6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:58:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 75C108EE42E;
        Tue,  8 Jan 2019 22:58:30 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PmnL43oLfymR; Tue,  8 Jan 2019 22:58:30 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 891668EE0CD;
        Tue,  8 Jan 2019 22:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1547017110;
        bh=Y6wBS4NyjRVcBjBw4T9WK9b8P57p87P6kg4yLicGKo4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ASbMHLsls7Bn3yb2mVZ6vmCtPoPlxvxK1PBpJqwZi7MYn7H/XSj9gdnbMUPqcoCk/
         sIx432fRIS+4UZyS1uixpYCdb5pCI4SAYm4/nKTWNe7Z7PCNiFrRVshCxWfFchm5vF
         DfhDMVDJLPQ+3a51urQieezA3egnxXSibUUcYCoI=
Message-ID: <1547017108.2789.24.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
Date:   Tue, 08 Jan 2019 22:58:28 -0800
In-Reply-To: <309406107.k3W2fMQUza@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com>
         <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
         <1546994671.6077.10.camel@HansenPartnership.com>
         <309406107.k3W2fMQUza@tauon.chronox.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 07:45 +0100, Stephan Mueller wrote:
> Am Mittwoch, 9. Januar 2019, 01:44:31 CET schrieb James Bottomley:
> 
> Hi James,
> 
> > Actually, it would be enormously helpful if we could reuse these
> > pieces for the TPM as well. 
> 
> Could you please help me understand whether the KDFs in TPM are
> directly usable as a standalone cipher primitive or does it go
> together with additional  key generation operations?

They're used as generators ... which means they deterministically
produce keys from what the TPM calls seeds so we can get crypto agility
of TPM 2.0 ... well KDFa does.  KDFe is simply what NIST recommends you
do when using EC for a shared key agreement ... and really we shouldn't
be using ECDH in the kernel without it.

> > It has two KDFs: KDFa, which is the CTR-KDF from
> > SP800-108 and KDFe which is the SP800-56A KDF for elliptic curve
> > one pass Diffie Hellman, so if we're going to do the former, I'd
> > really like the latter as well.
> > 
> > The way the TPM parametrises input to both KDFs is
> > 
> > (hashAlg, key, label, contextU, contextV, bits)
> > 
> > Where
> > 
> > hashAlg  = the hash algorithm used as the PRF
> > key      = the input parameter of variable bit size or
> >            the x co-ordinate of the shared point
> > label    = An ASCII string representing the use
> > contextU = public input U
> > contextV = public input V
> > bits     = number of output bits
> 
> When implementing KDFs as an extension of the kernel crypto API's RNG
> facility we currently have to handle the limitiation of the existing
> API. The label/context data (and when considering RFC 5869 HKDF
> requring IKM, salt and  additional information as input) currently
> cannot directly be communicated  through the API.
> 
> The issue is that the RNG facility currently has the following
> prototype defined:
> 
> int (*generate)(struct crypto_rng *tfm,
>                         const u8 *src, unsigned int slen,
>                         u8 *dst, unsigned int dlen);
> 
> The src pointer would need to take the label/context data.

That's probably good enough.  For both KDFa and KDFe the label contextU
and ContextV are concatenated, so in both cases a single source is
probably good enough.  However, we also need to feed in the key somehow
since it's usually used separately in the derivation functions.

> Would it be appropriate, to implement a type cast to a structure from
> the u8 pointer?
> 
> E.g. for the aforementioned label/context data, we could define
> something like
> 
> struct crypto_kdf_ctr {
> 	char *label;
> 	size_t label_len;
> 	u8 *contextU;
> 	size_t contextU_len;
> 	u8 *contextV;
> 	size_t contextV_len;
> };
> 
> And the implementation of the generate function for CTR KDF would
> then have a  type cast along the following lines:
> 
> 	if (slen != sizeof(struct crypto_kdf_ctr))
> 		return -EINVAL;
> 	const struct crypto_kdf_ctr *kdf_ctr_input = (struct
> crypto_kdf_ctr *)src;
> 
> 
> For different KDFs, different structs would be needed.

Actually, we probably just need the input key (or secret material), the
concatenation and the number of output bits.

James

