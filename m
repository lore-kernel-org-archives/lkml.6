Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88413C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C142173C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547837444;
	bh=VoFGDVLCVcIdDEcxLef2+rlsJOjPa2ebgAiYkYzOvZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y79qeUA/TztLUC0h874QGQtx2C3kYqWBhHMnNwWxrekcd3Zkn/2o2bOoLRbujR+OY
	 0RFKe5dcH7KVz3y7bLHVKBwii1WCc1NK61LpjRV9EXhcbXp/J9/FxZvyXgCRM9kkt7
	 NaarzOL/To9V0ks/J8OFQ/vHx2Qam6unwGpUlIBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfARSum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfARSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:50:41 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2647C21738
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547837440;
        bh=VoFGDVLCVcIdDEcxLef2+rlsJOjPa2ebgAiYkYzOvZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tCFAK8gh97QDVr+fqWM0ezDHTjqy+XJu0QeHvgv68vQG0bzqd09EkJwf8q2it5ZkO
         +CyufkCIlWkyDFGLQOpJcf5gZUihDk8swxgtvRTWwNn6840T68JYAaNgjsMp2Nd6SG
         pSYCdP9AxhF5tv6127zvXShyJaA1Ml1ueTffz0aA=
Received: by mail-wr1-f41.google.com with SMTP id u4so16313358wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:50:40 -0800 (PST)
X-Gm-Message-State: AJcUukcNn1KDEwD/RFizRG8vINsgUWD7YCOl6sXrXoLPI5wxVYsRGb6D
        xWM0891wUasMi5ggfd5XyCG8IJJUYlJL8nfmgaG+sg==
X-Google-Smtp-Source: ALg8bN67TmQMlfRaxpFOTS6mBbA0hkrufcMeB82R0DYAMNtI7glElQBQro2q4MgunvPtGRQh0RhmI0b7ZOkTrvyT000=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr17046840wri.199.1547837438534;
 Fri, 18 Jan 2019 10:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-30-arnd@arndb.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 18 Jan 2019 10:50:27 -0800
X-Gmail-Original-Message-ID: <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
Message-ID: <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        deepa.kernel@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, firoz.khan@linaro.org,
        linux-alpha@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This adds 21 new system calls on each ABI that has 32-bit time_t
> today. All of these have the exact same semantics as their existing
> counterparts, and the new ones all have macro names that end in 'time64'
> for clarification.
>
> This gets us to the point of being able to safely use a C library
> that has 64-bit time_t in user space. There are still a couple of
> loose ends to tie up in various areas of the code, but this is the
> big one, and should be entirely uncontroversial at this point.
>
> In particular, there are four system calls (getitimer, setitimer,
> waitid, and getrusage) that don't have a 64-bit counterpart yet,
> but these can all be safely implemented in the C library by wrapping
> around the existing system calls because the 32-bit time_t they
> pass only counts elapsed time, not time since the epoch. They
> will be dealt with later.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The one point that still needs to be agreed on is the actual
> number assignment. Following the earlier patch that added
> the sysv IPC calls with common numbers where possible, I also
> tried the same here, using consistent numbers on all 32-bit
> architectures.
>
> There are a couple of minor issues with this:
>
> - On asm-generic, we now leave the numbers from 295 to 402
>   unassigned, which wastes a small amount of kernel .data
>   segment. Originally I had asm-generic start at 300 and
>   everyone else start at 400 here, which was also not
>   perfect, and we have gone beyond 400 already, so I ended
>   up just using the same numbers as the rest here.
>
> - Once we get to 512, we clash with the x32 numbers (unless
>   we remove x32 support first), and probably have to skip
>   a few more. I also considered using the 512..547 space
>   for 32-bit-only calls (which never clash with x32), but
>   that also seems to add a bit of complexity.

I have a patch that I'll send soon to make x32 use its own table.  As
far as I'm concerned, 547 is *it*.  548 is just a normal number and is
not special.  But let's please not reuse 512..547 for other purposes
on x86 variants -- that way lies even more confusion, IMO.

--Andy
