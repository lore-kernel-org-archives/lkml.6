Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F145120892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEpn8b7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F145120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeKITjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:39:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39836 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeKITjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:39:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so1365857wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KdvVMrhYxojFpjfvQnQuUkHklgoOtGked9DucC83n0c=;
        b=TEpn8b7px8qYOJ1DWRNYhaThH2i4S0TqApqaq5QNqGY7oeyVodOKrgWfrEHMjcOnZS
         HCJCeTs14omr9fAItcLev5OsC85BScgliaE04HAbyReKxj1uwvP+2iXXSn+NiBEh/KPB
         KMUyEkv3G5hxZUU8aF+OwTwTPlr9DZEY9PmPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KdvVMrhYxojFpjfvQnQuUkHklgoOtGked9DucC83n0c=;
        b=T/xnIom+Nbn9bLR11G0+BpVRWG8RCutogiDDi6f6ldKdoVI9II80T9YFfRQagjnyi/
         43QpzeuOZk0FE/WItbHMug6/PGNtv/Yh1f3/KdYFnH5UrrcVq6B5HY1oDBpryRWQZ7WK
         ptJpVpQ0mUPkMNtZo8GQWLQkZMKdM7ydTg66J1HZfrJm2CXxojfOkeOSv9zbjVpjru4T
         +XU+CNZs1SywAWBjJCgDA0vpgke0eWOvcb2N/z88E9Wzi5uTia9y7752nFpU7SPO5gF+
         r2gTkBVHokJk8I+DG6VQ7g9NCnB4rhckQPn1yRej6c/SU/sKZlTzM5AsHnKBort9h4uv
         ghBQ==
X-Gm-Message-State: AGRZ1gJ2ILtlEp0xqaOr/ScwgnImYfgIwmJMmARqopPHhAoc3e/uHQnn
        PbFi0cUiv89YsMu4Vm8IBIAbMQ==
X-Google-Smtp-Source: AJdET5fweoFRA+WRqKf/uPJYkzz2ZhMRD3dRzTUEixoVSH0OF9q5hnUx98dJ3xGltfEGjSrJZC17aA==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr4301245wme.33.1541757594142;
        Fri, 09 Nov 2018 01:59:54 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id p20-v6sm982702wmd.10.2018.11.09.01.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 01:59:53 -0800 (PST)
Subject: Re: [PATCH v1 3/5] media: venus: do not destroy video session during
 queue setup
To:     Srinu Gorle <sgorle@codeaurora.org>, stanimir.varbanov@linaro.org,
        hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     acourbot@chromium.org, vgarodia@codeaurora.org
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
 <1538222432-25894-4-git-send-email-sgorle@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <d8cb0c47-a3f7-314b-c65d-3c8eca724e6a@linaro.org>
Date:   Fri, 9 Nov 2018 11:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1538222432-25894-4-git-send-email-sgorle@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinu,

On 9/29/18 3:00 PM, Srinu Gorle wrote:
> - open and close video sessions for plane properties is incorrect.

Could you rephrase this statement? I really don't understand what you mean.

> - add check to ensure, same instance persist from driver open to close.

This assumption is wrong. The v4l client can change the codec by SFMT
without close the device node, in that case we have to destroy and
create a new session with new codec.

> 
> Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/hfi.c  | 3 +++
>  drivers/media/platform/qcom/venus/vdec.c | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
> index 36a4784..59c34ba 100644
> --- a/drivers/media/platform/qcom/venus/hfi.c
> +++ b/drivers/media/platform/qcom/venus/hfi.c
> @@ -207,6 +207,9 @@ int hfi_session_init(struct venus_inst *inst, u32 pixfmt)
>  	const struct hfi_ops *ops = core->ops;
>  	int ret;
>  
> +	if (inst->state >= INST_INIT && inst->state < INST_STOP)
> +		return 0;

In fact you want to be able to call session_init multiple times but
deinit the session only once? The hfi.c layer is designed to follow the
states as they are expected by the firmware side, if you want to call
session_init multiple times just make a wrapper in the vdec.c with
reference counting.

> +
>  	inst->hfi_codec = to_codec_type(pixfmt);
>  	reinit_completion(&inst->done);
>  
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index afe3b36..0035cf2 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -700,6 +700,8 @@ static int vdec_num_buffers(struct venus_inst *inst, unsigned int *in_num,
>  
>  	*out_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
>  
> +	return 0;

OK in present implementation I decided that the codec is settled when
streamon on both queues is called (i.e. the final session_init is made
in streamon). IMO the correct one is to init the session in
reqbuf(output) and deinit session in reqbuf(output, count=0)?

The problem I see when you skip session_deinit is that the codec cannot
be changed without closing the video node.

> +
>  deinit:
>  	hfi_session_deinit(inst);
>  
> 

-- 
regards,
Stan
