Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF1C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBB520875
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FnwZNttj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBB520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJVO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:29:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45284 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeJVO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:29:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so31248126oig.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdZqYtfO2uNg3Rpzca+BzwU37rN472GnIztkPMEBTyo=;
        b=FnwZNttjsQo2v60pVZaYZ/qEaxOTHibETGeKViRcG3Z7CmpSN9u6kCBzOZhQ9uViBM
         C9FyKj6yruuwQ+vtRWZNTt8BwKcnXC8hSRlubN0U2gqMSCKAT8KP6ZbzQFev6j7wPUFY
         Dhd9FdXySQ37PTAtcG5ac8fkb2fwIyWLKYTB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdZqYtfO2uNg3Rpzca+BzwU37rN472GnIztkPMEBTyo=;
        b=jN/xjpwvx8LvrGEZNfVLUDb0YOf9XKBC5EV+0nHjytQ2c0bMpmdk5F8ZAQHVc7V4kg
         9TVdJnZDvJaZ3uQFMsn9iM/ecS9pd/mLI7kj/vtdJLT211JGo8VBewmxcH0kkpyKLOld
         At5M9+NASCuw2UkJYjin9rTpr29deRIAO6F+dt17gmC62qylpGXVUuOmbcgxV/MtxSi4
         5o5nFI9ui3CP9sF24BxWBhI7rJDFRDH4ai/4ihv+LmvxCFs4U8H5omHuIb8BwUNldrS0
         bmAIOtcQZppoCdirMNZSvGFY62K2d1cVQmT85TgIJrMNc+OMlTwOLyEJzbyMLtumhUHE
         q8LA==
X-Gm-Message-State: ABuFfog8uTSeJ+UKZlgyOtGEYecPagKbszIQ+nMzDdAYPJ1ksQV9FnCv
        mD2oWCQuh2Wwq+MMggAXxF5JtEPBUie0TOT0
X-Google-Smtp-Source: ACcGV60rx3O2AtKU3zU+yatgp8c5kE5NbpzXnDDRht89s2HrFEiXQ0Jxs2enz1+WUvz3rGu6GeUJfw==
X-Received: by 2002:aca:3083:: with SMTP id w125-v6mr24595225oiw.67.1540188738875;
        Sun, 21 Oct 2018 23:12:18 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id l56sm10935156otb.65.2018.10.21.23.12.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 23:12:18 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id l1so38834604otj.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:12:17 -0700 (PDT)
X-Received: by 2002:a9d:5b6:: with SMTP id 51mr27258007otd.221.1540188737699;
 Sun, 21 Oct 2018 23:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 22 Oct 2018 15:12:06 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWF2XWZyyKUXpe=JDmSfcyPcjgXWOd5VQDpmz9iA4C1PQ@mail.gmail.com>
Message-ID: <CAPBb6MWF2XWZyyKUXpe=JDmSfcyPcjgXWOd5VQDpmz9iA4C1PQ@mail.gmail.com>
Subject: Re: [PATCH] media: venus: amend buffer size for bitstream plane
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 4:52 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> For lower resolutions, incase of encoder, the compressed
> frame size is more than half of the corresponding input
> YUV. Keep the size as same as YUV considering worst case.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>

This fixes some issues we had with low-resolution VP8 encoding. Maybe
this can be refined some more for higher resolutions, but the current
version at least works.

Tested-by: Alexandre Courbot <acourbot@chromium.org>

> ---
>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 2679adb..05c5423 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
>         }
>
>         if (compressed) {
> -               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
> +               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;
>                 return ALIGN(sz, SZ_4K);
>         }
>
> --
> 1.9.1
>
