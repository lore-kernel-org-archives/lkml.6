Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A10C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D542170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="rQbCMtyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D542170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeI1I5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:57:18 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45749 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbeI1I5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:57:18 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3fb1e1b4;
        Fri, 28 Sep 2018 02:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=OsRjeCnSqYferUDKuV1z/bCdgLE=; b=rQbCMty
        YD+GA5gAdETZwbBXZTz31q/T4NsFMK+AFIe3YK6arMcgXPs42yDrN9EJVUnpWKTS
        h5HUv2GoI6iczR9Ytn/B2juepATrYNaBUJikzE4yd9iwFlC3cHs30S+3ojP0dtYj
        /BTqnV4Mrk2EsR5ja6FXlT3niIbBKnxU1ggv7MnBo9VjV5Mxum0lyIf5ahw2ej0k
        eQmjuhWPQVghCTDd9fR57zGPPeR774aL5OprkKOxzbS+I7+Ri9lAJ+iW/M+1Hjeo
        fVLpONXB94ILpwyrex1+B5h2xtO6OfipJpexqFX3meKdURCVZ1VfqCH5zuJrFZK+
        61pFcMOgczK8h5g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1429ebf7 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 28 Sep 2018 02:17:06 +0000 (UTC)
Date:   Fri, 28 Sep 2018 04:35:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
Message-ID: <20180928023546.GA20765@zx2c4.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180927182944.GA22921@gmail.com>
 <20180927213537.GA27576@zx2c4.com>
 <20180928011726.GA98113@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180928011726.GA98113@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Sep 27, 2018 at 06:17:27PM -0700, Eric Biggers wrote:
> So, Zinc will simultaneously replace the current crypto implementations, *and*
> be "orthogonal" and "separate" from all the crypto code currently maintained by
> Herbert?  You can't have your cake and eat it too...

The plan is for it to replace many uses of the crypto API where it makes
sense, but not replace uses where it doesn't make sense. Perhaps in the
long run, over time, its usage will grow to cover those cases too, or,
perhaps instead, Zinc will form a simple basis of software crypto
algorithms in whatever future API designs crop up. In other words, like
most changes in kernel development, things happen gradually, starting
with a few good cases, and gradually growing as the need and design
arise.

> I'm still concerned you're splitting the community in two.  It will be unclear
> where new algorithms and implementations should go.  Some people will choose
> Herbert and the current crypto API and conventions, and some people will choose
> you and Zinc...  I still don't see clear guidelines for what will go where.

I can try to work out some explicit guidelines and write these up for
Documentation/, if that'd make a difference for you. I don't think this
is a matter of "community splitting". On the contrary, I think Zinc will
bring communities together, inviting the larger cryptography community
to take an interest in improving the state of crypto in Linux. Either
way, the litmus test for where code should go remains pretty similar to
how it's been working so far. Are you tempted to stick it in lib/
because that fits your programming paradigm and because you think it's
generally useful? If so, submit it to lib/zinc/. Conversely, is it only
something used in the large array of options provided by dmcrypt, ipsec,
afalg, etc? Submit it to the crypto API.

If you think this criteria is lacking, I'm amenable to adjusting that
and changing it, especially as situations and designs change and morph
over time. But that seems like a fairly decent starting point.

> Please reach out to Herbert to find a sane solution
> crypto development without choosing "sides".

Please, don't politicize this. This has nothing to do with "sides". This
has to do with which paradigm makes sense for implementing a particular
algorithm. And everything that goes in Zinc gets to be used seamlessly
by the crypto API anyway, through use of the trivial stub glue code,
like what I've shown in the two commits in this series. Again, if it's
something that will work well as a direct function call, then it seems
like Zinc makes sense as a home for it.

With that said, I've reached out to Herbert, and we'll of course discuss
and reach a good conclusion together.

> Note that usage can change over time; a user that requires a
> single cipher could later need multiple, and vice versa.

I think this depends on the design of the driver and the style it's
implemented in. For example, I could imagine something like this:

   encrypt_stuff_with_morus(obj, key);

evolving over time to:

  if (obj->type == MORUS_TYPE)
    encrypt_stuff_with_morus(obj, key);
  else if (obj->type == AEGIS_TYPE)
    encrypt_stuff_with_aegis(obj, key);

