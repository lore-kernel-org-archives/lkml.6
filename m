Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547EC21567
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YLcmDxts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547EC21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeHPAea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:34:30 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35964 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727327AbeHPAea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:34:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7C3ED8EE171;
        Wed, 15 Aug 2018 14:40:32 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ldwuwm48pETt; Wed, 15 Aug 2018 14:40:32 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A84658EE0C9;
        Wed, 15 Aug 2018 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534369232;
        bh=2pJElYdZnhOtQ8eb2rMsyzB3a9b/WUAshfhTT0FwVU8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YLcmDxtsiyaYvUDwJFB8/xF8/d5HIBjAKpEdWq6K/CNse+53z0hFYBRR9AWxBIUN4
         edJn3/Ik1kDd8fD3fLL+E3rPU9GNhhp16glY2D2m/oMfD1qCL5uVvH+AtEqiK+ewRl
         7gaHmKzV39HrsMWMQQu5nPql/ue77fSoFP9xGU64=
Message-ID: <1534369231.4049.23.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Yannik Sembritzki <yannik@sembritzki.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Wed, 15 Aug 2018 14:40:31 -0700
In-Reply-To: <2872b945-60e7-b5d1-1f20-1ae6ecfd3967@sembritzki.me>
References: <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
         <1ca6772b-46e0-9d93-0e15-7cf73a0b7b3f@sembritzki.me>
         <1534367597.4049.21.camel@HansenPartnership.com>
         <2872b945-60e7-b5d1-1f20-1ae6ecfd3967@sembritzki.me>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 23:31 +0200, Yannik Sembritzki wrote:
> On 15.08.2018 23:13, James Bottomley wrote:
> > Consider a UEFI system for which a user has taken ownership, but
> > which
> > has some signed ROMs which are UEFI secure boot verified.  Simply
> > to
> > get their system to boot the user will be forced to add the ODM key
> > to
> > the UEFI db ... and I'm sure in that situation the user wouldn't
> > want
> > to trust the ODM key further than booting.
> 
> I definitely agree with this point.
> 
> Is there any solution, except from building your own kernel, to the
> scenario I described?
> I think there should be. (I've personally run into this with
> VirtualBox, which I IIRC couldn't load, even though I provisioned my
> own PK, and signed both kernel and VirtualBox module with my own key.
> I could've compiled my own kernel with my //own key, but that is
> pretty impractical for most users.)

What about the key linking patches:

https://lkml.org/lkml/2018/5/2/989

? They allow you to insert your own binary key into bzimage and then
resign the resulting blob for secure boot.  It's a fairly painless
process.  The patches have been languishing for an unstated reason but
it's suspected to have something to do with Red Hat not wanting to
support Enterprise users signing their own kernels.

James

