Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465D4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9294208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hmh2svcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9294208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeH1BoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:44:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37915 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1BoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:44:20 -0400
Received: by mail-yw1-f65.google.com with SMTP id n21-v6so209979ywh.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=v1FRi6G8+u/RF10vNmoCfUzxuuIG6weXUPlAw76GWpk=;
        b=Hmh2svcrZOMbuRbRvrEvBUKNyagqPkCqL6K3TkNlkpDLAob5xyeDU9JKbi4p6ulsyw
         kNHxzoqRoattTGqcEu/snbioXP8XMJwl15ZxMKl+JtoyKWLf1pe0aS1UTsUqRb6oA3BG
         ec1Ft5uVJ4VYMnOGq7iyad+IrArQ88NF1sOzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v1FRi6G8+u/RF10vNmoCfUzxuuIG6weXUPlAw76GWpk=;
        b=QYYrBXCVH4Rv16OIrkrZwYkQgF6E9m0XZQI9POuz//6/alxLdHAHvAUoFg8ESrKTQg
         gyPjzkK578U5+iPqM5idgJJxVwolqX6/hocfVzvrWRRRKo+A7xpP80/JZkXqAAfqt5NX
         2GVzzLygGPzgT/8lTZA6ftsq39OCtnaaOufRas9Ou8FmyWjB4+ptpxvFaOfFiaEVQ0xO
         nAq1zv85YZiRzI2tm/z1EgIZjm+oeJvt1iPt4k5Jxxip2xDg9jPeDMRrO7JVESYaKpAG
         KFNrwsAf/8FJZh6e49xrZLi6w9XUe3/wWbHq30gQ5tzB3iWh4IEExO29d23BF3hNRGTA
         EOFw==
X-Gm-Message-State: APzg51Bg71A4N5RgvwKnbfHzeGFrB6matk6t8tTzE0FgFP77z24rH/pV
        ArHAF+I4x8+q3xKT1vi/pQFsC4ZBK6A=
X-Google-Smtp-Source: ANB0Vdb7OwedDumZv+2w3OC7z4ATm6jUxpC6jCS1IxBp70ve6N+i84CBzsg2f06lWOS7uBbw84bwWg==
X-Received: by 2002:a0d:f141:: with SMTP id a62-v6mr7703583ywf.202.1535406950297;
        Mon, 27 Aug 2018 14:55:50 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id b135-v6sm359937ywh.24.2018.08.27.14.55.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 14:55:49 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id n21-v6so209950ywh.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:55:49 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr7941746ywg.47.1535406948623;
 Mon, 27 Aug 2018 14:55:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 14:55:48
 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Aug 2018 14:55:48 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL9b3Ks95fpq5tdqS1avQysasaCBDzaA31-FVmJCqz=Og@mail.gmail.com>
Message-ID: <CAGXu5jL9b3Ks95fpq5tdqS1avQysasaCBDzaA31-FVmJCqz=Og@mail.gmail.com>
Subject: checkpatch.pl bug? (was Re: [PATCH] random: Make CPU trust a boot parameter)
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 2:51 PM, Kees Cook <keescook@chromium.org> wrote:
> Instead of forcing a distro or other system builder to choose
> at build time whether the CPU is trusted for CRNG seeding via
> CONFIG_RANDOM_TRUST_CPU, provide a boot-time parameter for end users to
> control the choice. The CONFIG will set the default state instead.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  drivers/char/Kconfig                            |  4 ++--
>  drivers/char/random.c                           | 11 ++++++++---
>  3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9871e649ffef..64a3bf54b974 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3523,6 +3523,12 @@
>         ramdisk_size=   [RAM] Sizes of RAM disks in kilobytes
>                         See Documentation/blockdev/ramdisk.txt.
>
> +       random.trust_cpu={on,off}
> +                       [KNL] Enable or disable trusting the use of the
> +                       CPU's random number generator (if available) to
> +                       fully seed the kernel's CRNG. Default is controlled
> +                       by CONFIG_RANDOM_TRUST_CPU.
> +
>         ras=option[,option,...] [KNL] RAS-specific options
>
>                 cec_disable     [X86]
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index ce277ee0a28a..40728491f37b 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -566,5 +566,5 @@ config RANDOM_TRUST_CPU
>         that CPU manufacturer (perhaps with the insistence or mandate
>         of a Nation State's intelligence or law enforcement agencies)
>         has not installed a hidden back door to compromise the CPU's
> -       random number generation facilities.
> -
> +       random number generation facilities. This can also be configured
> +       at boot with "random.trust_cpu=on/off".
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index bf5f99fc36f1..c75b6cdf0053 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -779,6 +779,13 @@ static struct crng_state **crng_node_pool __read_mostly;
>
>  static void invalidate_batched_entropy(void);
>
> +static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
> +static int __init parse_trust_cpu(char *arg)
> +{
> +       return kstrtobool(arg, &trust_cpu);
> +}
> +early_param("random.trust_cpu", parse_trust_cpu);
> +
>  static void crng_initialize(struct crng_state *crng)
>  {
>         int             i;
> @@ -799,12 +806,10 @@ static void crng_initialize(struct crng_state *crng)
>                 }
>                 crng->state[i] ^= rv;
>         }
> -#ifdef CONFIG_RANDOM_TRUST_CPU
> -       if (arch_init) {
> +       if (trust_cpu && arch_init) {

checkpatch.pl complains:

ERROR: space prohibited after that '&&' (ctx:WxW)
#79: FILE: drivers/char/random.c:809:
+       if (trust_cpu && arch_init) {
                      ^

I can't figure out what is going on here. Using "||" doesn't trigger
the issue; it seems related to the earlier "&trust_cpu" use in the
patch, but I can't figure out what checkpatch was trying to do with
this...

-Kees

>                 crng_init = 2;
>                 pr_notice("random: crng done (trusting CPU's manufacturer)\n");
>         }
> -#endif
>         crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
>  }
>
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
