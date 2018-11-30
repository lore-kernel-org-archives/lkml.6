Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8137DC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F1C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KKgmBIzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F1C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeLAG7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:59:00 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40194 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeLAG7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:59:00 -0500
Received: by mail-yw1-f65.google.com with SMTP id r130so2759220ywg.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LYpvSrpQ9dcoi03g4ER+RIXiPYci9RgyF3SIrkS2oXE=;
        b=KKgmBIzmu4oI+polNLq5Brfpj1qS0y7lvSd49FBKk9CcGZuKKj8UuOM4epzEF29QJ7
         bvml7VPcPsS1PUzqEniYi6zqQ5zMFNRon/sJsdG1cwekDj33O97yHV39FZgP8Ubskp4Q
         NAEfKfLDyoazvCvjnJvPRFC1nAEDM5YacVh+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LYpvSrpQ9dcoi03g4ER+RIXiPYci9RgyF3SIrkS2oXE=;
        b=apZBzyTtPTh9RG349iprBYQsZzgzq1rvnuIeRdi9wk4lfQyJhYnrJ+aJ+H3bf8UoSu
         1m08TiT41QNuV7+FzSChJGJMJuSQciXlOjPhv7a18JZmc4BTchx3c8uapuT0iWdJ18TB
         qqor2/YiwS9m2VRCWfPIKc0ZkinAYl3g6aFIU4I2C6pSeepIBpLpQqZ0mD3Zjv3fbZoI
         hgsm0ZgxCbhYZb72dE8vJrnaRdwCRw5YRDaVCx1q0L0z421Ea1aKHmS3qPyQYs19ccCL
         yR0bMMCioAuz9tJWjSrWcdU/LUfNNxWZK3uGCzLUv8m8I6tY7C0HNSlteTYZuFL8T+rk
         xP7w==
X-Gm-Message-State: AA+aEWaw2qqTmX1+QaoJumOYia7Lin8/B4VEQX7x7tPN4lZzzqdGX3+A
        qnfiNDggpGbfI1TXHw+BxW6Ni1AI1Pk=
X-Google-Smtp-Source: AFSGD/VCRZmIzM3IMkuuHGUmgzCtJMaiH44lMpH2vsWO+6Y5cOc14KrSfrHrf+15fJUna6iwm5mNlg==
X-Received: by 2002:a81:848b:: with SMTP id u133mr7125062ywf.15.1543607317196;
        Fri, 30 Nov 2018 11:48:37 -0800 (PST)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id i21sm6307943ywg.5.2018.11.30.11.48.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 11:48:36 -0800 (PST)
Received: by mail-yw1-f54.google.com with SMTP id f65so2761642ywc.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:48:36 -0800 (PST)
X-Received: by 2002:a81:28c7:: with SMTP id o190mr7206977ywo.288.1543607315834;
 Fri, 30 Nov 2018 11:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
In-Reply-To: <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 30 Nov 2018 11:48:24 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+DE0CkRf92yyPo6dzG8FODBCz_=3J6S2oFat4UyLKwjw@mail.gmail.com>
Message-ID: <CAGXu5j+DE0CkRf92yyPo6dzG8FODBCz_=3J6S2oFat4UyLKwjw@mail.gmail.com>
Subject: Fwd: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
To:     LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend with CCs dropped so it'll actually get delivered to lkml...]

On Fri, Nov 30, 2018 at 11:27 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to comply with the CoC, replace **** with a hug.

Heh. I support the replacement of the stronger language, but I find
"hug", "hugged", and "hugging" to be very weird replacements. Can we
bikeshed this to "heck", "hecked", and "hecking" (or "heckin" to
follow true Doggo meme style).

"This API is hugged" doesn't make any sense to me. "This API is
hecked" is better, or at least funnier (to me). "Hug this interface"
similarly makes no sense, but "Heck this interface" seems better.
"Don't touch my hecking code", "What the heck were they thinking?"
etc... "hug" is odd.

Better yet, since it's only 17 files, how about doing context-specific
changes? "This API is terrible", "Hateful interface", "Don't touch my
freakin' code", "What in the world were they thinking?" etc?

-Kees

>
> Jarkko Sakkinen (15):
>   MIPS: replace **** with a hug
>   Documentation: replace **** with a hug
>   drm/nouveau: replace **** with a hug
>   m68k: replace **** with a hug
>   parisc: replace **** with a hug
>   cpufreq: replace **** with a hug
>   ide: replace **** with a hug
>   media: replace **** with a hug
>   mtd: replace **** with a hug
>   net/sunhme: replace **** with a hug
>   scsi: replace **** with a hug
>   inotify: replace **** with a hug
>   irq: replace **** with a hug
>   lib: replace **** with a hug
>   net: replace **** with a hug
>
>  Documentation/kernel-hacking/locking.rst      |  2 +-
>  arch/m68k/include/asm/sun3ints.h              |  2 +-
>  arch/mips/pci/ops-bridge.c                    | 24 +++++++++----------
>  arch/mips/sgi-ip22/ip22-setup.c               |  2 +-
>  arch/parisc/kernel/sys_parisc.c               |  2 +-
>  drivers/cpufreq/powernow-k7.c                 |  2 +-
>  .../gpu/drm/nouveau/nvkm/subdev/bios/init.c   |  2 +-
>  .../nouveau/nvkm/subdev/pmu/fuc/macros.fuc    |  2 +-
>  drivers/ide/cmd640.c                          |  2 +-
>  drivers/media/i2c/bt819.c                     |  8 ++++---
>  drivers/mtd/mtd_blkdevs.c                     |  2 +-
>  drivers/net/ethernet/sun/sunhme.c             |  4 ++--
>  drivers/scsi/qlogicpti.h                      |  2 +-
>  fs/notify/inotify/inotify_user.c              |  2 +-
>  kernel/irq/timings.c                          |  2 +-
>  lib/vsprintf.c                                |  2 +-
>  net/core/skbuff.c                             |  2 +-
>  17 files changed, 33 insertions(+), 31 deletions(-)
>
> --
> 2.19.1
>

-- 
Kees Cook
