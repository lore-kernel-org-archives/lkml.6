Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD15ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72DC20838
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCBsGSPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72DC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJYGRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:17:53 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34066 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJYGRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:17:52 -0400
Received: by mail-yb1-f193.google.com with SMTP id n140-v6so2806940yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SpR5PQEROeAv83K8afXyXqw/J6C4jmUgmC8hplFSm64=;
        b=oCBsGSPvBXL9EdKvmdPAdDzC7A9Qss8d1x8bQ/yaE6M3uDeDhAAvtguMgfVypcGsiO
         /+jdM/3i/GmYoSHC3u1q61BcgiwQkl4nPwCVqmcxJlUl5lrx2OfUcDtPYzUU0e5TkFqI
         86g4SpeZkJr47G5yf6Y4PY5xW7HlrHr5Vn9Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SpR5PQEROeAv83K8afXyXqw/J6C4jmUgmC8hplFSm64=;
        b=LwQjw/L3Jz2npa9yTzH/ODGjsvxEEkNDYhlcaQhQtAOBmhtgF0bRROUhudfPX0piv4
         gzUNY3FYbT0C0ba69ECFD4wJr/TKTL+rRhTW68YCIH7cIM9Dz92ntcQX6MtNU2CIskX8
         aUMbKjqDertO8I9te2vX6nFEklUeTCKwPJA/P0Wm+g6zBMGODp+H4iXR2K9r89w8BmwX
         245pDiN7HtR91sCREgVmuTKs6yRnFUumlnKPqk6+E8zdQzGA5qhU6xkraeGEogi33tyR
         EbjBRfeayFlWpT1pgQzOwLbhO4CxY6iBSyPVTJ2RgWqDb05S9gjj8gVm8geU146fEboP
         FQCA==
X-Gm-Message-State: AGRZ1gInFz0QyF1RiMdBDf9vJiFk6Eqna2IP1fnMTUxRp/JZ8tGo89ap
        eVXpKK5/FglYyk9I0WszlDgZ0BPOCxY=
X-Google-Smtp-Source: AJdET5fmVGZ+NYS05/ubOEO6yNcPNuT8BoxlUaboyaWLyGi569yw0OpgP3tLt1T4wXahc4E2br91bA==
X-Received: by 2002:a25:4c02:: with SMTP id z2-v6mr4181236yba.68.1540417685197;
        Wed, 24 Oct 2018 14:48:05 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id v5-v6sm1424660ywc.96.2018.10.24.14.48.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 14:48:04 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id v199-v6so2746075ywg.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 14:48:04 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr4082861ywf.237.1540417324661;
 Wed, 24 Oct 2018 14:42:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 14:42:03
 -0700 (PDT)
In-Reply-To: <20181024204036.8799-3-palmer@sifive.com>
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com> <20181024204036.8799-3-palmer@sifive.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Oct 2018 14:42:03 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ7gmVXZE+iksW99c6bHEV2rSOG+boQDRGmMSDa9HOh_A@mail.gmail.com>
Message-ID: <CAGXu5jJ7gmVXZE+iksW99c6bHEV2rSOG+boQDRGmMSDa9HOh_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Wesley Terpstra <wesley@sifive.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:40 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> This is a fairly straight-forward implementation of seccomp for RISC-V
> systems.
>
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/Kconfig                   | 18 ++++++++++++++++++
>  arch/riscv/include/asm/seccomp.h     | 10 ++++++++++
>  arch/riscv/include/asm/syscall.h     |  6 ++++++
>  arch/riscv/include/asm/thread_info.h |  1 +
>  include/uapi/linux/audit.h           |  1 +
>  5 files changed, 36 insertions(+)
>  create mode 100644 arch/riscv/include/asm/seccomp.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a344980287a5..28abe47602a1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,6 +28,7 @@ config RISCV
>         select GENERIC_STRNLEN_USER
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
> +       select HAVE_ARCH_SECCOMP_FILTER

I think this patch is missing most of the actual seccomp glue?

config HAVE_ARCH_SECCOMP_FILTER
        bool
        help
          An arch should select this symbol if it provides all of these things:
          - syscall_get_arch()
          - syscall_get_arguments()
          - syscall_rollback()
          - syscall_set_return_value()
          - SIGSYS siginfo_t support
          - secure_computing is called from a ptrace_event()-safe context
          - secure_computing return value is checked and a return value of -1
            results in the system call being skipped immediately.
          - seccomp syscall wired up

I only see syscall_get_arch(). Nothing is using TIF_SECCOMP (I'd
expect a masked check in entry.S -- it seems like tracepoints are
getting missed too? I see it handled in ptrace.c but not checked in
entry.S?) There's no checking for seccomp in ptrace.c, etc.

At the very least, I think the Kconfigs should not be included in this
patch. The other things are needed, but without everything else,
seccomp isn't actually available. :)

Reading the per-arch Kconfigs, I am reminded I still need to move
CONFIG_SECCOMP up into arch/Kconfig. :P

-Kees

-- 
Kees Cook
