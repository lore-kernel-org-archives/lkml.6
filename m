Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEFBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A715C208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kX1FYggq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A715C208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeH1B5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:57:12 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41561 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1B5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:57:12 -0400
Received: by mail-yw1-f68.google.com with SMTP id q129-v6so214046ywg.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CkL6JdI/pDE2OSYbk6WhV7K8EnI9iaftzDy8jFxv6CA=;
        b=kX1FYggq5MEacIB8bnHAQVUdH/p4dek1u1nq5TdqeldsVbVJ8hwgkV6ZeZWikyDYY0
         /8BJIU5Rbuz6DjXJZQP66sRFToERtcKQlbip9RHjLKUQv9x2luajOfQgfyDhiGf3VBlP
         QkRCfglC33q1k4yaki71NnQtDcLKr/ftjVPYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CkL6JdI/pDE2OSYbk6WhV7K8EnI9iaftzDy8jFxv6CA=;
        b=DyH8hFM7UYptcC4OzTI6JxixbN5MTiWB0OCNn1Lzt6QOfWRhObepU7stMuTpWDwAfr
         ajYWn1VhMzNh/EqdDMRen6lhvlvWyRUMSb1neCG+6REGWWNRqY9OlO+Gy5YoZDfx+t2+
         3rjGuRP3Geyn1erVt/y7NY2XeXluKZ3usxGW9hsjTmxetQB4X5j7oB5eZvxHSvzKSEoY
         sUBxHHrME/F4bOmYb9sMnL5CwaTJpaoVvlzjNoUlMt9A1wSwFYMkltZPZEAl9Wc5X7Wf
         q/Fc7fa8knR9bSviwH0a5hW4GVIg4YxKxhatQH4ZszDkhGlDILQZXN//oT1KU8kbS1su
         8yvw==
X-Gm-Message-State: APzg51C2ok8DhY1ngByscWPcr1alDb2pdF7I1U0fyov1mowMLyFF5DO7
        4mT4Zl6r+MHhQoWe+78uadp9okcozqk=
X-Google-Smtp-Source: ANB0VdahWcOvLYn2OeyNJskTQxvDPS8vmKCCIivKTcF+eweX10XrE4Nz9XWY+dO/q6KZkWRZc4L9Yg==
X-Received: by 2002:a81:1b82:: with SMTP id b124-v6mr8142592ywb.381.1535407719033;
        Mon, 27 Aug 2018 15:08:39 -0700 (PDT)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com. [209.85.213.178])
        by smtp.gmail.com with ESMTPSA id 189-v6sm432911ywf.4.2018.08.27.15.08.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 15:08:37 -0700 (PDT)
Received: by mail-yb0-f178.google.com with SMTP id l16-v6so208546ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 15:08:37 -0700 (PDT)
X-Received: by 2002:a25:7349:: with SMTP id o70-v6mr8206546ybc.403.1535407717151;
 Mon, 27 Aug 2018 15:08:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 15:08:36
 -0700 (PDT)
In-Reply-To: <20180827185631.163506-8-jannh@google.com>
References: <20180827185631.163506-1-jannh@google.com> <20180827185631.163506-8-jannh@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Aug 2018 15:08:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLrmzowaoSq_a0KM2O604ri45V-JMF9un=dE4zSc7sLSA@mail.gmail.com>
Message-ID: <CAGXu5jLrmzowaoSq_a0KM2O604ri45V-JMF9un=dE4zSc7sLSA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] lkdtm: test copy_to_user() on bad kernel pointer
 under KERNEL_DS
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:56 AM, Jann Horn <jannh@google.com> wrote:
> Test whether the kernel WARN()s when, under KERNEL_DS, a bad kernel pointer
> is used as "userspace" pointer. Should normally be used in "DIRECT" mode.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/misc/lkdtm/core.c     |  1 +
>  drivers/misc/lkdtm/lkdtm.h    |  1 +
>  drivers/misc/lkdtm/usercopy.c | 13 +++++++++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 2154d1bfd18b..5a755590d3dc 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -183,6 +183,7 @@ static const struct crashtype crashtypes[] = {
>         CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
>         CRASHTYPE(USERCOPY_STACK_BEYOND),
>         CRASHTYPE(USERCOPY_KERNEL),
> +       CRASHTYPE(USERCOPY_KERNEL_DS),
>  };
>
>
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index 9e513dcfd809..07db641d71d0 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -82,5 +82,6 @@ void lkdtm_USERCOPY_STACK_FRAME_TO(void);
>  void lkdtm_USERCOPY_STACK_FRAME_FROM(void);
>  void lkdtm_USERCOPY_STACK_BEYOND(void);
>  void lkdtm_USERCOPY_KERNEL(void);
> +void lkdtm_USERCOPY_KERNEL_DS(void);
>
>  #endif
> diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
> index 9725aed305bb..389475b25bb7 100644
> --- a/drivers/misc/lkdtm/usercopy.c
> +++ b/drivers/misc/lkdtm/usercopy.c
> @@ -322,6 +322,19 @@ void lkdtm_USERCOPY_KERNEL(void)
>         vm_munmap(user_addr, PAGE_SIZE);
>  }
>
> +void lkdtm_USERCOPY_KERNEL_DS(void)
> +{
> +       char __user *user_ptr = (char __user *)ERR_PTR(-EINVAL);
> +       mm_segment_t old_fs = get_fs();
> +       char buf[10] = {0};
> +
> +       pr_info("attempting copy_to_user on unmapped kernel address\n");
> +       set_fs(KERNEL_DS);
> +       if (copy_to_user(user_ptr, buf, sizeof(buf)))
> +               pr_info("copy_to_user un unmapped kernel address failed\n");
> +       set_fs(old_fs);
> +}
> +
>  void __init lkdtm_usercopy_init(void)
>  {
>         /* Prepare cache that lacks SLAB_USERCOPY flag. */
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>



-- 
Kees Cook
Pixel Security
