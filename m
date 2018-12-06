Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4AC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180320850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BHdf0pTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6180320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLFQtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:49:12 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36750 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLFQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:49:11 -0500
Received: by mail-yb1-f193.google.com with SMTP id w203so935615ybg.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6ZhIgPxb5JuEi5w65rXIUYHXmApKJnwNsBxtTH3yT4=;
        b=BHdf0pTDh1fcUnEzAb5K2S1oG8rWk/mh7j7WM6Hni5W9pp++25RnRnYhX7ZmgqV3pH
         FerZn5Pq+xwK7tSjDNXjUrrH5t2BXhEmc61Y5RkWSDB33VRt6QRnimqH5p3bCsC5JLpP
         a1aIWFjjcvTJ/r+u25H3UuIRad4UFcdTFgyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6ZhIgPxb5JuEi5w65rXIUYHXmApKJnwNsBxtTH3yT4=;
        b=AUNreAVI3WWJLzOAr+0L7v+l1TfaD/mVNL4i/j7kJP4isUiHp0F892yLlfJLS8Wjkb
         UG4HHJdqzwX7F9Np0t/+54Y+wItWzfllIB7fTwR1OLzSjO8GZt21CYIpRDQdEafM4+hY
         6MGtr64Dd5Lnrf7prRHz3WBe+baYlLgng8kXrr8DFxewAsq1Rxw2kBVYqWqAty0vAG1c
         WxpxxgYx/++0JZ/ZOOP8W92hNL/fwx09lR1zaXVTBjNt0VumswcxEBtxxASeyeWbVbQl
         UwVWAzogFN6vxNwRf6r5q9VKM/FwXR0JIyD1pLmVX9R5L0VKusfsfCaZEJ87PgkURWdt
         XWfA==
X-Gm-Message-State: AA+aEWbbOTTel40ZiDUKYZ0HwoFNMLLZy3uDJwM+UN4Raqm5gBwEg+0Z
        1AyvsmYVkpoJ7Sw0ntRCaYTeUefYisc=
X-Google-Smtp-Source: AFSGD/XA3VdcnuwbvPxL8OClGSJPURijb1JdfKEra2UR8oLivMGgN8DC1lLBbwB4VGLfF0JB0fuDTA==
X-Received: by 2002:a81:6cf:: with SMTP id 198mr29246418ywg.138.1544114950309;
        Thu, 06 Dec 2018 08:49:10 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id h62sm183896ywe.100.2018.12.06.08.49.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:49:08 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id w203so935437ybg.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:49:07 -0800 (PST)
X-Received: by 2002:a81:98e:: with SMTP id 136mr28855840ywj.47.1544114947295;
 Thu, 06 Dec 2018 08:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com> <20181206150156.28210-3-david.abdurachmanov@gmail.com>
In-Reply-To: <20181206150156.28210-3-david.abdurachmanov@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 08:48:55 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJT4wY9wgCF8gB+tjgH+YQps4eUDVwZoGY=GVmLMpLPxw@mail.gmail.com>
Message-ID: <CAGXu5jJT4wY9wgCF8gB+tjgH+YQps4eUDVwZoGY=GVmLMpLPxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: fix syscall_{get,set}_arguments
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, green.hu@gmail.com,
        deanbo422@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 7:02 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> Testing with libseccomp master branch revealed that testcases with
> filters on syscall arguments were failing due to wrong values. Seccomp
> uses syscall_get_argumentsi() to copy syscall arguments, and there is a
> bug in pointer arithmetics in memcpy() call.
>
> Two alternative implementation were tested: the one in this patch and
> another one based on while-break loop. Both delivered the same results.
>
> This implementation is also used in arm, arm64 and nds32 arches.

Minor nit: can you make this the first patch? That way seccomp works
correctly from the point of introduction. :)

-Kees

>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  arch/riscv/include/asm/syscall.h | 42 ++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> index bba3da6ef157..26ceb434a433 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -70,19 +70,32 @@ static inline void syscall_set_return_value(struct task_struct *task,
>         regs->a0 = (long) error ?: val;
>  }
>
> +#define SYSCALL_MAX_ARGS 6
> +
>  static inline void syscall_get_arguments(struct task_struct *task,
>                                          struct pt_regs *regs,
>                                          unsigned int i, unsigned int n,
>                                          unsigned long *args)
>  {
> -       BUG_ON(i + n > 6);
> +       if (n == 0)
> +               return;
> +
> +       if (i + n > SYSCALL_MAX_ARGS) {
> +               unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
> +               unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
> +               pr_warning("%s called with max args %d, handling only %d\n",
> +                       __func__, i + n, SYSCALL_MAX_ARGS);
> +               memset(args_bad, 0, n_bad * sizeof(args[0]));
> +       }
> +
>         if (i == 0) {
>                 args[0] = regs->orig_a0;
>                 args++;
>                 i++;
>                 n--;
>         }
> -       memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
> +
> +       memcpy(args, &regs->a0 + i, n * sizeof(args[0]));
>  }
>
>  static inline void syscall_set_arguments(struct task_struct *task,
> @@ -90,14 +103,23 @@ static inline void syscall_set_arguments(struct task_struct *task,
>                                          unsigned int i, unsigned int n,
>                                          const unsigned long *args)
>  {
> -       BUG_ON(i + n > 6);
> -        if (i == 0) {
> -                regs->orig_a0 = args[0];
> -                args++;
> -                i++;
> -                n--;
> -        }
> -       memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
> +       if (n == 0)
> +               return;
> +
> +       if (i + n > SYSCALL_MAX_ARGS) {
> +               pr_warning("%s called with max args %d, handling only %d\n",
> +                       __func__, i + n, SYSCALL_MAX_ARGS);
> +               n = SYSCALL_MAX_ARGS - i;
> +       }
> +
> +       if (i == 0) {
> +               regs->orig_a0 = args[0];
> +               args++;
> +               i++;
> +               n--;
> +       }
> +
> +       memcpy(&regs->a0 + i, args, n * sizeof(args[0]));
>  }
>
>  static inline int syscall_get_arch(void)
> --
> 2.19.2
>


-- 
Kees Cook
