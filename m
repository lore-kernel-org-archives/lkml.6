Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC2CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB61214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB61214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbeHPXcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:32:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbeHPXcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:32:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8964F40201C4;
        Thu, 16 Aug 2018 20:31:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6203E20180F8;
        Thu, 16 Aug 2018 20:31:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1534435000.3166.9.camel@HansenPartnership.com>
References: <1534435000.3166.9.camel@HansenPartnership.com> <1534432615.3166.5.camel@HansenPartnership.com> <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com> <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com> <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com> <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me> <20180815194932.GD29541@redhat.com> <20628.1534427487@warthog.procyon.org.uk> <30607.1534434597@warthog.procyon.org.uk>
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
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18925.1534451480.1@warthog.procyon.org.uk>
Date:   Thu, 16 Aug 2018 21:31:20 +0100
Message-ID: <18926.1534451480@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 16 Aug 2018 20:31:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 16 Aug 2018 20:31:25 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> As a step by step process, I agree.  However, I think we can automate
> it to the point where you install a package and it says "insert your
> yubikey" every time you upgrade the kernel

That's a very bad idea.  You train people to unlock their private key on
request.  It can be abused like one of those emails that tells you that your
account has been suspended - just follow the link and put in your password
please.

Further, you expose the unlocked key on a machine that might be compromised.

> Mehmet's patches don't require building a new kernel.  They merely
> require the added key be linked into the Red Hat built bzImage and then
> the resulting blob be signed.  You can still identify that the original
> bzImage is the Red Hat one.

No, you can't.  You might *think* that it is, but the signature you're
checking is after the image has being fiddled with by the key-adder - and that
means there's a window in which someone else can fiddle with the image too.

Mehmet's patches make sense from the reproducible kernel build PoV, but don't
actually help with the security so much since they're replacing, say, a RH
generated key with one you've generated locally, likely on the box that you
don't necessarily trust.

The bootloader would need to check the kernel image with the keys and the
image with the keys stripped off.  And if you're doing that, it doesn't make
sense to modify the kernel image, but rather load the keys separately,
possibly by an initrd=-like option on the bootloader or in your initrd.

> > That's the problem is right there.  AIUI, we *don't* want to set up a
> > third party signing process.  As I said, it potentially comes with lawyers
> > attached.
> 
> Right so generate a business pressure to overcome the legal one.

No.  We *really* don't want to do this, and the legal reasons are minor ones
like people suing us for GPL infringement[*] or because we said no.

The primary reason is that we aren't willing to just rubber stamp any old
kernel module.  The signature is, in effect, a certification.  We'd be putting
our name to something and we would want to be absolutely sure we know what it
does, review all the sources and have thoroughly tested it internally - and
we'd have to be willing to support it to some extent.  That takes a lot of
resources - and also requires the module vendor to be willing to open up their
sources to us.

We also don't want to sign the keys of third party vendors because then we
give away a certain degree of control over whatever they do with that, though
we would have the option of blacklisting it - after the fact.

[*] I've had people demand the transient private keys for Fedora kernels under
    the GPL.  They didn't seem to like the answer that I couldn't give them
    those keys because no one had them anymore; they seemed to think that this
    in some way violated their rights under the GPL.

David
