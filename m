Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85339C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309A0214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QcfJKGB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfAIGto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:49:44 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57864 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728661AbfAIGtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:49:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AB8AE8EE42E;
        Tue,  8 Jan 2019 22:49:42 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uSz0yw9A6AXl; Tue,  8 Jan 2019 22:49:42 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 677488EE0CD;
        Tue,  8 Jan 2019 22:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1547016582;
        bh=rx1ugEx3ULVlECKMgaFtIKDCEPUSpjyVteqxFlTEEcY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QcfJKGB5qZ8B5xcsILKEiE4q0RGYeuYj76dinspBpo4BHmzVHXr0BbzTtAwpZByNS
         MYZSjdZlJ5U5DZArSZfgfRyzfn1YQK7myF0Ie/WsjvxsKE3O1Oz6QS0GCS79GRZMVb
         cxUjSAy0LKATqIox8swVz/9ODdPNlPk0nXELLAjE=
Message-ID: <1547016579.2789.17.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andy Lutomirski <luto@kernel.org>,
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
        Jann Horn <jannh@google.com>
Date:   Tue, 08 Jan 2019 22:49:39 -0800
In-Reply-To: <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
References: <20190103143227.9138-1-jlee@suse.com>
         <4499700.LRS4F2YjjC@tauon.chronox.de>
         <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
         <1565399.7ulKdI1fm5@tauon.chronox.de>
         <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
         <1546994671.6077.10.camel@HansenPartnership.com>
         <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 17:43 -0800, Andy Lutomirski wrote:
