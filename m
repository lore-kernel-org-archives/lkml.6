Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5EDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3269A20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546998251;
	bh=Os7GiwN54DZ3wpzOMLgn+usmROqaPalWDiPuh4BLhqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sr2OitFmHB1HFZx4Qcwkgy0BIQUV2HVYgutc9/NRnj7H7eP7ForlsHuJoN/9R3t5w
	 KjNcLx7UsiXWAQdZnEU3yKuuJdcqHaz15uQK0r65r4hRUggFOyzrfPM9+aMwlBovOL
	 atUIKwgHvxDWmKyY8rkRRVjlsT/tmF0SabuWoRRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfAIBoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:44:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbfAIBoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:44:10 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463DD21872
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 01:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546998248;
        bh=Os7GiwN54DZ3wpzOMLgn+usmROqaPalWDiPuh4BLhqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e1qFIB9yCcPEYwy6JnsUcr/14KMNc+tnnMYNcqmflfxWZXBEyIxE6br1uwbt+mi/4
         h4qjof7xwG9xkVl/QOMOGYn+Vd5WJiGZ335KRZQvghcGIPTBHqg4Z2HFoGh1hxP7ox
         IEtdpxEkKxuMpd3dxS0oOZRSwChpwP4JRUTIN3/4=
Received: by mail-wm1-f50.google.com with SMTP id y185so9754621wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 17:44:08 -0800 (PST)
X-Gm-Message-State: AJcUukcAc8qCKuEuIf2ZvW6CfpEIL34AuqTNDQAWNGxeQMaJaAWXsKcj
        +pGp8fwXODfv3LpZbToxLQF6W67lnoIdmDOfc5kTLw==
X-Google-Smtp-Source: ALg8bN6+zMOeJF3K50ChwcL9s744NFPbi+GEqtQTG2F01i5DCD7WCzhGBzHCo7vCka3w2mG0350XTqLHqocS+vSPeRU=
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr3768087wmk.74.1546998246556;
 Tue, 08 Jan 2019 17:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20190103143227.9138-1-jlee@suse.com> <4499700.LRS4F2YjjC@tauon.chronox.de>
 <20190108050358.llsox32hggn2jioe@gondor.apana.org.au> <1565399.7ulKdI1fm5@tauon.chronox.de>
 <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net> <1546994671.6077.10.camel@HansenPartnership.com>
In-Reply-To: <1546994671.6077.10.camel@HansenPartnership.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 8 Jan 2019 17:43:53 -0800
X-Gmail-Original-Message-ID: <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
Message-ID: <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Jarkko because this stuff relates to the TPM.]

On Tue, Jan 8, 2019 at 4:44 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2019-01-08 at 15:54 -0800, Andy Lutomirski wrote:
> > > On Jan 7, 2019, at 11:09 PM, Stephan Mueller <smueller@chronox.de>
> > > wrote:
> > >
> > > Am Dienstag, 8. Januar 2019, 06:03:58 CET schrieb Herbert Xu:
> > >
> > > Hi Herbert,
> > >
> > > > Are we going to have multiple implementations for the same KDF?
> > > > If not then the crypto API is not a good fit.  To consolidate
> > > > multiple implementations of the same KDF, simply provide helpers
> > > > for them.
> > >
> > > It is unlikely to have multiple implementations of a KDF. However,
> > > KDFs relate to hashes like block chaining modes to raw block
> > > ciphers. Thus a KDF can be applied with different hashes.
> > >
> > > My idea was to add template support to RNGs (because KDFs are
> > > effectively a type of RNG since they produce an arbitrary output
> > > from a fixed input). The KDFs would be a template wrapping hashes.
> > > For example, the CTR-KDF from SP800-108 could be instantiated like
> > > kdf-ctr(sha256).
> > >
> > >
> >
> > I think that, if the crypto API is going to grow a KDF facility, it
> > should be done right. Have a key type or flag or whatever that says
> > =E2=80=9Cthis key may *only* be used to derive keys using such-and-such
> > algorithm=E2=80=9D, and have a helper to derive a key.  That helper sho=
uld
> > take some useful parameters and mix them in:
> >
> > - What type of key is being derived?  ECDSA signing key?  HMAC
> > key?  AES key?
> >
> > - Can user code access the derived key?
> >
> > - What is the key=E2=80=99s purpose?  =E2=80=9CEncrypt and authenticate=
 a hibernation
