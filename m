Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA71EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715FA21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715FA21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389472AbeHPQuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:50:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388977AbeHPQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:50:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1FE5406E885;
        Thu, 16 Aug 2018 13:51:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00C5616870;
        Thu, 16 Aug 2018 13:51:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
References: <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com> <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com> <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com> <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me> <20180815194932.GD29541@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
        yannik@sembritzki.me, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform keys to boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20627.1534427487.1@warthog.procyon.org.uk>
Date:   Thu, 16 Aug 2018 14:51:27 +0100
Message-ID: <20628.1534427487@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 16 Aug 2018 13:51:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 16 Aug 2018 13:51:31 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > I see that module signing code trusts only builtin keys and
> > not the keys in secondary_trusted_keys keyring.
> 
> This, I think, makes sense.
> 
> It basically says: we don't allow modules that weren't built with the
> kernel. Adding a new key later and signing a module with it violates
> that premise.

At the risk of starting another flamewar...

The problem with that is that it means you can't load third party modules -
such as the NVidia driver.  That's fine if you absolutely reject the right of
people to produce third party drivers for the Linux kernel and absolutely
require that they open and upstream their code if they want in.

One of the reasons *for* letting modules be loaded using UEFI keys is that
this allows you to load signed third-party drivers without needing to manually
re-sign your shim, grub and kernel.

But this is not something we can ask most ordinary users to do (not least
because of key material security) - and they would have to at least partially
repeat the process every time one of those components is upgraded.  One of the
jobs of a distribution is to insulate the ordinary user from this.

And before anyone says "well, the distribution should just build and sign
$THIRD_PARTY_MODULE", there are issues with that that potentially come with
lawyers attached.

Further, if you want to go down the route of restricting the use of UEFI keys
to load modules because that might allow someone to run hacked code, then you
also can't let kexec use UEFI keys because that would then be able to run
hacked code too.

As an alternative, though, maybe it would make sense to allow TPM-based keys
to be used to verify modules.  The problem there is that it doesn't prevent
the signing process from being interfered with on an already-hacked box.

David
