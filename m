Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A9FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB3F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUqMZnYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB3F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeJPRbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:31:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53346 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJPRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:31:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so21656021wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IClMZFktwHwaJaa1aReRnWQw8PazyNLEvZ+HCSSFGVg=;
        b=XUqMZnYqJ4NPiHf/dmbALGhC4Fkew2sAi2KbFKjLAwj9uGciiNkDBJvOUJiPInhpFh
         YRAUHdyQbx4VDNf0G4bDN5o/QSKYNN3LQ76TLNCHnfdPL0yWda53gJCvRLyfNTpKl4VD
         xr0BF1ErYtbnPyxeQjhSJZ8w+FGpvQAjyNRUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IClMZFktwHwaJaa1aReRnWQw8PazyNLEvZ+HCSSFGVg=;
        b=tzRRODepPRDuqnYVMPaGF22ewviNKBNUm4vd3h/YzpIUdIkTm+B8nmLPkNtKjtKAge
         EPEkcGoMbY3zFlzUc4oX65+jwecwIkcv4pb8S1NWpx1r5DOEBqMTixODY0/tRj+ShK2X
         uydD3DiGl9gEQElk8NmuCwlcNgsaeN3F/T5d5s9G2rR6ClN1PYS4AG/LztDnZHK5X+FB
         E/ZKKJdjZIgCElv8iECEMu49PEraTXSuK6/cfWQwKFg9WBvBrm5nBXb0+5eGkEzPuZxu
         AQeN87yvf9rJYecBYvnsxuSMVEqR2A+OipETeSSvJCemZcn4hQxNNsMFhQhVGrFliUji
         LL6A==
X-Gm-Message-State: ABuFfojoX5uQmQZlcGrRnNMXkE/OeWCDw8c2tRTu3Hnipo6t+fWZ4SAE
        1QkVucUBWTuf6iwBKWHwYh7Krg==
X-Google-Smtp-Source: ACcGV62qoDOXH0J67hoLWSqXPz8Ap6j6TQLu70y0g9RJiWIw1RRVAt9MQ6MsgIu+mprjzEluc1lVkQ==
X-Received: by 2002:a1c:1812:: with SMTP id 18-v6mr16484019wmy.34.1539682908825;
        Tue, 16 Oct 2018 02:41:48 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id m16-v6sm11864135wmd.35.2018.10.16.02.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 02:41:47 -0700 (PDT)
Subject: Re: [PATCH] media: venus: add support for selection rectangles
To:     Malathi Gottam <mgottam@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1539071603-1588-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <0e0f689e-f6e3-73a6-e145-deb2ef7cafc8@linaro.org>
Date:   Tue, 16 Oct 2018 12:41:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539071603-1588-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On 10/09/2018 10:53 AM, Malathi Gottam wrote:
> Handles target type crop by setting the new active rectangle
> to hardware. The new rectangle should be within YUV size.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 3f50cd0..754c19a 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -478,16 +478,31 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
>  venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
>  {
>  	struct venus_inst *inst = to_inst(file);
> +	int ret;
> +	u32 buftype;
>  
>  	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>  		return -EINVAL;
>  
>  	switch (s->target) {
>  	case V4L2_SEL_TGT_CROP:
> -		if (s->r.width != inst->out_width ||
> -		    s->r.height != inst->out_height ||
> +		if (s->r.width > inst->out_width ||
> +		    s->r.height > inst->out_height ||
>  		    s->r.top != 0 || s->r.left != 0)
>  			return -EINVAL;
> +		if (s->r.width != inst->width ||
> +		    s->r.height != inst->height) {
> +			buftype = HFI_BUFFER_OUTPUT;
> +			ret = venus_helper_set_output_resolution(inst,
> +								 s->r.width,
> +								 s->r.height,
> +								 buftype);

I'm afraid that set_output_resolution cannot be called at any time. Do
you think we can set it after start_session?

-- 
regards,
Stan
