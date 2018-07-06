Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F85C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D46D22446
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D46D22446
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeGFP0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:26:53 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40613 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753814AbeGFP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:26:52 -0400
Received: by mail-vk0-f68.google.com with SMTP id s23-v6so7020323vks.7;
        Fri, 06 Jul 2018 08:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XplO1Khr8qG2YDQ8Xs8MMP08rPJJotlrjJigrly8mIc=;
        b=J0hESVPGX3gEFHxDtaHpWXEIcxCr9TiT343pSJGtvsHnim6XVPJ1QWr413jWA02yWk
         /updDnvYK1pli94OnqXl3ub6UxcJeiJ+jMKF+hn5JYmwr1VJhiyI5107atBy67Pb9YD4
         OGk4Uaru9TCNYF0iY8P52eTJYoDmIQs4gKoY0jY1AdT7ssXP+Ls4OrrwPNCSM6whwHHe
         R6wWJ1SGRlGzaLo/9vM+TB9xUzjPR+o3RrgUOA84yT2Rvs31xxkGWGLzeWkpCaux+ado
         GKcv0oEFlprQzb1tNnlqlVwvxxEXANIoey4No/xb2YViLT6Qwbdi5kE6Y3oE1uQV9dSh
         V+Fw==
X-Gm-Message-State: APt69E0JvosbVWcci0HJKP3Rku2eruomRNv+R/lhKwqFkI4dN+u5Rd3Z
        N6Ju0LKVfBgXThWOb3fM1axjKkQqRg8TonM+VGaARc+s
X-Google-Smtp-Source: AAOMgpcnI+klWOR8I08LwtG2JSATANXuhYZn5byldr92qoVG12sd0PvNMx/9VfYxDOdo5876ZIBr7/uszRB3Kn5lPYI=
X-Received: by 2002:a1f:654:: with SMTP id 81-v6mr5913276vkg.159.1530890811546;
 Fri, 06 Jul 2018 08:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180706151528.3759312-1-arnd@arndb.de>
In-Reply-To: <20180706151528.3759312-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jul 2018 17:26:40 +0200
Message-ID: <CAMuHMdXhN_Mw-Z+71LetjX2mJar-F4m3_-FjqouHgvjqtMq4OA@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: r8a7779: hide unused r8a7779_platform_cpu_kill
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Jul 6, 2018 at 5:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> After the cleanup in r8a7779_smp_prepare_cpus(), the only remaining caller of
> r8a7779_platform_cpu_kill() is in an ifdef, which leads to a build warning
> without CONFIG_HOTPLUG_CPU:
>
> arch/arm/mach-shmobile/smp-r8a7779.c:26:12: error: 'r8a7779_platform_cpu_kill' defined but not used [-Werror=unused-function]
>
> This moves the function inside of that #ifdef to avoid the warning.
>
> Fixes: 62f55ce683e3 ("ARM: shmobile: r8a7779: Stop powering down secondary CPUs during early boot")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, seems like I only built the R-Car Gen2 code without
CONFIG_HOTPLUG_CPU...

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
