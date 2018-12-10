Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65633C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A692084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A692084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeLJV0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:26:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38917 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeLJV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:26:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so7419563qkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tB9LaGcU2AH9V0fXwW40nldkPwatYcJwMs2yK4idg4=;
        b=S58CVGFERi3sBu+oTlJB02Hv+qlRVNOKGQ0BTH4o4me3N1eO8uHUvliJ0o3APdzr8W
         aJ362xBNzmHn2CqlbuRHbwHnZem3Kww4DzYss2kdxfzq38qS2lh/X8Q+TNd60SS1VCNV
         gbSKMANH5k5VUtsyMlZAnwL+WeXELGpc74nZbdqPfFT1HWhaoFu9EOh5rsuDX5HuIzyh
         GK3uU8Su0mF/NOas9QgzT1m12WwOCEEgDmP/eCsTNBFTjzr5tlTzMIEcfBHDkh3vYVaO
         BxYM/1Aiq8hftCDZUkw23V7FcV9XNqCeU/mTWOnwnf9nQerBvCLc8Tntj6RbvS1AxCQk
         9irw==
X-Gm-Message-State: AA+aEWaMfx6zkAQQKxe3J4RMCvrEkyJzUMp4JryYfL5ZjJWPEsnSqtQh
        c74GI6d/zWsIFSjhE/Py0EXE0sZHFaLhCK88doU=
X-Google-Smtp-Source: AFSGD/UL8tR6Hzk65fgXGHMgSQPJ2KCxDJ9AJRwaLQLaZ08y2SEZPGVSTLmciI8iuwJ2X/OcrUuetrJdiIxtolTVSWk=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr11792059qkf.107.1544477192891;
 Mon, 10 Dec 2018 13:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20181210205929.3213516-1-arnd@arndb.de> <CAAeHK+y_ySWM7NLsAvX7UzeBjYdofQHGgG_xbOMwX_pVsQJJKA@mail.gmail.com>
In-Reply-To: <CAAeHK+y_ySWM7NLsAvX7UzeBjYdofQHGgG_xbOMwX_pVsQJJKA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Dec 2018 22:26:15 +0100
Message-ID: <CAK8P3a1944yQ5rUG8zAYB5O5CQ=G-khyRGkwQmn-fZ6_-jMKcQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: add missing Kconfig dependencies
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, gor@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:15 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Mon, Dec 10, 2018 at 9:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Building with CONFIG_KASAN=y when neither KASAN_GENERIC nor KASAN_SW_TAGS
> > can be selected leads to a build error:
> >
> > arch/arm64/mm/kasan_init.c: In function 'kasan_pte_populate':
> > arch/arm64/mm/kasan_init.c:106:28: error: 'KASAN_SHADOW_INIT' undeclared (first use in this function); did you mean 'KASAN_SHADOW_END'?
> >
> > We should really only allow enabling KASAN when all its dependencies
> > are met as it was before the introduction of CONFIG_KASAN_SW_TAGS.
> >
> > Fixes: b8440cc16515 ("kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hi Arnd,
>
> Is this a patch against linux-next? The issue has been addressed by
> v13 of the patchset, which is now in the mm tree and should end up in
> the linux-next soon AFAIU.

Yes, I tested on today's linux-next. I'll drop the patch tomorrow then from
my test tree.

       Arnd
