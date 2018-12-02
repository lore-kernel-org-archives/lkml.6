Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D38C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C602081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 13:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C602081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLBN5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:57:08 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38828 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeLBN5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 08:57:07 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so5983916vsa.5;
        Sun, 02 Dec 2018 05:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=094R2mMO6bI0SBvNrb//X9DS1G06Z5RxhccskItvK7A=;
        b=otMPIZ0CqbG75NmphGAtwKq45J9wgWOMCaqzQrN+G4u6ahaeWoLYwnHPRxGSBHSVs0
         09u3PDXHPNyWvMGmtccCSg1UJVFMU4k/d5cf1HjpYmaSJr3GhQGALyU2O34IyrSgQrIH
         vt28/vwgCi9QQZ2fLVE8HpCXg2EiyBJcSNID+EPc2FrK5vk8rXvC+rhwzlKe0z5Gs4Ba
         R6XDxcU8lrmz15pu3mdsjoG9rJgIveGtOopFeXW92nCuleY0gZ5CNumyunC5FildTKI5
         8mjTWdKfZ1nPY62tVFb6bWaytQFiUqXMD0l1kzkbzSpjNeuXkRH0U3o11nUjixV26Ahf
         BEpw==
X-Gm-Message-State: AA+aEWZ97OnQzfOUkzzDo3NeJYPMcoAEzyiTZs8l8J9GwPFNMAbvgWE9
        9l2BMO8h40BaAmzWVl64AaP3V3BkKtvtuEqO3hc=
X-Google-Smtp-Source: AFSGD/UqsYzTWWXKTHVOOK3TfLpO3j3XgWf2H9o4Letz+j/18nqfwWwocF+xqb8/c5+uaK3yOhMuIuGw70yL7qqtKpE=
X-Received: by 2002:a67:d119:: with SMTP id u25mr4999217vsi.63.1543759024424;
 Sun, 02 Dec 2018 05:57:04 -0800 (PST)
MIME-Version: 1.0
References: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org> <1542088829-19790-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542088829-19790-3-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Dec 2018 14:56:52 +0100
Message-ID: <CAMuHMdVsBwL9vcqejfc47GN793wMXdQ=SwEsSUP1fbpMt-OoWw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] m68k: add system call table generation support
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

On Tue, Nov 13, 2018 at 7:01 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> The system call tables are in different format in all
> architecture and it will be difficult to manually add,
> modify or delete the syscall table entries in the res-
> pective files. To make it easy by keeping a script and
> which will generate the uapi header and syscall table
> file. This change will also help to unify the implemen-
> tation across all architectures.
>
> The system call table generation script is added in
> kernel/syscalls directory which contain the scripts to
> generate both uapi header file and system call table
> files. The syscall.tbl will be input for the scripts.
>
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry
> point. Add a new system call in this architecture will
> be possible by adding new entry in the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi header
> unistd_32.h and syscall_table.h files respectively. Both
> .sh files will parse the content syscall.tbl to generate
> the header and table files. unistd_32.h will be included
> by uapi/asm/unistd.h and syscall_table.h is included by
> kernel/syscall_table.S - the real system call table.
>
> ARM, s390 and x86 architecuture does have similar support.
> I leverage their implementation to come up with a generic
> solution.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_M68K_`basename "$out" | sed \
> +       -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +       -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +       printf "#ifndef %s\n" "${fileguard}"
> +       printf "#define %s\n" "${fileguard}"
> +       printf "\n"
> +
> +       nxt=0
> +       while read nr abi name entry ; do
> +               if [ -z "$offset" ]; then
> +                       printf "#define __NR_%s%s\t%s\n" \
> +                               "${prefix}" "${name}" "${nr}"
> +               else
> +                       printf "#define __NR_%s%s\t(%s + %s)\n" \
> +                               "${prefix}" "${name}" "${offset}" "${nr}"
> +               fi
> +               nxt=$((nr+1))
> +       done
> +
> +       printf "\n"
> +       printf "#ifdef __KERNEL__\n"
> +       printf "#define __NR_syscalls\t%s\n" "${nxt}"
> +       printf "#endif\n"
> +       printf "\n"
> +       printf "#endif /* %s */" "${fileguard}"

The above line is lacking a "\n", causing:

    ./arch/m68k/include/generated/uapi/asm/unistd_32.h:370:42:
warning: no newline at end of file

Changing it to:

    printf "#endif /* %s */\n" "${fileguard}"

fixes this.

Interestingly, this issue seems to be present on powerpc, parisc, sparc,
sh, xtensa (and probably more, I gave up looking), too?

Apart from that, it seems to work fine on m68k.

> +) > "$out"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
