Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE059208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE059208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbeLDIwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:52:32 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44377 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeLDIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:52:32 -0500
Received: by mail-vs1-f68.google.com with SMTP id g68so9309369vsd.11;
        Tue, 04 Dec 2018 00:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZwt9btZxj87q2lbzhV0k/4hfIFw+qtDE7qC3aSIBik=;
        b=ELhL87xQCjAdzfpHcDMhzZSJ5IQuoGCGfv0VszfDAhHlaUzIDfQAEUL9E6iFNeTjuQ
         XMyLaE9L+ltLcF56kZg8XKpSvKjp350S2L9kEVjOrdg9zC6FKlM4Q7ioRK1SZEaBCbdU
         6pBSfTIMZUh/mzE1p/RFuJu9vmBLO00AGwDuoypcBuWu7tq6tbVbNVB3W2VqwUz8SDri
         +/wAUm6MP+hgsPpHauaMJoUPTkl97ZQ5rmSYGP+uRRC/UXOk6WYpdYtTseoZC8ivUGFX
         GmpGim55tY+mtWE22BKN0ldmBiqw3741X0VUwBp54WIQaGmYaKezxnruH7ptpyb2ZRKX
         rraQ==
X-Gm-Message-State: AA+aEWZdOqMW1obuxwKtIwFMO3fh51slyUhSprv9i2IiKqJe1iZk9zvt
        pcP56npBUMmUjLIai0Vd3T8WOtOtq2arlUjNggA=
X-Google-Smtp-Source: AFSGD/X7ndVXYJqJh21GRzdLxCa/QI9faT2vFhsZU0yfbKfdorI8DJeJ6Ugy87OsuhHypUKeHnmcXm/8iX3aj2msatw=
X-Received: by 2002:a67:3885:: with SMTP id n5mr7377186vsi.96.1543913549592;
 Tue, 04 Dec 2018 00:52:29 -0800 (PST)
MIME-Version: 1.0
References: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Dec 2018 09:52:17 +0100
Message-ID: <CAMuHMdW6JiponxLiGNEXUX4xJk3hK4b8dTOCNvVBr7s2LyfhJw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] m68k: system call table generation support
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

On Tue, Nov 13, 2018 at 7:01 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in the
> syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>
> I have done the same support for work for alpha, ia64,
> microblaze, mips, parisc, powerpc, sh, sparc and xtensa.
> Below mentioned git repository contains more details
> about the workflow.
>
> https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
>
> changes since v4:
>  - changed from generic-y to generated-y in Kbuild.
>  - remove the patch "0001-m68k-rename-system-call-
>    table-file-name.patch".
>
> changes since v3:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>
> changes since v2:
>  - removed __IGNORE entries which was added in v2
>    to suppress the warning.
>  - added missing new line.
>
> changes since v1:
>  - enclosed __NR_sycalls macro with __KERNEL__.
>
> Firoz Khan (3):
>   m68k: add __NR_syscalls along with NR_syscalls
>   m68k: add system call table generation support
>   m68k: generate uapi header and syscall table header files
>
>  arch/m68k/Makefile                      |   3 +
>  arch/m68k/include/asm/Kbuild            |   1 +
>  arch/m68k/include/asm/unistd.h          |   3 +-
>  arch/m68k/include/uapi/asm/Kbuild       |   1 +
>  arch/m68k/include/uapi/asm/unistd.h     | 385 +------------------------------
>  arch/m68k/kernel/syscalls/Makefile      |  38 ++++
>  arch/m68k/kernel/syscalls/syscall.tbl   | 389 ++++++++++++++++++++++++++++++++
>  arch/m68k/kernel/syscalls/syscallhdr.sh |  36 +++
>  arch/m68k/kernel/syscalls/syscalltbl.sh |  32 +++
>  arch/m68k/kernel/syscalltable.S         | 387 +------------------------------
>  10 files changed, 507 insertions(+), 768 deletions(-)
>  create mode 100644 arch/m68k/kernel/syscalls/Makefile
>  create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh

Thanks, applied and queued for v4.21 (with the missing newline added).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
