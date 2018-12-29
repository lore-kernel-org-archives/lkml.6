Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25609C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CC920818
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeL2WUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:20:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35809 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeL2WUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:20:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so26569547qtc.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 14:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEKNttcn2DuV6IUidckb9z98s4YMQSt0m/gFTL7QWxY=;
        b=shwh4ihixViS4Lg9Tm9sbCvuoLdDLfLCsT50s76NHskzs/NW+C1psJ9rwNVoa+pCL+
         neuE/Gb6zu6rVtYyabpf6kRVJfxrPBmqwixDqjNNXYh/mxcmy+Qd7ecsyimTn7Sfr5sT
         3gDY/rxkRQyrDI4maO0Vec2+jB+/C4n3DePJ0K9piMdE0/i/md1YpqDZtm4D262kPo+l
         +p8Ff1bjeW4i9AC62f+B2/BAJZkmUkBT8CdAfTbIq8LNd64KTaaYn09cb9aDT1/spQE7
         iHu5fI7Vrkd+3vrTU6K4cvpRGFDi4XjMzi+kcdNeofK7bDf1KgsBjPAw6Ug8MWi7tSPX
         CHuA==
X-Gm-Message-State: AA+aEWZDSyIsVL79mqP7K5cHQ2HwdBzjHfpeoCbYdeBdEN+ayLKr9B5i
        TwaQnFsMT4qGGyKXOaNG7bNO4gx6Tu6L/nMZ8eY=
X-Google-Smtp-Source: AFSGD/VP4OgqTevr0l0kgt+jsLmHm4koubyN5NQH8QXOPDhgnoDNjTdGQzAzSL0INVYSyEyZd+6OwMNuoJ/8J8lFSpM=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr30221440qtr.319.1546122013947;
 Sat, 29 Dec 2018 14:20:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au> <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Dec 2018 23:19:57 +0100
Message-ID: <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/drivers/char/nvram.c
> +++ b/drivers/char/nvram.c
> @@ -48,6 +48,10 @@
>  #include <linux/mutex.h>
>  #include <linux/pagemap.h>
>
> +#ifdef CONFIG_PPC
> +#include <asm/nvram.h>
> +#include <asm/machdep.h>
> +#endif
>
>  static DEFINE_MUTEX(nvram_mutex);
>  static DEFINE_SPINLOCK(nvram_state_lock);
> @@ -331,6 +335,37 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>         long ret = -ENOTTY;
>
>         switch (cmd) {
> +#ifdef CONFIG_PPC
> +       case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
> +               pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
> +               /* fall through */
> +       case IOC_NVRAM_GET_OFFSET:
> +               ret = -EINVAL;
> +#ifdef CONFIG_PPC_PMAC

I think it would make be nicer here to keep the ppc bits in arch/ppc,
and instead add a .ioctl() callback to nvram_ops.

> @@ -369,12 +405,14 @@ static int nvram_misc_open(struct inode *inode, struct file *file)
>                 return -EBUSY;
>         }
>
> +#ifndef CONFIG_PPC
>         /* Prevent multiple writers if the set_checksum ioctl is implemented. */
>         if ((arch_nvram_ops.set_checksum != NULL) &&
>             (file->f_mode & FMODE_WRITE) && (nvram_open_mode & NVRAM_WRITE)) {
>                 spin_unlock(&nvram_state_lock);
>                 return -EBUSY;
>         }
> +#endif
>
> diff --git a/include/linux/nvram.h b/include/linux/nvram.h
> index b7bfaec60a43..24a57675dba1 100644
> --- a/include/linux/nvram.h
> +++ b/include/linux/nvram.h
> @@ -18,8 +18,12 @@ struct nvram_ops {
>         unsigned char   (*read_byte)(int);
>         void            (*write_byte)(unsigned char, int);
>         ssize_t         (*get_size)(void);
> +#ifdef CONFIG_PPC
> +       long            (*sync)(void);
> +#else
>         long            (*set_checksum)(void);
>         long            (*initialize)(void);
> +#endif
>  };

Maybe just leave all entries visible here, and avoid the above #ifdef checks.

       Arnd
