Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8523AC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2D120672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2D120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLKV4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:56:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40348 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKV4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:56:30 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so18279234qtf.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1C/Y8paVa6cbuC3OXuha+9gYH9uR0lCk9u1OqWl4dv8=;
        b=q7BOMp+zR6gYODxzc/3rHUqAjenAMGtPmFQHyz2x1emMJmeCdXA09N9CjJSYOWFNCM
         k/ZFtr8X7hGjGkPi3BpPVV7UEIxte8bY5mLWymvA2mMFWX0CkhY5Lc1KHnEaWidLoTMw
         xcEeh4vEGLzwkGaU5BK1cH3Pcymu81/roV9WsEeoAI3tRBGIgCxT3zPm2aEMRLO+1WYZ
         KkZlUmjCXWXvVjtBzPKJ3mrVNQRXbgAre4wtgLKRaeXmyxL5H3T/rtErhub4pW3xOo09
         RTy3mYxG3tBjb2z14ATkmabpkM6q1V8/JcpwhVu8iOeLgdrDXKSIpJCbPT/blcDye9Tx
         ATIA==
X-Gm-Message-State: AA+aEWZ7YpVgpgJMotu24BAGoPxHfmqgwjqMz5OMY4YD0eNc4lwjHmSm
        Pm+LdpPjKllI2IlLq+1K2V2ABSCFzRS7sZeqBVI=
X-Google-Smtp-Source: AFSGD/VkJIMyVGx+p2H1p6b348u6a7Hha0J/jC6k+w/MKOIGVotoua+MuPHFphNjbxA4QKadS3QUGe78Yo2Slu1rxtA=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr16620641qvl.180.1544565389687;
 Tue, 11 Dec 2018 13:56:29 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us> <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw> <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw>
In-Reply-To: <1544565158.18411.5.camel@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 22:56:12 +0100
Message-ID: <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
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

On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:

> I am not too keen to do the version-check considering some LTS versions could
> just back-port those patches and the render the version-check incorrectly.

I'm not following what the problem is. Do you mean distro versions gcc
with the compiler bugfix, or LTS kernel versions?

For backported kernel fixes, this doesn't seem to be any different
from other kernel changes that might be incorrect, but a straight
backport of that kernel patch should still do the right thing in older
kernels, and set the frame size higher for old compilers but not
new ones.

    Arnd
