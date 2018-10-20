Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391D8C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D946520869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PFsUVkJg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N17ZaNvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D946520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJTQAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 12:00:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeJTQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 12:00:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 074E76086B; Sat, 20 Oct 2018 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540021841;
        bh=y/xi5mbJcIbx5q3iSyfa6FLfxbWRfOscOFbMXeMp0Wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PFsUVkJgr5vbXZIVAoOi8pemnZJvwHBGFuZvuDghoIk2jj7jnwXJHKZ31sLJY+jTf
         W6meNFzQntuyTsdkX0rVd0ITplcvMdX2w9+jfr5p5LmxrXbZDBlJlwsrVR77MMO5Jo
         rK7ayYy5zxI/NackFyIzM+tlBgR4l96BMVkIIrHw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 184DF60227;
        Sat, 20 Oct 2018 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540021840;
        bh=y/xi5mbJcIbx5q3iSyfa6FLfxbWRfOscOFbMXeMp0Wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N17ZaNvzUWuoJaLJHEjb/7dMCBd6gu2Qajh07Hgk1RPiTCapuxXmvxrLFdMTNGIIH
         hmncL+c9SJFscX5TisAuGvoohpmJ55Y9fO7zEFKdGjfJnxWxsSx6m4QJu3PBmmRaLZ
         F4w7teDtk76M1Wz0oqH0kNGJ3CYaw7vBzJ3FgBeQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 20 Oct 2018 13:20:40 +0530
From:   mgottam@codeaurora.org
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: Re: [PATCH] media: venus: queue initial buffers
In-Reply-To: <7960b369-3bb3-529b-c06c-26ea4de821c8@linaro.org>
References: <1539071426-1282-1-git-send-email-mgottam@codeaurora.org>
 <7960b369-3bb3-529b-c06c-26ea4de821c8@linaro.org>
Message-ID: <7ab8c5ef795b774ad684e5b941e0d346@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-09 20:47, Stanimir Varbanov wrote:
> Hi Malathi,
> 
> On 10/09/2018 10:50 AM, Malathi Gottam wrote:
>> Buffers can be queued to driver before the planes are
>> set to start streaming. Queue those buffers to firmware
>> once start streaming is called on both the planes.
> 
> yes and this is done in venus_helper_m2m_device_run mem2mem operation
> when streamon on both queues is called, thus below function just
> duplicates .device_run.
> 
> Do you fix an issue with that patch?
> 
>> 
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/helpers.c | 22 
>> ++++++++++++++++++++++
>>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>>  drivers/media/platform/qcom/venus/venc.c    |  5 +++++
>>  3 files changed, 28 insertions(+)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c 
>> b/drivers/media/platform/qcom/venus/helpers.c
>> index e436385..2679adb 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.c
>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>> @@ -1041,6 +1041,28 @@ void venus_helper_vb2_stop_streaming(struct 
>> vb2_queue *q)
>>  }
>>  EXPORT_SYMBOL_GPL(venus_helper_vb2_stop_streaming);
>> 
>> +int venus_helper_queue_initial_bufs(struct venus_inst *inst)
>> +{
>> +	struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
>> +	struct v4l2_m2m_buffer *buf, *n;
>> +	int ret;
>> +
>> +	v4l2_m2m_for_each_dst_buf_safe(m2m_ctx, buf, n)	{
>> +		ret = session_process_buf(inst, &buf->vb);
>> +		if (ret)
>> +			return_buf_error(inst, &buf->vb);
>> +	}
>> +
>> +	v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
>> +		ret = session_process_buf(inst, &buf->vb);
>> +		if (ret)
>> +			return_buf_error(inst, &buf->vb);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(venus_helper_queue_initial_bufs);
>> +
>>  int venus_helper_vb2_start_streaming(struct venus_inst *inst)
>>  {
>>  	struct venus_core *core = inst->core;
>> diff --git a/drivers/media/platform/qcom/venus/helpers.h 
>> b/drivers/media/platform/qcom/venus/helpers.h
>> index 2475f284..f4d76ab 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.h
>> +++ b/drivers/media/platform/qcom/venus/helpers.h
>> @@ -31,6 +31,7 @@ void venus_helper_buffers_done(struct venus_inst 
>> *inst,
>>  int venus_helper_vb2_start_streaming(struct venus_inst *inst);
>>  void venus_helper_m2m_device_run(void *priv);
>>  void venus_helper_m2m_job_abort(void *priv);
>> +int venus_helper_queue_initial_bufs(struct venus_inst *inst);
>>  int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
>>  			    struct hfi_buffer_requirements *req);
>>  u32 venus_helper_get_framesz_raw(u32 hfi_fmt, u32 width, u32 height);
>> diff --git a/drivers/media/platform/qcom/venus/venc.c 
>> b/drivers/media/platform/qcom/venus/venc.c
>> index ce85962..ef11495 100644
>> --- a/drivers/media/platform/qcom/venus/venc.c
>> +++ b/drivers/media/platform/qcom/venus/venc.c
>> @@ -989,6 +989,11 @@ static int venc_start_streaming(struct vb2_queue 
>> *q, unsigned int count)
>>  	if (ret)
>>  		goto deinit_sess;
>> 
>> +	ret = venus_helper_queue_initial_bufs(inst);
>> +	if (ret)
>> +		goto deinit_sess;
>> +	}
>> +
>>  	mutex_unlock(&inst->lock);
>> 
>>  	return 0;
>> 
Hi Stan,

As I considered playback sequence as well, this function 
"venus_helper_m2m_device_run" was muted as a part of it. So I had to 
explicitly implement this function for encoder.

For now, we can omit this patch. Once the playback sequence gets merged 
into upstream, we can re-look into this.
