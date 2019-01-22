Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AA0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A02B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nnYtZQKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfAVV0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:26:11 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35299 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVV0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:26:11 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so20844vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA73U3orqts/aQvhT/E9hNnoUEIPSLYn2QJd+UKDOHA=;
        b=nnYtZQKIEw2X+lcZ7kxyFOE1X6P+2PGFEMJ/kFQKu+qPYt5cDrw9QYFujLbhzq/H5N
         ixJpF8CVtwbN/n/fiVb5Z68y7iUVBapOuCjDbmz5NxPlOY9/Dxgm8BLLv/R+h1XC5cNL
         cEjSCkCGm6EnG0T8KY3vRbxOOQ3ncK9o1HsJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA73U3orqts/aQvhT/E9hNnoUEIPSLYn2QJd+UKDOHA=;
        b=r8/8ATjvK03aA4FArazjzGyHH5jKfHJG/kfIvZVUsP1FiOZk19tL2gOuxZQ7nRtokr
         lceCLxsNPjBpicvrZ8l5sgYXYZ4sa2d/7Vklsd15b/BQbGHT4B56eBCxVbNh5lr5VtZZ
         Cmi90q3XzxGdTqRNJ4nOqSw/xYYOBzh9wKn5dAm17LqVIalc0WNwRq7VMWegN5qoDvxE
         UpFFC1r/lhFPYHlO/t0gnBvJC5dpzIHcbHYEzjXkBc/DP6WnEex9rmJlWseyyxWetsm5
         aa2tzUR7LJXutjIHoCsHVJqIRpKFCu4WYPlCxvEPldVJwCloKLPb0UMP6sHboU9Iujvx
         0CNw==
X-Gm-Message-State: AJcUukdF/KT9fzFEuL19jod/qjm6pPsNqYHhddVEwR6ei7nMDdoeYP3B
        DlXVOEtz6qE0aWuJX1O2Y29OS4OvZP8=
X-Google-Smtp-Source: ALg8bN5KvUPBMf0RKtYnSCSoj8OndNafK4spRV9aQoJmmwBHUJGuq9sETIUDAJ1ZPn6vChhHgS3wzw==
X-Received: by 2002:a67:f114:: with SMTP id n20mr15264217vsk.90.1548192369684;
        Tue, 22 Jan 2019 13:26:09 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id n206sm72042605vkn.36.2019.01.22.13.26.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:26:08 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id n13so13104vsk.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:26:07 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr14586369vss.172.1548192366962;
 Tue, 22 Jan 2019 13:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20190122144114.9816-1-gregkh@linuxfoundation.org> <20190122144114.9816-3-gregkh@linuxfoundation.org>
In-Reply-To: <20190122144114.9816-3-gregkh@linuxfoundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 23 Jan 2019 10:25:53 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJPyKwM3E=-pnRBJ0NCb4kMB7EtLdS-+5khE76qnEhcdQ@mail.gmail.com>
Message-ID: <CAGXu5jJPyKwM3E=-pnRBJ0NCb4kMB7EtLdS-+5khE76qnEhcdQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: dump: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 3:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Jinbum Park <jinb.park7@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Do you mean that it bubbles up to an initcall, and the return value is
meaningless there? This seems fine to me...

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/include/asm/ptdump.h | 9 +++------
>  arch/arm/mm/dump.c            | 4 ++--
>  arch/arm/mm/ptdump_debugfs.c  | 8 ++------
>  3 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
> index 3ebf9718288d..0c2d3d0d4cc6 100644
> --- a/arch/arm/include/asm/ptdump.h
> +++ b/arch/arm/include/asm/ptdump.h
> @@ -21,13 +21,10 @@ struct ptdump_info {
>
>  void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
>  #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
> -int ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> +void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>  #else
> -static inline int ptdump_debugfs_register(struct ptdump_info *info,
> -                                       const char *name)
> -{
> -       return 0;
> -}
> +static inline void ptdump_debugfs_register(struct ptdump_info *info,
> +                                          const char *name) { }
>  #endif /* CONFIG_ARM_PTDUMP_DEBUGFS */
>
>  void ptdump_check_wx(void);
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 084779c5c893..eb385a500ed0 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -450,7 +450,7 @@ void ptdump_check_wx(void)
>  static int ptdump_init(void)
>  {
>         ptdump_initialize();
> -       return ptdump_debugfs_register(&kernel_ptdump_info,
> -                                       "kernel_page_tables");
> +       ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> +       return 0;
>  }
>  __initcall(ptdump_init);
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index be8d87be4b93..598b636615a2 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -24,11 +24,7 @@ static const struct file_operations ptdump_fops = {
>         .release        = single_release,
>  };
>
> -int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
> +void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>  {
> -       struct dentry *pe;
> -
> -       pe = debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
> -       return pe ? 0 : -ENOMEM;
> -
> +       debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
>  }
> --
> 2.20.1
>


-- 
Kees Cook
