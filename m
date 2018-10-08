Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2412084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAHvSMCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2412084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJHTco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:32:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54864 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJHTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:32:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so7946369wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FDvWRPW+7Q1Ik580MqMrJkW0QUBQS4a6eQhekKhs6o0=;
        b=DAHvSMCJ63Rts8Y5ldKl1Q5ZRuEEEsyrPViEoRWlruhmdjSKt3wdyX1+gphna5HhVy
         UbObACoVLPKejwomCp7QLhqSrBkSd8Ig0SssVlSMzgCEMEXNgDtSqWaBGq6bPcnCSrjZ
         +akp9rxO2Fbww47cfGnGyQl9OpvAyXELMctAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FDvWRPW+7Q1Ik580MqMrJkW0QUBQS4a6eQhekKhs6o0=;
        b=Sh8UKC+XvtWIQ4pVuKxXnaK6tKnIGwV4w4nmCmTfQef5BsA+zANU6rvrn2DDqGBoNx
         /k80uCVKX8QzAg3WE8GwJGwnIlwWs7kakebEgsdcfHu51KGD1RkkavVOcRS8wgGOVtCm
         XCHlWMDUsjpbQ6Pc4hmSKw8O9Sl+MFCFR2DcCDT/umC+0F0D0d9d12lcRIzhBJ59WaYb
         3h09FqyW3wBTNGpEeltX9AICa4HXDyf3e6xdUt0bLQaBZpdd66VoD1kCkfjo2J7Mouju
         tLR+52WnuttxjsgwaeDkedvinl7exU18fzg1duSJVOT1Aznl7cC83J8CCZwFmhm6gozn
         uwgw==
X-Gm-Message-State: ABuFfojCm5gEXT2smd5YDmGwvHTFP9dWhnr3018iyFNUqN5RySDaHwYD
        l8LnRMEIK0QHH0IRQc0RobPbsQ==
X-Google-Smtp-Source: ACcGV61cJ3UH4BEcLZpV/yH0kkAxW2KojouVub62f40ouuiuABMc+KXjI0jhlEVhdTPWKHlG+SR7OQ==
X-Received: by 2002:a1c:be09:: with SMTP id o9-v6mr15402491wmf.109.1539001275578;
        Mon, 08 Oct 2018 05:21:15 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id b128-v6sm6934109wmh.22.2018.10.08.05.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 05:21:14 -0700 (PDT)
Subject: Re: [PATCH v2] venus: vdec: fix decoded data size
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
References: <1538996944-15042-1-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <8f1b17e3-5015-3a4e-821f-8097da933f91@linaro.org>
Date:   Mon, 8 Oct 2018 15:21:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538996944-15042-1-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 10/08/2018 02:09 PM, Vikash Garodia wrote:
> Existing code returns the max of the decoded size and buffer size.
> It turns out that buffer size is always greater due to hardware
> alignment requirement. As a result, payload size given to client
> is incorrect. This change ensures that the bytesused is assigned
> to actual payload size, when available.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 991e158..189ec97 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -888,8 +888,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>  		unsigned int opb_sz = venus_helper_get_opb_size(inst);
>  
>  		vb = &vbuf->vb2_buf;
> -		vb->planes[0].bytesused =
> -			max_t(unsigned int, opb_sz, bytesused);
> +		vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
>  		vb->planes[0].data_offset = data_offset;
>  		vb->timestamp = timestamp_us * NSEC_PER_USEC;
>  		vbuf->sequence = inst->sequence_cap++;
> 

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
