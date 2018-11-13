Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B644CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675D8223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdjusBXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675D8223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeKMSJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:09:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56064 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730998AbeKMSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:09:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id i73-v6so5592533wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3guUA5MzgU4ZBZDtUKaMxOTVGRJneH+l42/+21nWs4M=;
        b=ZdjusBXGQHm9B6iY9AGlSASHdFAV6Onpydb3ca4ThdMTfjWJjkMEB5iYgBrycX4pXT
         kQSOcXp6I5726geTT4B9AUn0JN3C/FcU4dziMlO4FKJudOcZiETsIOwNZ9YXXeOAqEJZ
         QgyqlkoV/Q+alSUxBdAU0/DWkmVT21mL5pQCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3guUA5MzgU4ZBZDtUKaMxOTVGRJneH+l42/+21nWs4M=;
        b=oqwgKPAJ+tEmztqGdw0hqD9a2531b+Z1Ek3bZBhQvkAkwK59afb+scu9ZUMMkWj1FR
         MqYBjQY1alheN1tq3l0xg4u7FxFjziiBEXs8zQuKUyN9Br9ge8WWvrpov6b6yrFmD8lX
         2A9WDvrQ0L/+UGn8vyGDkausR/ocNOQe10t8JmFqKnMLdLvgH1rSEZ4pGdgFZLkqKUdd
         iAZHJo2PYy59SFkVA96RztO1xXkPDqSRgBBSThqr4ax/1aYXzRvvat6MEwzkUsTndPpD
         C0EkniuOnZL4Dxn82wnyqOATCxnzgxfL8xLM99+BiAe6RUkY2Dcu5IzkbrkwbTv8Kd+j
         g5bA==
X-Gm-Message-State: AGRZ1gJq2ybp2yuGEppLjNPgYqcC6MwT31mVzQc0m3ICk4V1v0kBUd+x
        CnA7SuMOuNrdGtY5K2T3rOvkTg==
X-Google-Smtp-Source: AJdET5dzWkuAd915BGbjb7GEfddAUdQegHgHMkSls9S8t41Vh9PAq4GKphSWScySZLkkPegGQ8GivQ==
X-Received: by 2002:a1c:c902:: with SMTP id f2-v6mr2423672wmb.80.1542096738695;
        Tue, 13 Nov 2018 00:12:18 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 78-v6sm3153122wma.30.2018.11.13.00.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 00:12:17 -0800 (PST)
Subject: Re: [PATCH] media: venus: amend buffer size for bitstream plane
To:     mgottam@codeaurora.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
References: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5BcFr11Hpngpn6hNL91OibAxUv25yh2qMohgfxsKusACw@mail.gmail.com>
 <8fe1d205-c5e7-01a0-9569-d3268911cddd@linaro.org>
 <38dfc098517b3ddb5d96195f2e27429d@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <86714c89-20ec-07c8-2569-65e78e8d584d@linaro.org>
Date:   Tue, 13 Nov 2018 10:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <38dfc098517b3ddb5d96195f2e27429d@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On 11/13/18 9:28 AM, mgottam@codeaurora.org wrote:
> On 2018-11-12 18:04, Stanimir Varbanov wrote:
>> Hi Tomasz,
>>
>> On 10/23/2018 05:50 AM, Tomasz Figa wrote:
>>> Hi Malathi,
>>>
>>> On Tue, Oct 9, 2018 at 4:58 PM Malathi Gottam
>>> <mgottam@codeaurora.org> wrote:
>>>>
>>>> For lower resolutions, incase of encoder, the compressed
>>>> frame size is more than half of the corresponding input
>>>> YUV. Keep the size as same as YUV considering worst case.
>>>>
>>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>>> ---
>>>>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/helpers.c
>>>> b/drivers/media/platform/qcom/venus/helpers.c
>>>> index 2679adb..05c5423 100644
>>>> --- a/drivers/media/platform/qcom/venus/helpers.c
>>>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>>>> @@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32
>>>> width, u32 height)
>>>>         }
>>>>
>>>>         if (compressed) {
>>>> -               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
>>>> +               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;
>>>>                 return ALIGN(sz, SZ_4K);
>>>>         }
>>>
>>> Note that the driver should not enforce one particular buffer size for
>>> bitstream buffers unless it's a workaround for broken firmware or
>>> hardware. The userspace should be able to select the desired size.
>>
>> Good point! Yes, we have to extend set_fmt to allow bigger sizeimage for
>> the compressed buffers (not only for encoder).
> 
> So Stan you meant to say that we should allow s_fmt to accept client
> specified size?

yes but I do expect:

new_sizeimage = max(user_sizeimage, venus_helper_get_framesz)

and also user_sizeimage should be sanitized.

> If so should we set the inst->input_buf_size here in venc_s_fmt?
> 
> @@ -333,10 +333,10 @@static const struct venus_format *
> venc_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
> 
>         pixmp->num_planes = fmt->num_planes;
>         pixmp->flags = 0;
> -
> -       pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> -                                                    pixmp->width,
> -                                                    pixmp->height);
> +       if (!pfmt[0].sizeimage)
> +               pfmt[0].sizeimage =
> venus_helper_get_framesz(pixmp->pixelformat,
> +                                                            pixmp->width,
> +                                                           
> pixmp->height);

yes, but please make

pfmt[0].sizeimage = max(pfmt[0].sizeimage, venus_helper_get_framesz)

and IMO this should be only for CAPTURE queue i.e. inst->output_buf_size

I'm still not sure do we need it for OUTPUT encoder queue.

> 
>         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>                 pfmt[0].bytesperline = ALIGN(pixmp->width, 128);
> @@ -387,6 +387,7 @@ static int venc_s_fmt(struct file *file, void *fh,
> struct v4l2_format *f)
>         venc_try_fmt_common(inst, &format);
> 
>         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> +               inst->input_buf_size = pixmp->plane_fmt[0].sizeimage;
>                 inst->out_width = format.fmt.pix_mp.width;
>                 inst->out_height = format.fmt.pix_mp.height;
> 
> Similar implementation is already handled in case of decoder.
> 
> Then in queue setup, we can compare this against calculated size to
> obtain final buffer size
> 
> @@ -899,7 +900,8 @@ static int venc_queue_setup(struct vb2_queue *q,
>                 sizes[0] = venus_helper_get_framesz(inst->fmt_out->pixfmt,
>                                                     inst->width,
>                                                     inst->height);
> -               inst->input_buf_size = sizes[0];
> +               if(inst->input_buf_size < sizes[0])
> +                       inst->input_buf_size = sizes[0];
>                 break;
> 
> I hope this meets are requirements.

-- 
regards,
Stan
