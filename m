Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF41C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7A92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBTOvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:51:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33379 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfBTOvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:51:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id x9so2140812qkf.0;
        Wed, 20 Feb 2019 06:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dtqk10ZgIAHu09454gFXtKTteBCSMlQx5PVXvXfWj2Q=;
        b=UFD2rgvXMcWpboWgml38qG4xyAWqzYqZn5mqF4T5zRYwJOZp0Rt6DFXvc2bZSk58+h
         VrOWIjwDJN4je+fl+H4qx3Ah6SHCzHblwfdg+36/hFZkCuxvdltS/Ayj9bnzhklHAtTv
         zqPPUwKyUsAVbEm8v2McXaqdynLXtAC4OFwK8RDV82r/5HdNCwm2w2D+CiZr9PdTWvqZ
         3Kobd0iLvS+ZLxvHdF+FJgoHZtFPEyGbU5cmZAs78XFA5fizxvK2YJkNzd2IWrrjsvwL
         DsK5fWIdbmnT0O3REEqsr+ANYkJmo8Y/JehtnWbWPpqlHOXhfQasVRjkGlBkA1AzLnk+
         3dBQ==
X-Gm-Message-State: AHQUAubpcxxxCQ2AtYAoXcEU8prnqKVp1QJnyymJj2RECV9szjiFgfdI
        ishG+gU10MMySCiH8fZCffraA4Um/PyYbsO4JbTM1w==
X-Google-Smtp-Source: AHgI3IaGtLgqzHHiPMxcl7KlZ4UnzA8PHRyEPc/SLtb4JkLhgZf0DZhF5Y+0OAff4SWkx253MKsKyJSirX5HN9abzmM=
X-Received: by 2002:a37:d492:: with SMTP id s18mr23821644qks.343.1550674291702;
 Wed, 20 Feb 2019 06:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
In-Reply-To: <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 15:51:14 +0100
Message-ID: <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 3:45 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Tue, Feb 19, 2019 at 10:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Building an arm64 allmodconfig kernel with clang results in over 140 warnings
> > about overly large stack frames, the worst ones being:
> >
> > drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size of 20224 bytes in function 'st7789v_prepare'
> > drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12: error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
> > drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes in function 'max3421_spi_thread'
> > drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes in function 'slic_ds26522_probe'
> > drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in function 'ccp_run_cmd'
> > drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840 bytes in function 'stv0367ter_algo'
> >
> > None of these happen with gcc today, and almost all of these are the result
> > of a single known bug in llvm.  Hopefully it will eventually get fixed with the
> > clang-9 release.
> >
> > In the meantime, the best idea I have is to turn off asan-stack for clang-8
> > and earlier, so we can produce a kernel that is safe to run.
>
> Hi Arnd,
>
> I don't think it's good to disable KASAN stack instrumentation for the
> whole kernel by default with clang. It makes more sense to disable
> stack instrumentation only for these few drivers.

Do you mean just the 114 files that we get warnings for in allmodconfig,
or also those that run into the same bug but stay below the warning limit,
and the ones that don't warn in allmodconfig but do warn in other
configurations?

I would have to some more research, but I expect several hundred
patches before we get to a clean randconfig build with a broken
compiler.

     Arnd
