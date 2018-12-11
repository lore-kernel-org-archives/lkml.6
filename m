Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A93C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0D320851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nuAV4Ihy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0D320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLKWWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:22:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44632 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKWWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:22:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so18341890qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icKYAgIL4bWF9PZE6/gMSlsm00TFljYHo2L7Ucs75g4=;
        b=nuAV4IhyFxv17FUf1tHEpwIwWo1jF6FzSlhsv263vohv0oT+aDjjD4N8sN7kcmtPgp
         1RKW8IVQm3XVXK6oMnw01kRtXn1zhSxTIfZOft5MTmUIF+CZTQx4ChwYV6rgBCv9/k6G
         YK1uZADK9IDmfVagViBzVPfF8u3HseF4rycHzdGiKFwZrlFT+fptjwOsheAIlHDKgpid
         ka+64O8Ph9p2cxUfPFEE8DoSuecx1czX1Yu+TkaDwDuU5pl0rh9X35gF+3nKPakJF5Mb
         Sz01BmK+f87TptrO6JiNbH3hwJ+wm8r588AziBg83Y+gKD2dsgno2mBuu9F8y3LdtBrZ
         N3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icKYAgIL4bWF9PZE6/gMSlsm00TFljYHo2L7Ucs75g4=;
        b=PUF2Oy0J++GrGTNyH0KaCuWb5n7Y705GKiTTDLMn3U4OfGY1xGS61Y3UTdaYo2t6cl
         34fvsIyoKcWZUTa4cESwKvNhOZTzj/hakvUq8eAtoYsFqEKMXvepqgcDpjfwiXTm+AqC
         /kqSS7d9s329CxcO9Pg/KkuK9FeqLuezfNWhyo9lMe8VjjsEASESLQ3sygZLw9/IkB/p
         im1mqAeYslLNxvxlaEf+06WvTjwCa0/iSIIKxpJX1ZJdkahTMjKzRUDzV3XLGKKoURnC
         6P+1dzi/DGMP1Bi+6hV7oCOhzXvMQtfsA4/ovSFGh9JntgYLPjwOm1aHOV5xU+fGjTcI
         /UCA==
X-Gm-Message-State: AA+aEWZwR7MtgPIN5ERHyJV8nxR7tcoEZGWFu5fRBpO3ZJDJF4N04AyS
        jaQqHue4/OrqjZcZpZW2/UcyUg==
X-Google-Smtp-Source: AFSGD/WrWSMKqo4f9Qej5w3s17kZjnPaRYokIhgzMvGCEbcseSe3MLj1BkLEhOjHpu2diUFvwsb0hg==
X-Received: by 2002:ac8:36d9:: with SMTP id b25mr18088498qtc.49.1544566939339;
        Tue, 11 Dec 2018 14:22:19 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o27sm10780191qkh.35.2018.12.11.14.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 14:22:18 -0800 (PST)
Message-ID: <1544566937.18411.9.camel@lca.pw>
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
Date:   Tue, 11 Dec 2018 17:22:17 -0500
In-Reply-To: <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
         <20181207223449.38808-1-cai@lca.pw>
         <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
         <1544548707.18411.3.camel@lca.pw>
         <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
         <1544565158.18411.5.camel@lca.pw>
         <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
         <1544565572.18411.7.camel@lca.pw>
         <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 23:12 +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 10:59 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Tue, 2018-12-11 at 22:56 +0100, Arnd Bergmann wrote:
> > > On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> > > > On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > > > > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > > > 
> > > > I am not too keen to do the version-check considering some LTS versions
> > > > could
> > > > just back-port those patches and the render the version-check
> > > > incorrectly.
> > > 
> > > I'm not following what the problem is. Do you mean distro versions gcc
> > > with the compiler bugfix, or LTS kernel versions?
> > > 
> > 
> > I mean distro versions of GCC where the version is still 8 but keep back-
> > porting
> > tons of patches.
> 
> Ok, but in that case, checking the version would still be no worse
> than your current patch, the only difference is that for users of a
> fixed older gcc, the kernel would use more stack than it needs.
> 

I am thinking about something it is probably best just waiting for those major
distors to complete upgrading to GCC9 or back-porting those stack reduction
patches first. Then, it is good time to tie up loose ends for those default
stack sizes in all combinations.