On the other hand, if the developer has good reason to use the crypto
API's dynamic dispatch and async API and so forth, then perhaps it just
changes from:

  static const char *cipher_name = "morus";

to

  static const char *cipher_name_type_1 = "morus";
  static const char *cipher_name_type_2 = "aegis";

I can imagine both programming styles and evolutions being desirable for
different reasons.

> >   - It matches exactly what Andy Polyakov's code is doing for the exact
> >     same reason, so this isn't something that's actually "new". (There
> >     are paths inside his implementation that branch from the vector code
> >     to the scalar code.)
> 
> Matches Andy's code, where?  The reason you had to add the radix conversion is
> because his code does *not* handle it...

For example, check out the avx blocks function. The radix conversion
happens in a few different places throughout. The reason we need it
separately here is because, unlike userspace, it's possible the kernel
code will transition from 2^26 back to 2^64 as a result of the FPU
context changing.

As well, AndyP seems to like the idea of including this logic in the
assembly instead of in C, if I understood our discussions correctly, so
there's a decent chance this will migrate out of the glue code and into
the assembly properly, which is probably a better place for it.

> >   - It has been discussed at length with Andy, including what kinds of
> >     proofs we'll need if we want to chop it down further (to remove that
> >     final reduction), and why we both don't want to do that yet, and so
> >     we go with the full carrying for the avoidance of risk.
> 
> Sorry, other people don't know about your private discussions.  For the rest of
> us, why not add a comment to the code explaining what's going on?

That's a good idea. I can include some discussion about this as well in
the commit message that introduces the glue code, too, I guess? I've
been hesitant to fill these commit messages up even more, given there
are already so many walls of text and whatnot, but if you think that'd
be useful, I'll do that for v7, and also add comments.

> >   - We've proved its correctness with Z3, actually using an even looser
> >     constraint on digit size than what Andy mentioned to us, thus resulting
> >     in a stronger proof result. So we're certain this isn't rubbish.
> AFAICS actually it *is* rubbish, because your C code stores the accumulator as
> 64-bit integers whereas the asm code (at least, the 32-bit version) reads it as
> 32-bit integers.  That won't work correctly on big endian ARM.
> > There's no doubt about it, we've done our due-diligence here. 
> Apparently not, given that it's broken on big endian ARM.
> Of course, having bugs in code which you insist was proven correct
> + fuzzed doesn't exactly inspire trust.

What's with the snark? It's not rubbish. I'm not sure if you noticed it in
the development trees (both the WireGuard module tree and my kernel.org
integration tree for this patch), but the big endian ARM support was fixed
pretty shortly after I jumped the gun posting v6. Like, super soon after.
That, and other big endian fixes (on aarch64 as well) are already queued up
for v7. And now build.wireguard.com has more big endian running in CI.

> The details of the correctness proofs and fuzzing you claim to have done aren't
> explained, even in the cover letter; so for now we just have to trust you on
> that point.

"Claim to have done", "trust you on that point" -- I think there's no
reason to doubt the integrity of my "claims", and I don't appreciate the
phrasing that appears to call that into question.

Regardless, sure, we can expand the "wall-of-text" commit messages even
further, if you want, and include the verbatim Z3 scripts for reproduction.

> I understand that your standards are still as high or even higher than
> Herbert's, which is good; crypto code should be held to high standards!  But
> based on the evidence, I do worry there's a double standard going on where you
> get away with things yourself which you won't allow from others in Zinc.  It's
> just not honest, and it will make people not want to contribute to Zinc.
> Maintainers are supposed to be unbiased and hold all contributions to the same
> standard.

This is complete and utter garbage, and I find its insinuations insulting
and ridiculous. There is absolutely no lack of honesty and no double
standard being applied whatsoever. Your attempt to cast doubt about the
quality of standards applied and the integrity of the process is wholly
inappropriate. When I tell you that high standards were applied and that
due-diligence was done in developing a particular patch, I mean what I
say.

> We need "Zinc" to be Linux's crypto library, not "Jason's crypto library".

This very much is a project directed toward the benefit of the kernel in
a general sense. It's been this way from the start, and there's nothing
in its goals or plans to the contrary of that. Please leave this vague
and unproductive rhetoric aside.

Jason
