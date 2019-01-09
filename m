Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D73C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2700820859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="x6rz9ciR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfAITqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:46:33 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49248 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbfAITqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:46:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A1D808EE444;
        Wed,  9 Jan 2019 11:46:31 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y7TAdiiNjhAu; Wed,  9 Jan 2019 11:46:31 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ACA868EE092;
        Wed,  9 Jan 2019 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1547063191;
        bh=ci5X5OXB50OlpLNpDIBXsEIikEeMcUNtGrVO1/LbG00=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=x6rz9ciRNJ73kpuCy1wke8UbKUXUkmP6lAvPwASBTwIPJccOBwm8L76ri3Kx2QNWJ
         YoSbbkL/VKR1XVhtHcPF1kPW6ov8XeLpPlh5N3qpliITWV+FAgfIta0qZiWUrB9Rs5
         PrkXNh/3mUpyzf6ocGXLxtjVefABgu9ihBtS3tg4=
Message-ID: <1547063189.2879.47.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stephan Mueller <smueller@chronox.de>,
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
Date:   Wed, 09 Jan 2019 11:46:29 -0800
In-Reply-To: <CALCETrWoSAf4hHCXvqVZhQ5YAMBaZzaBCfnb6sC8JPrSs6FRog@mail.gmail.com>
References: <20190103143227.9138-1-jlee@suse.com>
         <4499700.LRS4F2YjjC@tauon.chronox.de>
         <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
         <1565399.7ulKdI1fm5@tauon.chronox.de>
         <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
         <1546994671.6077.10.camel@HansenPartnership.com>
         <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
         <1547016579.2789.17.camel@HansenPartnership.com>
         <CALCETrWoSAf4hHCXvqVZhQ5YAMBaZzaBCfnb6sC8JPrSs6FRog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 10:34 -0800, Andy Lutomirski wrote:
> > > On Jan 8, 2019, at 10:49 PM, James Bottomley <James.Bottomley@han
> > > senpartnership.com> wrote:
> > > 
> > > On Tue, 2019-01-08 at 17:43 -0800, Andy Lutomirski wrote:
> > > [Adding Jarkko because this stuff relates to the TPM.]
> > > Anyway, if we're talking about the TPM, it seems like the entire
> > > "trusted key" mechanism in the kernel is missing the point.  If I
> > > want to encrypt something like a hibernation image on a machine
> > > with a TPM, it makes essentially no sense to me that we would get
> > > a key with a known raw value that is merely TPM-backed (i.e. the
> > > "trusted key") and use that to decrypt the image.  The right way
> > > to do it is to the use the TPM as it was intended to be used:
> > > generate a single-use key that protects the hibernation image and
> > > seal *that* directly on the TPM, such that it can only be
> > > unsealed with appropriate PCR values.  Heck, we could even use
> > > one of the fancy NV counters such that we *can't* decrypt the
> > > image later on.  And using HMAC or any AE construction the normal
> > > way is also wrong -- we should *hash* the image and sign the hash
> > > directly on the TPM so that the restore code can validate the PCR
> > > values that were in place when the hibernation image was
> > > created.  [0]
> > 
> > Well, theoretically, trusted keys can be used for PCR sealed
> > bundles, at least in 1.2 ... I'm not sure the 2.0 one actually
> > works because you have to construct the policy session outside the
> > kernel.
> 
> I suppose I should go read the 2.0 spec. I’ve read the 1.2 spec, but
> I always assumed that 2.0 was essentially a superset of 1.2
> functionality.

It was sold as an incremental upgrade, but in practice, adding crypto
agility and flexible policy (the main 2.0 enhancements) meant that the
API is redically different.

> > >  Presumably we should at least try to replay the PCR operations
> > > that have occurred so that we can massage the PCRs into the same
> > > state post-hibernation.  Also, do we have any way for the kernel
> > > to sign something with the TPM along with an attestation that the
> > > signature was requested *by the kernel*?  Something like a sub-
> > > hierarchy of keys that the kernel explicitly prevents userspace
> > > from accessing?)
> > 
> > We're just growing that now with the TPM asymmetric operations.
> > Attesting that the kernel requested the signature is harder.  The
> > TPM can attest to log entries (as it does for the UEFI log and IMA)
> > and it can certify keys, but that only proves they're TPM resident
> > not who the requestor was.  Effectively the latter is an assertion
> > about who knows the key authority, which is hard to prove.
> 
> Can the kernel filter TPM 2.0 operations?

