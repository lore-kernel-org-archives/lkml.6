Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C649CC282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53A214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfAUIHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:07:23 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44023 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbfAUIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:07:20 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so12071456vsc.10;
        Mon, 21 Jan 2019 00:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXLD08ZhNbo1NMvbOHKMcfHtw8oqcgdcNXRBleZ02HU=;
        b=H+LGhgOOKEsvHBTmtxJTCjBPdBxhSsqMIv6GQDdtUurtQufHr6umgi9leWNhrSfzQ5
         A7R8L89ey7zHpgAtQT4PDW9nyoGSg8HiovsxXNFP3T5rzdxhEUHmGW21u3tlrXSCw9rm
         6Mq9WwvjH2I91010gfnz9OFy2jXkva1UJd1en4J9hCWa9UTaYtAZCVM1AXQodeW8iUm9
         tF+4b/kWXwt8k++K0YTSSVe4rKJkL1up1BtpB2F1ltCJGwP7LEMhOHsPoTUplXQSsyWt
         ju3FVCsEbaprqzHEyGUVh6ZCmy9xJm9GgklPZXUn1OXDkm02GZbEdJmFrbYv1EcTmVxL
         9j2g==
X-Gm-Message-State: AJcUukc1Lh0h+OVKwwX1YFeMvrpxPbiLx6zG1nsfczZacKCVlEz47njn
        uuIwGicH8FjWdTzHlZpLpSaH8hoi3El0R2qtIKU=
X-Google-Smtp-Source: ALg8bN7PAkoiEcltbZZ90okuIHKeh3Hd7zrjUBYlI94Ofq6l4zsWCDbU0HLun3Hy0/S9rRYk7ybtuk0MjXCtnpQGbIE=
X-Received: by 2002:a67:f43:: with SMTP id 64mr11912894vsp.166.1548058038054;
 Mon, 21 Jan 2019 00:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-27-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-27-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 09:07:06 +0100
Message-ID: <CAMuHMdU1tNA74QRKhcuJ-LkRi4HBynZoQ0hd-MVZtY4+oh6OUA@mail.gmail.com>
Subject: Re: [PATCH v2 26/29] y2038: use time32 syscall names on 32-bit
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

Hi Arnd,

On Fri, Jan 18, 2019 at 5:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> This is the big flip, where all 32-bit architectures set COMPAT_32BIT_TIME
> abd use the _time32 system calls from the former compat layer instead

and

> of the system calls that take __kernel_timespec and similar arguments.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
