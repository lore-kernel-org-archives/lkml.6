Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A543C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFE32080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFE32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeLAAgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:36:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36107 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLAAgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:36:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so5859419qtn.3;
        Fri, 30 Nov 2018 05:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiIiq+eBwupJMmehByf87me5bWCoRjY4A7/Tc6drQ5A=;
        b=VW5bYGcrMmVEBT6uA27po1fI2QyeFmVVbQ7gz7gWdOgAu7O1H9sliIk564QsFNB+7x
         f7zZ4gq8B6cja49P612LhIcpLhZdRWBhMy6Z5PIR7jMz82z5CMFs+fesElTZCdgRUak4
         7E6Y/LfDW3tzx+DHUz9CfwVMshKhNh9zyEZNZ8VYDpUuS65Mx2mhgWCQIg/oOJY5zUOS
         1VAlhS8ykOtb31saEcucIexM6BaC8vR0W9hEYixIJ+xh77zcDUQ64iKA8l6sbvJuhABB
         lJt+bxg1YTTqmJa49MLfeC7ta5SjqvYml5a260rnsnjOF3kJJo2Dsgqc+1gDcBqZq/0p
         3q7A==
X-Gm-Message-State: AA+aEWbKptVocN4wheNpYveeoKzp99W4++7+5dg0fzRlte75BHfwWblI
        4jsimXnWMVAZLITcnDx4mbdRKm2nnyM1EvY4iRU=
X-Google-Smtp-Source: AFSGD/W9KBzauhsLZSWYV1MD/+wETNGmwKn1bhig5mEFb8JsuSZwoviUOz2+i4bIt7aLh3YOg+4qq/DvEZzSdlFTG44=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr5554344qta.152.1543584401848;
 Fri, 30 Nov 2018 05:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org> <20181130104657.14875-5-srinivas.kandagatla@linaro.org>
In-Reply-To: <20181130104657.14875-5-srinivas.kandagatla@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 14:26:23 +0100
Message-ID: <CAK8P3a0CzU5mGE9YBfe5FVPGCBhjFRsZbgbyy8Yvopu4wQ7uxA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] char: fastrpc: Add support for create remote init process
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> +
> +static int fastrpc_init_process(struct fastrpc_user *fl,
> +                               struct fastrpc_ioctl_init *init)
> +{
> +       struct fastrpc_ioctl_invoke *ioctl;
> +       struct fastrpc_phy_page pages[1];
> +       struct fastrpc_map *file = NULL, *mem = NULL;
> +       struct fastrpc_buf *imem = NULL;
> +       int err = 0;
> +
> +       ioctl = kzalloc(sizeof(*ioctl), GFP_KERNEL);
> +       if (!ioctl)
> +               return -ENOMEM;
> +
> +       if (init->flags == FASTRPC_INIT_ATTACH) {
> +               remote_arg_t ra[1];
> +               int tgid = fl->tgid;
> +
> +               ra[0].buf.pv = (void *)&tgid;
> +               ra[0].buf.len = sizeof(tgid);
> +               ioctl->handle = 1;
> +               ioctl->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
> +               ioctl->pra = ra;
> +               fl->pd = 0;
> +
> +               err = fastrpc_internal_invoke(fl, 1, ioctl);
> +               if (err)
> +                       goto bail;

It doesn't seem right to me to dynamically allocate an 'ioctl' data structure
from kernel context and pass that down to another function. Maybe eliminate
that structure and change fastrpc_internal_invoke to take the individual
arguments here instead of a pointer?

> +       } else if (init->flags == FASTRPC_INIT_CREATE) {

How about splitting each flags== case into a separate function?

> diff --git a/include/uapi/linux/fastrpc.h b/include/uapi/linux/fastrpc.h
> index 8fec66601337..6b596fc7ddf3 100644
> --- a/include/uapi/linux/fastrpc.h
> +++ b/include/uapi/linux/fastrpc.h
> @@ -6,6 +6,12 @@
>  #include <linux/types.h>
>
>  #define FASTRPC_IOCTL_INVOKE   _IOWR('R', 3, struct fastrpc_ioctl_invoke)
> +#define FASTRPC_IOCTL_INIT     _IOWR('R', 4, struct fastrpc_ioctl_init)
> +
> +/* INIT a new process or attach to guestos */
> +#define FASTRPC_INIT_ATTACH      0
> +#define FASTRPC_INIT_CREATE      1
> +#define FASTRPC_INIT_CREATE_STATIC  2

Maybe use three command codes here, and remove the 'flags' member?

> @@ -53,4 +59,16 @@ struct fastrpc_ioctl_invoke {
>         unsigned int *crc;
>  };
>
> +struct fastrpc_ioctl_init {
> +       uint32_t flags;         /* one of FASTRPC_INIT_* macros */
> +       uintptr_t file;         /* pointer to elf file */
> +       uint32_t filelen;       /* elf file length */
> +       int32_t filefd;         /* ION fd for the file */

What does this have to do with ION? The driver seems to otherwise
just use the generic dma_buf interfaces.

> +       uintptr_t mem;          /* mem for the PD */
> +       uint32_t memlen;        /* mem length */
> +       int32_t memfd;          /* fd for the mem */
> +       int attrs;
> +       unsigned int siglen;
> +};

This structure is again not suitable for ioctls. Please used fixed-length
members and no holes in the structure.

       Arnd
