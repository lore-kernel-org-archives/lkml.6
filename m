Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E4FC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB75B204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="guncIxh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB75B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeKAV2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:28:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56006 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbeKAV2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:28:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id s10-v6so1229046wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CTnJxPL0PmaKBKcPNalFpcZuplKKdFOISJjI++bsBjk=;
        b=guncIxh8y4z9gPZXvax0M0oqcIuISyM/sQ2cHN5JJ90qpycimIOw6bZSnmnjZHGURo
         V2HGJBJJsnNTVTwzjzXxUgv7h1MJGrSNTqrvdmMcoO35kVlFmSeTqSuKeISO4jcqXbMH
         ILn/aMs/5FfxY/6EfdRKcQIlnxpVdqeuyj7lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CTnJxPL0PmaKBKcPNalFpcZuplKKdFOISJjI++bsBjk=;
        b=feAGKyMGHnBT0FsQwIOryhQU9PNBgl3t4yk1qAHdRf4Ms72AJg1tFvuJZ1ZuLXtCUm
         nTADAJaOx93qVGqCJtjt8fE2kAtVJTsa3075xzLrnNfW9dOJzvQlfwTbDCBvs+thCp+w
         JWMGTidnot1YySO3PL2EQCl/KCTAt8FBmNRmZ3ocCRzfUre6P9OSRYb35DcfEgcVIbYn
         PRDW0KQhKEpT0Qe6O8cLAJsjX6X5KiYVvpk+vQnSBK9wYZv9vWyWkACOJwPMt8zH+16q
         VYB4+k5kYYY1KL0qPLynd8LkmrIc71vITVRS9x2a8klvBgD2w/MgdAC+gOaMh0eeKg6d
         Fp0Q==
X-Gm-Message-State: AGRZ1gIRISSw14gCcTknPaLyR059B85ziJMKp25sGfq27DTwAkvspjjo
        Uof25aqJtThq82kgBn35pHYqyg==
X-Google-Smtp-Source: AJdET5c+JLvJcan5gm9m0XivOvhNjSkuDkxqii/aRh32RHfcadtUZFYOjoaFD1yCC5cJpRHuNdbgog==
X-Received: by 2002:a1c:1f4c:: with SMTP id f73-v6mr2279362wmf.56.1541075163570;
        Thu, 01 Nov 2018 05:26:03 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id v8-v6sm5593912wrr.41.2018.11.01.05.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:26:02 -0700 (PDT)
Subject: Re: [PATCH] media: venus: queue initial buffers
To:     mgottam@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1539071426-1282-1-git-send-email-mgottam@codeaurora.org>
 <7960b369-3bb3-529b-c06c-26ea4de821c8@linaro.org>
 <7ab8c5ef795b774ad684e5b941e0d346@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6e3189ad-4dfa-0694-1dd3-3d81f396b664@linaro.org>
Date:   Thu, 1 Nov 2018 14:26:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7ab8c5ef795b774ad684e5b941e0d346@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/20/18 10:50 AM, mgottam@codeaurora.org wrote:
> On 2018-10-09 20:47, Stanimir Varbanov wrote:
>> Hi Malathi,
>>
>> On 10/09/2018 10:50 AM, Malathi Gottam wrote:
>>> Buffers can be queued to driver before the planes are
>>> set to start streaming. Queue those buffers to firmware
>>> once start streaming is called on both the planes.
>>
>> yes and this is done in venus_helper_m2m_device_run mem2mem operation
>> when streamon on both queues is called, thus below function just
>> duplicates .device_run.
>>
>> Do you fix an issue with that patch?
>>
>>>
>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>> ---
>>>  drivers/media/platform/qcom/venus/helpers.c | 22 ++++++++++++++++++++++
>>>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>>>  drivers/media/platform/qcom/venus/venc.c    |  5 +++++
>>>  3 files changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/helpers.c
>>> b/drivers/media/platform/qcom/venus/helpers.c
>>> index e436385..2679adb 100644
>>> --- a/drivers/media/platform/qcom/venus/helpers.c
>>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>>> @@ -1041,6 +1041,28 @@ void venus_helper_vb2_stop_streaming(struct
>>> vb2_queue *q)
>>>  }
>>>  EXPORT_SYMBOL_GPL(venus_helper_vb2_stop_streaming);
>>>
>>> +int venus_helper_queue_initial_bufs(struct venus_inst *inst)
>>> +{
>>> +    struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
>>> +    struct v4l2_m2m_buffer *buf, *n;
>>> +    int ret;
>>> +
>>> +    v4l2_m2m_for_each_dst_buf_safe(m2m_ctx, buf, n)    {
>>> +        ret = session_process_buf(inst, &buf->vb);
>>> +        if (ret)
>>> +            return_buf_error(inst, &buf->vb);
>>> +    }
>>> +
>>> +    v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
>>> +        ret = session_process_buf(inst, &buf->vb);
>>> +        if (ret)
>>> +            return_buf_error(inst, &buf->vb);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL(venus_helper_queue_initial_bufs);
>>> +
>>>  int venus_helper_vb2_start_streaming(struct venus_inst *inst)
>>>  {
>>>      struct venus_core *core = inst->core;
>>> diff --git a/drivers/media/platform/qcom/venus/helpers.h
>>> b/drivers/media/platform/qcom/venus/helpers.h
>>> index 2475f284..f4d76ab 100644
>>> --- a/drivers/media/platform/qcom/venus/helpers.h
>>> +++ b/drivers/media/platform/qcom/venus/helpers.h
>>> @@ -31,6 +31,7 @@ void venus_helper_buffers_done(struct venus_inst
>>> *inst,
>>>  int venus_helper_vb2_start_streaming(struct venus_inst *inst);
>>>  void venus_helper_m2m_device_run(void *priv);
>>>  void venus_helper_m2m_job_abort(void *priv);
>>> +int venus_helper_queue_initial_bufs(struct venus_inst *inst);
>>>  int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
>>>                  struct hfi_buffer_requirements *req);
>>>  u32 venus_helper_get_framesz_raw(u32 hfi_fmt, u32 width, u32 height);
>>> diff --git a/drivers/media/platform/qcom/venus/venc.c
>>> b/drivers/media/platform/qcom/venus/venc.c
>>> index ce85962..ef11495 100644
>>> --- a/drivers/media/platform/qcom/venus/venc.c
>>> +++ b/drivers/media/platform/qcom/venus/venc.c
>>> @@ -989,6 +989,11 @@ static int venc_start_streaming(struct vb2_queue
>>> *q, unsigned int count)
>>>      if (ret)
>>>          goto deinit_sess;
>>>
>>> +    ret = venus_helper_queue_initial_bufs(inst);
>>> +    if (ret)
>>> +        goto deinit_sess;
>>> +    }
>>> +
>>>      mutex_unlock(&inst->lock);
>>>
>>>      return 0;
>>>
> Hi Stan,
> 
> As I considered playback sequence as well, this function
> "venus_helper_m2m_device_run" was muted as a part of it. So I had to
> explicitly implement this function for encoder.
> 
> For now, we can omit this patch. Once the playback sequence gets merged
> into upstream, we can re-look into this.

Sorry, I didn't look deeply into playback sequence patches yet, but
looks like we have to fix them first. So please drop this patch.

-- 
regards,
Stan
