Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95EAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCED206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n8oWMglI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfAIBOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:14:52 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43311 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfAIBOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:14:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so3729669vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 17:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2A/fwvQAV6lsXaJ6k3wt6YiW60CG0GvpiajItkhBSKM=;
        b=n8oWMglITuixTL1tZ9wTM2CGYxHozKdsRA5lE8adSfWGH4WWtOUV5ObEIZnZhA2oi1
         pnoDbf0G5Bc1gM97+cqY8nkA2OsL8uerocE7ZMJNIXWVT5rO4zyazNiPmAi+KHBTHwo7
         4Cgo+YWbK1/DZXziu1DQhgZ4Dx0r2iIvHRd4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2A/fwvQAV6lsXaJ6k3wt6YiW60CG0GvpiajItkhBSKM=;
        b=AFmuXvEyPYq/p6/Rmg2wdVccZ1ElMJNgJ+YK7ixILLlCSyH00byQAkQ7VN6MqjsWBr
         qQ6Z/QWGpaR/w0xmkDjvwhudBTzKGB5wLLzISQ+YfXy5aRW5HkEkoEx+eQdNRHK6FuoC
         Gj6bhByKT56yjI3uiPSNeNCvuSCaMIE57wPbUN3QXKlXVFALMInjCiwch6R3izlNqPFj
         +K9lQm6h5rvox6AbAy9Qt+ePRZRPhU5eAIvPAPsvnzYZJ4dAPdWPChIrIClDjOXy7inS
         Izlsj/uBRRX7xlCajjxTKLfPfuu4N/Jqc+vcAyx7a2RT7cozFg/bq2TXUvHdBMflhxcA
         wL2w==
X-Gm-Message-State: AJcUukfj2JoRnLPA17HSrLigTW+DV87NpgVt2sMGgH7V21TitMUHiprL
        Ww8h3M7I6NQyuyiU2UNMIBNpfD7dCBU=
X-Google-Smtp-Source: ALg8bN53XlNz+x6+VVnY7k40TNjilU958/NVMAiHIpfJd7HizdZZXaxmcnFuy5sJNR2WHvY9l5B9jg==
X-Received: by 2002:a67:820f:: with SMTP id e15mr1682051vsd.156.1546996490720;
        Tue, 08 Jan 2019 17:14:50 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id j25sm25780869uag.8.2019.01.08.17.14.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 17:14:49 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id e7so3760596vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 17:14:49 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr1681649vsl.188.1546996488909;
 Tue, 08 Jan 2019 17:14:48 -0800 (PST)
MIME-Version: 1.0
References: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
In-Reply-To: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 17:14:36 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
Message-ID: <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Add a tests for NULL pointer dereference
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 7:26 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Introduce lkdtm tests for NULL pointer dereference: check
> access or exec at NULL address.

Why is this not already covered by the existing tests? (Is there
something special about NULL that is being missed?) I'd expect SMAP
and SMEP to cover NULL as well.

-Kees

>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/misc/lkdtm/core.c  |  2 ++
>  drivers/misc/lkdtm/lkdtm.h |  2 ++
>  drivers/misc/lkdtm/perms.c | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index bc76756b7eda..36910e1d5c09 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -157,7 +157,9 @@ static const struct crashtype crashtypes[] = {
>         CRASHTYPE(EXEC_VMALLOC),
>         CRASHTYPE(EXEC_RODATA),
>         CRASHTYPE(EXEC_USERSPACE),
> +       CRASHTYPE(EXEC_NULL),
>         CRASHTYPE(ACCESS_USERSPACE),
> +       CRASHTYPE(ACCESS_NULL),
>         CRASHTYPE(WRITE_RO),
>         CRASHTYPE(WRITE_RO_AFTER_INIT),
>         CRASHTYPE(WRITE_KERN),
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index 3c6fd327e166..b69ee004a3f7 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -45,7 +45,9 @@ void lkdtm_EXEC_KMALLOC(void);
>  void lkdtm_EXEC_VMALLOC(void);
>  void lkdtm_EXEC_RODATA(void);
>  void lkdtm_EXEC_USERSPACE(void);
> +void lkdtm_EXEC_NULL(void);
>  void lkdtm_ACCESS_USERSPACE(void);
> +void lkdtm_ACCESS_NULL(void);
>
>  /* lkdtm_refcount.c */
>  void lkdtm_REFCOUNT_INC_OVERFLOW(void);
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index fa54add6375a..62f76d506f04 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -164,6 +164,11 @@ void lkdtm_EXEC_USERSPACE(void)
>         vm_munmap(user_addr, PAGE_SIZE);
>  }
>
> +void lkdtm_EXEC_NULL(void)
> +{
> +       execute_location(NULL, CODE_AS_IS);
> +}
> +
>  void lkdtm_ACCESS_USERSPACE(void)
>  {
>         unsigned long user_addr, tmp = 0;
> @@ -195,6 +200,19 @@ void lkdtm_ACCESS_USERSPACE(void)
>         vm_munmap(user_addr, PAGE_SIZE);
>  }
>
> +void lkdtm_ACCESS_NULL(void)
> +{
> +       unsigned long tmp;
> +       unsigned long *ptr = (unsigned long *)NULL;
> +
> +       pr_info("attempting bad read at %px\n", ptr);
> +       tmp = *ptr;
> +       tmp += 0xc0dec0de;
> +
> +       pr_info("attempting bad write at %px\n", ptr);
> +       *ptr = tmp;
> +}
> +
>  void __init lkdtm_perms_init(void)
>  {
>         /* Make sure we can write to __ro_after_init values during __init */
> --
> 2.13.3
>


-- 
Kees Cook