There is a proposal for this, but the proposal is on the operations by
type, not the content.  Meaning we can't really police loading and
using a kernel key because we can't distinguish whether any key is a
kernel key.  We can't forbid all key load operations to non-kernel
because that removes most of the TPM usefulness as a keystore.

>   If so, then a signature that the kernel would have prevented user
> code from generating is de facto an attestation that the kernel
> generated it (or that the kernel was compromised, which is sort of
> equivalent).

The TPM's idea of this is it polices by authorization.  Now one of the
things we can do here is add what's called locality based
authorization.  we have three non-uefi localities to play with and we
could enforce walling one off for the kernel only to use, so a kernel
key could come with a policy requiring use of the kernel locality for
use of the key.  That would give you an effective guarantee that only
the kernel could use this key.  Note the enforcement of locality would
require a key policy, which is easy for TPM 1.2, but requires the use
of a policy session for TPM 2.0 which means we'd have to improve our
policy session handling.

> > > [0] If you take some data, run it through an authenticated
> > > encryption algorithm, and sign (key, nonce, tag), I think you're
> > > operating outside of the accepted security definitions if you
> > > expect this to guarantee that the data wasn't tampered with.  I'm
> > > reasonably confident that there are quite a few excellent AE
> > > algorithms that completely fail if used this like this.  In fact,
> > > pretty much all of the modern fast ones probably fail.  AE is for
> > > when the key is *secret*.
> > 
> > Well, I think here, if we were actually trying to solve the problem
> > of proving the hibernated image were the same one we would need to
> > prove some log of the kernel operation came to a particular value
> > *after* the hibernated image were restored ... it's not really
> > possible to condition key release which must occur before the
> > restore on that outcome, so it strikes me we need more than a
> > simple release bound to PCR values.
> 
> I’m not sure I follow. Here are the two properties I’d like to see:
> 
> 1. If you have an encrypted hibernation image, the only thing you
> should be able to do with it is to restore it. So only an actual
> Linux kernel in hibernation restore mode ought to be able to restore
> it.  We get this if the image can only be read with appropriate PCRs
> and then only by the kernel.  This way, you can’t just read out
> secrets from the image if you steal a laptop — you have to actually
> boot the thing.

Right, this we can do and if you use a TPM sealed encryption key, you
can guarantee the image will only restore on the same physical system. 
You don't need PCRs for this, just the TPM and the locality
enforcement.

Note if someone has your laptop and the ability to boot their own
kernels, they could always corrupt the kernel into decrypting the image
or giving you the unsealed key, but there's no real way of preventing
that even with PCR sealing or lockdown, so the basis for the threat
model is very much my laptop in my possession running my kernel.

> 2. You shouldn’t be able to create an intentionally corrupt image
> that pwns you when you restore it unless you have already pwned the
> kernel.

So here there's a problem: the policy stated above governs key *use*
not key creation, so anyone can create a key that has a locality
restriction.  The way to guarantee that the key was created by
something that has access to the locality is to have a parent key with
a locality use policy (key creation requires parent key use
authorization).  Which means every system would have to create a
persistent parent key for the kernel to use (the kernel could do this
and it could be made NV resident for persistence, so it's not
impossible, just complicated).

> Maybe the “kernel” bit in #1 can be relaxed to “root” without totally
> defeating the purpose, but if some random non-root process that
> happens to have access to /dev/tpm* can make a valid-looking TPM
> image, then I think we fail.  Limiting it to the kernel is only
> dubiously better than limiting it to root until we implement
> lockdown, in which case it's important.
> 
> #2 only really matters with lockdown.
> 
> I suppose that a good summary of my opinion is that there is no point
> to kernel support for encrypted hibernation images until lockdown is
> upstream.

I really don't think lockdown helps.  If we implement locality
isolation for the kernels use of keys, a properly functioning kernel
isn't going to be tricked into releasing one of its keys to userspace. 
A buggy kernel might be exploited to cause it to give one up but that
would happen irrespective of lockdown and, of course, all bets are off
if the attacker can boot their own kernel.

James

