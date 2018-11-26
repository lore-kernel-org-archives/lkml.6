Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF4EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABE120865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABE120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeK0Abw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:31:52 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:57294 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbeK0Abv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:31:51 -0500
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id RH4xgkJpRbGVyRH51gYTOT; Mon, 26 Nov 2018 14:37:40 +0100
Subject: Re: [PATCH v3] media: venus: amend buffer size for bitstream plane
To:     Malathi Gottam <mgottam@codeaurora.org>,
        stanimir.varbanov@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d74281c8-a177-12a3-9e72-7a7db3014943@xs4all.nl>
Date:   Mon, 26 Nov 2018 14:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHlDvhGtegRXaepWxVP2eAKmMDjUfPp4FU91bmsLEpKHYbfhSSfAGU2VmjcDvyAE1F51sJ1FUjZ+ek+kvH+xHCcIgsGlVqUP+X8iNt1DS6xIQ1m+Fltb
 jmEJ+0M3XHX43DHIGpaE93IXRrIbFK9biW+Ke+Y6Y+PgplnIFpzp/LKwpwt/weW/idxVQHw015jUiE6aXVZrxYOmmjQkaOsWKTM8pxaNcWFhpsWsGyY7pBfI
 F9btWV14cA9Yj0PO3PMKyqaYzQX4UU5ZDXkWNASeYPe4dMPdtgRshh6Id7tNrt9hYykZ3JYj0yhrvVoL/x1Z0AgzUmo4LFHMC2WxRuAuUnOaeJEsZ8AH/sbO
 oHOHbh31XaHmDV/CAQourD709msJpZ5NSOaN+NuFM3wKm2IbhuksaeXP2Cvwjnc2I8PhhwmYXQ5Z+rYD4gc690GcNxJxcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 11:12 AM, Malathi Gottam wrote:
> Accept the buffer size requested by client and compare it
> against driver calculated size and set the maximum to
> bitstream plane.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>

Sorry, this isn't allowed. It is the driver that sets the sizeimage value,
never the other way around.

If you need to allocate larger buffers, then use VIDIOC_CREATE_BUFS instead
of VIDIOC_REQBUFS.

What problem are you trying to solve with this patch?

Regards,

	Hans

> ---
>  drivers/media/platform/qcom/venus/venc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index ce85962..e43dd3d 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -303,6 +303,7 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>  	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
>  	struct v4l2_plane_pix_format *pfmt = pixmp->plane_fmt;
>  	const struct venus_format *fmt;
> +	u32 sizeimage;
>  
>  	memset(pfmt[0].reserved, 0, sizeof(pfmt[0].reserved));
>  	memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
> @@ -334,9 +335,10 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>  	pixmp->num_planes = fmt->num_planes;
>  	pixmp->flags = 0;
>  
> -	pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> -						     pixmp->width,
> -						     pixmp->height);
> +	sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> +					     pixmp->width,
> +					     pixmp->height);
> +	pfmt[0].sizeimage = max(ALIGN(pfmt[0].sizeimage, SZ_4K), sizeimage);
>  
>  	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>  		pfmt[0].bytesperline = ALIGN(pixmp->width, 128);
> @@ -408,8 +410,10 @@ static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
>  
>  	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>  		inst->fmt_out = fmt;
> -	else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +	else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>  		inst->fmt_cap = fmt;
> +		inst->output_buf_size = pixmp->plane_fmt[0].sizeimage;
> +	}
>  
>  	return 0;
>  }
> @@ -908,6 +912,7 @@ static int venc_queue_setup(struct vb2_queue *q,
>  		sizes[0] = venus_helper_get_framesz(inst->fmt_cap->pixfmt,
>  						    inst->width,
>  						    inst->height);
> +		sizes[0] = max(sizes[0], inst->output_buf_size);
>  		inst->output_buf_size = sizes[0];
>  		break;
>  	default:
> 

