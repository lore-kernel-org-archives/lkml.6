Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFCAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0438C20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnsOhErv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfBYNyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:54:50 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:37939 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfBYNyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:54:50 -0500
Received: by mail-ua1-f42.google.com with SMTP id p9so8377349uaa.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 05:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GziJ3EFuDLGu2W9l4GBWorWhHzBpk99fC2re92G5R8o=;
        b=qnsOhErvX4TX+KNzewhiyYOh8EzLqzGnmDRI4KoKyjO4vrZBcuOgkV/sTeuaG0AJs7
         81Cqm7UCbQtl2EqM3aD4CBQBKEYPz54Eg1mcudp4fQkYlbfUuMKhKHB0OIP5/cKUwQSd
         jhwZlgp0oYDuqvb2ggP7loAiqLiwVD0DW1SvZpZ/tjybwcWdKUOxSjXiKn2gSN3VHVwc
         7I2FPMVfstZf1S+g3cNQIbomspx5A0kIa4dwm8f4IbMf6hbn98mYk+GcvndB67O1NMwX
         caEQvrWXjciGdIW7bGKkMD9QJ7cBXRYdSAQI8l8yMJMn0NTlcOivfZ9kbfFnKchCIFlB
         CW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GziJ3EFuDLGu2W9l4GBWorWhHzBpk99fC2re92G5R8o=;
        b=VTaO98o3gzSDTyyDFhR6GkJQqvBGBuHHs0YCLirEujCroZ0YeIWpq1H1PwFjKsmKHJ
         FbSArLIZQiB35F0Cy+xJ6JD/Bqa+o8IOgdIAk4PTGYf8YoKishRyyHEwQnceG0EsoDfQ
         dTPHkcT8D+THi3u97BV/ZEtAPecwFQ/Z0BDU0gN5sEco2T2Qu3mjj9oNYBmlvHG6R9sE
         9V2eDgrLmE92Q1XQ4m1Z1tliw7HVvjpJykT8QCJyTaRL966aZZeqIYg88Cf2DQHr4RwO
         V2qZVHz90Il1ISeAwZhzSMjcQd7OlhPXjy+zhHKS5H03W29wQ34T0gHn1uQsuE5WWPWl
         bnCw==
X-Gm-Message-State: AHQUAuZ/vY+JdV7qJ86pottInzIOPRiBe8CxA6vaJddqi21OHBJIc37w
        efMprXRVk/0DbRH+AoKTTBycJN8X1iq4lsklpoCi2g==
X-Google-Smtp-Source: AHgI3Ib3x8BxLL/jSlhOthuHadtmGXvwt6gIvxYQpLeAh9b6hGBGywveBfAXNVPGXodmhsjMppzx2BdxvPlKq3YicBk=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr8953736uar.39.1551102889211;
 Mon, 25 Feb 2019 05:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20190212072528.13167-1-hch@lst.de>
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Feb 2019 14:54:13 +0100
Message-ID: <CAPDyKFr6gDYttazFJJzyFm04qiy=9oQAeW9a-cFxHE1vP+DhLA@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC v2
To:     Christoph Hellwig <hch@lst.de>
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

On Tue, 12 Feb 2019 at 08:25, Christoph Hellwig <hch@lst.de> wrote:
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
>
> Changes since v1:
>  - fix a missing kunmap_atomic in mvsdio
>  - fix a stray whitespace in s3cmci
>  - add new sg_kmap_atomic and sg_kunmap_atomic helpers
>  - set the DMA and block layer dma boundary
>  - use pointer arithmetics to reduce the amount of changes in
>    various drivers
>

This looks good to me, however the lack of feedback/tests worries me a
bit. So, unless you think it's a bad idea, I intend to apply this when
v5.1 rc1 is out, which allows a lengthy test period in linux-next.

Make sense?

Kind regards
Uffe
