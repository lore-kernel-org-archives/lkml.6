Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC46C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E482084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E482084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeLKWMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:12:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42600 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:12:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so18328680qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCLIIx+Ta3FsJrtxXffY5szvTCAOJRtCN5MO7fu/3ns=;
        b=TQRO4Zd890J+nWGteuKV1uJbvvVX3P2wlyUoEaaqf8VNU4NheNLtTal7oNJ8ca8q8a
         W60lTJZNsOsd8JT1QLVAtBmvcXcWdmwUyQLowpSN7iajyXFGouo5KwA982Iawhm7YyUn
         6qLVSpnWKacJ0Xl7T1Qjq/yJ/6n55mk8+XWhmw3IHeqh9px0JKJBOnJJmUN/E4CcDeYZ
         n97YvoRHy4AMTmLgLS+A4C71zWeH7mGPVWfQ8/CDndATTWJ04fdulelSqjjkOeKbpMpD
         AT4gXQNRk8wndbnwo/qsyaxPr2xgdD9jbe+fKdNkMmBhtTDFY0L65dp/l5tpH+VGBr2p
         xktQ==
X-Gm-Message-State: AA+aEWZ+YNC+L1TZFf6qNPVcgjvNzD8kEiEqjC56VRDcncXUKPJymb7C
        hfkEKillJJgX+agUOiiK97yAzc2vtlHVGz67/Cc=
X-Google-Smtp-Source: AFSGD/XEddtKYraecQTBX7vb5QZ2pWnNMBR23oqy3TLkBhy0jYwAey6lAm9Okc5fGs3VmEcFxU6+0dyMGWt4x9tduNs=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr17323831qvr.115.1544566368176;
 Tue, 11 Dec 2018 14:12:48 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us> <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw> <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw> <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
 <1544565572.18411.7.camel@lca.pw>
In-Reply-To: <1544565572.18411.7.camel@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 23:12:30 +0100
Message-ID: <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
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

On Tue, Dec 11, 2018 at 10:59 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2018-12-11 at 22:56 +0100, Arnd Bergmann wrote:
> > On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> > > On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > > > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > > I am not too keen to do the version-check considering some LTS versions
> > > could
> > > just back-port those patches and the render the version-check incorrectly.
> >
> > I'm not following what the problem is. Do you mean distro versions gcc
> > with the compiler bugfix, or LTS kernel versions?
> >
>
> I mean distro versions of GCC where the version is still 8 but keep back-porting
> tons of patches.

Ok, but in that case, checking the version would still be no worse
than your current patch, the only difference is that for users of a
fixed older gcc, the kernel would use more stack than it needs.

        Arnd
