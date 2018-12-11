Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4BFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420FA20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420FA20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLKIiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:38:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38523 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeLKIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:38:19 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so8129400qkg.5;
        Tue, 11 Dec 2018 00:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZt7QKxVXk9ndQlEI7kmMB68Fy8IDJAWcTf8yAG5W+4=;
        b=MGhQVXkzXH0fDY566J3Ba7cBHXiyNIjdMIa3CqQYwpj/LkMY3pNDrJH/2gCZ6fqYI1
         YIx3qOMYjuf5R/jMHc+gZqdB7qXLTk/jYk20QIElY2GdR+3hl2r48XRw+qKB2eb58b7j
         RpWDEhxQK6blgWjnfRPcFcGvnIZN/p4ykPAokQra2ZIV/EXIsuhtJaKFEesmGQT87yhc
         Xl/j3w/Gc/ywKI4psaBuUafBff74ylmdu38TII2dq1zBu8BfUjTrZeKztq+U1Z3MzQM5
         o4HkU0w3i+18A0OFX0i/VGK9oIvj8pXHERO656eJ6rELtXiKeY2PQwk0j4wv2+MK8yNB
         HYAQ==
X-Gm-Message-State: AA+aEWYjKT25rUOgppnx0LXKdvZ5ldapbgoY/bnor5JDIfPcgby6HENN
        2bUZGJ8nZ11hh8oGV+KXPJHcCvJn8N+5YkDAM6M=
X-Google-Smtp-Source: AFSGD/W4aEcrD6QZzZoZGoWYtbEtuO2qHaeg97uaWmSyydk2whcAldtkxB1xFf2U1yfUmVU0FUrsnuiYSjjzzIYoyr8=
X-Received: by 2002:a37:324a:: with SMTP id y71mr13926330qky.291.1544517497058;
 Tue, 11 Dec 2018 00:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20181210210033.3276054-1-arnd@arndb.de> <CAMuHMdU0fp5p1QoD=h6v=RW9V5NgMvhz-NpoK5_8NNsnMKtjhA@mail.gmail.com>
In-Reply-To: <CAMuHMdU0fp5p1QoD=h6v=RW9V5NgMvhz-NpoK5_8NNsnMKtjhA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 09:37:59 +0100
Message-ID: <CAK8P3a3d_jTHrgfh1tv-FB2hj5oHf-s+VzJwCY3F8-_yFuQx-g@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: fix build regressions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        biju.das@bp.renesas.com, fabrizio.castro@bp.renesas.com,
        yoshihiro.shimoda.uh@renesas.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 9:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Mon, Dec 10, 2018 at 10:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > A number of Kconfig options have become available now to random ARM
> > platforms outside of ARCH_MULTIPLATFORM, which now causes Kconfig
> > warnings, and other build errors when those select options that
> > lack additonal dependencies, e.g.:
> >
> > WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
> >   Depends on [n]: CPU_V7 [=n]
> >   Selected by [y]:
> >   - ARCH_RCAR_GEN2 [=y] && SOC_RENESAS [=y]
> >   - ARCH_R8A73A4 [=y] && SOC_RENESAS [=y] && ARM [=y]
> >
> > WARNING: unmet direct dependencies detected for SYS_SUPPORTS_EM_STI
> >   Depends on [n]: GENERIC_CLOCKEVENTS [=n]
> >   Selected by [y]:
> >   - ARCH_EMEV2 [=y] && SOC_RENESAS [=y] && ARM [=y]
> >
> > Put the old dependency on ARCH_RENESAS back for the moment to restore
> > the previous behavior.
>
> Thanks, the build bots must be lazy or overloaded these days...
> The ARM selects are indeed more troublesome than the ARM64 ones.
>
> BTW, did you see issues with the ARM64 Kconfig symbol move too,
> or is that mitigated by ARM64 always selecting GENERIC_CLOCKEVENTS?

I restarted my randconfig builder yesterday, and after a few hundred builds
on each architecture, I did not see any arm64 failures, so it's
probably ok there.
I have a clean build now (about to rebase to today's linux-next, which will
surely change that).

> > Fixes: 062887bf5ef7 ("ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks.

     Arnd
