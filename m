Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7C7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F042188D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Lx/HRHBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F042188D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHQTGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:06:13 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54972 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbeHQTGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:06:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 338CF8EE171;
        Fri, 17 Aug 2018 09:02:18 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rdz5phUXMpKZ; Fri, 17 Aug 2018 09:02:18 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 610378EE0C6;
        Fri, 17 Aug 2018 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534521737;
        bh=s/1pyiOUZr3GOycWX23OHZn6KBSZ6IrkCaxLp6KMy/g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Lx/HRHBFWDkLblvHM2hXI/2U0GrzEiJarFeK357uA77wQyfJfD8w7onNe1AWoSxmi
         uv7YhDjP3MeMsKArJRBVeDdb8Z1RFtROq9KsE/DYaeUhRkVyqfG2WqDkSl6hEiN0c+
         hswGnLayVgkbCFxtFQ3i3uD89EvkEMJY/QqgnwpI=
Message-ID: <1534521736.3994.13.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Justin Forbes <jforbes@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, yannik@sembritzki.me,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Fri, 17 Aug 2018 09:02:16 -0700
In-Reply-To: <CAFbkSA2qijHeycF7k4Bg0ePxdxj5nLX4CnXnbuqDzm6A0=2bUQ@mail.gmail.com>
References: <1534464451.22442.1.camel@HansenPartnership.com>
         <1534435000.3166.9.camel@HansenPartnership.com>
         <1534432615.3166.5.camel@HansenPartnership.com>
         <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
         <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <20628.1534427487@warthog.procyon.org.uk>
         <30607.1534434597@warthog.procyon.org.uk>
         <18926.1534451480@warthog.procyon.org.uk>
         <28088.1534494293@warthog.procyon.org.uk>
         <1534517883.3994.9.camel@HansenPartnership.com>
         <CAFbkSA2qijHeycF7k4Bg0ePxdxj5nLX4CnXnbuqDzm6A0=2bUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 10:42 -0500, Justin Forbes wrote:
> On Fri, Aug 17, 2018 at 9:58 AM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Fri, 2018-08-17 at 09:24 +0100, David Howells wrote:
[...]
> > > We also don't necessarily want to encourage ordinary users to
> > > fiddle with the system key databases unless they really know what
> > > they are doing.  There've been cases where doing this has bricked
> > > a machine because the BIOS is buggy. Now I will grant, since
> > > you'll probably raise it if I don't;-), that this might be a good
> > > reason *for* having our own third party signing key as we could
> > > then build the key into our kernels.
> > > 
> > > But if they use a yubikey, they have to get the public key from
> > > there into the system key list or possibly the yubikey has to be
> > > accessed by the bootloader. The same for the TPM.
> > 
> > For security reasons, a Yubikey should only be connected when you
> > need it to sign something.  The TPM you can assume is always
> > available.
> > 
> 
> This is absolutely correct, the important word here being *should*.
> The reality is, with weekly kernel updates and various uses of the
> Yubikey, the average user is just going to leave it connected. We can
> lay out best practices all we want, but it seems pretty obvious that
> most users go with convenient or default.  I really wish we could
> change that, but it is unlikely.  As a result, we have to make the
> convenient or default path also fairly secure.

Imagining the worst scenario with the most stupid user doesn't prove
anything.  We have sensible users who want to achieve security.  Our
job is to design processes that help them with that goal.  Just because
someone could do something stupid is no excuse for not helping the
sensible users.  I admit this "design usable processes to help sensible
users with security" is hard (it's the reason why we've never been able
to deploy the TPM successfully for the majority of users) but they're
not impossible.

Why don't I tell you how it currently works here so you can see how
easily it would slot into a cloud deployment process?  We're designing
CI/CD images for physical systems (i.e. images that are immutable, like
those of containers).  The signing occurs in a special secure area
using a code signing service (so we don't even use a local key dongle)
after the image has been tested in the DevOps cycle.  Today, because
the image is immutable, the initrd it built to support all the cloud
physical systems and thus it can actually be linked in to the bzImage
and the entire thing signed, which solves the initrd security problem
neatly for us.  Linking a key into the bzImage as well is a trivial
addition for us, as you can see.  For us, by the way, you can also see
that providing a key in the initrd would work fine as well.

Since our images are immutable, we don't allow automatic updates.  Even
for mutable images they're a huge security and downtime risk in a cloud
environment because you just don't know what impact they'll have
without testing them.  So even before we moved to immutable images, the
process has always been to disable updates, test out the distro
proposed update first and then deploy if all tests pass.

I'm fairly certain all cloud providers have similar processes.

If we can run this process at industrial scale, there's no reason a
simpler version can't be designed for a user to follow.

James

