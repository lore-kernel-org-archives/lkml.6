Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA087C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B432086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hxr9KTSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B432086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbeKGKBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:01:01 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46464 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeKGKBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:00 -0500
Received: by mail-pg1-f181.google.com with SMTP id w7so6550387pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LO16PbJ/K3AArKyoRoeZEi/U/eQfkTbEnqcKbY4deoI=;
        b=hxr9KTSH9XsaL4QSDJGSeq2D7gYeQ+gSc4OSBVALcwhj1kftBwqw0NuBZf6oh4+f7j
         u0S1oRB43INpUzkiy3mRcIY/yixQlNtXhTLJj+LNBDXNWXKGRDxdn5Hczr8QqEu8sqWv
         WaaDhV7OVsHaF6fY9FqksrxQBJgPrXE2+ywbKzE20DcHB1CK5Gh2TOhERzmafogf4sGl
         +CWg7W4DCmA9oGdk1tGRhkZDGGYRpfxUZkG4kFZm5DAVUJFYcRh+f83SuHTETu6tYhXX
         +XAi3OAQeRPOUBy/7ccJ+K8cyPFKnUCloH5soKs9yr5YeOWUnO+vIagHXE7nQbgN3xBG
         sSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LO16PbJ/K3AArKyoRoeZEi/U/eQfkTbEnqcKbY4deoI=;
        b=rCnN/J+bBQKlluf0aEaaV/lMPo9eEUWitcbYBLAIcGtsHsS7xVtu1sTk/PD5/7aGHj
         eEY/8+jo1664HnjMvRhlq/RGP8VkrTi5NHKFWIE08YXuqDncQYZmSCFBJvDlWD5fDMYv
         cRNUV2pG6qQUF7Mz8bhBNImxjOxrtYtbm8DWq85/PzPHOr0PG7/ZYbY+0/BR5WdYT45d
         8i3L6MYketOfa56xHjKW/05f4myZb2caP4jPeEk2M5hUnotX5k/ENoJwUIlaoWz+qmKj
         2bd+lRW+z2vXoFWIR3nMFiL9gg8IT8JL/tuEhCpK1baUjX6HyUk5Nrni+WDE1HtkEGNA
         QmLg==
X-Gm-Message-State: AGRZ1gJ3pjcvqVyg/UJ1mNKCLE6k2iulqfI8alWEae0I2owPAo9fpMl9
        vx2OoZLGOXN1bQKGQYS/pqKt6g==
X-Google-Smtp-Source: AJdET5dyHGeCv6RCjsenhZR5NuSHHIaU6jMEuIQVky6pOPd7PghxNCXIIOOnW/D1PirSlaAtmucgEg==
X-Received: by 2002:a62:60c6:: with SMTP id u189-v6mr20707613pfb.191.1541550785551;
        Tue, 06 Nov 2018 16:33:05 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d126-v6sm68107654pgc.32.2018.11.06.16.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:04 -0800 (PST)
Date:   Tue, 06 Nov 2018 16:33:04 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 16:30:16 PST (-0800)
Subject:     Re: [PATCH] riscv: add missing vdso_install target
In-Reply-To: <20181105143537.27396-1-david.abdurachmanov@gmail.com>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-a44df3fe-5958-4566-a057-5e028be53203@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov 2018 06:35:37 PST (-0800), david.abdurachmanov@gmail.com wrote:
> Building kernel 4.20 for Fedora as RPM fails, because riscv is missing
> vdso_install target in arch/riscv/Makefile.
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  arch/riscv/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index d10146197533..4af153a182b0 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -77,4 +77,8 @@ core-y += arch/riscv/kernel/ arch/riscv/mm/
>
>  libs-y += arch/riscv/lib/
>
> +PHONY += vdso_install
> +vdso_install:
> +	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
> +
>  all: vmlinux

While this doesn't smell like it should be an arch-specific thing, it looks 
like everyone else has a copy and they're all slightly different so it'd 
probably be more complexity to merge them than duplicate them.

I'll take this into my PR for next week.

Thanks!
