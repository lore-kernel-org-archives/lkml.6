Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC40ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37622075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37622075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeGRMRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:17:01 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33567 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeGRMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:17:01 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so2306731vkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Dl+XpLKrC1bvHpx03JRwDMDee2Ag2FbzSgLDZgcrig=;
        b=bLM+omxw+H50oUrcuDfSDYDPG+6PkvKlkP4RJV4iD3vIaVy41OL2AzXH21uSwXW7uo
         xEMfgJLZ//KX6G7WoIT803zt2k0EQj0tz9WMdbl51Hq541Jg3PbdlhIazomBKJHhN/VO
         xQV9fvNHWGZCy9uKg7gwpQoXwrPIhhkKDk+ouLTHGr0JJLjNStutbQF/tR74fFNBqh2P
         pUsGKgsFJKsLXYEBA7E72RmDQaF9KQ9c/H3PdLBtYqXvDz/ZuAfwbwIXTQ+r/Dg7xUkA
         6wlIGl7CmkxYsuM6WJhTzY2DSkCG5X6Z8zXOXC/48DJ37QvhpL+vNTBEM0X1ub7d3Vrp
         4yPg==
X-Gm-Message-State: AOUpUlHRmppG+/eEpQDGUisdenhq817roNCTEzsZgB1vwxMu2sNEiKzf
        cu0bRwl85Ruq/w225A0EtwJNdUVBr5IULFm7TT6nT2re
X-Google-Smtp-Source: AAOMgpcHDpUB8ttycp7MzQvCkxLjlhfJkfF5Cq0j4CLJVf6j/Bh6+h9WT3gq7ks++BAK21IZFSDXMVptey9i3Q2BYyI=
X-Received: by 2002:a1f:3701:: with SMTP id e1-v6mr3098698vka.50.1531913971643;
 Wed, 18 Jul 2018 04:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jul 2018 13:39:19 +0200
Message-ID: <CAMuHMdWOCtrYN4t4y5eucy1juE3L8fkb1PaZ9gJ9a=jMXV+FGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, Sam Creasey <sammy@sammy.net>,
        Michal Hocko <mhocko@kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Jul 4, 2018 at 8:28 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> These patches switch m68k boot time memory allocators from bootmem to
> memblock + no_bootmem.
>
> The first two patches update __ffs() and __va() definitions to be inline
> with other arches and asm-generic. This is required to avoid compilation
> warnings in mm/memblock.c and mm/nobootmem.c.
>
> The third patch performs the actual switch of the boot time mm. Its
> changelog has detailed description of the changes.
>
> I've tested the !MMU version with qemu-system-m68k -M mcf5208evb
> and the MMU version with q800 using qemu from [1].
>
> I've also build tested allyesconfig and *_defconfig.
>
> [1] https://github.com/vivier/qemu-m68k.git
>
> v2:
> * fix reservation of the kernel text/data/bss for ColdFire MMU

Boots fine on the real Amiga, too. Let's assume it works on Sun 3 too.
Thanks a lot, applied and queued for v4.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
