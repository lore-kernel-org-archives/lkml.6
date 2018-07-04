Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73DE23DC3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73DE23DC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934063AbeGDIWB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:22:01 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33639 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbeGDIV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:21:58 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so308032vkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBzMlpCd4miyHAASu6lI0NrnayFxFWj0CKVW/1z9IAI=;
        b=VBSQUAeDVaNzRnfSIjaQK1B861mRUHPD670XPmFeZN9IfUAM8+2lCzRzN0RRu/CEPp
         iXKVQkg03Nu49k05s0fn2rM/yxVk4p0qNkumofaVGcNPFQ4+t/6Z7lOAXHK3rhOJWPLG
         OclB5T8/WtVyDhH3gwf1f2ZPE6iqm7ForxNddSBM5hESVYVinQEQZfKIfORnOvNHfusD
         L/HRBeC0oFEPkJMv4QuSxHuAaPNOd/tboQkmXMWn5Rzbn2xM0+7qyBDJ66Nng9G/DZJw
         ymYLLchivMl2vs/utoIemk8A/2K+nshw+lU/8QJBujIRUWHoChyyJHBkmCtzsFJ2p2SU
         meLA==
X-Gm-Message-State: APt69E1ZtBfwyOWL2OEFQNkgkdrMMnN8SZ5MYThgYC2n3CX5exKNiH17
        H2/XCLHB//1EjfIFMDW1sh6CXe8rmeplVKsId4k=
X-Google-Smtp-Source: AAOMgpfQn4ZJLD9q1n0xOH1sIquD+bbb9HtMcVO6l8ctGEwf06TWANldLfeEMcjnIbr6oVBQTXuU3pyDNCJa7zHpr5s=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr510885vkg.176.1530692517686;
 Wed, 04 Jul 2018 01:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530685696-14672-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAMuHMdWEHSz34bN-U3gHW972w13f_Jrx_ObEsP3w8XZ1Gx65OA@mail.gmail.com> <20180704075410.GF22503@dhcp22.suse.cz>
In-Reply-To: <20180704075410.GF22503@dhcp22.suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Jul 2018 10:21:45 +0200
Message-ID: <CAMuHMdU_m0+BeTnCwU0qm-3G+-9apa41dTcZDV9cGT84W8x=fA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
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

Hi Michael,

On Wed, Jul 4, 2018 at 9:54 AM Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 04-07-18 09:44:14, Geert Uytterhoeven wrote:
> [...]
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at mm/memblock.c:230
> > memblock_find_in_range_node+0x11c/0x1be
> > memblock: bottom-up allocation failed, memory hotunplug may be affected
>
> This only means that hotplugable memory might contain non-movable memory
> now. But does your system even support memory hotplug. I would be really

No it doesn't.

> surprised. So I guess we just want this instead
> diff --git a/mm/memblock.c b/mm/memblock.c
> index cc16d70b8333..c0dde95593fd 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -228,7 +228,8 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>                  * so we use WARN_ONCE() here to see the stack trace if
>                  * fail happens.
>                  */
> -               WARN_ONCE(1, "memblock: bottom-up allocation failed, memory hotunplug may be affected\n");
> +               WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
> +                                       "memblock: bottom-up allocvation failed, memory hotunplug may be affected\n");
>         }
>
>         return __memblock_find_range_top_down(start, end, size, align, nid,

Thanks, that does the trick!

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
