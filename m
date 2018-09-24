Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D6DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D42145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7D42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeIXNCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:02:09 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45930 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeIXNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:02:09 -0400
Received: by mail-vs1-f67.google.com with SMTP id x198-v6so7681674vsx.12;
        Mon, 24 Sep 2018 00:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5qEmwmXRXWmngUmez8sdcstFoFkLbd6cTbu2TYg++4=;
        b=BAllTHxs5u/N/WJfgh77SkxoiiOjcu3iX1q9OrIgrDOn0sqPrC72AO5NgVVfORtIIy
         cVfuacFuNr8a1ZoovFDTZK56w4E4lyqD8r8L+LB801/jXnTaNEBgWu+wgRTMJQNGG5Xj
         WRauHnU2wgBt3YPqAjxrXaLTk3IAVdMxxs+UD3FrVQeyAmNr0lcVNCDGnpg3uh+vqLGW
         vXscBGUuPvuCPZHyz4IAeTcbRBbP117buEYx6tQFwlepUhxGO/YUQxBO5mVAQ6a0+yXu
         xiI32OmARTe07B+lsIW49KI4OtDqXr93pdHWhXC9Uvf0+ueQremKJKGO0JFrWkeDms1O
         LfcQ==
X-Gm-Message-State: APzg51Ckulmu8FGPe6LlmrIQjp5Xk3aI1+W7tiVW6NO/vi++9k6wCDDT
        DEpnfBy8ImiAO/8eg5xdkpymV/Urwr5ndhFdymw7mJoo
X-Google-Smtp-Source: ACcGV60szOYpY2EVmgDxnj73L0icabJWfd8T2A4Ren23FwlFab51Rkp6Ns7mOhhDbRHFIoNafNopaT1Y+4QcUq11CRE=
X-Received: by 2002:a67:6e06:: with SMTP id j6-v6mr2106920vsc.152.1537772490471;
 Mon, 24 Sep 2018 00:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:01:19 +0200
Message-ID: <CAMuHMdWST+PJM8EChBpbToycmXWyt6icNM0x6H9FWtHOMQK7aQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] m68k: Replace NR_syscalls macro from asm/unistd.h
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:06 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> NR_syscalls macro holds the number of system call exist in m68k
> architecture. This macro is currently the part of asm/unistd.h file.
> We have to change the value of NR_syscalls, if we add or delete a
> system call.
>
> One of patch in this patch series has a script which will generate
> a uapi header based on syscall.tbl file. The syscall.tbl file
> contains the number of system call information. So we have two
> option to update NR_syscalls value.
>
> 1. Update NR_syscalls in asm/unistd.h manually by counting the
>    no.of system calls. No need to update NR_syscalls untill
>    we either add a new system call or delete an existing system
>    call.
>
> 2. We can keep this feature it above mentioned script, that'll
>    count the number of syscalls and keep it in a generated file.
>    In this case we don't need to explicitly update NR_syscalls
>    in asm/unistd.h file.
>
> The 2nd option will be the recommended one. For that, I come up
> with another macro - __NR_syscalls which will be updated by the
> script and it will be present in api/asm/unistd.h. While __NR_syscalls
> isn't strictly part of the uapi, having it as part of the generated
> header to simplifies the implementation. So we need to enclose this
> macro with #ifdef __KERNEL__ to avoid side effects.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
