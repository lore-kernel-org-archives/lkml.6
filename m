Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA73C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DFC205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BesW7d1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DFC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJWJPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:15:25 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39305 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:15:24 -0400
Received: by mail-yb1-f193.google.com with SMTP id j9-v6so128790ybj.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfX2X77q2dw+FbbfsWQujTDGWrTAq9rDbEu8N4Rjq3c=;
        b=BesW7d1BQtKlNybl200I+dRl8CguatpNjLhmVwCgoUdR2hPaE96alZneqtHr2XZpBv
         lWIIg6FUsteOIaozxQooJI7/A/+5MJfL/IS/xziG0V86kUsDq8CiZgadzGWWcxuc6ARA
         UYzrYtIurJy2DxBBcDkTPV42+qy9z6hgBQXIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfX2X77q2dw+FbbfsWQujTDGWrTAq9rDbEu8N4Rjq3c=;
        b=FcGb39Z5v+gA7x/q+lBDLqcg2xX51GCscYgg3pFcP7N+U+ansh40psPD9zG1NLd4Y6
         hAwNtmSv4s1ndkp0Z/blAC4n05otXZ+FntV55sFeP7QqfX7TdUk+TmVAIW11aGUA4p89
         l8fDskoxOWOBC9T5cKbz3lOX7L2pz7nGyPrxUl+lSI4hjF2Yy6kpppxlldOr+XkVWHDU
         35e9RZnsAU+ARsAfT0ztVrwPrzAbwIJBwLPcdYMTIqdD2jdsD2KjT7HkT1rwbtbhlsQt
         Hml+uouneVNfRN0SOqhky+xCkN/5sj/WWA0D0YcXdpqXbwXx01PxXwZ7M2lOT1c1DBId
         8K8g==
X-Gm-Message-State: ABuFfojF3rVP59Wi0PfQBvBkaaFzq35o/0pX6X2HeGsy3JHYwwZsqVNF
        eHvIpaO/z1mQm8fxgfJY/2X8QPvEAPYElQ==
X-Google-Smtp-Source: ACcGV60tkAZOn6GgQHi8d4bp1VEdK7aqxM++I0lW4FoUbE7j2hBjeH45AdWLOdel7V5sD+x+st6fGw==
X-Received: by 2002:a25:6342:: with SMTP id x63-v6mr32781803ybb.198.1540256068684;
        Mon, 22 Oct 2018 17:54:28 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id q126-v6sm8535436ywf.7.2018.10.22.17.54.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 17:54:27 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id m184-v6so5889610ybm.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:54:26 -0700 (PDT)
X-Received: by 2002:a25:b3c9:: with SMTP id x9-v6mr33060125ybf.508.1540256066501;
 Mon, 22 Oct 2018 17:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181022144901.113852-1-tfiga@chromium.org> <6621f3b9-a5a0-d33f-306f-d405db34da2c@xs4all.nl>
In-Reply-To: <6621f3b9-a5a0-d33f-306f-d405db34da2c@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 23 Oct 2018 09:54:14 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DWnk4+7bF7Ju=stzh44_2k9dAXnDJMyaTsxBf3Tx_oMg@mail.gmail.com>
Message-ID: <CAAFQd5DWnk4+7bF7Ju=stzh44_2k9dAXnDJMyaTsxBf3Tx_oMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Document memory-to-memory video codec interfaces
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        todor.tomov@linaro.org, nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, Oct 23, 2018 at 12:41 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Tomasz, Alexandre,
>
> Thank you for all your work! Much appreciated.
>
> I've applied both the stateful and stateless patches on top of the request_api branch
> and made the final result available here:
>
> https://hverkuil.home.xs4all.nl/request-api/
>
> Tomasz, I got two warnings when building the doc tree, the patch below fixes it.
>
> Regards,
>
>         Hans
>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
>
> diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentation/media/uapi/v4l/dev-decoder.rst
> index 09c7a6621b8e..5522453ac39f 100644
> --- a/Documentation/media/uapi/v4l/dev-decoder.rst
> +++ b/Documentation/media/uapi/v4l/dev-decoder.rst
> @@ -972,11 +972,11 @@ sequence was started.
>
>     .. warning::
>
> -   The sentence can be only initiated if both ``OUTPUT`` and ``CAPTURE`` queues

This should also have been s/sentence/sequence/.

> -   are streaming. For compatibility reasons, the call to
> -   :c:func:`VIDIOC_DECODER_CMD` will not fail even if any of the queues is not
> -   streaming, but at the same time it will not initiate the `Drain` sequence
> -   and so the steps described below would not be applicable.
> +      The sentence can be only initiated if both ``OUTPUT`` and ``CAPTURE`` queues
> +      are streaming. For compatibility reasons, the call to
> +      :c:func:`VIDIOC_DECODER_CMD` will not fail even if any of the queues is not
> +      streaming, but at the same time it will not initiate the `Drain` sequence
> +      and so the steps described below would not be applicable.
>
>  2. Any ``OUTPUT`` buffers queued by the client before the
>     :c:func:`VIDIOC_DECODER_CMD` was issued will be processed and decoded as
> diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Documentation/media/uapi/v4l/dev-encoder.rst
> index 41139e5e48eb..7f49a7149067 100644
> --- a/Documentation/media/uapi/v4l/dev-encoder.rst
> +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
> @@ -448,11 +448,11 @@ sequence was started.
>
>     .. warning::
>
> -   The sentence can be only initiated if both ``OUTPUT`` and ``CAPTURE`` queues

Ditto.

> -   are streaming. For compatibility reasons, the call to
> -   :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is not
> -   streaming, but at the same time it will not initiate the `Drain` sequence
> -   and so the steps described below would not be applicable.
> +      The sentence can be only initiated if both ``OUTPUT`` and ``CAPTURE`` queues
> +      are streaming. For compatibility reasons, the call to
> +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is not
> +      streaming, but at the same time it will not initiate the `Drain` sequence
> +      and so the steps described below would not be applicable.

Last minute changes after proof reading...

Thanks for fixing up and uploading the html version!

Best regards,
Tomasz
