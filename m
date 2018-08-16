Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30241C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5DA20C07
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Q9yoCKAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5DA20C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeHPUO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:14:58 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44710 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728927AbeHPUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:14:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5A52C8EE171;
        Thu, 16 Aug 2018 10:15:13 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7XC4CR5n48mu; Thu, 16 Aug 2018 10:15:13 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 76E748EE092;
        Thu, 16 Aug 2018 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534439713;
        bh=dvLOWuwdU9754Ye3uLY4sFYi9HMiwhz26xL9QxMjaIw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q9yoCKAcEUQjAq9xsGGLzpODjGDfLs7vuC8k+UMYW80SkaI4HIz46LtJ8vVFwBJGs
         lCx1YWfOQSGxgrzhdxpMVsvtC8+k05ALyyaNHmIoYRhUC7kn29QsWuZTW7Dc+82tOm
         CC93FvWXFnjuVKmmIvvve8oBxW9KGR/5jgCaFpLo=
Message-ID: <1534439711.3166.13.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        "yannik@sembritzki.me" <yannik@sembritzki.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Thu, 16 Aug 2018 10:15:11 -0700
In-Reply-To: <b29ce8375b454440b7b019ac20cfe726@AcuMS.aculab.com>
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
         <1534435000.3166.9.camel@HansenPartnership.com>
         <b29ce8375b454440b7b019ac20cfe726@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 16:56 +0000, David Laight wrote:
> From: James Bottomley
> > Sent: 16 August 2018 16:57
> > On Thu, 2018-08-16 at 16:49 +0100, David Howells wrote:
> > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > 
> > > > > The problem with that is that it means you can't load third
> > > > > party modules - such as the NVidia driver.  That's fine if
> > > > > you absolutely reject the right of people to produce third
> > > > > party drivers for the Linux kernel and absolutely require
> > > > > that they open and upstream their code if they want in.
> > > > 
> > > > So if you build your own kernel and want to load the nVidia
> > > > module, you have the key to sign it.
> > > 
> > > I think you have to assume that doing this is beyond most people.
> > 
> > As a step by step process, I agree.  However, I think we can
> > automate it to the point where you install a package and it says
> > "insert your yubikey" every time you upgrade the kernel
> 
> What about 3rd parties that want to release drivers that can be
> loadedinto 'distribution' kernels?

You'd follow the distributions external kernel module process, I think.

> We can do that for windows (provided we've paid the 'driver signing
> tax') because windows has a stable kernel DDI/DKI.
> For Linux we have to release most of the driver as a binary 'blob'
> and compile wrapper code on the target system with the correct kernel
> headers.

Right, that's the usual distribution kernel module approach.  I'm most
familiar with the SUSE DKMS packaging project, which has a lot of
automation around this.  I believe it's actually pretty easy to use
from talking to people about it.  Of course, SUSE doesn't currently use
signed kernel modules, which makes the key issue a non problem for them
...

> There is no way we could generate signed copies for every
> 'distribution' kernel - even if there was a way to get them signed.
> Even if we agreed to make our source code available it wouldn't be
> accepted for inclusion in the kernel source tree.

Well, I think for signed kernel modules the DKMS process could be
adapted to generate a private key and then install the public component
in the kernel, resign with the private key, put the private key in the
MoK database and that means the DKMS process now has a key with which
it could sign any kernel module at the request of the user.  Of course
the main problem will be guarding the private key.

However, in the above process signing is under the control of the end
user.  I'm guessing you want signing to be under the control of an
external third party or the distro, like the Microsoft case?  In that
case you have to either persuade the distros to run a signing service
or persuade them to trust a third party to run it.

James

