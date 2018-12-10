Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D09C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6263020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6263020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeLJIpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:45:55 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43282 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:45:54 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so6119972vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 00:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9kiCz2Nbl7kzPnmwdC2Vm+4Fg+8YE2IjD/RYXYrheY=;
        b=ZYAvNtVMS0dKZvx60ZZs7gJtHi+HKg88B5hLNkSoFwxzzXxWc+tcC9WVxcv3GGx1ue
         TaJh3vqvPvcnpMSKwV42i6LWsQnlc73DuCFU/D47cXhBOTg9LYyw6l5baD/+XNjPjc1r
         haeq6USYDnKq/QUB+XwPSzpSK2IKXxgeOtR7iQBL1rVGy2eg7Gx4KcWVouOwbaOjNfyP
         cMhwIvZRVmFTDuHXsDcLWlyRTfkH95sNlMKqhHecz0ChGIP9U6E3b6oJoAGXMoCPtmCa
         E6snvva1kDhGDySaieS1uRicRuIdfeO350IbsDrnM5/+rr40tfk6mgyuVgQLumhIQoP+
         c/rA==
X-Gm-Message-State: AA+aEWZRzXGv5tZCmdeXII7V+10vS7BXubS8Rl9rjMzlje/m+Qrfggx0
        p89/g+VdGGju3veJ6jLtl2WhF55wsiyaBytljOEtLg==
X-Google-Smtp-Source: AFSGD/XHdy7r6NYzDCymz7EwmOoys7+TuNp9EVRgWoDRuThdEouvsIQ6yskxbrpcTJOJS10nAnuzSh++EYgyh29gW7s=
X-Received: by 2002:a67:c202:: with SMTP id i2mr4440803vsj.11.1544431553746;
 Mon, 10 Dec 2018 00:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043010.GM6131@altlinux.org>
In-Reply-To: <20181210043010.GM6131@altlinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Dec 2018 09:45:42 +0100
Message-ID: <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> syscall_get_* functions are required to be implemented on all
> architectures in order to extend the generic ptrace API with
> PTRACE_GET_SYSCALL_INFO request.
>
> This introduces asm/syscall.h on m68k implementing all 5 syscall_get_*
> functions as documented in asm-generic/syscall.h: syscall_get_nr,
> syscall_get_arguments, syscall_get_error, syscall_get_return_value,
> and syscall_get_arch.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
>         and syscall_get_return_value
>     v1: added syscall_get_arch

> --- /dev/null
> +++ b/arch/m68k/include/asm/syscall.h
> @@ -0,0 +1,39 @@

> +static inline void
> +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> +                     unsigned int i, unsigned int n, unsigned long *args)
> +{
> +       BUG_ON(i + n > 6);

Does this have to crash the kernel?
Perhaps you can return an error code instead?

> +       memcpy(args, &regs->d1 + i, n * sizeof(args[0]));
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
