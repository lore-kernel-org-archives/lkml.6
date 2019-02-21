Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C879C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C3C20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfBUPof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:44:35 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45339 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfBUPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:44:35 -0500
Received: by mail-ua1-f65.google.com with SMTP id e16so9634191uam.12;
        Thu, 21 Feb 2019 07:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eMh2+4Dzu8fH8dTG8IuUcw3i7yHGPBUrizuhfdjbzM=;
        b=Q0LWjaozhnYqMMcBHMD0Fua0qZOUJ+ULhEh537tLs1WCFgyO8ftyHUEzkdihKkoydK
         r1P1uEPpe9YW7A6Ub+pxaqZaVAz0jGfwA2NKmORRkvWRIk+ndMye9IXSXQTyTJxUzrM+
         HEE+UaOEBcEUGFCUvPZwWYFW/dO98NU3YIxaeDLWRQeU7pJLse6WLLvxwMqzggT+/ChO
         qQlcX/j7jZQPQ/JRY1TqCvJGBLmlf8Vr0k4A8x+s0r79TGfXIfP9d6itTYg0umoCMama
         9fAewp9uJmR8iXoAb8n+YqPPNZ3SLw9WiPa1TZInRQa4IQr1Mqef6CYF+O7M/GPBN0Ug
         yTXA==
X-Gm-Message-State: AHQUAua7ZzzFacvGuJwDulZJIN0emTEaxML54E6veIIIgw/e7Wo5kMgZ
        25BA7+YvOz///GxFThW35YXHF3XvxV6kU3gjNcY=
X-Google-Smtp-Source: AHgI3IYHR/rvso6r8oBc1YsmiKIWozJLbR7EZ4EqqZKb7c/uuOjbi1ImhsdIK1jqouVkO8hMKu9y1o7UYKxdNt8694g=
X-Received: by 2002:a67:ead0:: with SMTP id s16mr17405341vso.63.1550763874055;
 Thu, 21 Feb 2019 07:44:34 -0800 (PST)
MIME-Version: 1.0
References: <1550749552-8133-1-git-send-email-krzk@kernel.org> <1550749552-8133-3-git-send-email-krzk@kernel.org>
In-Reply-To: <1550749552-8133-3-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Feb 2019 16:44:22 +0100
Message-ID: <CAMuHMdUFvrW5RuhJxCoZdjzbYobJydcdTttkZTaRtL3=7Ao_Fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: samsung: exynos5: Fix kfree() of const memory
 on setting driver_override
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:46 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Platform driver driver_override field should not be initialized from
> const memory because the core later kfree() it.  If driver_override is
> manually set later through sysfs, kfree() of old value leads to:
>
>     $ echo "new_value" > /sys/bus/platform/drivers/.../driver_override
>
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058e8c0>] (platform_set_driver_override+0x84/0xac)
>     (platform_set_driver_override) from [<c058e908>] (driver_override_store+0x20/0x34)
>     (driver_override_store) from [<c031f778>] (kernfs_fop_write+0x100/0x1dc)
>     (kernfs_fop_write) from [<c0296de8>] (__vfs_write+0x2c/0x17c)
>     (__vfs_write) from [<c02970c4>] (vfs_write+0xa4/0x188)
>     (vfs_write) from [<c02972e8>] (ksys_write+0x4c/0xac)
>     (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
>
> The clk-exynos5-subcmu driver uses override only for the purpose of
> creating meaningful names for children devices (matching names of power
> domains, e.g. DISP, MFC).  The driver_override was not developed for
> this purpose so just switch to default names of devices to fix the
> issue.
>
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
