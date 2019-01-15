Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03421C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A1420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMCemkgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfAOICw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:02:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46963 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfAOICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:02:51 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so1325597ios.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McN6moR7y88+4bHZhsA4IJdl2dXNtxu73L8Cv6c8vJo=;
        b=BMCemkgFqp7ogQxURcXpH3XZfZKctda5nI20RiZ3Fm7bOLETb5vXvC5VHveXVlQvhP
         ixzFM7NYkLtA7L+LaEysPMd5TEuMOhFuwjlF1CodHnDvEUVp8ND7FhpEkKfstJ4nlkHO
         5FWeRvuFS1VnQRmxssBvcbXsjrvUEynuArx/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McN6moR7y88+4bHZhsA4IJdl2dXNtxu73L8Cv6c8vJo=;
        b=pVHHte4NdqtdKRhmbHtK3qc24ZF7/LLGt9p02tISnqzhff2rdMKjeq/9ck/5MaTNHf
         ZWO+XdZBoBG/gmkV/z6ZVxiu89Shtz+sb8PjmYL+AH531BBbxPawH4jpD1JLXfcYLjrA
         U6olLRauEjy7jBeyHjXvug+FJpFBSXGslcZ9DtKKDCHE92tOU7EdgCZkHxme/W8xkwMu
         jy5vKALDP4DVZkAPSwMe4jX+8Y3zYgIKx17Glb2VgrWbgoI0Qkzzm9ni+q5Ki9dE53NS
         BPO+9JmNTpJOaLr1G/TZtEnaHaK7vMJuqQrFSfEtNif96nIYLMLqj1kLUGj8rHJ6HV78
         fuOA==
X-Gm-Message-State: AJcUukfQEFehA9zx9aH6s4UJIqD1GhKYTQAQBoJoi+IQYh3gSb8VO99n
        BWvruNPiP+l6LLpVApPfFLWpIWAwonpPyfqFNHy/ag==
X-Google-Smtp-Source: ALg8bN6ZZt8ErAyZptBe8Cm5A3zYjUNW+vcN8IJRFNgG99+6fjZJjifeqxiOqCUNzlxaydHre3MtoaZC738WVp7f9lc=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr1397349iop.60.1547539371093;
 Tue, 15 Jan 2019 00:02:51 -0800 (PST)
MIME-Version: 1.0
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 15 Jan 2019 09:02:40 +0100
Message-ID: <CAKv+Gu9qt1HydS7J2q8g6f07XpSgCtRy-vc_shJqknYtAp2u9g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module build
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 at 08:20, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
> caused kernel panic on PowerPC if an external module is used with
> CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
> for the external module build.
>
> Commit e07db28eea38 ("kbuild: fix single target build for external
> module") turned it into a build error because the 'prepare' target is
> now executed but the 'prepare0' target is missing for the external
> module build.
>
> External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
> also broken in the same way.
>
> Move 'PHONY += prepare0' to the common place. Make is fine with missing
> rule for phony targets.
>
> I minimize the change so it can be easily backported to 4.20.x
>
> To fix v4.20 for external modules of PowerPC, please backport
> e07db28eea38 ("kbuild: fix single target build for external module"),
> and then this commit.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
> Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
> Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
> Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
> Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
> Cc: linux-stable <stable@vger.kernel.org> # v4.20
> Reported-by: Samuel Holland <samuel@sholland.org>
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 499b968..789b332 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -955,6 +955,7 @@ ifdef CONFIG_STACK_VALIDATION
>    endif
>  endif
>
> +PHONY += prepare0
>
>  ifeq ($(KBUILD_EXTMOD),)
>  core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> @@ -1061,8 +1062,7 @@ scripts: scripts_basic scripts_dtc
>  # archprepare is used in arch Makefiles and when processed asm symlink,
>  # version.h and scripts_basic is processed / created.
>
> -# Listed in dependency order
> -PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
> +PHONY += prepare archprepare prepare1 prepare2 prepare3
>
>  # prepare3 is used to check if we are building in a separate output directory,
>  # and if so do:
> --
> 2.7.4
>
