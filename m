Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7210C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845CE2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845CE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeLLO64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:58:56 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36535 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeLLO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:58:56 -0500
Received: by mail-vs1-f67.google.com with SMTP id v205so11232094vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 06:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m2cSOPHqWCI1RzjYj1hl2ykcnYNNtnj5A2KYjWBg8U=;
        b=SEeG7idUr8el50bBAe3ycR473cG2dA9/bDhZq7/6Yt0hIQKQNaYv6ulIXtcEHHsbUF
         bVl7IPyROuJsMjJruiKRU0Otu9f12cOnF41chNCkUPkvNt1VE/dW6wfyx5eje/3soNOi
         4ocJNVWv5wGrxXHMDKIsJbhs74BvQM1pGCpCt2noV+5G+IznYirH74WYtHvZsyEyo+cD
         ciyV+EBEXNv0Jr8o+wqtdV5Z1lfiYJOMvd9bPniS74P2Ez0WPxp0OmN/70KyVJchEE2u
         lU+3q8nqmksqQqGD17C2p+NMr7n9thd+AD5b1pvmrB2ZDB6V7pflnRs/M1jELq4ky/Rk
         uLTw==
X-Gm-Message-State: AA+aEWbyjC7woYtK/t9doMLalVEcjq6TTP8RlIfyIKt00+TqAuUDcIBJ
        WOO8Mt6vVn31Xk6ZWYUSTmryaQU4hE0T0qNSHhk=
X-Google-Smtp-Source: AFSGD/Uo+nNCz1YBKzz3ixMToe7nljnKgkvzrRyJqa2qpmnlHdT0QAcVQ3mMMplUuLpa4ZOS/TDis9Z9bqQkL4JMD1M=
X-Received: by 2002:a67:f43:: with SMTP id 64mr9522253vsp.166.1544626734755;
 Wed, 12 Dec 2018 06:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20181207165011.31497-1-geert@linux-m68k.org>
In-Reply-To: <20181207165011.31497-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Dec 2018 15:58:42 +0100
Message-ID: <CAMuHMdXj67QnqeMHGr_TiEaJr6gUw5qzWFvaJvoVkm89Kiuq_Q@mail.gmail.com>
Subject: Re: [PATCH v3] m68k: Fix memblock-related crashes
To:     Andreas Schwab <schwab@linux-m68k.org>, rppt@linux.ibm.com,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     Sam Creasey <sammy@sammy.net>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Fri, Dec 7, 2018 at 5:50 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> When running the kernel in Fast RAM on Atari:
>
>     Ignoring memory chunk at 0x0:0xe00000 before the first chunk
>     ...
>     Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
>     Oops: 00000000
>     Modules linked in:
>     PC: [<0069dbac>] free_all_bootmem+0x12c/0x186
>     SR: 2714  SP: (ptrval)  a2: 005e3314
>     d0: 00000000    d1: 0000000a    d2: 00000e00    d3: 00000000
>     d4: 005e1fc0    d5: 0000001a    a0: 01000000    a1: 00000000
>     Process swapper (pid: 0, task=(ptrval))
>     Frame format=7 eff addr=00000736 ssw=0505 faddr=00000736
>     wb 1 stat/addr/data: 0000 00000000 00000000
>     wb 2 stat/addr/data: 0000 00000000 00000000
>     wb 3 stat/addr/data: 0000 00000736 00000000
>     push data: 00000000 00000000 00000000 00000000
>     Stack from 005e1f84:
>             00000000 0000000a 027d3260 006b5006 00000000 00000000 00000000 00000000
>             0004f062 0003a220 0069e272 005e1ff8 0000054c 00000000 00e00000 00000000
>             00000001 00693cd8 027d3260 0004f062 0003a220 00691be6 00000000 00000000
>             00000000 00000000 00000000 00000000 006b5006 00000000 00690872
>     Call Trace: [<0004f062>] printk+0x0/0x18
>      [<0003a220>] parse_args+0x0/0x2d4
>      [<0069e272>] memblock_virt_alloc_try_nid+0x0/0xa4
>      [<00693cd8>] mem_init+0xa/0x5c
>      [<0004f062>] printk+0x0/0x18
>      [<0003a220>] parse_args+0x0/0x2d4
>      [<00691be6>] start_kernel+0x1ca/0x462
>      [<00690872>] _sinittext+0x872/0x11f8
>     Code: 7a1a eaae 2270 6db0 0061 ef14 2f01 2f03 <96a9> 0736 2203 e589 d681 e78b d6a9 0732 2f03 2f40 0034 4eb9 0069 b8d0 260e 4fef
>     Disabling lock debugging due to kernel taint
>     Kernel panic - not syncing: Attempted to kill the idle task!
>
> As the kernel must run in the memory chunk with the lowest address,
> ST-RAM is ignored, and removed from the m68k_memory[] array.
> However, it is not removed from memblock, causing a crash later.
>
> More investigation shows that there are 3 places where memory chunks are
> ignored, all after the calls to memblock_add() in m68k_parse_bootinfo(),
> and thus causing crashes:
>   1. On classic m68k CPUs with a MMU, paging_init() ignores all memory
>      chunks below the first chunk, cfr. above,
>   2. On Amigas equipped with a Zorro III bus, config_amiga() ignores all
>      Zorro II memory,
>   3. If CONFIG_SINGLE_MEMORY_CHUNK=y, m68k_parse_bootinfo() ignores all
>      but the first memory chunk.
>
> Fix this by moving the calls to memblock_add() from
> m68k_parse_bootinfo() to paging_init(), after all ignored memory chunks
> have been removed from m68k_memory[].
>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Fixes: 1008a11590b966b4 ("m68k: switch to MEMBLOCK + NO_BOOTMEM")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Does this patch fix your crash?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
