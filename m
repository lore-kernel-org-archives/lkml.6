Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73B2C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3F720844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfAUU22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:28:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41299 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfAUU20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:28:26 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so24951873qtf.8;
        Mon, 21 Jan 2019 12:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kD6IFPEOKNOz9iNntsGiu85pLEy/bbFmo7y1npa4eOs=;
        b=EOJdDBLoCxPPDTZPaxlq6LXDWq5W81M1oEqwDVFUVQzfhApV+1gWmI88OEQrbynIZc
         nUNnTg2wNiLi0OZAGiwjAsX1Be7v5VX77nWK1j/SJ9fgkGR9/rvv+xNAkPI3n03IFLRn
         6kGo3Iw9GxEpXCO6+bvlAmIbYA9yA31FbP3y/yuhnTS7xV3n0tKhXtgEstSEA6aBNfXg
         Hd09FvBGs6kkFHrE7nJcMMANP6PHw/d4O2I1hfxHz2wThmQZxHKHo87ywaLnKaaqMA2C
         O1bItyw+SoG1AshD2uEi6x3NhqC6Q9GMjk1bC48qv1DbsKqsCRvTNg6Bj16GXr+b6xYv
         ACfg==
X-Gm-Message-State: AJcUukecrA8No6tIdbvGe8gcCXrxnDr4WhXWMR0eHqgQlIWxoDvGZSzg
        TtFAZ8mCT9f9ta3ZtplTtudV5kWhqhKIHsHO8GDdNw==
X-Google-Smtp-Source: ALg8bN6mLscM+pbjX9xQ6/wy1A9ikEOKpuR+5XAFBodnDm12Xj0LxRlfII1AhYmWMPLWezvh7DcCeu+FaKZ+CS1nC+w=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr28748763qta.152.1548102504937;
 Mon, 21 Jan 2019 12:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-15-arnd@arndb.de>
 <CAMuHMdWaJyNqUeq4qu3AgU0fYrQdZ_zbo0DFFiM97Y5HESYYnA@mail.gmail.com>
In-Reply-To: <CAMuHMdWaJyNqUeq4qu3AgU0fYrQdZ_zbo0DFFiM97Y5HESYYnA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Jan 2019 21:28:08 +0100
Message-ID: <CAK8P3a1BxBHfHZCvTM6aoBiiN+EpnD4P9LM=Ked5Sc_QwF7hCg@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] arch: add pkey and rseq syscall numbers everywhere
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Mon, Jan 21, 2019 at 9:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Note that all architectures that already define pkey syscalls, list
> pkey_mprotect first.

It's easy enough to change, so I've reordered them for consistency now.

> Regardless, for m68k:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks,

     Arnd
