Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00340C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8B0217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="tDYGI+El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfAIGpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:45:50 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:19603 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfAIGpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547016345;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=B1zNwFmFiIapFdpP8iyrcrMTZuXmB8nc0JU8vXd1krs=;
        b=tDYGI+ElFN1fidFf9flPNGZfVfjH58A0ajIE21VT/TfGeFFhtwdsx13P09Y+OL2qMM
        6GXGmmwQvj+8M3e3fVXQKJFvfOUGEytkLlLI6yAKvlhmZeT8XWqNvIMCPUx2Jpg4Bqnv
        speQielcDoPPitDspAXO9e5iTBJh4F40smvCZ/J7qVYh5qiyfGjm9mAmuwi1iybgVtsq
        gXH2JPI5LJXbcZtX/qg85ueXmmIUXZuhh9O3OpWMeUey1CoxnYfKHkBo508VXPMjuqVs
        thoUCl7wOVS8/lGfVPlOZ6kvYgElujAnJK2sQ0lgS3lxS7x6xoWapBO/utbrYD2jWG7W
        bl6w==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaLvSbdkg="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv096jLNs3
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 07:45:21 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
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
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date:   Wed, 09 Jan 2019 07:45:21 +0100
Message-ID: <309406107.k3W2fMQUza@tauon.chronox.de>
In-Reply-To: <1546994671.6077.10.camel@HansenPartnership.com>
References: <20190103143227.9138-1-jlee@suse.com> <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net> <1546994671.6077.10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 01:44:31 CET schrieb James Bottomley:

Hi James,

> Actually, it would be enormously helpful if we could reuse these pieces
> for the TPM as well. 

Could you please help me understand whether the KDFs in TPM are directly 
usable as a standalone cipher primitive or does it go together with additional 
key generation operations?

> It has two KDFs: KDFa, which is the CTR-KDF from
> SP800-108 and KDFe which is the SP800-56A KDF for elliptic curve one
> pass Diffie Hellman, so if we're going to do the former, I'd really
> like the latter as well.
> 
> The way the TPM parametrises input to both KDFs is
> 
> (hashAlg, key, label, contextU, contextV, bits)
> 
> Where
> 
> hashAlg  = the hash algorithm used as the PRF
> key      = the input parameter of variable bit size or
>            the x co-ordinate of the shared point
> label    = An ASCII string representing the use
> contextU = public input U
> contextV = public input V
> bits     = number of output bits

When implementing KDFs as an extension of the kernel crypto API's RNG facility 
we currently have to handle the limitiation of the existing API. The label/
context data (and when considering RFC 5869 HKDF requring IKM, salt and 
additional information as input) currently cannot directly be communicated 
through the API.

The issue is that the RNG facility currently has the following prototype 
defined:

int (*generate)(struct crypto_rng *tfm,
                        const u8 *src, unsigned int slen,
                        u8 *dst, unsigned int dlen);

The src pointer would need to take the label/context data.

Would it be appropriate, to implement a type cast to a structure from the u8 
pointer?

E.g. for the aforementioned label/context data, we could define something like

struct crypto_kdf_ctr {
	char *label;
	size_t label_len;
	u8 *contextU;
	size_t contextU_len;
	u8 *contextV;
	size_t contextV_len;
};

And the implementation of the generate function for CTR KDF would then have a 
type cast along the following lines:

	if (slen != sizeof(struct crypto_kdf_ctr))
		return -EINVAL;
	const struct crypto_kdf_ctr *kdf_ctr_input = (struct crypto_kdf_ctr *)src;


For different KDFs, different structs would be needed.

Ciao
Stephan


