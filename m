Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B9EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CEE20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R2n+cZ+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfANXQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:16:34 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36106 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfANXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:16:34 -0500
Received: by mail-ua1-f65.google.com with SMTP id j3so301886uap.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6b50usfb2/6xcsB12gSXMOXGtg3RWJdvw6oM3Zulef8=;
        b=R2n+cZ+sxdHPZuaC0CpOBNbV6uKdcOe7yHLx9ioHS8U8I8KQBxrvxoaSgV8LKAVEYh
         GH34igpuoQq8t/BSQlur1DZuBz5FmXtilToCHUaWMCJ6nlfMi2kYpkMXeWctoNzhaMBV
         JjnLGvxIpTVELhthop8U4M6UZXYVPnbyME9NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6b50usfb2/6xcsB12gSXMOXGtg3RWJdvw6oM3Zulef8=;
        b=VCyKmchMnTeW54wTtU0vy39JGJ5MYBiJW+9oz7Q1b3USoEQqxfhk4MKBS2tLX3du/A
         AiKAuIckmHsi5jMDMiyd52Y2e8NhScoHChuQjPz3nXAXYAVZwvGM65EwUC39q5EDWwlm
         Ymzec6nJ0H0wuWQc88CVJnzk+n68SmEXYQ5yfb9+3+JWPlJqW0iHBUt6zs3GDzAhOcKC
         /I2g/yuCaszdoqLdJb0tLfwskni32pwuMPCWcAI4k/AbMHUgiZGrd1WDFFucL6yTfxSS
         U4tKEmirbymVC2TCgd8kKdK+Ab+v1DtQbymd0rgUqfcZz9/P5kaKKP6wbcCkfSIu/GN8
         lmYQ==
X-Gm-Message-State: AJcUukd9CL/23cwTmcg7upL2hZNDkMwjCVPbaNJxhwNwOvpMSEgyL/NH
        6q3Y1wkGT2PU0J/GsEUBoI6KH8sq6v0=
X-Google-Smtp-Source: ALg8bN4+EKEmJ8H8rys627WHQjodg1BCUmeLHYjdf+xPMhW+Q93nTxSgZ9tz2ywaS34ya+y+CP26HQ==
X-Received: by 2002:ab0:7581:: with SMTP id q1mr429155uap.17.1547507792516;
        Mon, 14 Jan 2019 15:16:32 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id n206sm47349825vkn.36.2019.01.14.15.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 15:16:31 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id x64so532467vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:16:30 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr447744vsc.48.1547507790430;
 Mon, 14 Jan 2019 15:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20190114135144.26096-1-geert+renesas@glider.be> <20190114135144.26096-6-geert+renesas@glider.be>
In-Reply-To: <20190114135144.26096-6-geert+renesas@glider.be>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 15:16:17 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+SHuqv0=gxdsYBqraPyZMWdVD+uxrtYrepVZBX3ZzTKw@mail.gmail.com>
Message-ID: <CAGXu5j+SHuqv0=gxdsYBqraPyZMWdVD+uxrtYrepVZBX3ZzTKw@mail.gmail.com>
Subject: Re: [PATCH 05/12] selftests: seccomp: Fix test dependencies and rules
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 5:51 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> When building kselftest in a separate output directory, the seccomp_bpf
> binary ends up in the source directory instead of in the output
> directory, and the build of seccomp_benchmark fails:
>
>     make[5]: *** No rule to make target 'seccomp_benchmark', needed by 'all'.  Stop.
>
> Fix this by declaring both test binaries using TEST_GEN_PROGS, and using
> the build support from lib.mk properly.
>
> Fixes: 967d7ba841513910 ("selftests/seccomp: Add simple seccomp overhead benchmark")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  tools/testing/selftests/seccomp/Makefile | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> index fce7f4ce069251a6..c728bd7a366f78b9 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -1,17 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> -all:
>
> -include ../lib.mk
> -
> -.PHONY: all clean
> -
> -BINARIES := seccomp_bpf seccomp_benchmark
>  CFLAGS += -Wl,-no-as-needed -Wall
> +LDFLAGS += -lpthread
>
> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
> -       $(CC) $(CFLAGS) $(LDFLAGS) -lpthread $< -o $@
> +TEST_GEN_PROGS = seccomp_bpf seccomp_benchmark

This breaks the dep on ../kselftest_harness.h. Changes go unnoticed if
this is changed:

$ touch tools/testing/selftests/kselftest_harness.h
$ make O=/tmp/kselftest -C tools/testing/selftests
...
make[1]: Entering directory
'/home/kees/src/linux/tools/testing/selftests/seccomp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory
'/home/kees/src/linux/tools/testing/selftests/seccomp'
...

>
> -TEST_PROGS += $(BINARIES)
> -EXTRA_CLEAN := $(BINARIES)
> -
> -all: $(BINARIES)
> +include ../lib.mk
> --
> 2.17.1
>


-- 
Kees Cook
