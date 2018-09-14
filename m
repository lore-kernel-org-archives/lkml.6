Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B4FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FDA206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FDA206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeINThq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:37:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42511 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeINThp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:37:45 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so8844863qto.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPXqZUU1Vr4gyWfW+42/MalTHVGF0SThCedXo0TEHmo=;
        b=iE1/M3MJeNDJQtXCKTfyTDjw6ZHgAogU4r5NuqczkQMDl1WmHV+1U+6MtAvkjDJRj2
         5OyiQ2bCyU5elqEgULjr1HR4rqGe196Wth5JqBd0TEQeXS9XUrBGOSv8H3t4Ox//fCbd
         2eUjBHpI4MxPYMJsWVb3JBY1eHC6e1FIeyeTbZ+S72JQQG/X5038HMCyJIpYcU8Cziqy
         P2CZLd4vnlg++EDlPvDGqfz5gwu9X22BxvCWF+TiNc5zAMiD+LOiAXR8Bp8rG2qyUExI
         72lKvlhCeyVifT8irvzMkAV65cpwdq94/Qpshoty6XbuVLEBnnd0ESkM9wtjFRfsn98k
         SPyQ==
X-Gm-Message-State: APzg51De1xdhkMPj/65sWr8nBN4dAMKfv3P3qwhGoaDmwDQ7gFp3cxqL
        fuUitvs+uYqkfc1+4UQZfuJUOCq85KYIMiBhNXo=
X-Google-Smtp-Source: ANB0VdadqDgfJT3sGD71vDsKKCjo/gnry6Ik9iaPPE5QushjgZWWki4q2xhtsgEPLhhXt7arZVjKoC8xS7X813E3lV0=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr9343475qvc.161.1536934981161;
 Fri, 14 Sep 2018 07:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180914125006.349747096@linutronix.de>
In-Reply-To: <20180914125006.349747096@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 16:22:44 +0200
Message-ID: <CAK8P3a1QfynDxkKBLXVa5Qj_z+7ct3QB5sDYuY5QV3ht-a0cTg@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, matt@softrans.com.au,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>, vkuznets@redhat.com,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 2:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> implementation, which extended the clockid switch case and added yet
> another slightly different copy of the same code.
>
> Especially the extended switch case is problematic as the compiler tends to
> generate a jump table which then requires to use retpolines. If jump tables
> are disabled it adds yet another conditional to the existing maze.
>
> This series takes a different approach by consolidating the almost
> identical functions into one implementation for high resolution clocks and
> one for the coarse grained clock ids by storing the base data for each
> clock id in an array which is indexed by the clock id.
>
> This completely eliminates the switch case and allows further
> simplifications of the code base, which at the end all together gain a few
> cycles performance or at least stay on par with todays code. The resulting
> performance depends heavily on the micro architecture and the compiler.

No objections from my side, just a few general remarks: Deepa
and I have discussed the vdso in the past for 2038. I have started
a patch that I'll have to redo on top of yours, but that is fine, your
cleanup is only going to help here.

More generally speaking, Deepa said that she would like to see
some generalization on the vdso before adding the time64_t
based variants. Your series probably makes x86 diverge more
from the others, which makes it harder to consolidate them again,
but we might just as well use your new implementation to base the
generic one on, and just move the other ones over to that.

A couple of architectures (s390, ia64, riscv, powerpc, arm64)
implement the vdso as assembler code at the moment, so they
won't be as easy to consolidate (other than outright replacing all
the code).

The other five:
arch/x86/entry/vdso/vclock_gettime.c
arch/sparc/vdso/vclock_gettime.c
arch/nds32/kernel/vdso/gettimeofday.c
arch/mips/vdso/gettimeofday.c
arch/arm/vdso/vgettimeofday.c

are basically all minor variations of the same code base and could be
consolidated to some degree.
Any suggestions here? Should we plan to do that consolitdation based on
your new version, or just add clock_gettime64 in arm32 and x86-32, and then
be done with it? The other ones will obviously still be fast for 32-bit time_t
and will have a working non-vdso sys_clock_getttime64().

I also wonder about clock_getres(): half the architectures seem to implement
it in vdso, but notably arm32 and x86 don't, and I had not expected it to be
performance critical given that the result is easily cached in user space.

         Arnd
