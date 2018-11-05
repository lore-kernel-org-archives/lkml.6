Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FFEC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12722082E
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="lwfmj+VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12722082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbeKEJ2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 04:28:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37816 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbeKEJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 04:28:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so12004503qkd.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 16:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=WZ0SN/9tIOLxDw5ecT7eyS26p7AIrwBGnjqeB2WICjE=;
        b=lwfmj+VZmnvhRNCzJ0Biylkt/sYF4zCNvsS1cfVx5a1treWDBmIKWQXqFRXYzgh0l8
         7GS3zm56rCCiXNepqRPCXAQz8Sz8XNveu+by4vat7nMlYdcBeL00HYr1CKUN3WKjFEex
         U93lVguGuwDeoiDhT279UVGftv72z3B9deecI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WZ0SN/9tIOLxDw5ecT7eyS26p7AIrwBGnjqeB2WICjE=;
        b=KazSQKTec0c4oY166kyh4Rsb10aauc+a0cUHM+zg8TJzG033q526vfCZDfJxqwIy/5
         /u7YDVhy9dZhOpVRo4toGtGWreKM3a90zuwestRV3sJiuldQPZXlG9kvewonpNmi00ww
         PkbhEmWf+4PTsFX/k+UxMrUSDt2llbHUojLn31O+IJQU2b6F9ay8PVSz/eF/HH+4VbOk
         /h8no1jNGSZN/JijXgc1Mw1ML2hjgSHS6FWN0PdTSkQPjQYfXnE/YcK6pkCdyVwBGt72
         DiIz32db8iZ/LQAIQ8ZOmhoUuXY6hREAoH/lshzhbgTaQFWfT58gYAqaNOVwnizUxmKA
         h4HQ==
X-Gm-Message-State: AGRZ1gIgBPCwbwSyWH6qISwRCDgai3REKFHypWpcA7VUq96ZTGZNR2lP
        T34KuCUBLM2gphY9IddxNpormQ==
X-Google-Smtp-Source: AJdET5d0d8Wnsse+wXmO+a2wHRWZG5XlesL/vcqRxFMtCeG9e2nhcsiuCrCZibHaoYr8weH61heNNQ==
X-Received: by 2002:ac8:1909:: with SMTP id t9mr18656691qtj.327.1541376715279;
        Sun, 04 Nov 2018 16:11:55 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4356])
        by smtp.gmail.com with ESMTPSA id e17sm1090593qte.12.2018.11.04.16.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 16:11:54 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/boot: Set target when cross-compiling for clang
In-Reply-To: <20181104231133.30848-3-joel@jms.id.au>
References: <20181104231133.30848-1-joel@jms.id.au> <20181104231133.30848-3-joel@jms.id.au>
Date:   Mon, 05 Nov 2018 11:11:49 +1100
Message-ID: <87d0rk4c3e.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Stanley <joel@jms.id.au> writes:

Hi Joel,

Thanks!

Tested-by: Daniel Axtens <dja@axtens.net> # powerpc 64-bit BE

This solves one of the 2 issues I have in building for 64-bit BE with
clang. The other is the VDSO32 stuff, and I hope to send a patch for
that soon.

Regards,
Daniel

> Clang needs to be told which target it is building for when cross
> compiling.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/259
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/boot/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 39354365f54a..8fdb1890f09a 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -55,6 +55,13 @@ BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
>  
>  BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
>  
> +ifdef CONFIG_CC_IS_CLANG
> +BOOTCFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> +BOOTAFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> +BOOTCFLAGS += $(call cc-option, -no-integrated-as)
> +BOOTAFLAGS += $(call cc-option, -no-integrated-as)
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO
>  BOOTCFLAGS	+= -g
>  endif
> -- 
> 2.19.1
