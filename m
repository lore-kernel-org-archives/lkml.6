Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6782064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TC+/8k8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6782064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeLJRaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:30:01 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37572 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeLJRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:30:01 -0500
Received: by mail-yw1-f65.google.com with SMTP id h193so4265417ywc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YcDZHuDW2Mposa+OPwei6Ym84F30fd+jVsFJkc3WVjE=;
        b=TC+/8k8GHnzb9oOf4ITNFvlDHxJnNTu1QILLhYZzz05agzThn7odAIpThFlGoxSf4Q
         ps6LThUtCH4mm3X+NnsiOZ4CN1KJnfCNiwv8DkeC+ifAKbYjWAu+UaDI5Fg1XtNQGqiJ
         lQMEC8T4104uj8r/tRANFJJFYjWM9rtVQRwPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcDZHuDW2Mposa+OPwei6Ym84F30fd+jVsFJkc3WVjE=;
        b=iGn62jyJ431j8mEMCwu14hgxWc4Ku5Tkyg5iIel55KRn6lemUo530hHpB3s6HUkv92
         v4ZsnKtEIEAhkYD9tIdY7IiLbG+ckGSvhZ3b1G1iGUNUuj9URh/lKT3Mc0MBfea4eoQw
         tqWKQktExtqrT6F27bMpXu53OEYMdTHXJOUY8cjZi11PpgwlXL6Igic3BYYXk4aBGkHH
         M0xZLmKLPoWHV4RH4Vwq2I/zMq2+OlnKIZxpD8CO/4ADWV+e8HXCoH9YAFCM6LEqRa+D
         q2enFa1/P5oTcUEBx7/EPRa62t3IRJ3mIf9krzQpViO2Ugo9ywlolVUdp184ejN9/J5h
         jGBw==
X-Gm-Message-State: AA+aEWYqGa0MfKdmDRyvEp8OVweRrB3oyoWWjRl7dMh6neFY6N/vP1fd
        CQCCosnhrkOp/Woq9G2HqauzdNXVS90=
X-Google-Smtp-Source: AFSGD/VO6kEfjb7tdh9ZLJQlfsU4vyVIuK+2PUv1Ijs2sa1AiR1tT3eZFu01YdK5JvJAAjn1kyTEuA==
X-Received: by 2002:a0d:e446:: with SMTP id n67mr13443373ywe.478.1544462999635;
        Mon, 10 Dec 2018 09:29:59 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id n16sm5123137ywn.31.2018.12.10.09.29.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:29:58 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id s15so5524958ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:29:57 -0800 (PST)
X-Received: by 2002:a5b:2cd:: with SMTP id h13mr12944851ybp.403.1544462997211;
 Mon, 10 Dec 2018 09:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043109.GV6131@altlinux.org>
In-Reply-To: <20181210043109.GV6131@altlinux.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Dec 2018 09:29:45 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKMWDGu0VbMd08XMdyzu6JHGjpTPDQ_Z6aQ6Hz4uv=tzg@mail.gmail.com>
Message-ID: <CAGXu5jKMWDGu0VbMd08XMdyzu6JHGjpTPDQ_Z6aQ6Hz4uv=tzg@mail.gmail.com>
Subject: Re: [PATCH v5 22/25] syscall_get_arch: add "struct task_struct *" argument
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 8:31 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This argument is required to extend the generic ptrace API with
> PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going
> to be called from ptrace_request() along with syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions with a tracee as their argument.
>
> Reverts: 5e937a9ae913 ("syscall_get_arch: remove useless function arguments")
> Reverts: 1002d94d3076 ("syscall.h: fix doc text for syscall_get_arch()")
> Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

For the seccomp parts:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index f2ae2324c232..77cb87bd2eae 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -82,7 +82,7 @@ static void populate_seccomp_data(struct seccomp_data *sd)
>         unsigned long args[6];
>
>         sd->nr = syscall_get_nr(task, regs);
> -       sd->arch = syscall_get_arch();
> +       sd->arch = syscall_get_arch(task);
>         syscall_get_arguments(task, regs, 0, 6, args);
>         sd->args[0] = args[0];
>         sd->args[1] = args[1];
> @@ -529,7 +529,7 @@ static void seccomp_init_siginfo(kernel_siginfo_t *info, int syscall, int reason
>         info->si_code = SYS_SECCOMP;
>         info->si_call_addr = (void __user *)KSTK_EIP(current);
>         info->si_errno = reason;
> -       info->si_arch = syscall_get_arch();
> +       info->si_arch = syscall_get_arch(current);
>         info->si_syscall = syscall;
>  }
>
> --
> ldv



-- 
Kees Cook
