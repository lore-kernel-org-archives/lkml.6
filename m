Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B90C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879421530
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Hd40LPVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2879421530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeHPAvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:51:06 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36064 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbeHPAvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:51:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DDAED8EE171;
        Wed, 15 Aug 2018 14:57:04 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R5woCJqv8l1G; Wed, 15 Aug 2018 14:57:04 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 154388EE0C9;
        Wed, 15 Aug 2018 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534370224;
        bh=TqQbqJR0ANJT2mQC7WZUjdk4Bd030CgxNVupgTVJRaI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Hd40LPVvwvAScoUIM0ME8ae2J0XogIGSJ6EhmnqmHGivYBSCXDNAW3ScRYiHr1cxK
         /hc8yhSjMA9VYd9RgWvAc+LvEmfVt47KGgWqnN3pX0xKRrK6dHW37mG3ACpJAYres+
         RJ/PQe6dr3Ko5queMwkIcnNwLUefznSbISPJHVBE=
Message-ID: <1534370222.4049.25.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Yannik Sembritzki <yannik@sembritzki.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Wed, 15 Aug 2018 14:57:02 -0700
In-Reply-To: <20180815215240.GA15952@redhat.com>
References: <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
         <1ca6772b-46e0-9d93-0e15-7cf73a0b7b3f@sembritzki.me>
         <1534367597.4049.21.camel@HansenPartnership.com>
         <20180815215240.GA15952@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 17:52 -0400, Vivek Goyal wrote:
> On Wed, Aug 15, 2018 at 02:13:17PM -0700, James Bottomley wrote:
> > On Wed, 2018-08-15 at 23:08 +0200, Yannik Sembritzki wrote:
> > > On 15.08.2018 22:47, Linus Torvalds wrote:
> > > > It basically says: we don't allow modules that weren't built
> > > > with
> > > > the kernel. Adding a new key later and signing a module with it
> > > > violates that premise.
> > > 
> > > Considering the following scenario:
> > > A user is running a distro kernel, which is built by the distro,
> > > and has the distro signing key builtin (i.e. fedora). Now, the
> > > user has taken ownership of their system and provisioned their
> > > own platform key. Accordingly, the user signs the distro kernel
> > > with their own key.
> > > 
> > > If I understand you correctly, modules signed by the users own
> > > key, but not signed with the distro key, will stop working in
> > > this case?
> > 
> > They never actually would have worked, but yes.
> > 
> > > IMO, this is not okay. The layer of trust should extend from the
> > > bottom (user-provisioned platform key) up. Only trusting the
> > > kernel builtin key later on (wrt. kernel modules) contradicts
> > > this principal.
> > 
> > The kernel can't tell whether the UEFI user has taken ownership or
> > not so it has no basis on which to make a decision to trust the
> > UEFI keys or not, so we should *always* not trust them.
> > 
> > Consider a UEFI system for which a user has taken ownership, but
> > which has some signed ROMs which are UEFI secure boot
> > verified.  Simply to get their system to boot the user will be
> > forced to add the ODM key to the UEFI db ... and I'm sure in that
> > situation the user wouldn't want to trust the ODM key further than
> > booting.
> 
> IIUC, it is fine to trust these ODM keys, User keys and "foo" keys
> for loading kernel but not for modules?

It's fine to trust the secure boot keys for the boot environment.  If
you argue kexec is linux booting linux then yes, that's a supported
use.

>  If yes, then atleast we can enable trusting keys in
> .secondary_trusted_keys keyring for kernel signature verificaton and
> that will solve the kexec/kdump issue on distribution kernels.

I think it's OK ... I can't think of any reason you'd want a signed
kernel to boot but not to be able to kexec to a kernel with the same
signer.

James

