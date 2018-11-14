Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BDEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9C721582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W196miNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9C721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbeKNVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:07:52 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39066 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732525AbeKNVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:07:51 -0500
Received: by mail-yb1-f195.google.com with SMTP id w17-v6so6710718ybl.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 03:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObB1349MhO7WgYz0jjTpgllH1WKgKaJUnIU9Z/a0EU8=;
        b=W196miNmmTpNWJUs2hg+Fh5uBb/88aTLqzM9wZ0/F1FYbqOmsxesLcJdS/ldAdd1NS
         E9ZRUdxjQBvstKfbTzdnJp5X6aGMwdVJY6eTycA4PCgSMhzRz6iTp2z6KZ+Tg9gMru8a
         bolKMT6NbLk8fPwYgrHsSTVdqd0v5pvJxqgHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObB1349MhO7WgYz0jjTpgllH1WKgKaJUnIU9Z/a0EU8=;
        b=mainESxZibJ9IsxUiQbTVVwyDcQiL0TTcUgulxp98iNzZZZ7qkMKMbk2Nq//0GBUAx
         cUugcNHSNMTn+qFO2Zjj1jr93l8BzEimMTiCSGmQurJBI3iQzcTBAtRZrOo2j4qDFOQh
         tejhAFxAAhoZ1oCZFdtFJ7/+qz2WuDnWkwd9loKAKwafWK/scBWRmPVAKFNVplIxN0av
         EDj5Q4362vxFm8kANq99ZD05Z3vCbMkobT/jNo9antJcH/M8hBVV3Xk133K7LU1ux5Ta
         FEBpe1B3dzRiaRq9cLRKVuyxKwM9CSAkskDC0KoCwjcxIFmwwhdXZGI7YiKgRhcO/MIE
         6qhA==
X-Gm-Message-State: AGRZ1gLcyZsmIr+6JgDJBc11mNgnOFD4JfrC2++9a76ZY/GtHUOzDo36
        7GMkLLRsAr9m7o+mJ8znQTU6MrK7C+U=
X-Google-Smtp-Source: AJdET5e+DUm1C1X28ImDvWHBh8NchJzJC9gjaH0UMWCIVfV3D2SdrMEgB4Y5uhlvT2+HdUgjR3ebpg==
X-Received: by 2002:a25:c781:: with SMTP id w123-v6mr957975ybe.135.1542193503377;
        Wed, 14 Nov 2018 03:05:03 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 10-v6sm6071992ywt.47.2018.11.14.03.05.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 03:05:01 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id i17-v6so6688095ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 03:05:01 -0800 (PST)
X-Received: by 2002:a25:7ec4:: with SMTP id z187-v6mr984676ybc.373.1542193500830;
 Wed, 14 Nov 2018 03:05:00 -0800 (PST)
MIME-Version: 1.0
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org> <1538222432-25894-5-git-send-email-sgorle@codeaurora.org>
In-Reply-To: <1538222432-25894-5-git-send-email-sgorle@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 14 Nov 2018 20:04:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BoP1jbzLam7X1TOxEMNCkVDTkjNWbBkcn3zdiScy0HjA@mail.gmail.com>
Message-ID: <CAAFQd5BoP1jbzLam7X1TOxEMNCkVDTkjNWbBkcn3zdiScy0HjA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] media: venus: video decoder drop frames handling
To:     sgorle@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 9:01 PM Srinu Gorle <sgorle@codeaurora.org> wrote:
>
> - when drop frame flag received from venus h/w, reset buffer
>   parameters and update v4l2 buffer flags as error buffer.
>
> Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 0035cf2..311f209 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -991,6 +991,12 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>         if (hfi_flags & HFI_BUFFERFLAG_DATACORRUPT)
>                 state = VB2_BUF_STATE_ERROR;
>
> +       if (hfi_flags & HFI_BUFFERFLAG_DROP_FRAME) {
> +               vb->planes[0].bytesused = 0;
> +               vb->timestamp = 0;
> +               state = VB2_BUF_STATE_ERROR;
> +       }

What does this HFI_BUFFERFLAG_DROP_FRAME flag mean? When would it
happen? I assume it applies only to CAPTURE buffers, since for OUTPUT
buffers you must not set the bytesuses/timestamp yourself, right? Is
the buffer guaranteed to have no decoded frame inside or the frame
could be there, but incomplete/corrupted?

Best regards,
Tomasz
