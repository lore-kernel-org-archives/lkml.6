Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F452152D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F452152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeHIJyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:54:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46209 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:54:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id l16-v6so3383003lfc.13;
        Thu, 09 Aug 2018 00:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=um1o8O0oro4qWrLZq0bV+ac6cbwb+JflNYf9q4SyrcY=;
        b=XVp83p0JRJ3xbzy3OSlD2H9k+KjHZwr9lvjwqaK4H9XtieoPy9LO2KkAAhyFFwhmo3
         Fdhr5Lu+vfZua6/7+w9z6CaiWXZK3xanWc6bNukFooJDSbH2YN13VRwvnth29Hh/oT6k
         Ah/KCSuat1On7W/BCpzUfTjMVuwtxXXpIP4gmVLo/MbLjfTkay3AW5sLAAVgiOBrfF0C
         OAVf/9Re8Oggpgn8wkUTNE4t+HbEStKgYU/e3v/WPg8fIJ8lJ/yDeUQQ0Fl0E/kRU5b2
         d27X3vf8f9c0ynoXZHA5bau485qstAzMYJPf2LR4K6GaFUr7xfnZ0/O5Q6LXqoNaLqgB
         df7w==
X-Gm-Message-State: AOUpUlGm1UMdchkIPWhdjXpLyCE5II64kbpwAAV0qL+rEED/qy6ICSrv
        ghCn5lyOI1yTYhnncppkWnro/PK4qs4SOnENnDc=
X-Google-Smtp-Source: AA+uWPxCZnE3z/bnAQpIA6qeSPx/JSb+AtFSTEQflSl6vMthcmnrQCwYr62tkB4ZYlE0hg9HzEONjoQfRTsyeMegLl4=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr702816lfh.19.1533799859320;
 Thu, 09 Aug 2018 00:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org> <1533791723-3882-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1533791723-3882-3-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Aug 2018 09:30:45 +0200
Message-ID: <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] m68k: Replace NR_syscalls macro from asm/unistd.h
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
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

One first comment below...

On Thu, Aug 9, 2018 at 7:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
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
> The 2nd option will be the recommended one. For that, I moved the
> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
> name also changed form NR_syscalls to __NR_syscalls for making the
> name convention same across all architecture. While __NR_syscalls
> isn't strictly part of the uapi, having it as part of the generated
> header to simplifies the implementation.

It can indeed not be part of the UAPI, as UAPI definitions can never change,
while new syscalls will be added in the future, increasing the number ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
