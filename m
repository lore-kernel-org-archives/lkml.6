Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEA0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EA520665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfAJWmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:42:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41860 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfAJWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:42:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so15848170qtf.8;
        Thu, 10 Jan 2019 14:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNKid8601Q74qbqdVMhf8FUFM1MYtF3TJK3jK7Mp7Ng=;
        b=O6te3nUmMzsV5pDCs32/YMjtxw9UVFlyLUiKJp9VDQWtNuZgkrTIvIwHK8gAPr8Hha
         HibVKhSb5VQHZqZ5vXk1ZrjUVnxIV9zvins9G5AaPz0OOJeHkcYlPETDSw+vlN/bhhDf
         2QeykFSvTVzqSzuaSykkaFi/gv2PcjsN7Ri8HPeu84MKWvo1A4v1AucULULMgSwO+wuz
         IPE3tb+dVXH9aoOMm7AI8OUzqwSzsEojVjS0yML4FJh5RaXfCJe4fVQ8iWfrkG70lGDO
         hNPYhfTb+8eOecyBdAHRAIVZdszmh4Bo+ftdhe8xE/uwEuKzCYHuOslbFinTFXSmREqe
         0iRw==
X-Gm-Message-State: AJcUukeF1OHFxv7eqEUMAkfMy3XW4JAtLCbRsK7JxslwcQqDyEXWdNip
        482BEf2cwFH7LQDi6ka1nZ8sAT+x+EvRusvfoHA=
X-Google-Smtp-Source: ALg8bN4wMR/sIxtpNUyojzYiti1ruSkqKLKoKXLZmlthH3ilc8ugAlgx3EsdaYVXiGEAkGXDoaecVD7bYSRnjKp5c14=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr10790675qkf.330.1547160169972;
 Thu, 10 Jan 2019 14:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <alpine.DEB.2.21.1901101808220.31458@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.21.1901101808220.31458@digraph.polyomino.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Jan 2019 23:42:32 +0100
Message-ID: <CAK8P3a2f4SCJXrm6HWO9UKY-akSW+ONNpOvQOtYbia_fRo9ciQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for y2038
To:     Joseph Myers <joseph@codesourcery.com>
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
        Heiko Carstens <heiko.carstens@de.ibm.com>,
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

On Thu, Jan 10, 2019 at 7:10 PM Joseph Myers <joseph@codesourcery.com> wrote:
>
> On Thu, 10 Jan 2019, Arnd Bergmann wrote:
>
> > - Add system calls that have not yet been integrated into all
> >   architectures but that we definitely want there.
>
> glibc has a note that alpha lacks statfs64, any plans for that?

Good catch, I missed that because all other 64-bit architectures
have a statfs() call with 64-bit fields. I see that it also has an
osf_statfs64 structure and system call with lots of padding and some
oddly sized fields: f_type, f_flags and f_namemax are only 16 bits
wide, the rest is all 64-bit.

Adding the regular statfs64() should be easy enough, we just need to
decide which layout to use:

a) use the currently unused 'struct statfs64' as provided by the
    alpha uapi headers, which has a 32-bit __statfs_word but
    64-bit f_blocks, f_bfree, f_bavail, f_files, and f_ffree.

b) copy asm-generic/statfs.h to the alpha asm/statfs.h and
    change statfs64 to have the regular layout that we use
    on all other 64-bit architectures, using all 64-bit fields.

The other open question for alpha (as mentioned in one of the
patches I sent) would be whether to add get{eg,eu,g,p,pp,u}id()
with the regular calling conventions.

       Arnd
