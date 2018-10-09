Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C09DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8F0204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8F0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJIOts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:49:48 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42284 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeJIOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:49:48 -0400
Received: by mail-qt1-f175.google.com with SMTP id j46-v6so551785qtc.9;
        Tue, 09 Oct 2018 00:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGhTpVcoCkwFxuALNcYHdAIDUtbdyYJ2TCNHfxIRU8s=;
        b=cvjGxrAeq3s75daP1P7cyMaEZAMM/7xPF9s1s2LiEPXIi9b1lofJ0AIFlEgHFG+Byf
         TOGBYIE1la6S0CgNSFjUb5Rw+pRgQ4wRAesIaZB4dfFbcDswPEtrnAtapZ3b9i1zC2RZ
         F7XNZmG5INFHIBXwLiw3HFM3T0dtammD6DxCDviwN4uXsF9kg+3a7eWTExlN+rce15Wx
         1sKiWh1P4v5o+Pd5qA3sOsSViBnwjFT1PvILX/ypBdtpUwmxWQwwnYAnEJKyP7Yb5rrH
         D9WHzaK2mCxrkL3aNjh7DbP15G+AfEzDEzp4oXc1yBY5DhGbYzA8UXG+y5CX4+rxkN0i
         vJEw==
X-Gm-Message-State: ABuFfoiTUlaOZYWhHZvU3iU+U+DrvqSiHDJhHQ+zokx8D21c663hQyGN
        P/Br0gyQSrI8Kj0qhzwogTZNpoyC04C+U8ieZzA=
X-Google-Smtp-Source: ACcGV61pPD9gTyz9iuvDD/s1k/sv/bsBXxR/A9Bfe7RnLvwCATcyJOyim07nAe5H7GWcxzYMd/ucpJRbISyRZZ3tMHs=
X-Received: by 2002:a0c:9e59:: with SMTP id z25-v6mr21543805qve.180.1539070452969;
 Tue, 09 Oct 2018 00:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161333.765973-1-arnd@arndb.de> <tip-1be3f247c2882a82279cbcf43717581ea943b692@git.kernel.org>
 <20181008202209.GA6597@zn.tnic> <CAGXu5j+4hjJSFpYi=5SqDmkonJ79J=hcb65qJC8+_r6+5NHewg@mail.gmail.com>
In-Reply-To: <CAGXu5j+4hjJSFpYi=5SqDmkonJ79J=hcb65qJC8+_r6+5NHewg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Oct 2018 09:33:56 +0200
Message-ID: <CAK8P3a2KTzTD5d10KkmcKh=_E7J7EJkE48wrcUe4AAwDiBVuEQ@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/mm: Avoid VLA in pgd_alloc()
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:28 AM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Oct 8, 2018 at 1:22 PM, Borislav Petkov <bp@alien8.de> wrote:
> > On Fri, Oct 05, 2018 at 09:24:53AM -0700, tip-bot for Arnd Bergmann wrote:

> >
> > For whatever reason - probably because it forced
> > MAX_PREALLOCATED_USER_PMDS be KERNEL_PGD_PTRS and not 0 (and I don't
> > have CONFIG_PAGE_TABLE_ISOLATION so it was 0 here with my .config
> > before) but this patch causes the fun below.
> >
> > If I revert it, no splat.
> >
> > Also, config has CONFIG_X86_PAE=y. And CONFIG_STACKPROTECTOR_STRONG=y. If I
> > disable _STRONG, it boots too. Attached.
>
> This really should mean that the stack canary changed. Either the
> stack canary wasn't prepared yet (but this is from run_init_process(),
> which is WELL after boot_init_stack_canary()), or the canary was
> actually stomped on, which would certainly be a bug in the existing
> code.
>
> Ah! I see it now. "pmds" shouldn't have changed, it's not .._USER_PMDS...
>
> -       pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
> -       pmd_t *pmds[PREALLOCATED_PMDS];
> +       pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
> +       pmd_t *pmds[MAX_PREALLOCATED_USER_PMDS];

Ah, cool, thanks for the analysis. Is the patch already reverted?
I.e. should I send a replacement patch, or a relative fix, or is
someone else already on it?

      Arnd
