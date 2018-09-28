Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0513C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723B320676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aF90RMnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723B320676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeI1Wnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:43:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34783 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Wnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:43:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so4840518pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=9dJuajz1zxJfUOH5LiiUe2llhZLoBztFpksJUqQCoNc=;
        b=aF90RMnriheF1svbZ+Nr8AHPOZBs87IzF1ncdxH2G5U/b5QnB/Zpg5L9SC2fUWGQFf
         5kqMTHq0Gw1nX+TJBiwg2rSwLjzynYhdZlkK44HH2cAUJoJWhbZnf3Ch3Fvz5nJTsxI2
         taZdsj/cnrg0FCfwYPoKCte5LMaZ3X75VfZsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=9dJuajz1zxJfUOH5LiiUe2llhZLoBztFpksJUqQCoNc=;
        b=Zbr9JVTnnGgaG7UQ6asIg0rbzUFX/72BI2Q1tEL0eIMpTqJdX/eInyMt898b302v4d
         ZL/xT/tWZycOcWK/HJC6I/PRXAVzfl/6Mt30Z8T1jU6lGTqA3i+U7toLdiVm/Mny4A9E
         nju2Y53cd0SsVi2iBjKG/CuEivrs9XREe9yOooPcvT809HKzYDL8Icrdzt57P6xDlh+n
         hYoCZJ7qd4u1Gs2KrWZWnMjnv6FhblykrAEz3ANy2n5aFj9V54/5q8oRbekgsVK5L6T7
         DM/YQfM1ruky6jPJMiAFrjEtMeB+7ULQdi1EjKSEG2dSoYKlulIAhgcoGAPeSgquo4he
         b6fA==
X-Gm-Message-State: ABuFfojbP5mCpM0aPvmQwYOspw+Yvlu7bFeWRjkM/XYskJ9gILXlUWAA
        zWx5J3+QVa442G3o88vuSM5GoY6166M=
X-Google-Smtp-Source: ACcGV62B/G9f12vP+zGmMJfSHNg+rmwtC8Li90CK5gHhp1ExwqM91jOF/qjYUBtvx1BLrKoOeEP7iA==
X-Received: by 2002:a62:f553:: with SMTP id n80-v6mr17357749pfh.59.1538151556268;
        Fri, 28 Sep 2018 09:19:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 25-v6sm8911571pfm.36.2018.09.28.09.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 09:19:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <f513d72b-3eec-1ddc-a318-9f3d17efe16e@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180920223559.136915-1-swboyd@chromium.org>
 <ef22f1b4-a2c5-25a4-451e-9191b3579a26@arm.com>
 <153755159334.119890.13825040401066852769@swboyd.mtv.corp.google.com>
 <f513d72b-3eec-1ddc-a318-9f3d17efe16e@arm.com>
Message-ID: <153815155438.119890.4863330936629381207@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] dma-debug: Check for drivers mapping vmalloc addresses
Date:   Fri, 28 Sep 2018 09:19:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robin Murphy (2018-09-26 06:24:42)
> On 21/09/18 18:39, Stephen Boyd wrote:
> > Quoting Robin Murphy (2018-09-21 04:09:50)
> >> Hi Stephen,
> >>
> >> On 20/09/18 23:35, Stephen Boyd wrote:
> >>> I recently debugged a DMA mapping oops where a driver was trying to m=
ap
> >>> a buffer returned from request_firmware() with dma_map_single(). Memo=
ry
> >>> returned from request_firmware() is mapped into the vmalloc region and
> >>> this isn't a valid region to map with dma_map_single() per the DMA
> >>> documentation's "What memory is DMA'able?" section.
> >>>
> >>> Unfortunately, we don't really check that in the DMA debugging code, =
so
> >>> enabling DMA debugging doesn't help catch this problem. Let's add a n=
ew
> >>> DMA debug function to check for a vmalloc address and print a warning=
 if
> >>> this happens. This makes it a little easier to debug these sorts of
> >>> problems, instead of seeing odd behavior or crashes when drivers atte=
mpt
> >>> to map the vmalloc space for DMA.
> >>
> >> Good idea!
> >>
> >>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >>> ---
> >>>    include/linux/dma-debug.h   |  8 ++++++++
> >>>    include/linux/dma-mapping.h |  1 +
> >>>    kernel/dma/debug.c          | 12 ++++++++++++
> >>>    3 files changed, 21 insertions(+)
> >>
> >> However I can't help thinking this looks a little heavyweight for a
> >> single specific check. It seems like it would be enough to simply pass
> >> the VA as an extra argument to debug_dma_map_page(), since we already
> >> have the map_single argument which would indicate when it's valid. What
> >> do you reckon?
> > =

> > I thought about augmenting debug_dma_map_page() but that has another
> > problem where those checks are done after the page has been mapped. The
> > kernel can oops when it's operating on the incorrect page so we need to
> > check things before calling the dma ops.
> =

> Oh, right, as usual I've managed to overlook a subtlety :)
> =

> In fact, with memory now jogged, I think the virt_to_page() itself is =

> allowed to blow up if !virt_addr_valid(), so we probably do need =

> something like your original idea to be properly robust. I guess it =

> probably makes sense to implement that as debug_dma_map_single() then, =

> since the purpose is really to cover any VA checks specific to that case =

> which debug_dma_map_page() can't be expected to do after the fact.
> =


Ok. I can rename it to dma_debug_map_single() and throw in a
virt_addr_valid() check too. Thanks for the suggestion.

