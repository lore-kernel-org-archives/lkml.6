Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB5BC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfAUIz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:55:56 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40717 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfAUIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:55:54 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so12154151vsf.7;
        Mon, 21 Jan 2019 00:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVAtAGarxS4wypP/3eT2eCQTmORwhs++L36a9mWKR3U=;
        b=drvlvRr7QE8789WE1vyVXkVdz7X9R4XFoBOm4CGnKS0+X06iMtR9VGSBmGW6yF+562
         NlId3BKzUG7svT0RD/CcIQzOQBPNab/J0GaLlbBaOxGDue9T4VNkXRwwB0F3PLWmVaIc
         I0Move9+X6vdcWeRzNAmLsMNIcNIen34wrFrgrZCzGlM7UEslK6nTbSHj8aTJXwp5Eh5
         OQIRmReUlSBR1mAcXWwwi6hGjr5SN+N3ZIlrVLWfVQ1wkFhQ8HtmZLJHEDSCZ5SxhjB/
         5p+8j/rnMMG5g9UbH2wYVLJZXELMhXwZDTIDeVySF4JRhzQmsMwOQI3HIwyzQyhcaLmZ
         EiMA==
X-Gm-Message-State: AJcUukcnWaLuJH3dpMWTc61QOsRkAUtBltj3DcviYqYXpr0hSz7QETNE
        eL2cZcTeLZviZQ593cLJN9tHTlAoA3NWqTLm2Aw=
X-Google-Smtp-Source: ALg8bN5Be0knSu5403sgnyKm3buMMWtoe1G93e4U+oAPSmiCzzcvAtemg3VTW+OqtwtQMKyCtP28wB0QbzIKsvryMUI=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr12198772vsm.152.1548060951904;
 Mon, 21 Jan 2019 00:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-9-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-9-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 09:55:38 +0100
Message-ID: <CAMuHMdUH+vJ89O6-Qm1p9r6h30z2ZRred1aQd6=h0sk6xXULMQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/29] m68k: assign syscall number for seccomp
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Most architectures have assigned a numbers for the seccomp syscall
> even when they do not implement it.
>
> m68k is an exception here, so for consistency lets add the number.
> Unless CONFIG_SECCOMP is implemented, the system call just
> returns -ENOSYS.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
