Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A970BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F474208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CUKoKenV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F474208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392153AbeHPS4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:56:03 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43868 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729847AbeHPS4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:56:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6FBA48EE171;
        Thu, 16 Aug 2018 08:56:42 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3GDi7ZiU2t7Q; Thu, 16 Aug 2018 08:56:42 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 97A678EE092;
        Thu, 16 Aug 2018 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534435002;
        bh=aoYZPowDpNkzFGb2N+mrmS5Ih8SYCCRzM0hyP5ZUq7M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CUKoKenVKBvrEQZRF2EJuBOG57v9LOTOvJatGiDz6L9oBnnfXISjgKEAqwVgzDFUT
         zqM44vaBX63KigrAEHF/9R7aHFnkIapGJxr4Q9EtloWgoQMYBukZgLGuhiL+3w+q3Y
         lM2JKUgbFiRuGn1rp06Ycbhn86LQf0ztmVQ8n0iM=
Message-ID: <1534435000.3166.9.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, yannik@sembritzki.me,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Thu, 16 Aug 2018 08:56:40 -0700
In-Reply-To: <30607.1534434597@warthog.procyon.org.uk>
References: <1534432615.3166.5.camel@HansenPartnership.com>
         <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
         <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <20628.1534427487@warthog.procyon.org.uk>
         <30607.1534434597@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 16:49 +0100, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > > The problem with that is that it means you can't load third party
> > > modules - such as the NVidia driver.  That's fine if you
> > > absolutely reject the right of people to produce third party
> > > drivers for the Linux kernel and absolutely require that they
> > > open and upstream their code if they want in.
> > 
> > So if you build your own kernel and want to load the nVidia module,
> > you have the key to sign it.
> 
> I think you have to assume that doing this is beyond most people.

As a step by step process, I agree.  However, I think we can automate
it to the point where you install a package and it says "insert your
yubikey" every time you upgrade the kernel

>   Further, as a distribution we would prefer people didn't raise bugs
> against kernels that we didn't build.

Mehmet's patches don't require building a new kernel.  They merely
require the added key be linked into the Red Hat built bzImage and then
the resulting blob be signed.  You can still identify that the original
bzImage is the Red Hat one.

> > If you're a distribution and want third party modules to be loaded
> > you can set up a third party signing process using a distro key ...
> > I don't see what the big problem is.
> 
> That's the problem is right there.  AIUI, we *don't* want to set up a
> third party signing process.  As I said, it potentially comes with
> lawyers attached.

Right so generate a business pressure to overcome the legal one.  To be
honest that's what I believe happened at Microsoft: I'm sure their
lawyers initially said "no way" to being a third party signing
authority until their executives laid out the business cost of being
blamed for the first boot virus after having refused to implement
ecosystem protection for legal reasons.

> > So your lawyers tell you if you sign a third party module for your
> > kernel then you could get blamed for the damage it causes?
> 
> There's more to it than that, but I feel I should discuss it with our
> legal dept. before airing it here.

Sure; if you want me to be involved in the conversation I can do it
under NDA or whatever they require.

James

