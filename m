Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A91BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5B220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1afYHsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfANK0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:26:49 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:44293 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:26:48 -0500
Received: by mail-ua1-f41.google.com with SMTP id d19so6857563uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVR6jL3jT3TYfklMxBYRcXQ2yIxGlx6cCPc4kO2v8J4=;
        b=Y1afYHsKn8Bn7MSoQfnIQV98PxLEE+q6Spgs1/h7kM4X85cxNSe/TwFVfUyoB6vsRe
         ck7jNbiCVj+pVWkP8Jb8phUfiJKLkkGhc/r92MF4Y+Iq4B6GTIrtO0fh5BGcBYwrRwms
         4vvJuG03hWWl8CDv6FT7IPPPfQeg9wfdTVt8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVR6jL3jT3TYfklMxBYRcXQ2yIxGlx6cCPc4kO2v8J4=;
        b=F8ujb0nLZKT7+ZnxnMGhPlyjnrK0Xaw1niakL2X248MzM7UEZsnRZsO/zHG/7lwh//
         Gridjp7+wioHjaaJIxIAwfsSGDXryjqB/dw+4PPL665V27voFF4EaW7FsG4htZ87m7L4
         jxoXE8hfHBKqX0GzxYfDaQODZPNq+BfXgxKDVAiJrcDMLbZtVU9fvRHdZ/xH0CpFlyWo
         ypCuBZPnN/7DdbQ1tPk1FjuSWh5miHwTMEfKJ+qSWSt/BXwMpilhoYixZwWHrNMPjUiN
         GJvYZbPVQHDfM+cubvVhHX75o6P7E8G0m+ULjkhm1tr9JS6kScqNN8XQ1Fa1QP4I+ksX
         qSDg==
X-Gm-Message-State: AJcUukdnzxY/HuLTA6Il6/nGxZ6o+YDDDx0knOBq+Xz7sRihUviWjQho
        GfChtO/WxtMoJGGT57qgN3XI4baO2oaqfH8Eyw5jdQ==
X-Google-Smtp-Source: ALg8bN7lU3vwX51ZYHQ2HmmOq+t5OEuotTc4Whzsu3WGWE7a4AE2pSnr2lByNcRaVmQDJUHkmsEM0YjSGqTc+MK6j3o=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr9143281uar.39.1547461607443;
 Mon, 14 Jan 2019 02:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de>
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Jan 2019 11:26:11 +0100
Message-ID: <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC
To:     Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Linus Walleij (recently made a cleanup of the mmc bounce buffering code).

On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi everyone,
>
> this series converts the remaining MMC host drivers to properly kmap the
> scatterlist entries it does PIO operations on, and then goes on to
> remove the usage of block layer bounce buffering (which I plan to remove
> eventually) from the MMC layer.
>
> As a bonus I've converted various drivers to the proper scatterlist
> helpers so that at least in theory they are ready for chained
> scatterlists.
>
> All the changes are compile tested only as I don't have any of the
> hardware, so a careful review would be appreciated.

Thanks for posting this. I will have a look as soon as I can, but
first needs to catch up with things since the holidays.

Kind regards
Uffe
