Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEABC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5594B20836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfAKRbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:31:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43900 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfAKRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:31:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so19647870qtj.10;
        Fri, 11 Jan 2019 09:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGHCnfowgHn30T+nuPC0hqbUSrYY8+wFH1Oi3pXaRzM=;
        b=WOOe2QlI17jPqERZWta9eFvu+NjfBer0Y9neCurnsZF53ESKfjLz6qU07k8coOLHA2
         26ohnScM3GptJ3Y97J6D/00NZ7HTp/dGOKsiImcAfAjjoRhzoBza3RVKT2PLg5GfKFCd
         CLa62GyCsQyyyOntT6hdtrkIGveqSdC0b14e0+p8BGGlXCkA/u23s/DXrYjrhPWom+SO
         cKpypT/kelTK+StYBzP5qpPIdKDKBV3KA1HjdfIALIaJXtdtRqPGUu6cGSXYMLWcXHfg
         c2p72bX2Brq8GdbFgAye8DhwgRIR7tS0FgI2CEjyedBSgIGrBZz5fD3BaWY36d3Ye0+o
         tYpA==
X-Gm-Message-State: AJcUukdpVZlLRrTEiBQmWP9XQ4qlglXUB0aQAifbz+IkUpHsQ3GlXQjM
        C/yz9RsPEpwuuamyW7umpWKckryPJ+wMU0YbvLk=
X-Google-Smtp-Source: ALg8bN775BnYYqpcTaMAandAOOVFGcb1fag8zY9M3WMS/TPmNFpmSdRaCOyAJ14+1Aq8ng+YTuIZvIzlZbwDHzn2U4I=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr14875090qta.152.1547227860501;
 Fri, 11 Jan 2019 09:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-16-arnd@arndb.de>
 <20190110203638.GB3676@osiris>
In-Reply-To: <20190110203638.GB3676@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 11 Jan 2019 18:30:43 +0100
Message-ID: <CAK8P3a0M6qSJQAtFNKVS5muissKvyzeE9MSYT_uwKnM4BKCAug@mail.gmail.com>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 9:36 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:

> Since you only need/want the system call numbers, could you please
> change these lines to:
>
> > +384  common  pkey_alloc              -                               -
> > +385  common  pkey_free               -                               -
> > +386  common  pkey_mprotect           -                               -
>
> Otherwise it _looks_ like we would need compat wrappers here as well,
> even though all of them would just jump to sys_ni_syscall() in this
> case. Making this explicit seems to better.

Ok, fair enough. I considered doing this originally and then
decided against it for consistency with the asm-generic file,
but I don't care much either way.

Is this something you may want to add later? I'm not sure exactly
how pkey compares to s390 storage keys, or if this is something
completely unrelated.

     Arnd
