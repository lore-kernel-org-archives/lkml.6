Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A7AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0315B21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="M1W58xaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0315B21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403972AbeHPR6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:58:48 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43368 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbeHPR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:58:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 06D5E8EE171;
        Thu, 16 Aug 2018 07:59:47 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gHKZfNQlFF6u; Thu, 16 Aug 2018 07:59:46 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 41BC38EE092;
        Thu, 16 Aug 2018 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534431586;
        bh=p5vmq23YstOfS1KfebH9fwWCi0fanc2JFLrWwpNsEF0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M1W58xaUhJ2u0XRoFTJKOzU48wKV4xwuNA8b9UnDp81nvBN0WhOvNdNNsyvmutBmd
         C1QsRqe7CmvBvYsni0QSZf31axqRBCORUEcJrD5JESagCnIZSQUdD1TVP3XJ6GiEJH
         U7RnzBkYBiAyWbO7PTcMZdk8HiLKv1wTCWw2glDM=
Message-ID: <1534431585.3166.4.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Yannik Sembritzki <yannik@sembritzki.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Thu, 16 Aug 2018 07:59:45 -0700
In-Reply-To: <25236.1534430630@warthog.procyon.org.uk>
References: <1534429345.3166.1.camel@HansenPartnership.com>
         <20180815185812.GC29541@redhat.com>
         <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com>
         <4911.1534421610@warthog.procyon.org.uk>
         <25236.1534430630@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 15:43 +0100, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > I've told you several times you can't use the secure boot keys for
> > any form
> > of trust beyond boot,
> 
> Yes - and you've been told several times that you're wrong.
> 
> As far as I can tell, you seem to think that whilst keys from the
> UEFI storage could be used to verify a hacked module, they couldn't
> be used to verify a hacked boot-time component (shim, grub, kernel,
> etc.).

I'm actually not talking about UEFI storage, just the UEFI secure boot
database.  I think we might come up with a viable model for adding keys
from a UEFI variable that isn't part of the secure boot database.

> However, if you can load a hacked module, you can very likely replace
> the shim, say, with a hacked one.  In fact, replacing the shim may be
> easier because modules are tied to their parent kernel in other ways
> besides the signing key, whereas a shim must be standalone.

I think our misunderstanding is around the granularity of security. 
You seem to be arguing that it's monolithic; that's true for compromise
(usually one compromise to anything breaks everything) but it's not
true for trust.  Trust goes in defined boundaries.  For the secure boot
keys that boundary ends after boot which is why trusting them into the
kernel runtime is wrong.

The reason for keeping this boundary is to do with the politics of
breaches.  If we get a breach to the secure boot boundary, Microsoft
and all the ODMs will help us hunt it down and plug it (They have no
option because Windows is threatened by any breach to that boundary). 
If we use the keys beyond the secure boot boundary and get a breach
that only affects our use case no-one will help us because no-one will
care.

> I will grant, however, that it I can understand a desire to reduce
> the attack surface by not trusting the UEFI keys beyond booting - but
> then you shouldn't use them for kexec *either*.

Depends whether you see kexec as a boot process or not, I think.

> > Personally, I don't see any use for the UEFI keys in the kernel
> > beyond kexec
> 
> Allowing you to load the NVidia module, say, into the kernel without
> the distribution having to build it in with the kernel.

How about I address that one in your invitation to a flamewar?

James

