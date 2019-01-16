Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5818420675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bcSWqxDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbfAPSOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:14:15 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43223 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfAPSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:14:15 -0500
Received: by mail-ua1-f66.google.com with SMTP id z11so2494926uaa.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YeovtTKcFZoIShUVI6LJfRJxWzSHt98QfNVCTY0fudk=;
        b=bcSWqxDATSWvM6ZIKAnmy0S4taqzqViQJa8kKQkoiMiJXewZEV6lJshRwr8wffzNHP
         ApNxjnXfciOaPKR9V7OVG6XFwLBsn8BBqtHpHLmiyCO3K9FkFHct5DdNHXMbyQkw+Ig0
         LqhOOt5LfPGMo6F5CoksPNitJFGI6Bzdx4q/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YeovtTKcFZoIShUVI6LJfRJxWzSHt98QfNVCTY0fudk=;
        b=HNZs3vbJAmPquPSSzLNZ1nocjBtme0WdaGcKdShhTrpCi4SEgs71xmkyA1Lo/f5/Ki
         PVET5MhIphkbcLa3y98zIVidjmdm4Azwnq6cCpismT8eQOklscy8x2s2ab8FLW1c3lt7
         /C/jDiTu4pQE48ElyFyQSyxk87JJkAQS9JELg1XzdWxg/0BhntSFjcF/q93Nmi2owvH6
         1fDTOGRVB/pv2OVCS/bW3QgXy1DXQKAEBmcxCOBewXS8A2Uwyv0LHpbPsLZ2g9znQDyO
         oj11ZdOHJYMqFzcgkyQtrvT8X3KxrFYkuKhWSjPV212L31bspajEVb5k99iPGRj4kXIi
         LWWw==
X-Gm-Message-State: AJcUukcHhX2GfaoGuOzWjjverTbu5E4lvDpU/wLeXbNNKu+iumMyjv5V
        puWLA2Acv86ow+wOqAWyblFHVe2kCwA=
X-Google-Smtp-Source: ALg8bN6sLXyZ/YNSfwdq5XGaYpR8kIyIpCiPI8rSd5NGHYJmNu2wBmc0hVuMEhTWg1KEeUk0O0tBnQ==
X-Received: by 2002:ab0:21c6:: with SMTP id u6mr4210879uan.97.1547662453095;
        Wed, 16 Jan 2019 10:14:13 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id y195sm44581076vkd.0.2019.01.16.10.14.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:14:11 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id y14so1658317vkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:14:11 -0800 (PST)
X-Received: by 2002:a1f:4982:: with SMTP id w124mr4042143vka.4.1547662450962;
 Wed, 16 Jan 2019 10:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20190116174320.14938-1-daniel.diaz@linaro.org> <20190116174320.14938-3-daniel.diaz@linaro.org>
In-Reply-To: <20190116174320.14938-3-daniel.diaz@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 16 Jan 2019 10:13:59 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+1tOvB0jHk=kCxfhTg-PEPjCHp2TQb++wZsGxJCcQxng@mail.gmail.com>
Message-ID: <CAGXu5j+1tOvB0jHk=kCxfhTg-PEPjCHp2TQb++wZsGxJCcQxng@mail.gmail.com>
Subject: Re: [PATCH 3/4] selftests: seccomp: use LDLIBS instead of LDFLAGS
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 9:44 AM Daniel D=C3=ADaz <daniel.diaz@linaro.org> w=
rote:
>
> From: Fathi Boudra <fathi.boudra@linaro.org>
>
> seccomp_bpf fails to build due to undefined reference errors:
>
>  aarch64-linaro-linux-gcc --sysroot=3D/build/tmp-rpb-glibc/sysroots/hikey
>  -O2 -pipe -g -feliminate-unused-debug-types -Wl,-no-as-needed -Wall
>  -Wl,-O1 -Wl,--hash-style=3Dgnu -Wl,--as-needed -lpthread seccomp_bpf.c -=
o
>  /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.=
12-rc7/tools/testing/selftests/seccomp/seccomp_bpf
>  /tmp/ccrlR3MW.o: In function `tsync_sibling':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1920: undefined reference to `sem_post'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1920: undefined reference to `sem_post'
>  /tmp/ccrlR3MW.o: In function `TSYNC_setup':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1863: undefined reference to `sem_init'
>  /tmp/ccrlR3MW.o: In function `TSYNC_teardown':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1904: undefined reference to `sem_destroy'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1897: undefined reference to `pthread_kill'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1898: undefined reference to `pthread_cancel'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1899: undefined reference to `pthread_join'
>  /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /tmp/ccrlR3MW.o: In function `TSYNC_siblings_fail_prctl':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1978: undefined reference to `sem_wait'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1990: undefined reference to `pthread_join'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1992: undefined reference to `pthread_join'
>  /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_ancestor':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2016: undefined reference to `sem_wait'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2032: undefined reference to `pthread_join'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2034: undefined reference to `pthread_join'
>  /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /tmp/ccrlR3MW.o: In function `TSYNC_two_sibling_want_nnp':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2046: undefined reference to `sem_wait'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2058: undefined reference to `pthread_join'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2060: undefined reference to `pthread_join'
>  /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_no_filter':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2073: undefined reference to `sem_wait'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2098: undefined reference to `pthread_join'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2100: undefined reference to `pthread_join'
>  /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_one_divergence':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2125: undefined reference to `sem_wait'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2143: undefined reference to `pthread_join'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2145: undefined reference to `pthread_join'
>  /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>  /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_not_under_filter':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2169: undefined reference to `sem_wait'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2202: undefined reference to `pthread_join'
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:2227: undefined reference to `pthread_join'
>  /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>  /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests=
/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>
> It's GNU Make and linker specific.
>
> The default Makefile rule looks like:
>
> $(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)
>
> When linking is done by gcc itself, no issue, but when it needs to be pas=
sed
> to proper ld, only LDLIBS follows and then ld cannot know what libs to li=
nk
> with.
>
> More detail:
> https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.htm=
l
>
> LDFLAGS
> Extra flags to give to compilers when they are supposed to invoke the lin=
ker,
> =E2=80=98ld=E2=80=99, such as -L. Libraries (-lfoo) should be added to th=
e LDLIBS variable
> instead.
>
> LDLIBS
> Library flags or names given to compilers when they are supposed to invok=
e the
> linker, =E2=80=98ld=E2=80=99. LOADLIBES is a deprecated (but still suppor=
ted) alternative to
> LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
> variable.
>
> https://lkml.org/lkml/2010/2/10/362
>
> tools/perf: libraries must come after objects
>
> Link order matters, use LDLIBS instead of LDFLAGS to properly link agains=
t
> libpthread.
>
> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>

Acked-by: Kees Cook <keescook@chromium.org>

Shuah, can you take this?

-Kees

> ---
>  tools/testing/selftests/seccomp/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/sel=
ftests/seccomp/Makefile
> index fce7f4ce0692..1760b3e39730 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -9,7 +9,7 @@ BINARIES :=3D seccomp_bpf seccomp_benchmark
>  CFLAGS +=3D -Wl,-no-as-needed -Wall
>
>  seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
> -       $(CC) $(CFLAGS) $(LDFLAGS) -lpthread $< -o $@
> +       $(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
>
>  TEST_PROGS +=3D $(BINARIES)
>  EXTRA_CLEAN :=3D $(BINARIES)
> --
> 2.17.1
>


--=20
Kees Cook
