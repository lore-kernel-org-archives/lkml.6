Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B4B20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfAJQ7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:59:25 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36486 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfAJQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:59:23 -0500
Received: by mail-vk1-f194.google.com with SMTP id 185so2639781vkc.3;
        Thu, 10 Jan 2019 08:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hw0e7GRKKordAWqSD7MEd/MdjXNL2gSRFLNoHST4yQU=;
        b=CziGAr1nQCqVnhpZZP4mLYVdPp9LLljpPTPSAbxPdvZ0uhcbbl44e/T0TfHzWwNE+p
         eeqR/R5i40FpaSrHwfRqGqJpfTwgeIzeTBUWQP+Ae3I7UUiZlEIAHdtqZh2cqpNoWFPo
         g4ms9CdCpLWX6FoYc8iXOqBIb7na459x25Cl1Fl7YdjP4lSjYYgK6r7bVQy8Khtkb52Q
         Y6mWlCKPNaUFxXN6r+11AtdizOXJ5mGLa014QrbkSZ/A9D1sXIql7zxRd6sexFdzqOwT
         a6o363N5KHS2QLLX+vlVgQYyDR+P7z3Fkt3Ea9W2jY9krUSBV7f2HIu3OGKE0GoqO753
         8LFg==
X-Gm-Message-State: AJcUukehbygLd14B5AE60XLgQT5oYm6fwINOpjf2OyJx+c8nmK0FTP0F
        OvwQg98x2Q0GaTQqipP+r37L4wOTcY2+qk6VGbA=
X-Google-Smtp-Source: ALg8bN5fFE92/p210UY0O3VvZTR7XlFlqefe7/Td73EjJzfygMgDltkNFwFLL65t6V7dhJltD1zMZSFgvRHYqKmM9HE=
X-Received: by 2002:a1f:a414:: with SMTP id n20mr4224838vke.83.1547139561779;
 Thu, 10 Jan 2019 08:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Jan 2019 17:59:08 +0100
Message-ID: <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for y2038
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
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
        Firoz Khan <firoz.khan@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
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

Hi Arnd,

On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> The system call tables have diverged a bit over the years, and a number
> of the recent additions never made it into all architectures, for one
> reason or another.
>
> This is an attempt to clean it up as far as we can without breaking
> compatibility, doing a number of steps:

Thanks a lot!

> - Add system calls that have not yet been integrated into all
>   architectures but that we definitely want there.

It looks like you missed wiring up io_pgetevents() on m68k.
Is that intentional?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
