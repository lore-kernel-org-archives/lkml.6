Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7721AC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327852087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327852087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJIPOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:14:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39238 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeJIPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:14:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id q5-v6so357606qki.6;
        Tue, 09 Oct 2018 00:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8CIKZAQO2/LVKGtnjk3pu1RltON6kBQHimiMTCZDZI=;
        b=TU56IG0UulavQxIV83B8QgGvKjnsRwkbPaX9Sq/e6Js4H209c0mYoTLr6TR1iBs6Pf
         MneNeRWfgxc6u9Jkthns0+GwIGBQaoCl4ry2l2r3HoYjuXVsmFwwQM5MStJB9QMaTKkS
         bWnQ3ukeZ1dZDdcxMBRkB6YarDEZeSiynADrjrEDw/hZa4rZLmlRi1lqWW7BcvuYGbpP
         ZZJihWqvM90MChXLPvBXTiNMa0jAu7vBjkmqi2T9XzYjWG3ThsBclmO30FXmT7FEv9Ru
         bb375D2dBJb5PkcHisL88cnZrmbgnJ9eHWYXNl2Yl4L/k3kytJWxNryNV2boFgBglr2d
         b4yQ==
X-Gm-Message-State: ABuFfoie5m/oIHVhBRDz4flBOGzToCrsMJpSIT3zl12KODVnFZcSdeNI
        fdAK7+QU+UA7AeWZ45aM0L7MW4i92PG5BIqGlwWPNg==
X-Google-Smtp-Source: ACcGV63QbnP3y6VQkMz1xgyj+dm1xQbp60eg9jEYdsFx9/fZ+evH/c3LAlafHktPB9HStVGV9mxPQhrWzT6jk7LiePk=
X-Received: by 2002:a37:38b:: with SMTP id 133-v6mr21490674qkd.173.1539071921139;
 Tue, 09 Oct 2018 00:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181008235434.GA35035@beast> <tip-184d47f0fd365108bd06ab26cdb3450b716269fd@git.kernel.org>
In-Reply-To: <tip-184d47f0fd365108bd06ab26cdb3450b716269fd@git.kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Oct 2018 09:58:24 +0200
Message-ID: <CAK8P3a2Ve91DbOtrjLmWifZMb-icwVa-J-XJ=W5am4-thWrmBw@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/mm: Avoid VLA in pgd_alloc()
To:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 9:03 AM tip-bot for Kees Cook <tipbot@zytor.com> wrote:
>
> Commit-ID:  184d47f0fd365108bd06ab26cdb3450b716269fd
> Gitweb:     https://git.kernel.org/tip/184d47f0fd365108bd06ab26cdb3450b716269fd
> Author:     Kees Cook <keescook@chromium.org>
> AuthorDate: Mon, 8 Oct 2018 16:54:34 -0700
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 9 Oct 2018 08:55:07 +0200
>
> x86/mm: Avoid VLA in pgd_alloc()
>
> Arnd Bergmann reported that turning on -Wvla found a new (unintended) VLA usage:
>
>   arch/x86/mm/pgtable.c: In function 'pgd_alloc':
>   include/linux/build_bug.h:29:45: error: ISO C90 forbids variable length array 'u_pmds' [-Werror=vla]
>   arch/x86/mm/pgtable.c:190:34: note: in expansion of macro 'static_cpu_has'
>    #define PREALLOCATED_USER_PMDS  (static_cpu_has(X86_FEATURE_PTI) ? \
>                                     ^~~~~~~~~~~~~~
>   arch/x86/mm/pgtable.c:431:16: note: in expansion of macro 'PREALLOCATED_USER_PMDS'
>     pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
>                 ^~~~~~~~~~~~~~~~~~~~~~
>
> Use the actual size of the array that is used for X86_FEATURE_PTI,
> which is known at build time, instead of the variable size.
>
> [ mingo: Squashed original fix with followup fix to avoid bisection breakage, wrote new changelog. ]
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Original-written-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for fixing up my incorrect fix, looks correct to me now.

       Arnd
