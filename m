Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC4BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D2E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YvWp8opp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D2E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeHPAIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:08:31 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35387 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeHPAIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:08:31 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so2180025iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+HNgKzF+RElvIhHUEY/nNNqiCrgzpum4bRgrcMSR+s=;
        b=YvWp8oppO0sAAXG13H0Ts9P/BKqxakVRJc6G3rlc9RAO99JCc7Dup1tR+MQnp++94Z
         qkHQPJfR5rLkkT4tLPLJ4wVx5fxs8qPdPxrlJcUEsiFaxCpHfqJZpFSSMPy2LyvodZRl
         /kpaITTAWRMbc2evZD5zeopqv/rU1P6FD/dU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+HNgKzF+RElvIhHUEY/nNNqiCrgzpum4bRgrcMSR+s=;
        b=nYkmE/GiVZJ8c5+x3Gpc8+ZYwfOHdXrS456oEKc8ouT/kIal9HyYyLZvuxXVvs+eUW
         DrFdehRMrTDCypSGZaIsxuO3zJ9f1/2zaWy/ouo2Cs+FCXlyNMe9Q5adUMT5nCbruT0C
         E4MQxQqcJuFuBii+qlyei/EclWOSA0mEuEnBfsz+O3saqiEWNZEsVW2hYn3PMU8Tq51m
         Dun4tFofAe0W+UTVX9WxyqfN9Qj993unJTpC0N+l8lkC/eVWgMlSvJisRCgGDxhNypON
         w1RkQf+XlgCoOK4XFurnPgUXjZ6MNwtn7nJRIqy+552TIwvPmxOpwz2ds9Ps6A0OsOiN
         h1jQ==
X-Gm-Message-State: AOUpUlF4JTFiUDl9yDpUzvF2fpKZfr44Wj4dziA+D/251zOt6fAARDnL
        IPL4NMZROrtDBRZnKtz8qUxGslYuaXoZjoBabI8=
X-Google-Smtp-Source: AA+uWPxRWaOAxtkvgpkgfSZwPF41Izjbk5X8N2vDyoEOKO71vnVX8wUxJjK+XtxYbEOWxH64KFBEq1DSYtUSPBfkulw=
X-Received: by 2002:a6b:7a08:: with SMTP id h8-v6mr19338633iom.238.1534367678212;
 Wed, 15 Aug 2018 14:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <20180815174247.GB29541@redhat.com>
 <20180815185812.GC29541@redhat.com> <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
 <20180815194932.GD29541@redhat.com> <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
 <1ca6772b-46e0-9d93-0e15-7cf73a0b7b3f@sembritzki.me>
In-Reply-To: <1ca6772b-46e0-9d93-0e15-7cf73a0b7b3f@sembritzki.me>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 14:14:27 -0700
Message-ID: <CA+55aFywxADCF74ek0CadwcDaTySZ79aKHAp0K-p1LDT=G-GcA@mail.gmail.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
To:     yannik@sembritzki.me
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        David Howells <dhowells@redhat.com>,
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

On Wed, Aug 15, 2018 at 2:08 PM Yannik Sembritzki <yannik@sembritzki.me> wrote:
>
> IMO, this is not okay. The layer of trust should extend from the bottom
> (user-provisioned platform key) up. Only trusting the kernel builtin key
> later on (wrt. kernel modules) contradicts this principal.

This module loading case is not about trusting the *key*.

This is about trusting the *build system*.

For example, I build my kernels with one single randomly generated key
(that gets deleted afterwards). The modules get built with that key
too.

No amount of added keys later will make a module valid to load.

                  Linus
