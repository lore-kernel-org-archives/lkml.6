Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ADBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C202147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YSO3eAE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C202147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404029AbeHPSQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:16:04 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43508 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391877AbeHPSQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:16:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DFCAF8EE171;
        Thu, 16 Aug 2018 08:16:56 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ovPfXh5x0vpk; Thu, 16 Aug 2018 08:16:56 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1065E8EE092;
        Thu, 16 Aug 2018 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534432616;
        bh=1XdRa2zo6QUEKzEKJ039icJ2hrDv28NByK9+leFN4qY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YSO3eAE63/9pfglqPbENjhTqnTeRyo4PTZO0JijzvsR/pDJOXBePDg/TviO4umfoH
         aH393mPjhiLoBhVw00tuLp9Ix+SUxKXtbxnTpXxvbDoQKC+o0V4NsvadjINBmkuyQh
         TjjatEeh1ucQ65JvDwSDmbPO7x+O3qq2p85jMOy8=
Message-ID: <1534432615.3166.5.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, yannik@sembritzki.me,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Thu, 16 Aug 2018 08:16:55 -0700
In-Reply-To: <20628.1534427487@warthog.procyon.org.uk>
References: <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
         <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <20628.1534427487@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 14:51 +0100, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > > I see that module signing code trusts only builtin keys and
> > > not the keys in secondary_trusted_keys keyring.
> > 
> > This, I think, makes sense.
> > 
> > It basically says: we don't allow modules that weren't built with
> > the kernel. Adding a new key later and signing a module with it
> > violates that premise.
> 
> At the risk of starting another flamewar...

OK, I'll bite, I can be technically polite.

> The problem with that is that it means you can't load third party
> modules - such as the NVidia driver.  That's fine if you absolutely
> reject the right of people to produce third party drivers for the
> Linux kernel and absolutely require that they open and upstream their
> code if they want in.

So if you build your own kernel and want to load the nVidia module, you
have the key to sign it.  If you're a distribution and want third party
modules to be loaded you can set up a third party signing process using
a distro key ... I don't see what the big problem is.

> One of the reasons *for* letting modules be loaded using UEFI keys is
> that this allows you to load signed third-party drivers without
> needing to manually re-sign your shim, grub and kernel.

At the cost of compromising the security of the entire system by
trusting a key for a use beyond its purpose.  That's why this is a daft
idea.

What is the use case for this?  I think I addressed all the ones I can
think of above (own or distro kernel).  If Red Hat wants to allow the
nVidia module in its kernel it needs a third party module signing
process.

> But this is not something we can ask most ordinary users to do (not
> least because of key material security) - and they would have to at
> least partially repeat the process every time one of those components
> is upgraded.  One of the jobs of a distribution is to insulate the
> ordinary user from this.
> 
> And before anyone says "well, the distribution should just build and
> sign $THIRD_PARTY_MODULE", there are issues with that that
> potentially come with lawyers attached.

So your lawyers tell you if you sign a third party module for your
kernel then you could get blamed for the damage it causes?  So this
whole escapade is about Red Hat trying to evade legal responsibility
for allowing customers to load third party modules.

Firstly, your lawyers are wrong: Microsoft took a lot of legal advice
before they agreed to become the third party signing authority for
UEFI.  They definitely believe they can't be sued if they sign
something that later breaches UEFI security.  However, I realise trying
to overcome overly cautious legal advice is a no win situation, so lets
move on.

What I don't understand is Red Hat's objection to Mehmet's patches
which seem to achieve this goal in a much more secure way than trusting
the UEFI database.  They allow a user to inject their own key into the
kernel in a way that it's verified.  The price is relinking and
resigning the kernel, but that whole process can be automated, thus it
would seem to achieve the goal of insulating the customer from the
process as much as possible.  I mean it's a security process so they
need some type of private key handling process (say a dongle) that
they'd need to plug in to resign the kernel and plug in to sign the
third party module, but if they care about security it's likely not too
high a price for them to pay and if they don't care about security then
why do they want signed modules in the first place?

> Further, if you want to go down the route of restricting the use of
> UEFI keys to load modules because that might allow someone to run
> hacked code, then you also can't let kexec use UEFI keys because that
> would then be able to run hacked code too.

Depends: if the hacked code could be booted directly then its within
the secure boot trust boundary.

> As an alternative, though, maybe it would make sense to allow TPM-
> based keys to be used to verify modules.  The problem there is that
> it doesn't prevent the signing process from being interfered with on
> an already-hacked box.

Hey, I'm the TPM person, so I'd be happy with this.  However, you're
going to find that the TPM process for doing this is hard: the TPM is
designed to hide private keys, not really to certify public keys for
specific uses, which is what the kernel needs.  It's not that it can't
be done but the certification key will have to be setup somehow and
probably installed with a physical presence policy so an attacker can't
certify a key remotely.  By  the time we've worked out how to do all
that, it would likely have been much easier and quicker to use a
Yubikey to follow Mehmet's key insertion method.

James

