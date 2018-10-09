Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C5C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FDB214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyAljfcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FDB214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJIWed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:34:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55153 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJIWec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:34:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so2288284wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r0jrOQD6ixGU7TxZGKQoECyaRmcUrxlCJjNnxm8rV4k=;
        b=TyAljfcgon+zmp+TfoifxTnJVvhFWogxpB03dIf8D277bYut/kqblO6LSwliwC7t9o
         3gw6hn4MVHMTZKcVZHXArf1OD5S9kUrqEDB+YlA4xJXEf78pqycDjgAlGUwduIqxX8Pq
         OFL0wkkitKJnabZBVfdPd7t0sWTH9zet2KROc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0jrOQD6ixGU7TxZGKQoECyaRmcUrxlCJjNnxm8rV4k=;
        b=FUoxxs57Tck4dynjd912lTma6Nx54/rWqLc9j1w+WrkrF+f5ahjnxtaJpJjWdGNcgu
         qVyB4N1/BebQJJqV5FXNq0MX/kUPK2k09hI21Fp660N9H33vb8Y024tuSUQrrM3me77Y
         u2j5VEouodokEJBIdZ1SqUaB3t0v2jAqcyHpUXpsMrImlSEBGxSd71fKSds/c71/zdxq
         HmdaHpzHEns26WzT49Xd/WLEBPeeruEf0ZwD7hGxhTq7VtppG1Awwbrt83aleKL+jGr3
         oGXD/GCU/BS/R6RxtEgko0Etk7yvloeJVWvbb2c4aVp1gtERsjTrSoyBBts0qnPtQyvJ
         0orA==
X-Gm-Message-State: ABuFfoiMKY3MkcvF8Uukjfes62v6XAktX6TmOI7A2gm9yn/zElK0eMlt
        G7wXbYe4rzqd03yD21KrxsfDmQ==
X-Google-Smtp-Source: ACcGV62sgiPAPuNOAJDv1qWXwwzi5RTt6VW09fWmq+Fq49LXXgpPiTwb+AJ/DAHY3CXclntR7YqLKw==
X-Received: by 2002:a1c:4889:: with SMTP id v131-v6mr2311739wma.87.1539098226087;
        Tue, 09 Oct 2018 08:17:06 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id b139-v6sm30388662wmd.36.2018.10.09.08.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 08:17:05 -0700 (PDT)
Subject: Re: [PATCH] media: venus: queue initial buffers
To:     Malathi Gottam <mgottam@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1539071426-1282-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <7960b369-3bb3-529b-c06c-26ea4de821c8@linaro.org>
Date:   Tue, 9 Oct 2018 18:17:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539071426-1282-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On 10/09/2018 10:50 AM, Malathi Gottam wrote:
> Buffers can be queued to driver before the planes are
> set to start streaming. Queue those buffers to firmware
> once start streaming is called on both the planes.

yes and this is done in venus_helper_m2m_device_run mem2mem operation
when streamon on both queues is called, thus below function just
duplicates .device_run.

Do you fix an issue with that patch?

> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 22 ++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>  drivers/media/platform/qcom/venus/venc.c    |  5 +++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index e436385..2679adb 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -1041,6 +1041,28 @@ void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_vb2_stop_streaming);
>  
> +int venus_helper_queue_initial_bufs(struct venus_inst *inst)
> +{
> +	struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
> +	struct v4l2_m2m_buffer *buf, *n;
> +	int ret;
> +
> +	v4l2_m2m_for_each_dst_buf_safe(m2m_ctx, buf, n)	{
> +		ret = session_process_buf(inst, &buf->vb);
> +		if (ret)
> +			return_buf_error(inst, &buf->vb);
> +	}
> +
> +	v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
> +		ret = session_process_buf(inst, &buf->vb);
> +		if (ret)
> +			return_buf_error(inst, &buf->vb);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(venus_helper_queue_initial_bufs);
> +
>  int venus_helper_vb2_start_streaming(struct venus_inst *inst)
>  {
>  	struct venus_core *core = inst->core;
> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index 2475f284..f4d76ab 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -31,6 +31,7 @@ void venus_helper_buffers_done(struct venus_inst *inst,
>  int venus_helper_vb2_start_streaming(struct venus_inst *inst);
>  void venus_helper_m2m_device_run(void *priv);
>  void venus_helper_m2m_job_abort(void *priv);
> +int venus_helper_queue_initial_bufs(struct venus_inst *inst);
>  int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
>  			    struct hfi_buffer_requirements *req);
>  u32 venus_helper_get_framesz_raw(u32 hfi_fmt, u32 width, u32 height);
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index ce85962..ef11495 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -989,6 +989,11 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
>  	if (ret)
>  		goto deinit_sess;
>  
> +	ret = venus_helper_queue_initial_bufs(inst);
> +	if (ret)
> +		goto deinit_sess;
> +	}
> +
>  	mutex_unlock(&inst->lock);
>  
>  	return 0;
> 

-- 
regards,
Stan
