Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761822087B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HbQWcShO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfBTX5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:57:35 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39504 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTX5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:57:34 -0500
Received: by mail-ua1-f66.google.com with SMTP id s15so8876917uap.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZmmUlKjHxR4UKqMoWrDSh0DK5yZUqQpuDVKkn9cnLE=;
        b=HbQWcShOBn2vxn8VbJBXSZSVMQ7AJq7SQP+lmiJEMyUnRtwQ81xSXq8nNxrbwyz87s
         I4Lrx9vPL8wtecUzOh1rDu6YOGx2RRTGJ7hVUfMdFUIfl/GdLHZKnz2JCeoxc3YKWPKb
         bY/qDZaDoalYyP2M9TQxnFolaGgAU9VO8k9FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZmmUlKjHxR4UKqMoWrDSh0DK5yZUqQpuDVKkn9cnLE=;
        b=M2sELUjJ9rgEtVVj1o6D/bneuK2DHfkIV9qNk3L6PHkhJC4vA9p58X5Jya+n4nNqTP
         USO4Fg4Wr9TEHRkXlUA6+ragjdacb/Wmqg9GzDOCdkcOima2xlioOxIFPnJKTNkSyMsi
         YRpihDKn78h/dyA/kgP0v9ek7R1FXvkJSrTcnyCMtLKqTh9291xhLyF3FW3p4WLjoq3k
         bZmAdSmiRE2i3debuv7bRROycgF6/d78AqTXuyYazPt9A7BHnmHclfwRDDxJFgtDg/ZU
         L+XKqcf084ysjw1H4IMXcAxcIIRuNm649IYTB0STyMyC2kFgEWec9NwX99/uTD5LGWon
         pXgw==
X-Gm-Message-State: AHQUAubolaVdnXCWdTr8DVIt+dF9sSFJyHpkJuqY8y8sykTFKm3nhM05
        Ek4wpD2jGEy8SsST0CVhM0Td2Fhllwk=
X-Google-Smtp-Source: AHgI3Iby2MLzEWoWX/D6Kcv9ULJKJBVXfIcHvUcT9oN6cnXkVjg6oWq8GPrCh3tTH0NGjWcpj2PECg==
X-Received: by 2002:ab0:6007:: with SMTP id j7mr18691342ual.40.1550707052775;
        Wed, 20 Feb 2019 15:57:32 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id z18sm2280163vsj.7.2019.02.20.15.57.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 15:57:31 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id e10so15149677vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:57:31 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr20825264vsi.66.1550707050777;
 Wed, 20 Feb 2019 15:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-2-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-2-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 15:57:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+ZbNu=6W2Srzbo7aYJZDcR_rRsEbVMOdcKdQXEGs1ZBw@mail.gmail.com>
Message-ID: <CAGXu5j+ZbNu=6W2Srzbo7aYJZDcR_rRsEbVMOdcKdQXEGs1ZBw@mail.gmail.com>
Subject: Re: [PATCH 1/6] lib/string: Enable string selftesting
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> Currently we have a test module but it is not tied into the kselftest
> infrastructure.  In preparation for adding string manipulation functions
> and testing we should enable kselftest to utilize the test module.
>
> Enable string testing via kselftest infrastructure.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  lib/Kconfig.debug                     | 14 ++++++++++++++
>  lib/Makefile                          |  2 +-
>  lib/test_string.c                     |  4 ++--
>  tools/testing/selftests/lib/Makefile  |  2 +-
>  tools/testing/selftests/lib/config    |  1 +
>  tools/testing/selftests/lib/string.sh | 19 +++++++++++++++++++
>  6 files changed, 38 insertions(+), 4 deletions(-)
>  create mode 100755 tools/testing/selftests/lib/string.sh
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d4df5b24d75e..0dca64c1d8a4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1802,8 +1802,22 @@ config ASYNC_RAID6_TEST
>  config TEST_HEXDUMP
>         tristate "Test functions located in the hexdump module at runtime"
>
> +config TEST_STRING
> +       tristate "Perform selftest on string manipulation functions"
> +       default n
> +       help
> +        Enable this option to test string manipulation functions.
> +       Currently this only tests memset_{16,32,64}.
> +
> +       If unsure, say N.
> +
>  config TEST_STRING_HELPERS
>         tristate "Test functions located in the string_helpers module at runtime"
> +       default n
> +       help
> +        Enable this option to unit test code in lib/string_helpers.c
> +
> +        If unsure, say N.
>
>  config TEST_KSTRTOX
>         tristate "Test kstrto*() family of functions at runtime"
> diff --git a/lib/Makefile b/lib/Makefile
> index e1b59da71418..9c30e1fee27f 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -39,7 +39,7 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
>          bsearch.o find_bit.o llist.o memweight.o kfifo.o \
>          percpu-refcount.o rhashtable.o reciprocal_div.o \
>          once.o refcount.o usercopy.o errseq.o bucket_locks.o
> -obj-$(CONFIG_STRING_SELFTEST) += test_string.o
> +obj-$(CONFIG_TEST_STRING) += test_string.o

This patch should remove 'config STRING_SELFTEST' from lib/Kconfig too.

> diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
> index 70d5711e3ac8..2ee4559b277e 100644
> --- a/tools/testing/selftests/lib/Makefile
> +++ b/tools/testing/selftests/lib/Makefile
> @@ -3,6 +3,6 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>
> -TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
> +TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh string.sh
>
>  include ../lib.mk
> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index 126933bcc950..2032402ad409 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -1,3 +1,4 @@
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_BITMAP=m
> +CONFIG_TEST_STRING=m
>  CONFIG_PRIME_NUMBERS=m
> diff --git a/tools/testing/selftests/lib/string.sh b/tools/testing/selftests/lib/string.sh
> new file mode 100755
> index 000000000000..99024b6f3a6a
> --- /dev/null
> +++ b/tools/testing/selftests/lib/string.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Runs string manipulation tests using test_string kernel module
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +if ! /sbin/modprobe -q -n test_string; then
> +       echo "string: module test_string is not found [SKIP]"
> +       exit $ksft_skip
> +fi
> +
> +if /sbin/modprobe -q test_string; then
> +       /sbin/modprobe -q -r test_string
> +       echo "string: ok"
> +else
> +       echo "string: [FAIL]"
> +       exit 1
> +fi
> --
> 2.20.1
>

You mentioned "redundant scripts" here. You might want to refactor
first, and have a common tool that does the core testing, and then
have the scripts doing one line each:

i.e.:

#!/bin/bash
exec./test_module.sh prime_numbers selftest=65536

with "test_module.sh" doing all the rest.

I bet there are other test_*.ko tests we could wire up too, and this
refactor will make that much easier. And actually, maybe we should
just have a single test running that just reads the "config" file for
the list of test modules, and runs them with the correct output format
to show which are skipped, etc.

-- 
Kees Cook
