Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488CA20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNQcOhBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488CA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeLCRe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:34:26 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52413 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLCReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:34:25 -0500
Received: by mail-it1-f195.google.com with SMTP id i7so10604494iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cg+48DoFxNYJ/GCLHItJYQDW72U1S3V3i9H+pqbVQ/0=;
        b=TNQcOhBwOLixilY4XXq/voa3rZQ+h5VmS4r3l7AO/LCAGBY8RGNGIzpC7PNn8qfDdg
         8ksipToTExzXSuG2CFDebsNt2l50Yq2RSt5dEBru4WeQYOe0IwDpXGp6+U5oyhksWXIZ
         GEPhMa7rBT2NU++94LHq5cEvCTi5n+AaeUswc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cg+48DoFxNYJ/GCLHItJYQDW72U1S3V3i9H+pqbVQ/0=;
        b=IAaEjUdgZUzKyKwq0C0jp47yPwUxDspUBhZ7YR3kk2GAmc1dDfPPH1YoKklvS5oGwx
         qFkHjx+Smqk9zw//aEP2pgUztnXoojjwrvnLOLEmeq7RtsvHVpvev3sr/yrdvrOk2oKN
         csShotoi17xT0PKVeHZDN002I7Pgvx8EOiX1CkhTHu8/KwFX21rwfQ/dUwWexON6ysOC
         uXfkpqrOP0PoTN2Sxf4ci76IZBQ02PxXU88MByT9WO0FfYSFEpFpFto1Tmv1q8FG3EA6
         uFImtcCIKksw7pdRA/K/46HWFMq7N1Z9oikNEYWRqHIbKNY1b3415B0X+5a+oJgNpRfN
         JsIg==
X-Gm-Message-State: AA+aEWYZqbT31GqP5EY1dFKQolizbgNllzuJ1BP/RgBV2bVIurgIC3An
        eyE8C4nPJy9WsulJacfVN8pIGNFkLWbYqlRNmdbWbE+H
X-Google-Smtp-Source: AFSGD/UJY7hy+sIo2ceMWvwRDc0V4Fs0+oXk9Zab7K5odLmRwTc2hHE5T8DrK/FLkUpw17jXORdym/KlWYzU1u+mCNQ=
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr8903651itl.146.1543858459010;
 Mon, 03 Dec 2018 09:34:19 -0800 (PST)
MIME-Version: 1.0
References: <1543540924-16321-1-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1543540924-16321-1-git-send-email-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 3 Dec 2018 10:34:07 -0700
Message-ID: <CANLsYkxc21RbNft+k_oBA=4ZPCBr_rhYSV2vxiHceyJH3M6jVw@mail.gmail.com>
Subject: Re: [PATCH] coresight: cpu-debug: Support for CA73 CPUs
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 18:22, Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
> module can be initialized successfully when a SoC contain CA73 CPUs.
>
> This patch has been verified on 96boards Hikey960.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 45b2460..e8819d7 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
>                 .id     = 0x000bbd08,
>                 .mask   = 0x000fffff,
>         },
> +       {       /* Debug for Cortex-A73 */
> +               .id     = 0x000bbd09,
> +               .mask   = 0x000fffff,
> +       },
>         { 0, 0 },
>  };
>

I have picked this up - thanks.

Mathieu

> --
> 2.7.4
>
