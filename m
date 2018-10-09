Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CBAC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A19214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsF59rb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A19214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJIWRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:17:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55976 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIWRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:17:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so2214795wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SKj0ZuycNvOvT4s4ibetnrVfziqaGTZUcC3TCC0KSPU=;
        b=YsF59rb4Otvvuwskl0D2pk88qOvRQJO4vIidUsxYWmZRM9CdlwxQWxeyd7P9d+Vr2K
         O4EXUwesCk2+v7sBZUAJXw8SyrmDKrRgmP8bapAXbM/dfYTNUkups46lfAFIk7AA90Xm
         La1TMIMaGD2aT+rQZaBLwfpePJIbIBY7gAiCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SKj0ZuycNvOvT4s4ibetnrVfziqaGTZUcC3TCC0KSPU=;
        b=BKokFZh+QALFs1RWp/ynKFDz/U4Pkn5791NHtmUac7Z9Tb9uunUUssZHaDmtqi/GBb
         tK0Kj8OikRPUDrtVng/RAPK+kMLlCnjV+bgne75bkThRijhRlHGmvuB7ci4FVyUwAL/1
         c6tQMxeS9Ae9uP1VmWhFtGiWuh1ZR4QT3uAyEQ9qrIy7TGdt6IAIh0fZCpibltW8AcUa
         P/8Yk051uVmBibiuYOc+j28YRrR4Q/tpZMmzzkJx48/gMgOkoE4SoWQoBzM5VgeZSJMh
         OMQ/7K/xQOad/PHYtEdmzyPsb1o3Al2u1cwBMj88yxwkTBEuoqpXG4BXCxT0J8YBJEjn
         mKCQ==
X-Gm-Message-State: ABuFfohJ79Uig8TmsuS0N9n/nay8UmlLUmsKATS5pU/k7eS0uTzY98/o
        nSRbV2bRqGLju8ByMOSwgsgxzA==
X-Google-Smtp-Source: ACcGV608/X/xCRpBY+q6EPKEXlMtNbWRlifImJ8fT9/7Mk69jP1ZI0XKDNZnYMm9MOHJRNWPTQSVyg==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197-v6mr2193122wme.82.1539097199395;
        Tue, 09 Oct 2018 07:59:59 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 143-v6sm17799936wmv.6.2018.10.09.07.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:59:58 -0700 (PDT)
Subject: Re: [PATCH] media: venus: handle peak bitrate set property
To:     Malathi Gottam <mgottam@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1539071483-1371-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <274a112a-604c-82b4-130a-c3718abcf141@linaro.org>
Date:   Tue, 9 Oct 2018 17:59:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539071483-1371-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

Thanks for the patch!

On 10/09/2018 10:51 AM, Malathi Gottam wrote:
> Max bitrate property is not supported for venus version 4xx.
> Add a version check for the same.

I'd like to avoid version checks in this layer of the driver. Could just
black-list this property in pkt_session_set_property_4xx? Hint, see
HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE in the same function.

> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index ef11495..3f50cd0 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -757,18 +757,20 @@ static int venc_set_properties(struct venus_inst *inst)
>  	if (ret)
>  		return ret;
>  
> -	if (!ctr->bitrate_peak)
> -		bitrate *= 2;
> -	else
> -		bitrate = ctr->bitrate_peak;
> +	if (!IS_V4(inst->core)) {
> +		if (!ctr->bitrate_peak)
> +			bitrate *= 2;
> +		else
> +			bitrate = ctr->bitrate_peak;
>  
> -	ptype = HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE;
> -	brate.bitrate = bitrate;
> -	brate.layer_id = 0;
> +		ptype = HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE;
> +		brate.bitrate = bitrate;
> +		brate.layer_id = 0;
>  
> -	ret = hfi_session_set_property(inst, ptype, &brate);
> -	if (ret)
> -		return ret;
> +		ret = hfi_session_set_property(inst, ptype, &brate);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_H264) {
>  		profile = venc_v4l2_to_hfi(V4L2_CID_MPEG_VIDEO_H264_PROFILE,
> 

-- 
regards,
Stan
