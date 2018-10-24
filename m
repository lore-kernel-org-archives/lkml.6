Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA4ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A638A20833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPXWBrBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A638A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeJYEY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbeJYEY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:24:57 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C3020856;
        Wed, 24 Oct 2018 19:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540410930;
        bh=odyqBKiYzBv5IdIjuzYAxZmBJIO7/EssQKEqn+zv55Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pPXWBrBY48yKmVZsXTwnisZP13JqtDYYYkw0MgF5fzrB0Kyr3C1w180LeNbCUqTMI
         7jGgJ5Aa6GlqBjlH1EXuO620tqj2AM9TpbqXXOJqD8ThiOnXSMbaekyyxcisqwNUJm
         6H8xB6oFAY5/Mosi2BOK2RnN9DT9LDaSAgYcgCaw=
Received: by mail-qt1-f178.google.com with SMTP id d14-v6so7095735qto.4;
        Wed, 24 Oct 2018 12:55:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKmUKzAHqOL6JadaLE9lXmmwmkYg5zIHRbcOhRKo/dlO5CMk+a/
        JwbYqYVUasfNVWd5EaHM3beWXSyXTomL+soyaw==
X-Google-Smtp-Source: AJdET5fsfiJJQiRG4tYbtk5oK2Hs+N0GSRD1ejgIMFFWz394cehWWCibOhJ12q0e8gCpcmQUgoAPaMWg1f+S+gdFGLQ=
X-Received: by 2002:ac8:5414:: with SMTP id b20-v6mr106396qtq.144.1540410929467;
 Wed, 24 Oct 2018 12:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181024193256.23734-1-f.fainelli@gmail.com>
In-Reply-To: <20181024193256.23734-1-f.fainelli@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Oct 2018 14:55:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
Message-ID: <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing CONFIG_BLK_DEV_INITRD
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>, linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        SH-Linux <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi all,
>
> While investigating why ARM64 required a ton of objects to be rebuilt
> when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
> because we define __early_init_dt_declare_initrd() differently and we do
> that in arch/arm64/include/asm/memory.h which gets included by a fair
> amount of other header files, and translation units as well.

I scratch my head sometimes as to why some config options rebuild so
much stuff. One down, ? to go. :)

> Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
> systems that generate two kernels: one with the initramfs and one
> without. buildroot is one of these build systems, OpenWrt is also
> another one that does this.
>
> This patch series proposes adding an empty initrd.h to satisfy the need
> for drivers/of/fdt.c to unconditionally include that file, and moves the
> custom __early_init_dt_declare_initrd() definition away from
> asm/memory.h
>
> This cuts the number of objects rebuilds from 1920 down to 26, so a
> factor 73 approximately.
>
> Apologies for the long CC list, please let me know how you would go
> about merging that and if another approach would be preferable, e.g:
> introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
> something like that.

There may be a better way as of 4.20 because bootmem is now gone and
only memblock is used. This should unify what each arch needs to do
with initrd early. We need the physical address early for memblock
reserving. Then later on we need the virtual address to access the
initrd. Perhaps we should just change initrd_start and initrd_end to
physical addresses (or add 2 new variables would be less invasive and
allow for different translation than __va()). The sanity checks and
memblock reserve could also perhaps be moved to a common location.

Alternatively, given arm64 is the only oddball, I'd be fine with an
"if (IS_ENABLED(CONFIG_ARM64))" condition in the default
__early_init_dt_declare_initrd as long as we have a path to removing
it like the above option.

Rob
