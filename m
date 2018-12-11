Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32015C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40E82086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40E82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeLKVnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:43:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43979 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:43:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so18231360qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZrYDhQDmw+7vlF+0D5VlJ5hXp14PJhXLq3YQkxDGhk=;
        b=SxgX253a+RgpEyVquQbLbNvLbSaDmcYXIccxoPWEMaxx3ZIDH5nFR/s0z7yvIzXJi/
         uFEEf47cHOGLqeFxBaAdOcnLGdsi3JIFxV0ZbRPcawoO/scR8tKRH8IA9vp0IKZuDFSo
         gK02f3MF6YMzjexj5IWiI/tv/1m0mcL3+mUcJxl4de7tGbZwah98eWg5PW4PSTLIbLV9
         pgYjRiT2L0LPIemgmvn7wDa5Nv9UsbJr3IBgHJVmLX1q/t4VnEdCDlHFxs3u0bvA6jTD
         UWhiQPO0JR3usJoW2RrW2KmFItvW5QPwFIFSBhuF6/fRdV5Alk9ZP/2PFOefMtjvMBXz
         WHoQ==
X-Gm-Message-State: AA+aEWbjc/m4dQ1CIWhpp4qfvz+Eso3ZqMFtGONPAPdIjPJ1QMWaEO1V
        lIjoeWZc2ZtBmtu/6YCwC21HxiYx9V32GYgtmPQ=
X-Google-Smtp-Source: AFSGD/W5mBXx/aKK1ofup/4ouSqZaDUCSUP59Ccw3pjOm395Eg8/fm5PPHm9tANuIPvwvuiHwmoMD2EzkJ0VqI5YW2M=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr16890413qtm.96.1544564624122;
 Tue, 11 Dec 2018 13:43:44 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us> <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com> <1544548707.18411.3.camel@lca.pw>
In-Reply-To: <1544548707.18411.3.camel@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 22:43:26 +0100
Message-ID: <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To:     cai@lca.pw
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2018-12-11 at 13:42 +0100, Arnd Bergmann wrote:
> > On Fri, Dec 7, 2018 at 11:35 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > If the kernel is configured with KASAN_EXTRA, the stack size is
> > > increasted significantly due to enable this option will set
> > > -fstack-reuse to "none" in GCC [1]. As the results, it could trigger
> > > stack overrun quite often with 32k stack size compiled using GCC 8. For
> > > example, this reproducer
> > >
> > > size
> > > 7536 shrink_inactive_list
> > > 7440 shrink_page_list
> > > 6560 fscache_stats_show
> > > 3920 jbd2_journal_commit_transaction
> > > 3216 try_to_unmap_one
> > > 3072 migrate_page_move_mapping
> > > 3584 migrate_misplaced_transhuge_page
> > > 3920 ip_vs_lblcr_schedule
> > > 4304 lpfc_nvme_info_show
> > > 3888 lpfc_debugfs_nvmestat_data.constprop
> > >
> > > There are other 49 functions are over 2k in size while compiling kernel
> > > with "-Wframe-larger-than=" on this machine. Hence, it is too much work
> > > to change Makefiles for each object to compile without
> > > -fsanitize-address-use-after-scope individually.
> > >
> > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23
> >
> > Could you clarify: are the numbers you see with or without the bugfix
> > from that bugzilla?
> >
>
> The numbers were from GCC8 which does NOT contain this patch [1].
>
> GCC9 is awesome which reduced the numbers in half even for KASAN_EXTRA. Only
> thing is that GCC9 has not been officially released yet, so it is a bit
> inconvenient for users need to compile the compiler by themselves first.
>
> I am fine either way to drop this patch or keep it until GCC9 is GA.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c35

Maybe we can make the constant depend on the compiler version?
It may also be possible to reduce the KASAN_THREAD_SHIFT
constant for the normal case with gcc-9 and go back to the
default frame size then.

       Arnd
