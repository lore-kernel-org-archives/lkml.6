Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1E4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CCA214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfAJRME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:12:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44834 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbfAJRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:12:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so13980253qte.11;
        Thu, 10 Jan 2019 09:12:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9Ub2IW9cySGL3QZFJM+qSZvbyYHJpNB32B/Hx6OxIg=;
        b=pUVuwK2tCgNuJv2DgtGRAvv9AY1YNqmwCT0U15x2/90IKkA9XNEQfVp5HzLSgiIqtR
         FpqYdYwJMF0qJ+xEWYwtKhPHJk/okzO0/1dPXRfJac4sU7qSNlv+4VnHpfaAPZy2XTSm
         LgwJpNrHwlYvwICWzwD8p6DZVNKPO6X8+e1ffK+QrgxRZBsjvxeF4QeiDhlaEEpXtcX3
         21As+BQGyWkr5AgwpDE3RFh/2vaD0wcgLsqFDNNrT8fGSh5uutjAjSoMYbEJ8j2CFq8o
         xFu8yg4Smu1FEXE9otqtDVzTCPvnTGFfLIQOmOTuK1/1xnaHybw9DHS+4YDeMOF3k0vb
         qTbA==
X-Gm-Message-State: AJcUukfRlfCoPgNdh1dmQ/XTjVGN4eqZNwJklO8FvNSoUydm6bTfqT7+
        sjQGdSvpM+AzKMXpish8ou2y8RcuPngBohuBDFg=
X-Google-Smtp-Source: ALg8bN4Gur1wD3h0ELBSl0ybGvD7wc1qcQeOBkYMXly/Z0pb/J89D40WVoT3xz1IidS9G8IG/oXogEOscyYpZb29+TE=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr10912612qvj.161.1547140320327;
 Thu, 10 Jan 2019 09:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-7-arnd@arndb.de>
 <20190110163220.GB31683@fuggles.cambridge.arm.com>
In-Reply-To: <20190110163220.GB31683@fuggles.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Jan 2019 18:11:44 +0100
Message-ID: <CAK8P3a0TyDTTG7Eoz9dZF1J0SH-=OYQvQ6=YVThTkDfX-mnfWg@mail.gmail.com>
Subject: Re: [PATCH 06/15] ARM: add migrate_pages() system call
To:     Will Deacon <will.deacon@arm.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
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

On Thu, Jan 10, 2019 at 5:32 PM Will Deacon <will.deacon@arm.com> wrote:

> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 04ee190b90fe..355fe2bc035b 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
> >  __SYSCALL(__NR_rseq, sys_rseq)
> >  #define __NR_io_pgetevents 399
> >  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
> > +#define __NR_migrate_pages 400
> > +__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
>
> Should be compat_sys_migrate_pages instead?

Yes, good catch! Fixed now.

Thanks,

        Arnd
