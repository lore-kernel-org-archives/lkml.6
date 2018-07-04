Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41BFC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5089222414
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5089222414
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeGDNFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:05:22 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34096 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbeGDNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:05:20 -0400
Received: by mail-vk0-f67.google.com with SMTP id l189-v6so3055161vke.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 06:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwBuPP7wIE031NipU6ShfvOC2YAg4HSQfL9YpKHS6Mw=;
        b=qtP6ohwBkU9fbK5c70ucvF+sUmeVZo9bCOE9Ay/FVA2ZgULbbVP8NFEqU2DyR6kgft
         Nrxxd+Q07SNDuYdNC4DoUcW760zQAqM586Aym7PODdh1Vzf+YthzHcHg0z9rMIeOfh6p
         vsWWo5pCdVaT+L6kr8llXm9h9zMP6o/9f5wFLpgWgL9ScIhEG6S+XSiqvfy6T8FTo6FX
         Qi9M15s646WNqIrRDZpeJU92wumLjxtNM8SRA40N8J3mooQ4ZriRgx6JBImtJ0kg8of6
         zcR0RUsAkh39K7KKrYvqvSJ19V5vm0cER9qlj5+sSScqev+rz6XBu751jw/HGr3xpcgM
         0Fcg==
X-Gm-Message-State: APt69E3DC8j8ui0+DfSsUoXadKcHjZPNCOqJvwNHIEIBm2TdXp2jLekY
        jr6NXcfR8IW9zp6Y9CLImnrrqrp8lsdXx0exSWs=
X-Google-Smtp-Source: AAOMgpfe2xUcpjrk0aEak5r+W0VnWbrnI0k4Bt2YgDi+OtD61xcu0xMovvR76y1T6EMZ++JV/8qtdZEQpHadY57hXnA=
X-Received: by 2002:a1f:654:: with SMTP id 81-v6mr1017863vkg.159.1530709520040;
 Wed, 04 Jul 2018 06:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530685696-14672-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAMuHMdWEHSz34bN-U3gHW972w13f_Jrx_ObEsP3w8XZ1Gx65OA@mail.gmail.com>
 <20180704075410.GF22503@dhcp22.suse.cz> <89f48f7a-6cbf-ac9a-cacc-cd3ca79f8c66@suse.cz>
 <20180704123627.GM22503@dhcp22.suse.cz>
In-Reply-To: <20180704123627.GM22503@dhcp22.suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Jul 2018 15:05:08 +0200
Message-ID: <CAMuHMdVuLd=y4Wk6ghFZ8YV_1Z9kvh588VkwBMwxScxateMu1g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Jul 4, 2018 at 2:36 PM Michal Hocko <mhocko@kernel.org> wrote:
> [CC Andrew - email thread starts
> http://lkml.kernel.org/r/1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com]
>
> OK, so here we go with the full patch.
>
> From 0e8432b875d98a7a0d3f757fce2caa8d16a8de15 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Wed, 4 Jul 2018 14:31:46 +0200
> Subject: [PATCH] memblock: do not complain about top-down allocations for
>  !MEMORY_HOTREMOVE
>
> Mike Rapoport is converting architectures from bootmem to noboodmem

nobootmem

> allocator. While doing so for m68k Geert has noticed that he gets
> a scary looking warning
> WARNING: CPU: 0 PID: 0 at mm/memblock.c:230
> memblock_find_in_range_node+0x11c/0x1be
> memblock: bottom-up allocation failed, memory hotunplug may be affected

> The warning is basically saying that a top-down allocation can break
> memory hotremove because memblock allocation is not movable. But m68k
> doesn't even support MEMORY_HOTREMOVE is there is no point to warn

so there is

> about it.
>
> Make the warning conditional only to configurations that care.

Still, I'm wondering if the warning is really that unlikely on systems
that support
hotremove. Or is it due to the low amount of RAM on m68k boxes?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
