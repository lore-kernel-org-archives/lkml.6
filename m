Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A6DC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748D520844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfcWRQaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748D520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389148AbeKGKzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:55:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39093 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbeKGKzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:55:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so15629817wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwFVtCFL5ilH82l/yXPlDlRA+7xWDIQPBAhHKWmS2kU=;
        b=UfcWRQaEwstqXTU1YiHw/ugC1cJ+JrPvXPoUT9hdVwKIr6WI1J++g4dIbktHr5/UdO
         51XBkAu4qbENgDWZzB9cDooV0wEC7RJfcQ8Z18KPs4D9/XhfxPaQVHDZ2H++/wTXnq9g
         MgHzomC0kSkUdpZZuYEyyGMTp0VsFPEuLIqLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwFVtCFL5ilH82l/yXPlDlRA+7xWDIQPBAhHKWmS2kU=;
        b=jUlt83LdQZSjWLD3hHKxZrVaAfjOh3wnj/vpOZ2ytDJiIoZnsGyyxvTWSxuK8WC5jZ
         9xPeLzsNPyuluqNCSvCCenr275sXL6iDZ5M80E8YDg6IicokHUOH3Wr+NiUPmpjnEXzm
         3BcbQI4RnpsEig6+mBWv/HC61+Ugks9VaQ2ef39E6LynEmaN79oYExf0wnu97XbETUfb
         qZsh+v5iepZh+EnB4xtpI1iQ5uR3YgxFTiU+k4UiMpCN+2b+aHhABm/gvR/Pzb23nsWH
         fOkRNcOj8jlDjLLoBhZq0l17cLzRruWX5/fu+gwwlBJzwHwdocsuA4LD9fG8KzWZa0XP
         5a3Q==
X-Gm-Message-State: AGRZ1gJYAi/WDmwbdea/oYZqfZOdkAhFIlyPkPMReCEHxFnk5sAw9g0l
        ULh1ZHH/H6Znn/h/c2akroLAfbfXSc38VMBHpLfG+DTb
X-Google-Smtp-Source: AJdET5dXz2QgHJ6sFAnohOVVrasxGAfDUZ8YxlVhP/F03nalvzXHtvnxpaTb4va8JPTpLtmm6qLX+DTtDfgfBn8L0C4=
X-Received: by 2002:adf:f0c9:: with SMTP id x9-v6mr24274028wro.15.1541554050495;
 Tue, 06 Nov 2018 17:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de>
In-Reply-To: <20181008080246.20543-7-hch@lst.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 6 Nov 2018 17:27:14 -0800
Message-ID: <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
To:     hch@lst.de
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        robin.murphy@arm.com, konrad.wilk@oracle.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 1:04 AM Christoph Hellwig <hch@lst.de> wrote:
>
> No need to duplicate the code - map_sg is equivalent to map_page
> for each page in the scatterlist.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/swiotlb.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Hey all,

So, I've found this patch seems to break userspace booting on the
HiKey960 board. Initially I thought this was an issue with the mali
drivers, and have worked w/ the mali team to try to find a solution,
but I've since found that booting just the upstream kernel (with no
graphics support) will see userland hang/block unless this patch is
reverted.

When I see the hangs, it seems like the filesystems are stuck or
something, as kernel messages still show up and sometimes I can get to
a shell, but commands that I run in that shell (like ls) just hang. I
don't see any other error messages.

Reverting this patch then gets it work. In order to cleanly revert the
patch, I have to revert the following set:
  "arm64: use the generic swiotlb_dma_ops"
  "swiotlb: add support for non-coherent DMA"
  "swiotlb: don't dip into swiotlb pool for coherent allocations"
  "swiotlb: refactor swiotlb_map_page"
  "swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs"

But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
swiotlb_map_sg_attrs", I reproduce the hangs.

Any suggestions for how to further debug what might be going wrong
would be appreciated!

thanks
-john
