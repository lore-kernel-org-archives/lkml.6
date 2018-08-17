Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A492188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A492188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeHQL10 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:27:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbeHQL10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:27:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18265406E885;
        Fri, 17 Aug 2018 08:24:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A527810D18CA;
        Fri, 17 Aug 2018 08:24:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1534464451.22442.1.camel@HansenPartnership.com>
References: <1534464451.22442.1.camel@HansenPartnership.com> <1534435000.3166.9.camel@HansenPartnership.com> <1534432615.3166.5.camel@HansenPartnership.com> <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com> <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com> <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com> <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me> <20180815194932.GD29541@redhat.com> <20628.1534427487@warthog.procyon.org.uk> <30607.1534434597@warthog.procyon.org.uk> <18926.1534451480@warthog.procyon.org.uk>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, yannik@sembritzki.me,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform keys to boot
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Fri, 17 Aug 2018 09:24:53 +0100
Message-ID: <28088.1534494293@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 08:24:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 08:24:58 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > > As a step by step process, I agree.  However, I think we can
> > > automate it to the point where you install a package and it says
> > > "insert your yubikey" every time you upgrade the kernel
> > 
> > That's a very bad idea.  You train people to unlock their private key
> > on request.  It can be abused like one of those emails that tells you
> > that your account has been suspended - just follow the link and put
> > in your password please.
> 
> It's exactly the same process those of us who use yubikeys for gpg or
> ssh keys follow.  You insert your key, you activate the process that
> needs the key, it asks for you to confirm your key, you press the
> button and the operation gets performed.  Since it's what we as kernel
> developers do, I don't see why it's a bad idea for others.

You've completely missed the point.

You need to think from the PoV of an ordinary user.  Imagine the system does
an automatic upgrade and wants to upgrade the kernel.  It pops up a dialogue
box saying "please put in your yubikey and enter your password here"[**].  It
might do this on a regular basis - and you can be sure that some users at
least will become accustomed to just doing this when their computer tells them
too.  *That* is the problem.

Now they follow a link to a dodgy website that causes some code to be
downloaded and run.  *It* now pops up a dialogue box that looks exactly like
the kernel installer's dialogue that says "please put in your yubikey and
enter your password here".  But now we've trained those users to do this on
demand...

PEBKAC[*].

[*] Note that I'm not trying to slight ordinary users here, it's more a fact
    of psychology.  As a distribution, it's our responsibility to try and
    protect them as best we can - and training them to unthinkingly bypass the
    security mechanisms isn't in anyone's best interests.

[**] Note also that I've never actually used a yubikey[***], so I'm not sure
     whether it takes a password or has some other mechanism to unlock the
     key.

[***] We also don't want to require that someone buys and keeps track of a
      yubikey to be able to use, say, the NVidia driver with Fedora/RHEL.
      Using the TPM if installed would be preferable because it's harder to
      lose.

We also don't necessarily want to encourage ordinary users to fiddle with the
system key databases unless they really know what they are doing.  There've
been cases where doing this has bricked a machine because the BIOS is buggy.
Now I will grant, since you'll probably raise it if I don't;-), that this
might be a good reason *for* having our own third party signing key as we
could then build the key into our kernels.

But if they use a yubikey, they have to get the public key from there into the
system key list or possibly the yubikey has to be accessed by the bootloader.
The same for the TPM.

> > Further, you expose the unlocked key on a machine that might be
> > compromised.
> 
> No it doesn't; the point about using a yubikey (or any other HSM type
> thing) is that the key is shielded inside the module so you get a
> signature back and the key can't be compromised even if the machine is.

Yes, you do.  Note that I don't mean necessarily exposing the actual key
material, but you do have to make it available for use - which means someone
can then use it and there's a window in which it is available for that use.
If there wasn't, it would be useless.

> > No, you can't.  You might *think* that it is, but the signature
> > you're checking is after the image has being fiddled with by the key-
> > adder
> 
> Well, yes, you have to add a new signature to the combination. 
> However, you can always verify that the hash without the added key is
> the hash of the Red Hat supplied bzImage.

At what point would you do this?  You have to assume that your userspace tools
can be compromised unless they are also verified (signature/IMA).  No, this
needs to be done by the bootloader.

Sometimes I feel I've spent too much time talking to people about security and
their paranoia is rubbing off... ;-)

David
