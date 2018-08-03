Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6CC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F992170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Zt/3ps9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F992170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeHCDUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:20:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42550 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeHCDUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:20:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so2036467pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8PoT6prSd3zCQyP1hl05xhkBAQ/1w3gNUi5e5fXPOJc=;
        b=Zt/3ps9Eev2IQAhzOKc00KzbhTM2lnyyN1iMgM38PTko7mg1K34Zgdsi3M8g0yRfSg
         GFJRCi4tzpgMuFNxVSN6vG3n84D6XSsEMXBafnEIcYeAHZXQLAnqGvmfAgwrdWM3JnyL
         wPb9kFLlJ/N63PhrEKF9MqRjcGKDwaCO4ALvngbNwVCxEusUolw6vxVk+KBD42/7qLVg
         wfKMkw56DWVURH2YqwUCXkWGRDT7Mgn7v/mcv2zaPf8inviiQKr8EL6Qk2oIC9e22Xn8
         91ED24gfiUuJoK+zbiaxOZOSWMSsTMlzsGIhIHF6/mmv0m69lFQ6mmv3g8/Kk8JsxqBf
         LAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8PoT6prSd3zCQyP1hl05xhkBAQ/1w3gNUi5e5fXPOJc=;
        b=GWB6PcRZ5ot+lFUu82NVrM755VOmVc9Zi4BQVeILLcALPSLjqWD9WKosvz33cteZG+
         l4RsymzciipUIzWE7hZChRrDgXgxk12zWkcWN+W12arv0LPayR60FsezqoBucsq4RqEy
         lOC+L7ku+H610jCIGc7uRh7Aw3B0F9B8L58Rd5OKFhbn8ttCRp8Lmt/8joVhRdnw8c42
         7o3XMbTgcjFHAGvfLYusOpRtGC6RgiW3U49ubJaoJHuSh2sohQheh+0+K9isZitnj/FD
         lmeHW1+hteLZwb1tfJqyWxqsiSFIPPjyQxjapnE34Ab7kwELrtGYd/SUtzoNwtJwSL/K
         T0ng==
X-Gm-Message-State: AOUpUlEjPwMxqmhBNgHp3Ih9DYhc8OKev3FtZND23ZuKBY5DvrOV9et9
        WUtWTW4zXzlkpqdYuk9BG+092w==
X-Google-Smtp-Source: AAOMgpdMbyF38FtteieTLUiVTqK7CiUavtqaDf+40//vnRGi0bGNTgP9J5UmXdtnVTYGv0cnqPPLqQ==
X-Received: by 2002:a63:fb57:: with SMTP id w23-v6mr1634328pgj.441.1533259619555;
        Thu, 02 Aug 2018 18:26:59 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u2-v6sm4584922pfn.59.2018.08.02.18.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 18:26:58 -0700 (PDT)
Date:   Thu, 02 Aug 2018 18:26:58 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Aug 2018 18:26:36 PDT (-0700)
Subject:     Re: [PATCH v3 3/7] riscv: Delete asm/compat.h
In-Reply-To: <20180707054247.19802-4-deepa.kernel@gmail.com>
CC:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     deepa.kernel@gmail.com, zongbox@gmail.com
Message-ID: <mhng-ca3e24c4-d59b-491d-a9c5-c8466168b638@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018 22:42:43 PDT (-0700), deepa.kernel@gmail.com wrote:
> riscv does not enable CONFIG_COMPAT in default configurations:
> defconfig, allmodconfig and allnoconfig.
> Remove the asm/compat.h as it does not seem to add any value to
> the architecture without CONFIG_COMPAT.
>
> Now that time compat syscalls are being reused in non CONFIG_COMPAT
> modes, asm-generic/compat.h provides definitions for riscv 32 bit
> mode.
>
> Alternative would be to make compat_time.h to be conditional on
> CONFIG_COMPAT_32BIT_TIME. But, since riscv does not does not need
> asm/compat.h, delete it instead.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: palmer@sifive.com
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/include/asm/Kbuild   |  1 +
>  arch/riscv/include/asm/compat.h | 29 -----------------------------
>  2 files changed, 1 insertion(+), 29 deletions(-)
>  delete mode 100644 arch/riscv/include/asm/compat.h
>
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 576ffdca06ba..efdbe311e936 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -1,6 +1,7 @@
>  generic-y += bugs.h
>  generic-y += cacheflush.h
>  generic-y += checksum.h
> +generic-y += compat.h
>  generic-y += cputime.h
>  generic-y += device.h
>  generic-y += div64.h
> diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
> deleted file mode 100644
> index 044aecff8854..000000000000
> --- a/arch/riscv/include/asm/compat.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/*
> - * Copyright (C) 2012 ARM Ltd.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> -#ifndef __ASM_COMPAT_H
> -#define __ASM_COMPAT_H
> -#ifdef CONFIG_COMPAT
> -
> -#if defined(CONFIG_64BIT)
> -#define COMPAT_UTS_MACHINE "riscv64\0\0"
> -#elif defined(CONFIG_32BIT)
> -#define COMPAT_UTS_MACHINE "riscv32\0\0"
> -#else
> -#error "Unknown RISC-V base ISA"
> -#endif
> -
> -#endif /*CONFIG_COMPAT*/
> -#endif /*__ASM_COMPAT_H*/

I thought we were using this to make uname print "riscv64" (or "riscv32") 
instead of just "riscv"?  Is there another mechanism to do that?
