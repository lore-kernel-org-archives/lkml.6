Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D668C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D74120878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjnZCOoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D74120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeLFSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:01:52 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55881 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeLFSBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:01:51 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so2755697itg.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0aBsvp/rh0WCAFydjv+EeSRbhvQ/94HjQEIz9TLyx8=;
        b=kjnZCOoVDxiS4ay04jCvRSiJd6uzCvvaPTQ9QhAqXxjoHu7kbIpPA/4YjzPFzOq68d
         7JJIO/qFIMWeP+Wp4xbauOc5YHAd//0x6FtfCnaFuUeGj0Bp/OK5gBb8DxwpC+yMoNqE
         0IXa06URPQavz07yc7fKIZ42JwaAybJWAQBPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0aBsvp/rh0WCAFydjv+EeSRbhvQ/94HjQEIz9TLyx8=;
        b=LSnFKXgdIeFI09kWMegMJ0wJ/qmtoOW9L9jzV3j5mWSuX8/TGt22mX+ag406PN4bPL
         Vv5O5xiWdG4Szi0DTcWkLKcX0OJgyRbRVz4Y4L3hV1KaA2Ri2PHZQA6XTwoXsr8rhII5
         J+T23xpFkkbQrNME2nl+HnF/NEwr0IWfjFozOgocxyTHm3exJvuc+6GgBwr/pnEE8NHI
         dLq6b49I0YYl0ZtV6RNZAJrH35piCQuo5zgNpFrwHym4jc0sOAjksPrVnrB495F+I057
         EBhK1MebZj/981+qFW0YFnl/9o5hDJYlyj2Bx0ia3WhA9qksDyOjYDkv5D2my3Ur5zQk
         6N4w==
X-Gm-Message-State: AA+aEWYItVJzvVirsQBX/MK9mpE64+441gTbmXqF+zUyWgvyG7ph9S0+
        AqIbt7ueA612T1SLUxlGNhMiJQ1mBOpeFSBTPiCvgw==
X-Google-Smtp-Source: AFSGD/UVQ7Xj9kpqtle+qbkTF4LCtq9Q8Q/Xj3j/A3CRjkhmvvvR+jxB1DZ161lmlQZ9nFMDPVxZeXXUJ3NGk98SbVs=
X-Received: by 2002:a02:183:: with SMTP id 3mr13214371jak.130.1544119310491;
 Thu, 06 Dec 2018 10:01:50 -0800 (PST)
MIME-Version: 1.0
References: <1543517152-23969-1-git-send-email-cai@gmx.us> <20181206161633.36292-1-cai@gmx.us>
 <20181206175958.GS54495@arrakis.emea.arm.com>
In-Reply-To: <20181206175958.GS54495@arrakis.emea.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Dec 2018 19:01:38 +0100
Message-ID: <CAKv+Gu97MU5kU878gF=KBLxQ5GjZatAbJ-LVdKv-QMgdPh3kZQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] efi: let kmemleak ignore false positives
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <cai@gmx.us>, Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 19:00, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Dec 06, 2018 at 11:16:33AM -0500, Qian Cai wrote:
> > unreferenced object 0xffff8096c1acf580 (size 128):
> >   comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
> >   hex dump (first 32 bytes):
> >     80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ................
> >     00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
> >   backtrace:
> >     [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
> >     [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
> >     [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
> >     [<00000000edf04e07>] its_cpu_init+0x104/0x150
> >     [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
> >     [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
> >     [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
> >     [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
> >     [<0000000015137d6a>] 0xffffffffffffffff
> >
> > efi_mem_reserve_persistent+0x50/0xf8:
> > kmalloc at include/linux/slab.h:546
> > (inlined by) efi_mem_reserve_persistent at drivers/firmware/efi/efi.c:979
> >
> > This line,
> >
> > rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
> >
> > Kmemleak has a known limitation that can only track pointers in the kernel
> > virtual space. Hence, it will report false positives due to "rsv" will only
> > reference to other physical addresses,
> >
> > rsv->next = efi_memreserve_root->next;
> > efi_memreserve_root->next = __pa(rsv);
> >
> > Signed-off-by: Qian Cai <cai@gmx.us>
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>\

I don't see the patch and I wasn't cc'ed
