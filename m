Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B686C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E6821A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E6821A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeHFMsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:48:02 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36600 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFMsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:48:01 -0400
Received: by mail-ua0-f170.google.com with SMTP id c12-v6so11559091uan.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VmxolvbcIJgv/TAmHuwERGYKTPdHWNQPRlnIEajBh90=;
        b=Sq9AsQfCOWGJwqfsTHiLAqiPj0xL2l8kDpPdPUcDQpcpJ6nyQyUysi+qkbzZhgL3G6
         9l9/74NBkz/i/XhdJrtVB3PHxY3ODiHZcYZvO/mCWCNQ1sdU7/iggw9IB2dKdFPLp8kt
         gQQbjtvKaMFvFQNC4fIJqY7tWUjKkCs7CJV5/LdKjZgyqgCyCi21qrouOXV4wsUlQR4c
         EeVaCJQuhwSQghaQtnHou3E0VhFG+AwY6/u0JDOW1rBdzR5D4x6Ot/0SFPAW9SBy7Gdu
         6CKm7FRKNVS7X3y0gG/0fVB9y2AEq0hezi4lfEpvA4m1s68tQKS+8G5aj8EpL7RgaQTV
         iz/Q==
X-Gm-Message-State: AOUpUlGuEw39wj/ikk5/2397yUdAvjwe8UtIDMaDzCTLxQXnigaZK6zq
        5xE8G/79luvE3iOZnn8R7UpObk0YrDAHdYKUcfFGVQ==
X-Google-Smtp-Source: AAOMgpescpYi+0R58CeOppuhGqEGB7WIm/pKL0KjlgGh3Y6OIoEblRVEScln+uwOSbiWZ0yotJO+LeSIU07wbpJg1sU=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr10008888uad.12.1533551973313;
 Mon, 06 Aug 2018 03:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Aug 2018 12:39:21 +0200
Message-ID: <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Dan, Michael, AKPM, powerpc

On Mon, Apr 16, 2018 at 3:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.17-rc1[1] compared to v4.16[2].

I'd like to point your attention to:

>   + warning: vmlinux.o(.text+0x376518): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x376d64): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x37dfd8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x37e824): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x3944): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
>   + warning: vmlinux.o(.text+0x3978): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
>   + warning: vmlinux.o(.text+0x3a66c): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
>   + warning: vmlinux.o(.text+0x3e9908): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x3ea154): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x498dbc): Section mismatch in reference from the function hmm_devmem_release() to the function .meminit.text:arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x499130): Section mismatch in reference from the function hmm_devmem_pages_create() to the function .meminit.text:arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4a59ec): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4a5d08): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4ad8ac): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4adbc8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4ca7238): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
>   + warning: vmlinux.o(.text+0x51ffec): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x520308): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A

These are still seen on v4.18-rc8 on various powerpc all{mod,yes}config builds.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
