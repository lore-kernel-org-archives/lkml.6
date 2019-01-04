Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A95204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfADRQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:16:46 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40525 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfADRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:16:45 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so23050735vsf.7;
        Fri, 04 Jan 2019 09:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvriM1Lv+ofrC7EkdpTv2LB6W1GMDvx4iGf9Rz8N23Q=;
        b=COlI/b1ZeHHx316GRrhoG9OWKV+pLpp5SHeki+jHFWGLpVSNXEO0230io9Pi8duFo5
         gwL96A1lAV9a1Nb5XIM7O8asZN6UchYOfPPXGhXe/RF3mu1gx+z1ni2X74QwMSd+5gbW
         GS1UT4u5PtxZ+FJ69lEJOYaqC5kcE1hRnpmZEnp7BzlJz9HTfZm7mbS4ygltyqZUP8ua
         81mAKCzabZQos15x0+09YDt9wY/ukH2eXRgEPHu1KqHqKOwhGAKcl1hz2dhLODh/m+4T
         DkpadrI5zr5qxWqnePQh4bNax0WL1pOHQh5muchxoBeA7jqvQfAY/SeUhmWldZrf+1W6
         zMPQ==
X-Gm-Message-State: AJcUukfe3sgm1aBzECSYkEkX0UOGwnrgVHnIniBeKq75F9vCkaYVfBob
        ASQEfi/c+x2GHZePjbb1CVYfAp1lr4wBH7M065I=
X-Google-Smtp-Source: AFSGD/V1lIEdK9+MgAJ7IqTpuS6V+rVd9IHZ7PwJMcegB/uz/4LYTEcXpXmeaW5mWEXUdKoapeV0D8asHrXXYnZZELU=
X-Received: by 2002:a67:3885:: with SMTP id n5mr18246062vsi.96.1546622203679;
 Fri, 04 Jan 2019 09:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20170908111923.27434-1-thomas@m3y3r.de> <20170908230155.esge2mctk5d5g7gb@ast-mbp>
 <59B32231.9090406@iogearbox.net> <ed20875b-7a01-fbc8-e8d1-3929ba35c8ac@kernel.org>
 <295553a4-aadc-e5d1-229e-22d1966bc9f5@kernel.org>
In-Reply-To: <295553a4-aadc-e5d1-229e-22d1966bc9f5@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Jan 2019 18:16:31 +0100
Message-ID: <CAMuHMdXRN=mSKTjZNBSxQi-pkgSrKqeANxD-GB+hqC8pDjx7nQ@mail.gmail.com>
Subject: Re: selftests/bpf doesn't compile
To:     Shuah Khan <shuah@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Networking <netdev@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

CC kbuild, gpio

On Thu, Sep 14, 2017 at 5:34 PM Shuah Khan <shuah@kernel.org> wrote:
> bpf test depends on clang and fails to compile when
>
> ------------------------------------------------------
> make -C tools/testing/selftests/bpf run_tests
>
>
> make: clang: Command not found
> Makefile:39: recipe for target '.linux-kselftest/tools/testing/selftests/bpf/test_pkt_access.o' failed
> make: *** [./linux-kselftest/tools/testing/selftests/bpf/test_pkt_access.o] Error 127
> make: Leaving directory '.linux-kselftest/tools/testing/selftests/bpf'

The above failure is indeed due to missing clang.

> With "make TARGETS=bpf kselftest" it fails earlier:
>
> make[3]: Entering directory './linux-kselftest/tools/lib/bpf'
> Makefile:40: tools/scripts/Makefile.arch: No such file or directory
> Makefile:84: tools/build/Makefile.feature: No such file or directory
> Makefile:143: tools/build/Makefile.include: No such file or directory

This is due to srctree being "." instead of the actual source tree,
when invoked as "make kselftest".
When using "make -C tools/testing/selftests", srctree is correct.

tools/testing/selftests/bpf/Makefile has:

    $(BPFOBJ): force
            $(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/

to enter the tools/lib/bpf directory to force a build of libbpf.a

Note that tools/gpio has the same issue.

There seem to be _four_ different ways to build kselftests
(Documentation/dev-tools/kselftest.rst):

    make kselftest
    make O=/path/to/output kselftest
    make -C tools/testing/selftests
    make O=/path/to/output -C tools/testing/selftests

I'm not so fond of the latter two, as they basically run make from
somewhere inside the tree, which complicates things. I believe we don't
support this anywhere else.

Each of the four seem to have (different) issues. Especially when you
throw cross-compiling into the mix. And care about where installed
headers end up (yes, kselftest calls headers_install internally).

I'm working on fixes for some of them, but I don't know how to fix the
srctree issue.

Anyone with a suggestion?

Thanks!

> make[3]: *** No rule to make target 'tools/build/Makefile.include'.  Stop.
> make[3]: Leaving directory '.linux-kselftest/tools/lib/bpf'
> Makefile:34: recipe for target './linux-kselftest/tools/testing/selftests/bpf/libbpf.a' failed
> make[2]: *** [./linux-kselftest/tools/testing/selftests/bpf/libbpf.a] Error 2
> make[2]: Leaving directory './linux-kselftest/tools/testing/selftests/bpf'
> Makefile:69: recipe for target 'all' failed
> make[1]: *** [all] Error 2
> Makefile:1190: recipe for target 'kselftest' failed
> make: *** [kselftest] Error 2

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
