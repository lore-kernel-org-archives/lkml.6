Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E9FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DA520892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DA520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeG3JBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:01:20 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37354 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeG3JBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:01:19 -0400
Received: by mail-ua0-f194.google.com with SMTP id y10-v6so7175035uao.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 00:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQtTymIw4tia0rPgA/OCw5KNlErlUZr8sYRLmIcLFw8=;
        b=ZPcf29qFmb0F2RZI6pdijz58v6XziJu6Wp5Nb5zli+F3l2FSrktbpwxcy1T7QFEu0n
         NFC/xr4/csmVJa6Zzt9HrsM2eIJu8D7FMt2nfuEOw4jypgUjEPpbJTkJsE5uKE/9Mqpb
         At8Asqmd7FKV91C30eEoeTSdchlMuXgSoR7ujOWiWbUW4ndeZjF2MiDDXbJxoQ4qKUxv
         p2M6P+7IaYdeba32egzRBGuMD/8ZQ32k+gezsYdkonL+yd1jNRkHpE0qiafOi5lf6NZm
         3NqquBAqqeQYga2EIqyPtArHiUjlBSLY8B6mDVrci9geZXPVwp521bbNlm/C8fXhBo/N
         xRGQ==
X-Gm-Message-State: AOUpUlHAcBsfFow9eZFIu+TSi/TuJksBlQWfKbFpRIV44X8kfwiXAO4Z
        TPhdYl0VjF+GP3A9C75ZvGq1Klt2DjKflb4Eddk=
X-Google-Smtp-Source: AAOMgpfLrpM+G1P2iBYCIPNfuauompe7phEdVhbzTMZuvxVNJAkWgVtKcrfVH3Mc4kzsWA+uSt2w2CMz0m5mbwVifqo=
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr11365755uae.72.1532935661635;
 Mon, 30 Jul 2018 00:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
 <87tvohi5ji.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvohi5ji.fsf@concordia.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jul 2018 09:27:30 +0200
Message-ID: <CAMuHMdURrJ6d22QCBsX9NKvmtaVckWKGayohgidBPpZoxwTrWg@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] macintosh/via-pmu: Replace via-pmu68k driver
 with via-pmu driver
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, Jul 30, 2018 at 8:47 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Finn Thain <fthain@telegraphics.com.au> writes:
> > Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> > switch over to that driver and remove the via-pmu68k driver.
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> >  arch/m68k/configs/mac_defconfig   |   2 +-
> >  arch/m68k/configs/multi_defconfig |   2 +-
> >  arch/m68k/mac/config.c            |   2 +-
> >  arch/m68k/mac/misc.c              |  48 +--
> >  drivers/macintosh/Kconfig         |  13 +-
> >  drivers/macintosh/Makefile        |   1 -
> >  drivers/macintosh/adb.c           |   2 +-
> >  drivers/macintosh/via-pmu68k.c    | 846 --------------------------------------
> >  include/uapi/linux/pmu.h          |   2 +-
> >  9 files changed, 14 insertions(+), 904 deletions(-)
> >  delete mode 100644 drivers/macintosh/via-pmu68k.c
>
> Geert are you OK with this and the other one that touches arch/m68k ?

Sure, feel free to take them through the PPC tree.
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
