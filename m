Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9786BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CD82154C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gdGMhPh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CD82154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHOXl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:41:28 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36825 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHOXl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:41:28 -0400
Received: by mail-io0-f194.google.com with SMTP id m4-v6so2117728iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iUnvtyy9SiLadysUqHVOWgTtkFZ1yftlaqqBP5XqjA=;
        b=gdGMhPh8OhVyrDZDPa9VcYDKDow9ygkejadxS5cR8afxyL92YVvW8s0+26QZRM4nsW
         icFxxyKAOViWdSiOmIWXPQPwKMCAy8m2VIbf4vaz7f/2JK2AX7yoJWoDyNzvHhh2eIbZ
         pOTSsLMkjhc3EAAS7J0oQn7ofRCMaeyg+41+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iUnvtyy9SiLadysUqHVOWgTtkFZ1yftlaqqBP5XqjA=;
        b=qqJwJTIVKXpuvTnbWcN/hxUoWVjSeQqINrmG0BQJtfnQiNN3dJrLoiY862qqa5qti5
         H0hRFNmJC7om7y0d71MbqWnrjhCTeegWH3LWB4jfpHy2LD2A8iyNb/O0WNvtOzVEqSZc
         FRA6AmIVcf8zGe9opCu4dUVGTqP9NmW8M3IkzUoKH7Es6SCOeL5R+Uiyxd4TNp+IiiPq
         RlQMK2LSbutCORbqS/yk82+cgp1ggT2w35brfRbQl4bkg+hRsqRn2DdiHsUIbsx9yeWK
         bNwKwhJbTFMjI6SAVXg8/t1LCMFMn7ZRSnOeDN25MWgZGdUseKBMdnkGcVF6nKER2nFV
         pmWA==
X-Gm-Message-State: AOUpUlHiN1hkIellefbv1hklr3Ht9T9Y8YvqkhpsL5GpCGLxhJRM4HE+
        X7pJe62CZkMz6PnoAYpyQuIV8mugekXJ/w/7w0Q=
X-Google-Smtp-Source: AA+uWPwa054QcnONvxgFuwZVY9KRDEjz6fac9rgJV28jYtxb1wHaoRm4KLpGRahRa6O61Z/UTpEzVmKIhHsZJv7O+fc=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr6822861ioh.259.1534366060799;
 Wed, 15 Aug 2018 13:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <20180815174247.GB29541@redhat.com>
 <20180815185812.GC29541@redhat.com> <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
 <20180815194932.GD29541@redhat.com>
In-Reply-To: <20180815194932.GD29541@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 13:47:29 -0700
Message-ID: <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     yannik@sembritzki.me, David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> I see that module signing code trusts only builtin keys and
> not the keys in secondary_trusted_keys keyring.

This, I think, makes sense.

It basically says: we don't allow modules that weren't built with the
kernel. Adding a new key later and signing a module with it violates
that premise.

                  Linus
