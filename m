Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71329C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDB321780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWZ5PM/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDB321780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeKOT0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:26:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeKOT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:26:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so17175262wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ndB5HfCVzoVq8frD+AyFpQ/Nk+pF+ed7XTyjsOq9M80=;
        b=OWZ5PM/eWFCKQ1exeLbllqYVmWPl+sWgQCOrPmoauIS8s8hhCAW7jf7yHSUzeZplh8
         SPYCA7LYuP79GGZgMcUljWxDO6aDRqudbhAZ3a24mGi7dtuPhBw642n0Psg+UmRQG4O9
         Yym5Juqi8w6PVvmIWy05dPtttx5Sfv24lF3x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ndB5HfCVzoVq8frD+AyFpQ/Nk+pF+ed7XTyjsOq9M80=;
        b=FzYW7vbCOdRlRdhdQSerwPqTBaBNZgMAr2TsFbznk4zauHxSgyOt9ibvMnpzTK9Mim
         fwC8qGnVf1I6YYCAifWXZDZQMKkbVMYd5zRXPT+6oQ79nblKsaNEYjlmzcCjD2y4uCpq
         04qmLb6Ifg/9vIpkynPd4WyvtdfyY0eAJ7xASZXSLgxNDw+EzI/83vwBjgN9tEbjLezR
         DMjOt6MyPsy1vfuam+DHXK2rzcD0Ir4DK/AL3eXq+6IKlgd3K2mWLB1E1Ca3APv9Ac2V
         ng+go6llzybVuf89o/su0mZj0oGI9wlrF9u0kNKq9z+Snim5t3sHF4EMb3I+cW9ilCbs
         04bw==
X-Gm-Message-State: AGRZ1gI6LvFcB6JfT3J3tTruhvTQGO8c+z5tHt0OiIFmaqLke99UmhyE
        Bnt5bePlZrf9y6Ox2pcJMc+sJ5kT3IU=
X-Google-Smtp-Source: AJdET5fZErYgsmgb4flsEZ9yodemIMk9urKB9ULlfxDHddO2M7LF7bxuzBjb9LiDPB52ZlVF4Neugw==
X-Received: by 2002:a1c:cb84:: with SMTP id b126mr4281018wmg.64.1542273555093;
        Thu, 15 Nov 2018 01:19:15 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id y83-v6sm18469170wmb.20.2018.11.15.01.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 01:19:14 -0800 (PST)
Subject: Re: [PATCH v2] media: venus: dynamic handling of bitrate
To:     Malathi Gottam <mgottam@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1541162476-20770-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <43bf0d2b-0b3e-9d83-5ffe-3e2250c7fa0c@linaro.org>
Date:   Thu, 15 Nov 2018 11:19:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541162476-20770-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

Thanks for the patch!

On 11/2/18 2:41 PM, Malathi Gottam wrote:
> Any request for a change in bitrate after both planes
> are streamed on is handled by setting the target bitrate
> property to hardware.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 45910172..f90a34e 100644
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
> @@ -88,6 +90,19 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	case V4L2_CID_MPEG_VIDEO_BITRATE:
>  		ctr->bitrate = ctrl->val;
> +		mutex_lock(&inst->lock);
> +		if (inst->streamon_out && inst->streamon_cap) {
> +			ptype = HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
> +			brate.bitrate = ctr->bitrate;
> +			brate.layer_id = 0;
> +
> +			ret = hfi_session_set_property(inst, ptype, &brate);
> +			if (ret) {
> +				mutex_unlock(&inst->lock);
> +				return ret;
> +			}
> +		}
> +		mutex_unlock(&inst->lock);
>  		break;
>  	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:
>  		ctr->bitrate_peak = ctrl->val;
> 

-- 
regards,
Stan
