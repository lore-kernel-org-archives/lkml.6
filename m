Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA40C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7850220657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfARTbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:31:17 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44091 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfARTbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:31:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so16437861qte.11;
        Fri, 18 Jan 2019 11:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AqmTALoASBra3sCdglfdVs8uL/QVnAKemn1xthUo0g=;
        b=M3qa94vR0GUJ/opu554yqvzjsVGkOepgvEqm4svLy3CYf9y2nvOSm3HQUyki4z+nux
         scg39E4wMwpzkC9qDxeJDzZkCeIFInEols/i9hruQyMnTTlVqI4HBQKGydBJa+EUqaUH
         27q63uDXlaRIoGqCbDB4k+EowFvHcJXw7pyILCXJiZraRUs/+5zV9gowzv92rBM55vrq
         RnpOul4wJZ1YeKb4HUYbKrv9DEShj3Gij19b+8xImi6HE9BTNxsum4gfhTDub/GT+kKk
         aJJAH5wUZoM9yM7p6BfimgA2JCc27sQszTwDJOHWeLxFj2qRAcrGJOTloZZ0UsACLA+g
         Rzuw==
X-Gm-Message-State: AJcUukcOw0VGUzl7FHX1WszPgTs6XvGs63MzAvjnDuYcgoT0UFS71ZFl
        m/5necECeFww4W058zdJ4ZVRDBFIegHl03sEkqnrtg==
X-Google-Smtp-Source: ALg8bN6j9yHcnKi+481JiICcfzmXamZ1jIWHSB1ab1h/DB+ThocBrv+KhcCDCSjIJzxiV13/exH4DDVlgzHxeSHApHc=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr16397093qvl.180.1547839873593;
 Fri, 18 Jan 2019 11:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-14-arnd@arndb.de>
 <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
In-Reply-To: <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jan 2019 20:30:57 +0100
Message-ID: <CAK8P3a1R8BfAnNGvBa-hoQBL3uJQ5bJ0_YO91YLv8pp3-nAe3Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/29] arch: add split IPC system calls where needed
To:     Gabriel Paubert <paubert@iram.es>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, linux-mips@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 6:20 PM Gabriel Paubert <paubert@iram.es> wrote:
>
> On Fri, Jan 18, 2019 at 05:18:19PM +0100, Arnd Bergmann wrote:
> > The IPC system call handling is highly inconsistent across architectures,
> > some use sys_ipc, some use separate calls, and some use both.  We also
> > have some architectures that require passing IPC_64 in the flags, and
> > others that set it implicitly.
> >
> > For the additon of a y2083 safe semtimedop() system call, I chose to only
>
> It's not critical, but there are two typos in that line:
> additon -> addition
> 2083 -> 2038

Fixed both, thanks!

     Arnd
