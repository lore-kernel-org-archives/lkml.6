Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA0C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F34420989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YM9kZpjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F34420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeKUFzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:55:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34064 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeKUFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:55:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so3211318wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTM/aHZnV1F3dWmHH/OtdXgtMP2odEXlC7+Xt9884ao=;
        b=YM9kZpjPhk2bH42K1nsdAwuwj3WlHbgbu+83ubnPL/ilNee/Hj5WnHHG+ebKSXiJQe
         hwv0NI43KTNSJ0v1Kcfk+5YJZulf/vsHIE6E2VkLq18wz6eMnUhywfq/SFPr72UriX34
         2SOqtCx9jmPbAwvfdSKznzong2eQ0SI3xEuV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTM/aHZnV1F3dWmHH/OtdXgtMP2odEXlC7+Xt9884ao=;
        b=XqC/4S1+ICGQA/ehN6fwd5Nk6FuGjCWTFjZYTq+YkuNYLV66LqMhvwZEtRwcMcdqtC
         57YJxxj+8pWO5b2ALxtRjtsXJlhXjkEFGHw1WE5Z0WVZd8tukASMBx1H9zvYU6/3NJGH
         GQ2RyVFzdkLrONVXs/z2W2YDdTPdyHYSvM8zNdF2mqn1TmKOo1h1L3VJBe7MBMcEI9OR
         wHn6GtCRxUWa8fiDsbR2WqayAbLLuEQlrSrDwERMZFHrs3crCXyra/XiwDbgKww8LLLr
         3n1EqT9z6A6nKWR4WV8qLG8ljBrce2EqaLK2HlC6ATwU2vkXeXSSiloeEfBZIiZ21sl/
         E1bQ==
X-Gm-Message-State: AA+aEWZcb++clzaV+fEux4uJ2nguzwME7o0+uE3rDzuJJk0cd+xKNQ3J
        4cFXxtHqCZKbUASoPkQHnrotElqWFqEnayLUirl+GSy+T8g=
X-Google-Smtp-Source: AFSGD/WF2nSF0BEaKJ7P8dWegJ+uBTxOJCjfzMMlyE7mQ9vticPFeVtD5X1u282ELsce/MajZRbaUA5k1zakD6UgIIA=
X-Received: by 2002:a5d:6988:: with SMTP id g8mr3041407wru.33.1542741871844;
 Tue, 20 Nov 2018 11:24:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542722463.git.robin.murphy@arm.com>
In-Reply-To: <cover.1542722463.git.robin.murphy@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 20 Nov 2018 11:24:18 -0800
Message-ID: <CALAqxLX5GPwce=oWh5nf2w8pjoCJUVkxCr7_hrqVVfYVHzx-fw@mail.gmail.com>
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 6:10 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> This is what I have so far, which at least resolves the most ovbious
> problems. I still haven't got very far with the USB corruption issue
> I see on Juno with -rc1, but I'm yet to confirm whether that's actually
> attributable to the SWIOTLB changes or something else entirely.
>
> Robin.
>
> Robin Murphy (2):
>   swiotlb: Make DIRECT_MAPPING_ERROR viable
>   swiotlb: Skip cache maintenance on map error
>
>  include/linux/dma-direct.h | 2 +-
>  kernel/dma/swiotlb.c       | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Thanks so much for chasing this down!

Unfortunately AOSP is giving me grief this week, so I've not been able
to test the full environment, but I don't seem to be hitting the io
hangs I was seeing earlier with this patch set.

For both:
  Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
