Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9ABC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431DB2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431DB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeLGQlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:41:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34481 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLGQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:41:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so2782662qkg.1;
        Fri, 07 Dec 2018 08:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZhvnSKTmbJcqh3y3ku1bQhmdAU1ynyRy64Ri+I/g7E=;
        b=ZKuqn/qRVDuh93qWX7jMZzV1AEU2dsnIuXWeF8sNCIwzzIIqxMVR9xc8jn/Xd6VObO
         pqj89eoDU+uEaQqu7gxG9YMVwyxOvsOEUYOXWd7UW/3d3D1Y4ZybzB7XKwhTPV97aE7z
         rO4SkKL3hQ58iAER6l1/dk4X05cIxm36Ugcuj8pdFRJ2baUQdAE9X1ZTprXp311FhLDm
         Mw9tvRyb6T2YR5Kft/X2pLCAue5JjHyaMFCfc4epDJvPr3lD+vZWIwb8jrO08JAC8JeU
         2Tq65yruxeRi+xGGCOU3mGk/3n8SQbcCAHQMEavfczcqkldr4fDhMY9rpBPHCkbGH5mr
         NSIg==
X-Gm-Message-State: AA+aEWZOe6OtePYik40EfFsGhd83sG7R8nWA3LXGjibnDsdP/Ac5GHlZ
        eAIIJe3Yg4zcfdmizalLOy9v8Sb913hhxPHHucs=
X-Google-Smtp-Source: AFSGD/VxVNQUTrZMYSMewQIBCO2BZSpZ7x7wj0HSfcegP+XpTiMai5B4Qojt3FT5RNYuefGkeqEWjkoYXerM/Aa4PB8=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr2332245qkm.343.1544200911620;
 Fri, 07 Dec 2018 08:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20181207134824.300024-1-arnd@arndb.de> <20181207134824.300024-2-arnd@arndb.de>
 <20181207154502.GA21335@infradead.org>
In-Reply-To: <20181207154502.GA21335@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 7 Dec 2018 17:41:33 +0100
Message-ID: <CAK8P3a2To65m5fXwbVEBqYHzReKC2XiXx361rbUbLR1Bp+=+5g@mail.gmail.com>
Subject: Re: [PATCH 1/8] sh: dreamcast: rtc: push down rtc class ops into driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 4:45 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Dec 07, 2018 at 02:48:17PM +0100, Arnd Bergmann wrote:
> > The dreamcast RTC support has an extra level of indirection to
> > provide either the old read_persistent_clock/update_persistent_clock
> > interface or the rtc-generic device for hctosys/systohc.
>
> s/dreamcast/sh/ in the above sentence?  Also repeated in the other
> patches.

Right, I guess this is at least ambiguous. What I was trying to express
here is that I'm taking the indirection out for dreamcast specifically.

In the other patches, I obviously copied it wrong. Fixed now in my
branch, thanks for the review!

      Arnd
