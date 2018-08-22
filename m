Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4CDC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E42208C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R8VFioAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E42208C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeHVVRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:17:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36577 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHVVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:17:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so1191178plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QgUK2d5jeSwQI6Y8u5Wk7p22DoAHY3S+pJGnLKtV0d8=;
        b=R8VFioAWE9SO6jL6ehDkQefD6V3qANRpM/kevFk76PRfsABpq8dUWC4y+gY8VJqy2K
         iIsFUf0MjbzEWptwgjfy+JMopxrZV8+C94GMA1m1WgO5exEczGjTcU7KB/zO32DYPgY/
         cY4JaZJSVCnsraDvdp4sP6Gu/gXdZ26Xt6y2zlwBO+zxQ+cQyyjWonD1F+VULb4ovQI3
         roKMWSWFTcpiiWOYsgzmBnpRvR2wDUB2BN2FrRbhJZwqB8/a2AUN2jwsu43IyB291ULz
         sUsusCQnag5VhHxnENWvOM055ADtam2L18eUh0FEGssTV9oqbIcWAmxKA3Ok0RhrzUnT
         qoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QgUK2d5jeSwQI6Y8u5Wk7p22DoAHY3S+pJGnLKtV0d8=;
        b=azsigYFMJuRQD1AOJXiVlCqoBSaJ64ZE5DFa8HN7gx4hhwSjcRNDV+z7TxtRxzazYu
         UUvwooAKTppyx/U4QNqeHsELg3mXcvo1nXKAtn72i8HCiReCkAJJg2fJsLDnhlBzBqvw
         TSW0eNoHinv5as8wACcLq6To4aHQKRCmEO269OeytN4Y7reKyp7B2PlnZ66LQgspHvHT
         NeYIR+yotsHAGsq+Dzuz/GDptpusspAKGgE/yhM/PCp53zVB/9YCN5/B2i3nHApTdwBH
         CGfx5qFROt5qxPbQEvrG1bmI4D5Xj0GRTwI0IgF6vMGG4uE/3rPf17SIflYRoYdRggKi
         Y6xA==
X-Gm-Message-State: AOUpUlGEkkG0KOM4aT8HyczW1LRqcug1+FraykiNmwEM6yoFF7yxnufs
        iuobgSz6tulXq/YDxD5dsGON4A==
X-Google-Smtp-Source: AA+uWPwS9dMGuqNjxqLIUx2zSfYxD5jns93njpYrQtFMXtTGw9FqJcF+H0KsSBViiRMEp1CzsbMKgA==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr54373577plf.320.1534960278632;
        Wed, 22 Aug 2018 10:51:18 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y3-v6sm3523039pfi.24.2018.08.22.10.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:51:17 -0700 (PDT)
Date:   Wed, 22 Aug 2018 10:51:17 -0700 (PDT)
X-Google-Original-Date: Wed, 22 Aug 2018 10:30:25 PDT (-0700)
Subject:     Re: [PATCH v2] kbuild: rename LDFLAGS to KBUILD_LDFLAGS
In-Reply-To: <1534945405-16396-1-git-send-email-yamada.masahiro@socionext.com>
CC:     linux-kbuild@vger.kernel.org, richard@nod.at, jdike@addtoit.com,
        x86@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        rmk+kernel@armlinux.org.uk, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     yamada.masahiro@socionext.com
Message-ID: <mhng-5d4b0f73-4c16-4111-a203-dc8076a2f3bc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 06:43:25 PDT (-0700), yamada.masahiro@socionext.com wrote:
> Commit a0f97e06a43c ("kbuild: enable 'make CFLAGS=...' to add
> additional options to CC") renamed CFLAGS to KBUILD_CFLAGS.
>
> Commit 222d394d30e7 ("kbuild: enable 'make AFLAGS=...' to add
> additional options to AS") renamed AFLAGS to KBUILD_AFLAGS.
>
> Commit 06c5040cdb13 ("kbuild: enable 'make CPPFLAGS=...' to add
> additional options to CPP") renamed CPPFLAGS to KBUILD_CPPFLAGS.
>
> For some reason, LDFLAGS was not renamed.
>
> Using a well-known variable like LDFLAGS may result in accidental
> override of the variable.
>
> Kbuild generally uses KBUILD_ prefixed variables for the internally
> appended options, so here is one more conversion to sanitize the
> naming convention.
>
> I did not touch Makefiles under tools/ since the tools build system
> is a different world.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>
> Changes in v2:
>   - Rebased on Linus's tree
>
>  Makefile                           | 6 +++---
>  arch/arc/Makefile                  | 2 +-
>  arch/arm/Makefile                  | 4 ++--
>  arch/arm64/Makefile                | 4 ++--
>  arch/c6x/Makefile                  | 3 +--
>  arch/h8300/Makefile                | 2 +-
>  arch/hexagon/Makefile              | 4 +---
>  arch/m68k/Makefile                 | 2 +-
>  arch/microblaze/Makefile           | 4 ++--
>  arch/mips/Makefile                 | 2 +-
>  arch/mips/boot/compressed/Makefile | 2 +-
>  arch/mips/lasat/image/Makefile     | 2 +-
>  arch/nds32/Makefile                | 4 ++--
>  arch/powerpc/Makefile              | 6 +++---
>  arch/riscv/Makefile                | 4 ++--
>  arch/s390/Makefile                 | 2 +-
>  arch/sh/Makefile                   | 4 ++--
>  arch/sparc/Makefile                | 4 ++--
>  arch/um/Makefile                   | 2 +-
>  arch/x86/Makefile                  | 4 ++--
>  arch/x86/Makefile.um               | 4 ++--
>  arch/x86/boot/compressed/Makefile  | 6 +++---
>  arch/xtensa/Makefile               | 2 +-
>  arch/xtensa/boot/boot-elf/Makefile | 2 +-
>  scripts/Kbuild.include             | 4 ++--
>  scripts/Makefile.build             | 4 ++--
>  scripts/Makefile.lib               | 2 +-
>  scripts/Makefile.modpost           | 2 +-
>  28 files changed, 45 insertions(+), 48 deletions(-)

[...]

> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 9ddd88b..61ec424 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -29,7 +29,7 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
>  	KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
>
>  	KBUILD_MARCH = rv64im
> -	LDFLAGS += -melf64lriscv
> +	KBUILD_LDFLAGS += -melf64lriscv
>  else
>  	BITS := 32
>  	UTS_MACHINE := riscv32
> @@ -37,7 +37,7 @@ else
>  	KBUILD_CFLAGS += -mabi=ilp32
>  	KBUILD_AFLAGS += -mabi=ilp32
>  	KBUILD_MARCH = rv32im
> -	LDFLAGS += -melf32lriscv
> +	KBUILD_LDFLAGS += -melf32lriscv
>  endif
>
>  KBUILD_CFLAGS += -Wall

Ah, thanks -- I'd noticed this when we were messing around in here recently and 
assumed there was some reason for the non-orthogonality.  As far as the RISC-V 
stuff goes, feel free to add a 

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I can deal with the inevitable merge conflicts on our end, as they'll be 
trivial :).
