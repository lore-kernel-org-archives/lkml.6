Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8082CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3079B2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWV7+TRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3079B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJRG0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbeJRG0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:26:04 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E634E2148E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539815298;
        bh=eUtAxQX5B6s9EXG+bZeo9jcC0fcLQFiJpJeWFpt1tig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oWV7+TRyfyk4srjtLcNYzRxwLSsR4pupB3IwPu4CI0M4M2fXtkR1moyrc6iNvWaSE
         1J9/EA/3Lnuzptax1tLSpOPxjYr52Hg4rdtSIG6B3aGy/Ajb//3A/vLaljKF7ylLdr
         o8IKhoo6EfcxqcOFDj8sE4i5/peqoLCa5rrkAoHA=
Received: by mail-wr1-f51.google.com with SMTP id a13-v6so31432746wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:28:17 -0700 (PDT)
X-Gm-Message-State: ABuFfojru1hNINI5P2+O69IVlhGKafcbrTWkLWDIDB77N0pqek0v60dn
        sry4NcGhcm0P4max4gHTm9zNkbEGEZ9jf82fGGzglg==
X-Google-Smtp-Source: ACcGV604YeUYs0nwFVcRhYn1bL0rAbCGRcdwAe4SIuqd75aEG1wQbbQwMc21vNeNa6g+RkMyNvYemmVHDfjZ3P3qQw0=
X-Received: by 2002:a5d:4151:: with SMTP id c17-v6mr25332237wrq.61.1539815296159;
 Wed, 17 Oct 2018 15:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com> <20181016235120.138227-27-brendanhiggins@google.com>
In-Reply-To: <20181016235120.138227-27-brendanhiggins@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 17 Oct 2018 17:28:04 -0500
X-Gmail-Original-Message-ID: <CABGGisyMYC12UZtZ3wBw_1GO1Qq9-MEzSznq0r8796kVsQ6DoA@mail.gmail.com>
Message-ID: <CABGGisyMYC12UZtZ3wBw_1GO1Qq9-MEzSznq0r8796kVsQ6DoA@mail.gmail.com>
Subject: Re: [RFC v1 26/31] arch: um: added stubs for mock iomem for KUnit
To:     brendanhiggins@google.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        joel@jms.id.au, Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>, Tim.Bird@sony.com,
        khilman@baylibre.com, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 6:54 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> This mocks out some iomem functions (functions like readl and writel),
> for mocking hardware interfaces.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/um/Kconfig.common               |  8 +++++-
>  arch/um/Kconfig.um                   |  5 ++++
>  arch/um/include/asm/Kbuild           |  1 -
>  arch/um/include/asm/io-mock-shared.h | 33 +++++++++++++++++++++
>  arch/um/include/asm/io-mock.h        | 43 ++++++++++++++++++++++++++++
>  arch/um/include/asm/io.h             |  8 ++++++
>  arch/um/kernel/Makefile              |  1 +
>  arch/um/kernel/io-mock.c             | 40 ++++++++++++++++++++++++++
>  kunit/Kconfig                        |  1 +
>  9 files changed, 138 insertions(+), 2 deletions(-)
>  create mode 100644 arch/um/include/asm/io-mock-shared.h
>  create mode 100644 arch/um/include/asm/io-mock.h
>  create mode 100644 arch/um/kernel/io-mock.c
>
> diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
> index 07f84c842cc31..72e7efb74f7fd 100644
> --- a/arch/um/Kconfig.common
> +++ b/arch/um/Kconfig.common
> @@ -19,7 +19,13 @@ config MMU
>         default y
>
>  config NO_IOMEM
> -       def_bool y
> +       bool
> +       default y if !KUNIT
> +
> +config HAS_IOMEM

HAS_IOMEM is essentially a disable flag for lots of drivers on UML.
Ignoring drivers, it doesn't really control a significant amount of
code (albeit small amount of code you need for this series). As a
driver disable, it does a poor job as lots of drivers aren't MMIO and
aren't disabled. I think we should decouple these 2 things. Perhaps
get rid of the driver disable part altogether. We already do 'depends
on ARCH_FOO || COMPILE_TEST' for lots of drivers.

Also, I wouldn't be surprised if turning on HAS_IOMEM causes UML
randconfig failures. Arnd does lots of randconfig testing and might be
willing to help check.

> +       bool "Turns on fake IOMEM support for KUnit"
> +       depends on KUNIT
> +       select MOCK_IOMEM
>
>  config ISA
>         bool
> diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
> index 20da5a8ca9490..8d35e0e2c23d1 100644
> --- a/arch/um/Kconfig.um
> +++ b/arch/um/Kconfig.um
> @@ -122,3 +122,8 @@ config SECCOMP
>           defined by each seccomp mode.
>
>           If unsure, say Y.
> +
> +config PLATFORM_MOCK
> +       bool "Enable a mock architecture used for unit testing."
> +       depends on KUNIT && OF
> +       default n
> diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
> index b10dde6cb793b..9fd2827ab76d1 100644
> --- a/arch/um/include/asm/Kbuild
> +++ b/arch/um/include/asm/Kbuild
> @@ -12,7 +12,6 @@ generic-y += ftrace.h
>  generic-y += futex.h
>  generic-y += hardirq.h
>  generic-y += hw_irq.h
> -generic-y += io.h
>  generic-y += irq_regs.h
>  generic-y += irq_work.h
>  generic-y += kdebug.h
> diff --git a/arch/um/include/asm/io-mock-shared.h b/arch/um/include/asm/io-mock-shared.h
> new file mode 100644
> index 0000000000000..6baf59cb17a58
> --- /dev/null
> +++ b/arch/um/include/asm/io-mock-shared.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_UM_IO_MOCK_SHARED_H
> +#define _ASM_UM_IO_MOCK_SHARED_H
> +
> +#define readb readb
> +u8 readb(const volatile void __iomem *);

What about all the other flavors of MMIO accessors like __raw_readb,
readb_relaxed, etc.? readX/writeX is intended for PCI based drivers
which doesn't seem to be what you are targeting in this series.

I think it would be good if this capability was not just on UML. I
could also imagine wanting to run tests on real h/w. Perhaps you just
want to log and/or check i/o accesses. Or you need some dependencies
in place rather than trying to fake everything (clocks, gpios, pinmux,
irq, etc.). That being said, I'm not trying to add a bunch of things
for you to do. Though maybe it makes sense to split this series some.
How many of the patches are needed to convert the DT unittests for
example?

Rob
