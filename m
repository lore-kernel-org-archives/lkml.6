Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46618C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4AF213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bg74843n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4AF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeK3GAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:00:17 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:43489 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3GAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:00:16 -0500
Received: by mail-lf1-f41.google.com with SMTP id u18so2241138lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrDIGvMFZ61P7XwTjN+VVrxZRozo8qUinJjUBiQ+wXc=;
        b=Bg74843nWWHD1YXFMRpFOEVId3CigmBTYWk97VTcqHNX8thigu5UZBMANFPm6658ZG
         9gBULGWSjyzDunuSSIyCiEzHwB2IBI3s3sHc2Shjx/NhwAFGvrSWRwWkxY/sbk0AhAhH
         ItXS8zjlSZNUQgEDHFgBfOgroGuk35J4gRqUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrDIGvMFZ61P7XwTjN+VVrxZRozo8qUinJjUBiQ+wXc=;
        b=hhqSbLrY5dYunO6ioZM8AwKIxzNn+BO/OlP+ZauDqYtFEQOihCRnXWCt8A2xUCW3s2
         URLEGW5NZ7D9PxtWK5dlpNc12Y7xcfcsZv/pOf0a2ybAvnvb+M20In9TnLh/TwAzMxYV
         oxOQzOApLWpai94qMex8M/WM5aOYUAcz0GZXcCJeOPY8Q+kQdzaGpGiMFR5UE1IDRxiY
         dW3asqigaD73ov2WcgRD8sp72WtSaSjDTZWsG9X+842xeHtzsHsUnynuPPYwN+MlA2Wd
         7RC2X2NIxxPb/6pHRYwK+GxI1EQnOy5oJnKRSTlAHC274sQ5S6vAwrZluY9eXhApIBBq
         tM9A==
X-Gm-Message-State: AA+aEWaQ55rrG0ZxW0BTPpOefiHydhfu2pMNNNHTWnvZmk0a/ZKFE9Rj
        DlScWviQVU1XFtA9a74svt6puhact1c=
X-Google-Smtp-Source: AFSGD/Va8s1bm5lSbl4yMvTq0ODRQEJMe+GDnRWtcYrvbBQNDbnuxA5WxUuIPDYWTS5ZuFbTQfwgtw==
X-Received: by 2002:a19:d90c:: with SMTP id q12mr1735710lfg.24.1543517632407;
        Thu, 29 Nov 2018 10:53:52 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e13-v6sm408030ljk.53.2018.11.29.10.53.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 10:53:49 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id z13so2242484lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:53:49 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr1899446lfc.147.1543517628990;
 Thu, 29 Nov 2018 10:53:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk> <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
 <20181128180841.GM30658@n2100.armlinux.org.uk> <CAHk-=whcbiSxSUprsKjVPEdN5-+o8WnTGiKxEV-+HbKNDs=iNA@mail.gmail.com>
 <20181129162323.GA27068@lst.de> <CAHk-=wi2K7_+dgCbc-sAK9CST5Zh+pOuH7sVT9WW-kqs50HSzQ@mail.gmail.com>
 <20181129183132.GA30281@lst.de>
In-Reply-To: <20181129183132.GA30281@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 10:53:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjmtZAAGvB8c6hyKvABPHNTfE+b+eHu7iktdogDfTgMw@mail.gmail.com>
Message-ID: <CAHk-=wjjmtZAAGvB8c6hyKvABPHNTfE+b+eHu7iktdogDfTgMw@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, robin.murphy@arm.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:31 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > Or, better yet, plan on removing the single-page dma mappign entirely
> > at a later date, and make the issue moot.
>
> What would be the replacement?  Build a S/G list for every single page
> mapping?  Not sure that would create a lot of happy campers..

It's what we ended up doing with some other cases, and it didn't
really end up hurting as much as I thought it would.

I'm thinking of the vfs functions that end up turning "buf, len" into

        struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = len };

and then passing it around as a single-entry iov instead (not even
that - they end up being an iov_iter, which is not just the iov, but
the whole "what _kind_ of iov" indirection)

Maybe a very similar model could be used for just simplifying the core
dma mapping setup: sure, people will want to do single-area dma, but
how bad would it be to just turn them into single-entry SG lists on
stack, and then the dma-maping internally would just always see that?

Most of the high-performance IO is already using SG lists anyway, no?
Disk/networking/whatever.

But just an idea. And the "map_sg()" error handling isn't actually any
better, I think. It returns zero on error, no? So it's not improving
the error handling.

The whole dma-mapping layer seems full of those kinds of "inspired
error handling choices" ;)

                  Linus
