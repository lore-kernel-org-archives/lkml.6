Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3104EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D4320672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nA8eJNPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D4320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeLKVwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:52:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45293 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:52:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so18236923qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4HFOG3VmVnE3ZqibYXZ9iqqQwLgZN74D8ZHOnCgwYU=;
        b=nA8eJNPJ38IPFj45HZ73XjrD1TAdVRWtvai26NSLm8oNjl+7HI5pRgXhJxGG9pj4L0
         FuskVy2oFpDdQfA53faKKfT8v9HjNOC92WThOm/HdOhjvGF9QDtO3A54dyEHZ0OouUE0
         hyBT8xDPu+VkB6kWO8HUwsibUTVsv3GnE0l5ubk/Nfv2+bSdbSTxGzgD6XQC/eqSVqx7
         aCnXsOR+bSU6BYGLM/HGzKpih6X8mRuhnRLG3vY/wgdX5Yb3uLlaVd/jyIFtHhBQceJR
         bQ+5+lulVlO59GoQAWtXwhPCv6ZivvCH13HVcCXE97rgQCIkHn8jglHZcDhGV22U6D2V
         o2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4HFOG3VmVnE3ZqibYXZ9iqqQwLgZN74D8ZHOnCgwYU=;
        b=eArElgaoeCA3Fs5tYQcTCLaXOIhC9wU0N7y3HXQi6D41zV0MKO3/uFKlbMbn+DV8uO
         4F6+TAeX/wck4Ni7oQ3dA6oZxF7y9yhlvRCowwlkONEATbdIfvAjP20tyHCnVQ5DnYPB
         infVOUBT1xjMs1oYfAmcDUWMQY5jPdnw46Cl0q2TPUrmFzaqa3/h0VVZUh880LXgfWHN
         F39+3ctbkuFMJvECSC4h9uu1+adtrKyfRS7FSiOagrrr85nJlbp37EK+jtBSs3qHMvqw
         tnaqWqIG7flSHOj8qjkcfAR3wwMWED1hIy4KczENRVeCskkk3YeYQmRY1aH6zWiag1G9
         THRw==
X-Gm-Message-State: AA+aEWYTHCSyPSuzXh9BU7qoB12yoyr0BEeA54NHnYNb2foLYE81ZKJI
        BU2SdLyB+qEVA1j0a88WAIxvQA==
X-Google-Smtp-Source: AFSGD/VR2uQRkA/UCfjikXqJ+gKFZ8IDlGVa4/3IKnAEieQiJzl8Q3khGp5oWmSiWVkawQN+YcacNQ==
X-Received: by 2002:a0c:aa84:: with SMTP id f4mr16894502qvb.243.1544565160972;
        Tue, 11 Dec 2018 13:52:40 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v186sm8553160qkd.13.2018.12.11.13.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:52:40 -0800 (PST)
Message-ID: <1544565158.18411.5.camel@lca.pw>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
From:   Qian Cai <cai@lca.pw>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Dec 2018 16:52:38 -0500
In-Reply-To: <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
         <20181207223449.38808-1-cai@lca.pw>
         <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
         <1544548707.18411.3.camel@lca.pw>
         <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Tue, 2018-12-11 at 13:42 +0100, Arnd Bergmann wrote:
> > > On Fri, Dec 7, 2018 at 11:35 PM Qian Cai <cai@lca.pw> wrote:
> > > > 
> > > > If the kernel is configured with KASAN_EXTRA, the stack size is
> > > > increasted significantly due to enable this option will set
> > > > -fstack-reuse to "none" in GCC [1]. As the results, it could trigger
> > > > stack overrun quite often with 32k stack size compiled using GCC 8. For
> > > > example, this reproducer
> > > > 
> > > > size
> > > > 7536 shrink_inactive_list
> > > > 7440 shrink_page_list
> > > > 6560 fscache_stats_show
> > > > 3920 jbd2_journal_commit_transaction
> > > > 3216 try_to_unmap_one
> > > > 3072 migrate_page_move_mapping
> > > > 3584 migrate_misplaced_transhuge_page
> > > > 3920 ip_vs_lblcr_schedule
> > > > 4304 lpfc_nvme_info_show
> > > > 3888 lpfc_debugfs_nvmestat_data.constprop
> > > > 
> > > > There are other 49 functions are over 2k in size while compiling kernel
> > > > with "-Wframe-larger-than=" on this machine. Hence, it is too much work
> > > > to change Makefiles for each object to compile without
> > > > -fsanitize-address-use-after-scope individually.
> > > > 
> > > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23
> > > 
> > > Could you clarify: are the numbers you see with or without the bugfix
> > > from that bugzilla?
> > > 
> > 
> > The numbers were from GCC8 which does NOT contain this patch [1].
> > 
> > GCC9 is awesome which reduced the numbers in half even for KASAN_EXTRA. Only
> > thing is that GCC9 has not been officially released yet, so it is a bit
> > inconvenient for users need to compile the compiler by themselves first.
> > 
> > I am fine either way to drop this patch or keep it until GCC9 is GA.
> > 
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c35
> 
> Maybe we can make the constant depend on the compiler version?

I am not too keen to do the version-check considering some LTS versions could
just back-port those patches and the render the version-check incorrectly.

> It may also be possible to reduce the KASAN_THREAD_SHIFT
> constant for the normal case with gcc-9 and go back to the
> default frame size then.
