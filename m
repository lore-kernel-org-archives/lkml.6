Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B94DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B1B20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="endyHtCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B1B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeKAVVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:21:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40918 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbeKAVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:21:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so1163217wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jFXrcmt0Hbu6VokRy7WOH99xBVt1l+L+FdYa6O5+ooI=;
        b=endyHtCqGte9Yv+jPpo3wj4hEYa0at0+b9Y6q1/F8RJwF+xFz1L35hsD7A5mh5YkEs
         628xT1zIJBcMRu3HLBdeFQ+hmTSIEG3JLKbbJs1RxrCyFK9Rb+XZl4SuOlaiCTeSITji
         yrtnI0mBTt67v5/CtElA33JpuljzMxV9JlJK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jFXrcmt0Hbu6VokRy7WOH99xBVt1l+L+FdYa6O5+ooI=;
        b=o1q16hvlN8X0rbVLY1MbaXmPvXHocyLVouAmNos53eUJCIpsYJRiGLz3tIxi7SZXAb
         F3CEozR66NhXSaKktoSuFKtXGgSAP2cLVgZZqqLow5sGEwwnZ25G3KuYZ1YdOyCYYFrw
         x4Mn7waQErW8U1Flkmz0NmruEHMe3aw62MiN97yRdKEor5uPKNHG7LgCXjHyXbda+5hR
         Kcpz7KkwjN+lwqcIGWUXJcndIqomEpL4N5h7SsbBMR1vfzW/cH9pNEjNTD5+PCpkxvGD
         TKBLPURti7k4TEtArtb6qKM2UgD1JeB/6duV5Z0ecFb6ErgQMNBTr8HkBz1BsQCviS1P
         tZqw==
X-Gm-Message-State: AGRZ1gJfJoJzk8lif66tFEPAO/GOQyrq8NVyJjg91FaWNs4L/MsmZG6L
        oTXhjSoDOepVx9K3tNsRW7MolQ==
X-Google-Smtp-Source: AJdET5etVh1Sla+Ymu8MKAcH4v288tu79+un0vHZJbJ/19UI1WzFzGmw5yMJAkPMxd0phteFx0jpSg==
X-Received: by 2002:a1c:154a:: with SMTP id 71-v6mr5065940wmv.83.1541074726852;
        Thu, 01 Nov 2018 05:18:46 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id o188-v6sm2725741wmg.9.2018.11.01.05.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:18:45 -0700 (PDT)
Subject: Re: [PATCH] media: venus: dynamic handling of bitrate
To:     Malathi Gottam <mgottam@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1540971728-26789-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <3ff2c3dd-434d-960b-6806-f4bb8ec0d954@linaro.org>
Date:   Thu, 1 Nov 2018 14:18:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540971728-26789-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

Thanks for the patch!

On 10/31/18 9:42 AM, Malathi Gottam wrote:
> Any request for a change in bitrate after both planes
> are streamed on is handled by setting the target bitrate
> property to hardware.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 45910172..54f310c 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -79,7 +79,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct venus_inst *inst = ctrl_to_inst(ctrl);
>  	struct venc_controls *ctr = &inst->controls.enc;
> +	struct hfi_bitrate brate;
>  	u32 bframes;
> +	u32 ptype;
>  	int ret;
>  
>  	switch (ctrl->id) {
> @@ -88,6 +90,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	case V4L2_CID_MPEG_VIDEO_BITRATE:
>  		ctr->bitrate = ctrl->val;
> +		if (inst->streamon_out && inst->streamon_cap) {

Hmm, hfi_session_set_property already checks the instance state so I
don't think those checks are needed. Another thing is that we need to
take the instance mutex to check the instance state.

> +			ptype = HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
> +			brate.bitrate = ctr->bitrate;
> +			brate.layer_id = 0;
> +
> +			ret = hfi_session_set_property(inst, ptype, &brate);
> +			if (ret)
> +				return ret;
> +		}
>  		break;
>  	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:
>  		ctr->bitrate_peak = ctrl->val;
> 

-- 
regards,
Stan
