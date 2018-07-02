Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D797AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B4625BB6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eURRN7ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B4625BB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeGBIv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:51:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35444 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbeGBIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:51:16 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so14056384iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TjdyQXsyL3mjkJnB80bb9GrDAuptfPkHXcvzQkECS4=;
        b=eURRN7ultZ6G3S6dJ+b+VWR9j8IkA4BCUWQgah+CYUFBUi0g7fKfPayJFzi5mmMT9X
         z/wluxpEOCsH/su0YPMvO+pPdD5pO2SDsoQWw6Xthy1KmaYoIYZLwqCFFE2t1oc97T2O
         gIZ337TcdxoBXK+tUbsHhzziHBd1Rv4ocY0W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TjdyQXsyL3mjkJnB80bb9GrDAuptfPkHXcvzQkECS4=;
        b=HL31C0iXfnI7sG25pd6BnMqZfQlHxa2tfCPWGOnSZ9XIRtCDdjsTPhZYpjhykygnww
         ik4A8wJ0qggFO6lu3rdwKFDk2RsYhmatNjirPqT7J3LSV9vtYvZtV075Oq8gBe8DsYSL
         zH9zdxvGPWC8Dhu4b37On8+aLVVB4PX9L2sVUBOvfBC5unNZJU5RXivsJShcD6vV8p/b
         yw7/qJHkddAGss/IhAU1BWJcnTdFrXqcJ0K1xAEAWGkzTln85OugIj+k6wzI1EkWwRR3
         nh3usHGyHNnaw7Kp+CfiFABXvviYRlsLC8ZC1ocSbmX4WZftpiYxDZoRBuDyk2NoqJBW
         ZpHQ==
X-Gm-Message-State: APt69E3jip9V5+M9rcvEc9C31dLPt4KM87nU/hFtEczodUgVVmukPLpe
        k/gkIiKi25/3tsUs3sCSzXjTKGBP0eE=
X-Google-Smtp-Source: AAOMgpfLpK9ZLzOQeBzbM/GcYyBywwlunerIk6lDaP/NdXscFyCHMcA+atntGk65sumDpxTWceOzMw==
X-Received: by 2002:a6b:96c2:: with SMTP id y185-v6mr8921398iod.161.1530521476074;
        Mon, 02 Jul 2018 01:51:16 -0700 (PDT)
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com. [209.85.223.171])
        by smtp.gmail.com with ESMTPSA id v199-v6sm3800319itb.18.2018.07.02.01.51.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:51:15 -0700 (PDT)
Received: by mail-io0-f171.google.com with SMTP id l25-v6so14030301ioh.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:51:15 -0700 (PDT)
X-Received: by 2002:a6b:33ce:: with SMTP id z197-v6mr3336225ioz.112.1530521474682;
 Mon, 02 Jul 2018 01:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 2 Jul 2018 17:51:03 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUBi+Dn5v4PKngxztFgKd6CA7bC1pKvWd1GMY9NJFoyZQ@mail.gmail.com>
Message-ID: <CAPBb6MUBi+Dn5v4PKngxztFgKd6CA7bC1pKvWd1GMY9NJFoyZQ@mail.gmail.com>
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:44 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> Exisiting code returns the max of the decoded

s/Exisiting/Existing

Also the lines of your commit message look pretty short - I think the
standard for kernel log messges is 72 chars?

> size and buffer size. It turns out that buffer
> size is always greater due to hardware alignment
> requirement. As a result, payload size given to
> client is incorrect. This change ensures that
> the bytesused is assigned to actual payload size.
>
> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index d079aeb..ada1d2f 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>
>                 vb = &vbuf->vb2_buf;
>                 vb->planes[0].bytesused =
> -                       max_t(unsigned int, opb_sz, bytesused);
> +                       min_t(unsigned int, opb_sz, bytesused);

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
Tested-by: Alexandre Courbot <acourbot@chromium.org>

This indeed reports the correct size to the client. If bytesused were
larger than the size of the buffer we would be having some trouble
anyway.

Actually in my tree I was using the following patch:

--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -924,13 +924,12 @@ static void vdec_buf_done(struct venus_inst
*inst, unsigned int buf_type,

               vb = &vbuf->vb2_buf;
               vb->planes[0].bytesused =
-                       max_t(unsigned int, opb_sz, bytesused);
+                       min_t(unsigned int, opb_sz, bytesused);
               vb->planes[0].data_offset = data_offset;
               vb->timestamp = timestamp_us * NSEC_PER_USEC;
               vbuf->sequence = inst->sequence_cap++;
               if (vbuf->flags & V4L2_BUF_FLAG_LAST) {
                       const struct v4l2_event ev = { .type = V4L2_EVENT_EOS };
-                       vb->planes[0].bytesused = bytesused;
                       v4l2_event_queue_fh(&inst->fh, &ev);

Given that we are now taking the minimum of these two values, it seems
to me that we don't need to set bytesused again in case we are dealing
with the last buffer? Stanimir, what do you think?
