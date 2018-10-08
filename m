Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA02DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652772145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f2P4smmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652772145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJIFLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:11:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40797 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJIFLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:11:41 -0400
Received: by mail-yw1-f65.google.com with SMTP id l79-v6so8714884ywc.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=adb+csjHuh8r2n+XAl2fzZhXMg6U3zxIwhUI/NO8vvA=;
        b=f2P4smmKPxfCEB8ziBNLmSuXfnh9kUx1jd+luW7yJqAHgy9V+2SJ9FR/S27X3uW2w2
         zD7f74+Mw/zgkkksUDVL/CvkJotecx6Jalt3dpm4+KMR8s8YtUbwnC3R0BvBG4cIkFuN
         XArWIhCXIQEIUwkxS2lpj9Yx+ddEaiqHWEWtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=adb+csjHuh8r2n+XAl2fzZhXMg6U3zxIwhUI/NO8vvA=;
        b=F3dxD5GkYZfXTX9yJ9i+v5gDW8ksklgzrGCRIX8M08pl/5665NXW5HMvZFUh+wdStR
         7eIRbw4G+UemW//FFIZUSgh0K/3hFYeJhx/gWlhDgKbDlKmsx0ZtYYuK6mno8Y1jEiLm
         aDI03/3V7ZZxWKKEH41uKgSdX6HbPd2YmP1I4Xs68PLbqgXZ8KD4dtxKYEO0yxBqhL3v
         g7IVSjVD274PGC+ceIa+YCwAtoBmskXM633Kc7fnlFQB726ov7SW+E4TxIxerwZeL5gd
         dIluJdUltN3j61UraIuvN1iBRhbpWDrq7Om/HUt2uuf8wd+ghjTux/zH7CMM6t/ChoKy
         Jybw==
X-Gm-Message-State: ABuFfoj9zjql/ad5JE+skm1dLPBupw0FQgV5Pc8G5TJp8HGw4jGG0KwL
        6kBLbwNZ5HPNLS3a8LUs6IhcOLSV7c0=
X-Google-Smtp-Source: ACcGV63IzHEYysJqHloBoHPMsy17lOGGqMlEnCczDeJIu0Yzq7bqlyrdO39Y5bHEExrhiTkLHQXQEw==
X-Received: by 2002:a81:1393:: with SMTP id 141-v6mr13679820ywt.73.1539035870864;
        Mon, 08 Oct 2018 14:57:50 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id q6-v6sm761738ywh.41.2018.10.08.14.57.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 14:57:49 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id a197-v6so8713968ywh.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 14:57:49 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr14716384ywp.407.1539035869058;
 Mon, 08 Oct 2018 14:57:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 14:57:48 -0700 (PDT)
In-Reply-To: <20181008202901.7894-1-bp@alien8.de>
References: <20181008202901.7894-1-bp@alien8.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Oct 2018 14:57:48 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKkAf1z1bGjTNn7F-Qf=3eObFD4WS_BYgKONCHd-Ge5dw@mail.gmail.com>
Message-ID: <CAGXu5jKkAf1z1bGjTNn7F-Qf=3eObFD4WS_BYgKONCHd-Ge5dw@mail.gmail.com>
Subject: Re: [PATCH] kernel/panic: Do not append newline to the stack
 protector panic string
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 1:29 PM, Borislav Petkov <bp@alien8.de> wrote:
> From: Borislav Petkov <bp@suse.de>
>
> ... because panic() itself already does this. Otherwise you have
> line-broken trailer:
>
>   [    1.836965] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x29e/0x2a0
>   [    1.836965]  ]---
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Acked-by: Kees Cook <keescook@chromium.org>

Andrew, can you take this?

-Kees

> ---
>  kernel/panic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 8b2e002d52eb..837a94b7024d 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -631,7 +631,7 @@ device_initcall(register_warn_debugfs);
>   */
>  __visible void __stack_chk_fail(void)
>  {
> -       panic("stack-protector: Kernel stack is corrupted in: %pB\n",
> +       panic("stack-protector: Kernel stack is corrupted in: %pB",
>                 __builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(__stack_chk_fail);
> --
> 2.19.0.271.gfe8321ec057f
>



-- 
Kees Cook
Pixel Security
