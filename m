Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C0EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07410208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07410208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbeHPRmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:42:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387985AbeHPRmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:42:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDFC7818F04C;
        Thu, 16 Aug 2018 14:43:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 606F72142F21;
        Thu, 16 Aug 2018 14:43:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1534429345.3166.1.camel@HansenPartnership.com>
References: <1534429345.3166.1.camel@HansenPartnership.com> <20180815185812.GC29541@redhat.com> <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com> <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <20180815174247.GB29541@redhat.com> <4911.1534421610@warthog.procyon.org.uk>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
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
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform keys to boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25235.1534430630.1@warthog.procyon.org.uk>
Date:   Thu, 16 Aug 2018 15:43:50 +0100
Message-ID: <25236.1534430630@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 16 Aug 2018 14:43:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 16 Aug 2018 14:43:55 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> I've told you several times you can't use the secure boot keys for any form
> of trust beyond boot,

Yes - and you've been told several times that you're wrong.

As far as I can tell, you seem to think that whilst keys from the UEFI storage
could be used to verify a hacked module, they couldn't be used to verify a
hacked boot-time component (shim, grub, kernel, etc.).

However, if you can load a hacked module, you can very likely replace the
shim, say, with a hacked one.  In fact, replacing the shim may be easier
because modules are tied to their parent kernel in other ways besides the
signing key, whereas a shim must be standalone.

I will grant, however, that it I can understand a desire to reduce the attack
surface by not trusting the UEFI keys beyond booting - but then you shouldn't
use them for kexec *either*.

> Personally, I don't see any use for the UEFI keys in the kernel beyond
> kexec

Allowing you to load the NVidia module, say, into the kernel without the
distribution having to build it in with the kernel.

David
