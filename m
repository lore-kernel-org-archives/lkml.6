Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A2C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF30E206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBoQfeam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF30E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeJEXdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:33:00 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41252 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:33:00 -0400
Received: by mail-yb1-f196.google.com with SMTP id e16-v6so5632569ybk.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=11Lt/XyyFUOUvizV+5zi0RucOZ8Olzy75ohxp97m96Y=;
        b=aBoQfeamHuVD558Tet8ABrDiakz7Gb7edCSkLKKhIenZ6K2Gm1GtV580tmEncDA4C8
         rAL317uzP8WSqvlpQVCu8JmvJeUL3LWWoyeVe05mHo1Pmaw0V6Bgxqe8ftkPvkR38Q8v
         ka6+BtmVXQE5FKv90YbIB7aZBSPwk2uu29wHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=11Lt/XyyFUOUvizV+5zi0RucOZ8Olzy75ohxp97m96Y=;
        b=Or1SpAlIzO8rxwjq+A89yeocJ8VxD7iMv98VgLNmTUGWevUNug5iRfxoAltfms8ScI
         Hi4IPcNv/mFqmL7ONhG1tDmCoocghD6lVoQTLozwosUz+IckCX9UOwXmql1R7UnvPYMh
         4MbQGwbgSoG9wbCPmpbvFwsa1DqACoKbKgppaMjFGKJWT4u+Yydj/B7YfkoQYF30bOIO
         s+HsHp0U0whpYXlps4Js6j0T7kokbPtIWACPuBDv/vBawA+em0JttLfx13M/NkJQdyJQ
         uhYlNPxGhQA9AanNWwGY+dkGQxQi1ABqgDCiWpdIq4xPoLvphP9N/13AHGXW7z3i+EDd
         VH8Q==
X-Gm-Message-State: ABuFfoixEc/bMHDWccQJ1PSDHa5ccApJZ4QUM1XZ4WVINxssJiNfzcy/
        Wlv8yJbn0mK/V+wGRkMvM2tmsIiv/Yc=
X-Google-Smtp-Source: ACcGV60jrDn6yi54zeyh3uW6iSjNemLpOhhLYqUL5PFpPceD2dpqD4xoW4QjUQEOgJ+l4gtW9dZM0Q==
X-Received: by 2002:a25:2d07:: with SMTP id t7-v6mr6723386ybt.176.1538757211459;
        Fri, 05 Oct 2018 09:33:31 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id b71-v6sm8791360ywa.48.2018.10.05.09.33.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:33:30 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id w80-v6so5650579ybe.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 09:33:29 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr6666439ybg.171.1538757209129;
 Fri, 05 Oct 2018 09:33:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 09:33:28 -0700 (PDT)
In-Reply-To: <20181005161601.875388-1-arnd@arndb.de>
References: <20181005161601.875388-1-arnd@arndb.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 5 Oct 2018 09:33:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+GWO6qB-Raq7XKKoFvwWpg_ZtzYBAEbXiU+N=dTs5YHA@mail.gmail.com>
Message-ID: <CAGXu5j+GWO6qB-Raq7XKKoFvwWpg_ZtzYBAEbXiU+N=dTs5YHA@mail.gmail.com>
Subject: Re: [PATCH] ARM: orion: avoid VLA in orion_mpp_conf
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 9:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Testing randconfig builds found an instance of a VLA that was
> missed when determining that we have removed them all:
>
> arch/arm/plat-orion/mpp.c: In function 'orion_mpp_conf':
> arch/arm/plat-orion/mpp.c:31:2: error: ISO C90 forbids variable length array 'mpp_ctrl' [-Werror=vla]

Ah! Thanks for catching this. It seems "allmodconfig" isn't quite "all". ;)

> This one is fairly straightforward: we know what all three
> callers are, and the maximum length is not very long.
>
> Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/plat-orion/mpp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
> index 5b4ff9373c89..8a6880d528b6 100644
> --- a/arch/arm/plat-orion/mpp.c
> +++ b/arch/arm/plat-orion/mpp.c
> @@ -28,10 +28,15 @@ void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int variant_mask,
>                            unsigned int mpp_max, void __iomem *dev_bus)

arch/arm/mach-dove/mpp.c:       orion_mpp_conf(mpp_list, 0, MPP_MAX,
DOVE_MPP_VIRT_BASE);
arch/arm/mach-dove/mpp.c-
--
arch/arm/mach-mv78xx0/mpp.c:    orion_mpp_conf(mpp_list, mv78xx0_variant(),
arch/arm/mach-mv78xx0/mpp.c-                   MPP_MAX, DEV_BUS_VIRT_BASE);
--
arch/arm/mach-orion5x/mpp.c:    orion_mpp_conf(mpp_list, orion5x_variant(),
arch/arm/mach-orion5x/mpp.c-                   MPP_MAX,
ORION5X_DEV_BUS_VIRT_BASE);

arch/arm/mach-dove/mpp.h:#define MPP_MAX                        23
arch/arm/mach-mv78xx0/mpp.h:#define MPP_MAX            49
arch/arm/mach-orion5x/mpp.h:#define MPP_MAX                     19

>  {
>         unsigned int mpp_nr_regs = (1 + mpp_max/8);
> -       u32 mpp_ctrl[mpp_nr_regs];
> +       u32 mpp_ctrl[8];

Largest possible is 1 + 49 / 8 == 7. But 8 makes it nice an round. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

>         int i;
>
>         printk(KERN_DEBUG "initial MPP regs:");
> +       if (mpp_nr_regs > ARRAY_SIZE(mpp_ctrl)) {
> +               printk(KERN_ERR "orion_mpp_conf: invalid mpp_max\n");
> +               return;
> +       }
> +
>         for (i = 0; i < mpp_nr_regs; i++) {
>                 mpp_ctrl[i] = readl(mpp_ctrl_addr(i, dev_bus));
>                 printk(" %08x", mpp_ctrl[i]);
> --
> 2.18.0
>

-Kees

-- 
Kees Cook
Pixel Security
