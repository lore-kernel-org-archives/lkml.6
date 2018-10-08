Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A66C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E112085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gwL+2hdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E112085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeJHLmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 07:42:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45434 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeJHLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 07:42:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id u12-v6so4607688pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 21:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=C9YKkDG+9wx0SGJSSRCxutx38MY2RxzBXc1u2dlLtvA=;
        b=gwL+2hdVxsqQ2npU9IWJj91bw1/TyUjp2aSWx57BPr+GjUTfbDRo5IwII7MVHD8Vvb
         qTl0uda8JusRAAQNchQpuDMJaKzGpcKTrjJEDG0MeuyyIrZPF+uvkrQaX4r33O/SjLpK
         640MBbzlbGAS1U5/EXzyi/MM/5yXgjymg8Eag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=C9YKkDG+9wx0SGJSSRCxutx38MY2RxzBXc1u2dlLtvA=;
        b=MjlHULAOyrpcZwd7f0eqUfW45+Sz7JH9vNeJHnMVT2iJ/AV4ueo8ZImJS+5JV1tPiT
         oPhtjxU0mbn2tNM9GV2jHmQM08C4m5wcBZuAlxO4oV30EnM229q0z3eiqDsJgY1y3Jxr
         hOvgqnhXtLCGuX/bvjkREyXUyS2ta5UqE36mMnjB/Ff1ReWMPJ/vkK2zmlJNGpBGbLJy
         wUC0aDrCJunfUmv93ScVjBTmiE8y6ItabqPgGPZuJ20Pn+XM86O9bwA0gEZlvJajdIL9
         oLrJTmxa21KrrSHwwhcx9cd2FmAASV6jMD2A6bEHee/MAbrSr9e24ISBsGYVp+/5EUAF
         jpTQ==
X-Gm-Message-State: ABuFfogFJhlZBSXgHgGThVQVE7P6t4Bv1VYyiS7e4VULgwZ51Q3FM49X
        dt9m0ns6e6VSvplt7mfPmXD8Pw==
X-Google-Smtp-Source: ACcGV610ZsXWLiqSETh6GiQI3TkaavsmT45CbNHfKsPidBDbpkWtwG/d7oMaFiaqhoxyXNr/u059NA==
X-Received: by 2002:a62:5a83:: with SMTP id o125-v6mr23552071pfb.117.1538973152032;
        Sun, 07 Oct 2018 21:32:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id o76-v6sm22290639pfi.162.2018.10.07.21.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 21:32:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <62816605-0cc9-3743-e98c-682bf7996c6c@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20181001215337.13358-1-swboyd@chromium.org>
 <62816605-0cc9-3743-e98c-682bf7996c6c@arm.com>
Message-ID: <153897315026.119890.9913725764215566223@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] dma-debug: Check for drivers mapping invalid addresses in
 dma_map_single()
Date:   Sun, 07 Oct 2018 21:32:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robin Murphy (2018-10-02 07:01:42)
> On 01/10/18 22:53, Stephen Boyd wrote:
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index d23fc45c8208..99ccba66c06a 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -231,6 +231,7 @@ static inline dma_addr_t dma_map_single_attrs(struc=
t device *dev, void *ptr,
> >       dma_addr_t addr;
> >   =

> >       BUG_ON(!valid_dma_direction(dir));
> > +     debug_dma_check_single(dev, ptr, size);
> =

> Ahem...
> =

> With that (and below) fixed so that it actually compiles,
> =

> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks for checking! ;)