> > image=E2=80=9D would be a purpose.
> >
> > - Number of bytes.
> >
> > All of these parameters should be mixed in to the key derivation.
> >
> > Also, an AE key, even for AES+HMAC, should be just one derived
> > key.  If you need 512 bits, ask for a 512-bit key, not two 256-bit
> > keys.
>
> Actually, it would be enormously helpful if we could reuse these pieces
> for the TPM as well.  It has two KDFs: KDFa, which is the CTR-KDF from
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
> hashAlg  =3D the hash algorithm used as the PRF
> key      =3D the input parameter of variable bit size or
>            the x co-ordinate of the shared point
> label    =3D An ASCII string representing the use
> contextU =3D public input U
> contextV =3D public input V
> bits     =3D number of output bits
>
> Is that a good enough parametrisation (not the only way you distinguish
> uses is with the label, which is not recoverable)?  ContextU and
> ContextV are simply concatenated to form the full Context of SP800-108,
> but we tend to need two separate inputs (for KDFe they're the public x
> co-ordinates of the points of the two inputs to ECDH for instance; in
> KDFa they're usually the local and remote nonces).
>
> The labels for TPM usage are things like "INTEGRITY" for HMAC keys or
> "CFB" when generating an aes128-cfb session key. For KDFe, the tpm
> seems to like the label "SECRET".  Although the TPM specifies fixed
> short strings for the label, nothing prevents them being longer like
> the purpose you state above (essentially we could mix purpose, use and
> key type into the label and the contexts).
>

That really ought to cover anything the kernel needs.

But can you explain what's up with with KDFe?  The obvious searches
end up with just warnings that the US currently has no government :(

Anyway, if we're talking about the TPM, it seems like the entire
"trusted key" mechanism in the kernel is missing the point.  If I want
to encrypt something like a hibernation image on a machine with a TPM,
it makes essentially no sense to me that we would get a key with a
known raw value that is merely TPM-backed (i.e. the "trusted key") and
use that to decrypt the image.  The right way to do it is to the use
the TPM as it was intended to be used: generate a single-use key that
protects the hibernation image and seal *that* directly on the TPM,
such that it can only be unsealed with appropriate PCR values.  Heck,
we could even use one of the fancy NV counters such that we *can't*
decrypt the image later on.  And using HMAC or any AE construction the
normal way is also wrong -- we should *hash* the image and sign the
hash directly on the TPM so that the restore code can validate the PCR
values that were in place when the hibernation image was created.  [0]

In other words, I think that a kernel-based encrypted hibernation
mechanism should create an image like this:

- wrapped key
- instructions, if needed, for unwrapping
- hash of the entire image except the hash and signature fields
- signature of the hash

and the remainder is a regular hiberation image that is encrypted
against the key.  No AE is needed -- just encryption.  And there's no
trampoline, no weird per-page hashing, etc.  Of course, this also
means that someone needs to audit the hibernation restore code to make
sure that there's no way for a malicious image to gain code execution
over the restoring kernel before the verification even runs.  Or some
much more complicated hash can be used that supports incremental
verification.


(Also, do we have a sensible story of how the TPM interacts with
hibernation at all?  Presumably we should at least try to replay the
PCR operations that have occurred so that we can massage the PCRs into
the same state post-hibernation.  Also, do we have any way for the
kernel to sign something with the TPM along with an attestation that
the signature was requested *by the kernel*?  Something like a
sub-hierarchy of keys that the kernel explicitly prevents userspace
from accessing?)

[0] If you take some data, run it through an authenticated encryption
algorithm, and sign (key, nonce, tag), I think you're operating
outside of the accepted security definitions if you expect this to
guarantee that the data wasn't tampered with.  I'm reasonably
confident that there are quite a few excellent AE algorithms that
completely fail if used this like this.  In fact, pretty much all of
the modern fast ones probably fail.  AE is for when the key is
*secret*.