> [Adding Jarkko because this stuff relates to the TPM.]
> 
> On Tue, Jan 8, 2019 at 4:44 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Tue, 2019-01-08 at 15:54 -0800, Andy Lutomirski wrote:
> > > > On Jan 7, 2019, at 11:09 PM, Stephan Mueller <smueller@chronox.
> > > > de>
> > > > wrote:
> > > > 
> > > > Am Dienstag, 8. Januar 2019, 06:03:58 CET schrieb Herbert Xu:
> > > > 
> > > > Hi Herbert,
> > > > 
> > > > > Are we going to have multiple implementations for the same
> > > > > KDF? If not then the crypto API is not a good fit.  To
> > > > > consolidate multiple implementations of the same KDF, simply
> > > > > provide helpers for them.
> > > > 
> > > > It is unlikely to have multiple implementations of a KDF.
> > > > However, KDFs relate to hashes like block chaining modes to raw
> > > > block ciphers. Thus a KDF can be applied with different hashes.
> > > > 
> > > > My idea was to add template support to RNGs (because KDFs are
> > > > effectively a type of RNG since they produce an arbitrary
> > > > output from a fixed input). The KDFs would be a template
> > > > wrapping hashes.  For example, the CTR-KDF from SP800-108 could
> > > > be instantiated like kdf-ctr(sha256).
> > > > 
> > > > 
> > > 
> > > I think that, if the crypto API is going to grow a KDF facility,
> > > it should be done right. Have a key type or flag or whatever that
> > > says “this key may *only* be used to derive keys using such-and-
> > > such algorithm”, and have a helper to derive a key.  That helper
> > > should take some useful parameters and mix them in:
> > > 
> > > - What type of key is being derived?  ECDSA signing key?  HMAC
> > > key?  AES key?
> > > 
> > > - Can user code access the derived key?
> > > 
> > > - What is the key’s purpose?  “Encrypt and authenticate a
> > > hibernation image” would be a purpose.
> > > 
> > > - Number of bytes.
> > > 
> > > All of these parameters should be mixed in to the key derivation.
> > > 
> > > Also, an AE key, even for AES+HMAC, should be just one derived
> > > key.  If you need 512 bits, ask for a 512-bit key, not two 256-
> > > bit keys.
> > 
> > Actually, it would be enormously helpful if we could reuse these
> > pieces for the TPM as well.  It has two KDFs: KDFa, which is the
> > CTR-KDF from SP800-108 and KDFe which is the SP800-56A KDF for
> > elliptic curve one pass Diffie Hellman, so if we're going to do the
> > former, I'd really like the latter as well.
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
> > 
> > Is that a good enough parametrisation (not the only way you
> > distinguish uses is with the label, which is not
> > recoverable)?  ContextU and ContextV are simply concatenated to
> > form the full Context of SP800-108, but we tend to need two
> > separate inputs (for KDFe they're the public x co-ordinates of the
> > points of the two inputs to ECDH for instance; in KDFa they're
> > usually the local and remote nonces).
> > 
> > The labels for TPM usage are things like "INTEGRITY" for HMAC keys
> > or "CFB" when generating an aes128-cfb session key. For KDFe, the
> > tpm seems to like the label "SECRET".  Although the TPM specifies
> > fixed short strings for the label, nothing prevents them being
> > longer like the purpose you state above (essentially we could mix
> > purpose, use and key type into the label and the contexts).
> > 
> 
> That really ought to cover anything the kernel needs.
> 
> But can you explain what's up with with KDFe?  The obvious searches
> end up with just warnings that the US currently has no government :(

You mean you can't find SP100-56A because NIST is a government entity
and it's discontinued its website because of the government shutdown? 
No idea, I only live here, you'll have to ask a real American.

ACM does have a copy:

http://delivery.acm.org/10.1145/2210000/2206270/SP800-56A_Revision1_Mar08-2007.pdf?ip=50.35.68.20&id=2206270&acc=OPEN&key=4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E6D218144511F3437&__acm__=1546993111_ed9c8bd24b2f838c829d428aac7f5d71

> Anyway, if we're talking about the TPM, it seems like the entire
> "trusted key" mechanism in the kernel is missing the point.  If I
> want to encrypt something like a hibernation image on a machine with
> a TPM, it makes essentially no sense to me that we would get a key
> with a known raw value that is merely TPM-backed (i.e. the "trusted
> key") and use that to decrypt the image.  The right way to do it is
> to the use the TPM as it was intended to be used: generate a single-
> use key that protects the hibernation image and seal *that* directly
> on the TPM, such that it can only be unsealed with appropriate PCR
> values.  Heck, we could even use one of the fancy NV counters such
> that we *can't* decrypt the image later on.  And using HMAC or any AE
> construction the normal way is also wrong -- we should *hash* the
> image and sign the hash directly on the TPM so that the restore code
> can validate the PCR values that were in place when the hibernation
> image was created.  [0]

Well, theoretically, trusted keys can be used for PCR sealed bundles,
at least in 1.2 ... I'm not sure the 2.0 one actually works because you
have to construct the policy session outside the kernel.

> In other words, I think that a kernel-based encrypted hibernation
> mechanism should create an image like this:
> 
> - wrapped key
> - instructions, if needed, for unwrapping

This sounds like the format we use for TPM resident keys, except it
would protect a TPM unseal bundle:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/tpm2-asn.h

> - hash of the entire image except the hash and signature fields
> - signature of the hash
> 
> and the remainder is a regular hiberation image that is encrypted
> against the key.  No AE is needed -- just encryption.  And there's no
> trampoline, no weird per-page hashing, etc.  Of course, this also
> means that someone needs to audit the hibernation restore code to
> make sure that there's no way for a malicious image to gain code
> execution over the restoring kernel before the verification even
> runs.  Or some much more complicated hash can be used that supports
> incremental verification.
> 
> 
> (Also, do we have a sensible story of how the TPM interacts with
> hibernation at all?

Not really, no ... there is a TPM patch for LUKS, but trusted keys are
unused within the kernel.

>   Presumably we should at least try to replay the PCR operations that
> have occurred so that we can massage the PCRs into the same state
> post-hibernation.  Also, do we have any way for the kernel to sign
> something with the TPM along with an attestation that the signature
> was requested *by the kernel*?  Something like a sub-hierarchy of
> keys that the kernel explicitly prevents userspace from accessing?)

We're just growing that now with the TPM asymmetric operations.
Attesting that the kernel requested the signature is harder.  The TPM
can attest to log entries (as it does for the UEFI log and IMA) and it
can certify keys, but that only proves they're TPM resident not who the
requestor was.  Effectively the latter is an assertion about who knows
the key authority, which is hard to prove.

> [0] If you take some data, run it through an authenticated encryption
> algorithm, and sign (key, nonce, tag), I think you're operating
> outside of the accepted security definitions if you expect this to
> guarantee that the data wasn't tampered with.  I'm reasonably
> confident that there are quite a few excellent AE algorithms that
> completely fail if used this like this.  In fact, pretty much all of
> the modern fast ones probably fail.  AE is for when the key is
> *secret*.

Well, I think here, if we were actually trying to solve the problem of
proving the hibernated image were the same one we would need to prove
some log of the kernel operation came to a particular value *after* the
hibernated image were restored ... it's not really possible to
condition key release which must occur before the restore on that
outcome, so it strikes me we need more than a simple release bound to
PCR values.


James

