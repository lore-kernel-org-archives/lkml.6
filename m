Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86E0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70D620870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbfAKRd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:33:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40580 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbfAKRdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:33:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so19669663qtf.7;
        Fri, 11 Jan 2019 09:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlXu3O61pUFPLleZ5AMTVxcoWeFNM1mKAK5t7dNAM0o=;
        b=TP6DXAT3p1j+5A4u4m4BFvUWImSq5n0+2KSpQfsyhkr4kzNAR0Hc/VviiTXMFXtGMX
         ncYTHe5C53FZ3ATUHerV/9xB4taaYdLvbYfh6QFfS0V15aCXvZ1whAz4Lgk5UdQVZYgX
         pT7hiCbeRq/SmxjhCvJst8noet5IY6sEC3J86P8YQB2UvoZPo6mGMioKsNYGocdS89xY
         lnnmssGTiGTglHiIS9nFsPGkx3QskIMkc/kCNP+wcCoHcVd60YuYfv+5TM/qqogRJGxR
         C2xSeo4AuVNzeljmhVa9RGLSL18Ao7ExyUfgm4bdTAVI6F/XPYE2Kfm09IHOM9Mitbdp
         avtw==
X-Gm-Message-State: AJcUukdxwi0KkcGe0N5/5c/JvYJ2QRtML6xS9Q7mlHTMkc5i9pWE59WI
        Dp66nzV7PKgISL6QqEYhF8Ns0mShDHfZMQICuw4=
X-Google-Smtp-Source: ALg8bN69vX9vcq63IXhYC33aOwWxtfAvEwzhoWorTBpfa9Zlf+nERekjdxP7iJFo0Zjh4Gu5ospxdXcZfV6z9FLdQY4=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr14381544qtl.343.1547228002113;
 Fri, 11 Jan 2019 09:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-15-arnd@arndb.de>
 <20190110203253.GA3676@osiris>
In-Reply-To: <20190110203253.GA3676@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 11 Jan 2019 18:33:05 +0100
Message-ID: <CAK8P3a0PahP8Bbc7OfiqrRcoxMReDuoyn8Hw=aSFtPjNeyrjcA@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
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

On Thu, Jan 10, 2019 at 9:33 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Jan 10, 2019 at 05:24:34PM +0100, Arnd Bergmann wrote:

> > diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> > index 022fc099b628..428cf512a757 100644
> > --- a/arch/s390/kernel/syscalls/syscall.tbl
> > +++ b/arch/s390/kernel/syscalls/syscall.tbl
> > @@ -391,3 +391,15 @@
> >  381  common  kexec_file_load         sys_kexec_file_load             compat_sys_kexec_file_load
> >  382  common  io_pgetevents           sys_io_pgetevents               compat_sys_io_pgetevents
> >  383  common  rseq                    sys_rseq                        compat_sys_rseq
> > +# room for arch specific syscalls
> > +392  64      semtimedop              sys_semtimedop                  -
> > +393  common  semget                  sys_semget                      sys_semget
> ...
> > +395  common  shmget                  sys_shmget                      sys_shmget
> ...
> > +398  common  shmdt                   sys_shmdt                       sys_shmdt
> > +399  common  msgget                  sys_msgget                      sys_msgget
>
> These four need compat system call wrappers, unfortunately... (well,
> actually only shmget and shmdt require them, but let's add them for
> all four). See arch/s390/kernel/compat_wrapper.c
>
> I'm afraid this compat special handling will be even more annoying in
> the future, since s390 will be the only architecture which requires
> this special handling.
>
> _Maybe_ it would make sense to automatically generate a weak compat
> system call wrapper for s390 with the SYSCALL_DEFINE macros, but that
> probably won't work in all cases.

For some reason I was under the impression that s390 already did that.
However, it seems that x86 does, so I'll try to convert the x86 version
for s390, and see if I can get rid of all the wrappers that way.

It would certainly be safer to have the wrappers always present,
especially if we expect future system calls to be added to the
s390 table by whoever implements the syscall itself.

      Arnd
