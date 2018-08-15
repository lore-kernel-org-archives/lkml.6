Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21599C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10D921557
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="seSTvXe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10D921557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeHOXrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:47:05 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35548 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbeHOXrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:47:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 188118EE171;
        Wed, 15 Aug 2018 13:53:17 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ql1yjkpTFri6; Wed, 15 Aug 2018 13:53:16 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4ACD28EE0C9;
        Wed, 15 Aug 2018 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534366396;
        bh=wXNx8GgRIfTPfp2DDyff1hQOYdpU/He0x5Lfq9Avd4g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=seSTvXe0WPCfWfxqN5ofg7fb6JgrcrtsMOq96GuZg/gPtLw/rkGeQAuDyRrpE4NeP
         UAYE8uTbGRW7VjowcvDUzleOS9aXrTs0DUAX8npyrT+RXehPpIGM7lE8uPedaYyN1y
         ifgu0OAV9YKIi0HM1+5mqQjZiS8VvA2enAicQY/I=
Message-ID: <1534366395.4049.19.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     yannik@sembritzki.me, David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Wed, 15 Aug 2018 13:53:15 -0700
In-Reply-To: <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
References: <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 13:47 -0700, Linus Torvalds wrote:
> On Wed, Aug 15, 2018 at 12:49 PM Vivek Goyal <vgoyal@redhat.com>
> wrote:
> > 
> > I see that module signing code trusts only builtin keys and
> > not the keys in secondary_trusted_keys keyring.
> 
> This, I think, makes sense.
> 
> It basically says: we don't allow modules that weren't built with the
> kernel. Adding a new key later and signing a module with it violates
> that premise.

Yes, the point is about layers of trust.  The UEFI secure boot keys for
a standard (i.e. system where the user hasn't taken ownership) contain
Microsoft and some ODM vendor keys.  You're forced to trust these keys
in the boot (or reboot) environment because that's consistent with the
way windows operates (any breach and microsoft will get annoyed and
help us sort it out).  You can't trust them for other kernel key
operations because that's outside the boot environment trust boundary
and if something goes wrong (say someone at an ODM signs a malicious
linux kernel module because the ODM keys are trusted to sign modules)
Microsoft won't care and we'll be on our own with no real ability to
sort it out.

James

