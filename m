Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358E0C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00F62082E
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="J2kYTNhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00F62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbeKEJ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 04:27:47 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44101 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeKEJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 04:27:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so11936554qkh.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 16:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DefHv6QVwy4iBHaY7rU6bIW3MRtaDfO7YheFLG6O6rc=;
        b=J2kYTNhC5lnKI2ecqJKrWwo5LqCz/RQ9TvXBUJMVCJUlr5PFc6D3ciIGBIMbdsTfW6
         vDOJCIgrrkFmxdC04GmwmQSf3kvQUrUN/lvEfKZc+aKNgohepCfq+RXqQRYmKQuEiAS5
         5VVsRgf3OtTmVo4l3l3XL1HPSYvZDCip1P0Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DefHv6QVwy4iBHaY7rU6bIW3MRtaDfO7YheFLG6O6rc=;
        b=WFBPwNB7DwZYqS7YwrrzKHOZHTAzdLahvWCd1oMi+tMxjgTqqma6XlcWlFm9jXqW75
         ICqsqauIGgePyPgyAzFI54Vex/jAapwh6+JMEvoKjVPP4khd+QJvOnN1EG/9iVh8PFH6
         svkoOPIL/opHwdbF1R0VfqvQjkpNJRpiSO/0wLKyIAJqqcpG//VY0SM+tRmsw+5hqoHn
         YuB/eCDHWu1ilPvOI2ajiZlDWHkv0FQzPaeWPJF3TFw+3HKS9hkIc1D65nrFIARSIa9S
         wilQwoEe/BehXLnysHvvEVOOco+mD+Q7YYMcjyOiDFmALzUvpju1Yuu9OcaPPW4p7XfY
         zfUg==
X-Gm-Message-State: AGRZ1gLo6ED/vVCTupMiaFu/YqbvXuYv+SCNdNLBdcyzr1GAHvbh1UI/
        agovZlfhz/7S9/xaBsJxmEQMzg==
X-Google-Smtp-Source: AJdET5fqqpmJQMTqhywuWxPh6SndKwYXrHtysPORvcO201bXdlKsusNH8RcGlQvq4hpPI9Y35pWVjQ==
X-Received: by 2002:a0c:c38d:: with SMTP id o13mr19328795qvi.100.1541376657311;
        Sun, 04 Nov 2018 16:10:57 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4356])
        by smtp.gmail.com with ESMTPSA id j51-v6sm20916062qtj.26.2018.11.04.16.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 16:10:55 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] Makefile: Export clang toolchain variables
In-Reply-To: <20181104231133.30848-2-joel@jms.id.au>
References: <20181104231133.30848-1-joel@jms.id.au> <20181104231133.30848-2-joel@jms.id.au>
Date:   Mon, 05 Nov 2018 11:10:49 +1100
Message-ID: <87ftwg4c52.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Thanks!

Tested-by: Daniel Axtens <dja@axtens.net> # powerpc 64-bit BE

Regards,
Daniel

> The powerpc makefile will use these in it's boot wrapper.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 9aa352b38815..a2db3c885b38 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,6 +495,9 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +export CLANG_TARGET
> +export CLANG_GCC_TC
> +export CLANG_PREFIX
>  KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> -- 
> 2.19.1
