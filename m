Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9B2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9092145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9092145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeIXNEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:04:33 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40289 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbeIXNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:04:33 -0400
Received: by mail-vk1-f194.google.com with SMTP id q184-v6so3803348vke.7;
        Mon, 24 Sep 2018 00:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gi07MnAHod4ZnR+PAFVwtRh9G8UYQNYuxGx9SKAjzqY=;
        b=RRx7p570R/P5SK7GxgRkOhh7/iTRZwFIMlSHUP6JUArmLgy84tP0t+j2SDP9iP2Kq3
         pn+giHxzNSPp6YkhaYGOb5oiEwtK7vleIEGVDklyHTpCXPz40ijDnkqtUu2Da6Zjubfz
         qKg9WsSB7+tdAeqIA16G2kbBpduIKz4oKnqPd9x/9YlmjVTeoVaGGmETwwxtyYqWoNGx
         0Z15fXzS2dbgKd3l2MQ/oFSCy4Nw5U1NgyqPu3s4hZENFNHIGBy4/fHKmxMn8o0/fHRi
         uBQtqQnbgz/nVZ4xVNPLxdlM5I4SKukTrRxlr3he1wM1vCXbQJ/GaH3YwNqwRHOwJTqv
         MtiQ==
X-Gm-Message-State: ABuFfoh+LmGqEm4/3ltyPGYiU38nmfwJgRx1rvZxrqFB1tfkqlaxBCef
        MN3nfR9rZBdOSbvmbFhqf0QsvQIrVmN0QrEVRV8=
X-Google-Smtp-Source: ACcGV60PfzLxouoX+XDOgTMl3wngNxNTPzksymOi6hmtBzUT2Rh9Ra2AmT3w/skN9vtq1zXUtMY2Y965IQXIuwTM/6w=
X-Received: by 2002:a1f:cc41:: with SMTP id c62-v6mr2192081vkg.74.1537772634085;
 Mon, 24 Sep 2018 00:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-4-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:03:42 +0200
Message-ID: <CAMuHMdUPKh+6ocdH38=46veyOFUE2o_Hj=xodyLDCQ3s8J9ADQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] m68k: Added system call table generation support
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

Hi Firoz,

On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> The system call tables are in different format in all
> architecture and it will be difficult to manually add or
> modify the system calls in the respective files. To make
> it easy by keeping a script and which'll generate the
> header file and syscall table file so this change will
> unify them across all architectures.
>
> The system call table generation script is added in
> syscalls directory which contain the script to generate
> both uapi header file system call table generation file
> and syscall.tbl file which'll be the input for the scripts.
>
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry point.
> Add a new system call in this architecture will be possible
> by adding new entry in the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi header-
> unistd.h and syscall_table.h files respectively. File
> syscall_table.h is included by syscall_table.S - the real
> system call table. Both .sh files will parse the content
> syscall.tbl to generate the header and table files.
>
> ARM, s390 and x86 architecuture does have the similar support.
> I leverage their implementation to come up with a generic
> solution. And this is the ground work for y2038 issue. We need
> to change two dozons of system call implementation and this
> work will reduce the effort by simply modify two dozon entries
> in syscall.tbl.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -0,0 +1,369 @@
> +#
> +# Linux system call numbers and entry vectors
> +#
> +# The format is:
> +# <number> <abi> <name> <entry point>
> +#
> +# The abi is always common for this file.
> +#
> +0       common   restart_syscall          sys_restart_syscall

Why the indentation by an "odd" number of spaces, instead of TABs?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
