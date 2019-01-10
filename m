Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A07C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E87120874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfAJRPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:15:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45199 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfAJRPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:15:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so14010849qtr.12;
        Thu, 10 Jan 2019 09:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vi+SvwsycUKtGhpMC3QEpN/Bk6bKq1AfTBDWYF1k7VQ=;
        b=hf/Qw2NMREqLD0cU2L5PwYV6N3JVMoymHdz6WPZ4m0wF+QIVmbrGaDTsAVhbXHq03N
         4zvyj8yMQlqAAkoSnTfjpTSDoKlE5/4DeDyYXqDanBk2XFUaWvhIweXT6lMTXFx35g0e
         UT6Q4jr945WYh8e637Kj6ObPedDpTpUpbSu1VWf/sLwt+8cdb9NgCHp83IDvOkmf35kJ
         eKcb0zmFQdz2u9d1PfJDI48UvC9AqA5sGgyzEGK2O3Pq7/Hinbi03TI30LWQ9v0sRygF
         tpFBRAWbmX7y40RN9bhyROcWqdgIZzIjE6dh7nnXGRgWA0sbqle/1qVCFu6heqQN4uaR
         L3zw==
X-Gm-Message-State: AJcUukdDu2iSUzrpLirdpfVetnMplsuyAWY8r/S6gdyK0on1eVhuVsN5
        e8yeoyAjDUQCUQcx+uFu9ACFiAKJ518JEpQ5pUI=
X-Google-Smtp-Source: ALg8bN4AdylggnguSr7egu7xIPGdOjTe436nAOiytiob3A7SfzgpinZUkBcCe85tXDNMw1nvzwC1nAoiCh7sWU6vHE4=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr10355152qtl.343.1547140506273;
 Thu, 10 Jan 2019 09:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-8-arnd@arndb.de>
 <20190110163908.GC31683@fuggles.cambridge.arm.com>
In-Reply-To: <20190110163908.GC31683@fuggles.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Jan 2019 18:14:50 +0100
Message-ID: <CAK8P3a27hYDL+yjO+DFe8n_C_dyjGNKcKOcWz-p3Pc1LwcxKjw@mail.gmail.com>
Subject: Re: [PATCH 07/15] ARM: add kexec_file_load system call number
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

On Thu, Jan 10, 2019 at 5:39 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 355fe2bc035b..19f3f58b6146 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
> >  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
> >  #define __NR_migrate_pages 400
> >  __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
> > +#define __NR_kexec_file_load 401
> > +__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
>
> Hmm, I wonder if we need a compat wrapper for this, or are we assuming
> that the early entry code has already zero-extended the long and pointer
> arguments?

Yes, that is generally the assumption for compat syscalls.

s390 needs some extra magic to do a 31-to-64 extension on pointer
arguments, and I think sometimes we need a special wrapper to
do sign-extension of 32-bit arguments into 64-bit, but the arguments
here should not need that.

     Arnd
