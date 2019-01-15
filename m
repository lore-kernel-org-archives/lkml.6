Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BA7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1390020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfAOOre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:47:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44572 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfAOOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:47:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id o8so1644170qkk.11;
        Tue, 15 Jan 2019 06:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJSgcbSLHBpkQA1mStr0T4cc3D19F0djyMHOoCBmTQM=;
        b=RUHAyP+29kPixCb277J+uTWs5WYDKV/MAXivp1JFG6o8q4t/wOrKu0yMKiYWhAPBGH
         5IQK6m19u8Gpd+GKIyveu34hegHIdewUJ4IxNYqLh1ynNNjmcRrzMYgK91JXF8IxnBLe
         tPWeHTZJt5y2LTkz39FMJuzCJZ/Eg+ae7lZa2G5hVMBs9DpdhXu7H+WTvfPOHDEpiYgK
         F+w9SpBoIvoHPTfSqzyuTxhqPjOCRtpYfPNxxBoeropt45iToRPdsr0tGeTdtQyatehJ
         qOvWWJkiww5RfjgORfHO6L6V91nFeHWVxHHfd8UfBK0pX8oqMKdrx+OM2kSxGv9FDW/3
         joFw==
X-Gm-Message-State: AJcUukf0QOJClHwB8aQtv/xIyIWaR97688J0afs0IvblMSSWvofdNOcD
        b4KDNJHWAYODTFzxldedA7XnMZT70CLQic//AhY=
X-Google-Smtp-Source: ALg8bN7NyBBLgCUds8tYMS0JcD3kjA3gSFqxzkmVv/3Wlh5Gl2kGahA1WPnfsZKIUU3QSibwFh0em/FK52DjAc3L5UI=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2838414qkf.107.1547563651094;
 Tue, 15 Jan 2019 06:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-16-arnd@arndb.de>
 <20190115115229.mcrmmpwdmjxf2cra@e5254000004ec.dyn.armlinux.org.uk>
In-Reply-To: <20190115115229.mcrmmpwdmjxf2cra@e5254000004ec.dyn.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Jan 2019 15:47:14 +0100
Message-ID: <CAK8P3a1Xb4z-mbhBTPZ0Cpy0Hy_s2wwT-8UG9yO6AGbUTjdkyw@mail.gmail.com>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
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

On Tue, Jan 15, 2019 at 12:52 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:
> > Most architectures define system call numbers for the rseq and pkey system
> > calls, even when they don't support the features, and perhaps never will.
> >
> > Only a few architectures are missing these, so just define them anyway
> > for consistency. If we decide to add them later to one of these, the
> > system call numbers won't get out of sync then.
>
> I was lambasted for adding the pkey syscalls for 32-bit ARM in 2016,
> which will probably never support it.  Why has the attitude towards
> this kind of thing now apparently become acceptable?

I was (and still am) a bit unsure about this one. A number of architectures
added the numbers that won't ever support them, but I wasn't sure if
any of those that didn't add them might need it later.

I tried to just go by the rule that anything that we list in
asm-generic/unistd.h
is probably important enough that we want to list it everywhere, even if
that includes a couple that we end up being rather architecture specific.

I'm happy to drop this patch if you or others feel that we're better off
without it though.

      Arnd
