Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAECAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1E92098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNzzfRch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1E92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeIQT6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:58:10 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51315 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbeIQT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:58:09 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so11376243itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G+hjCVUflbmRhyTN7f9391ojziAbEgPnRoQV5ZQx8M4=;
        b=VNzzfRchHhSN3xK9cy0qSzBPgRv6DbNcv964PYdahD3jAp/G/6KH+xtzejuLqOLi74
         eo664zkk4t8W6vCg/roIyzKS7voONsS/gsny59rcmAow3dlg6X6hupSJ1Ocy8KBzI6E3
         YN2c1OmLj7SG0GSWYOBfZ12KH7RoAr/4t7hH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G+hjCVUflbmRhyTN7f9391ojziAbEgPnRoQV5ZQx8M4=;
        b=H/OoBtOZPUYLhYXHIIWif2/fiY5A3J9jajT/O7DyLrKKQcaylh3bpZcKHGfo3/tM0x
         DOzIZaErbrlyG3LuJlUgrxR+qs3VzV22LZoDypWPi4HannZSymxKmOoGtxrAY0/f7m74
         UEWEWVrDzJ/KJX5lXid56XnorSbWVkKZ41Rjk1URBvxvSiD8DrxNkjIn6XHyb9fR+8Oh
         PM0QHOpNaMWUmNHxYlrnCZAn3YU27IWRZQjkSiNNDlUcE+SL/ZVxWRQmxJiAki8034EF
         aYSrO44SypTGaI5L05MqWvG4O6xAltZ9KPsbSWb9t3Ab2BQ5nFBiK0Iew14J8CoGyWAy
         b5Mg==
X-Gm-Message-State: APzg51C2niOQt/L6V6kUcwI49GE5GpxJzi3WHk6ZythaQI8LyMcaMUNh
        kTn6hXfy4Ho8kKknd8mFlFp9bQ==
X-Google-Smtp-Source: ANB0VdbrkXi8RAfbr0bjLc8uEbHtdAyxttwwaUJrVoagNo3CvkUyRWb42Hnd73hPND/wMl+sSITpLA==
X-Received: by 2002:a24:6401:: with SMTP id t1-v6mr13515190itc.135.1537194633940;
        Mon, 17 Sep 2018 07:30:33 -0700 (PDT)
Received: from [10.199.97.98] ([209.82.80.116])
        by smtp.googlemail.com with ESMTPSA id x68-v6sm4368628ita.2.2018.09.17.07.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:30:33 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Vikash Garodia <vgarodia@codeaurora.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, acourbot@chromium.org
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
 <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org>
 <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
 <92f6f79a-02ae-d23e-1b97-fc41fd921c89@linaro.org>
 <33e8d8e3-138e-0031-5b75-4bef114ac75e@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <36b42952-982c-9048-77fb-72ca45cc7476@linaro.org>
Date:   Mon, 17 Sep 2018 17:30:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <33e8d8e3-138e-0031-5b75-4bef114ac75e@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 09/17/2018 01:00 PM, Hans Verkuil wrote:
> On 07/18/2018 04:37 PM, Stanimir Varbanov wrote:
>> Hi,
>>
>> On 07/18/2018 04:26 PM, Nicolas Dufresne wrote:
>>> Le mercredi 18 juillet 2018 à 14:31 +0300, Stanimir Varbanov a écrit :
>>>> Hi Vikash,
>>>>
>>>> On 07/02/2018 10:44 AM, Vikash Garodia wrote:
>>>>> Exisiting code returns the max of the decoded
>>>>> size and buffer size. It turns out that buffer
>>>>> size is always greater due to hardware alignment
>>>>> requirement. As a result, payload size given to
>>>>> client is incorrect. This change ensures that
>>>>> the bytesused is assigned to actual payload size.
>>>>>
>>>>> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
>>>>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>>>>> ---
>>>>>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c
>>>>> b/drivers/media/platform/qcom/venus/vdec.c
>>>>> index d079aeb..ada1d2f 100644
>>>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>>>> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst
>>>>> *inst, unsigned int buf_type,
>>>>>  
>>>>>  		vb = &vbuf->vb2_buf;
>>>>>  		vb->planes[0].bytesused =
>>>>> -			max_t(unsigned int, opb_sz, bytesused);
>>>>> +			min_t(unsigned int, opb_sz, bytesused);
>>>>
>>>> Most probably my intension was to avoid bytesused == 0, but that is
>>>> allowed from v4l2 driver -> userspace direction
>>>
>>> It remains bad practice since it was used by decoders to indicate the
>>> last buffer. Some userspace (some GStreamer versions) will stop working
>>> if you start returning 0.
>>
>> I think it is legal v4l2 driver to return bytesused = 0 when userspace
>> issues streamoff on both queues before EOS, no? Simply because the
>> capture buffers are empty.
>>
> 
> Going through some of the older pending patches I found this one:
> 
> So is this patch right or wrong?

I'm not sure either, let's not applying it for now (if Nicolas is right
this will break gstreamer plugin).

-- 
regards,
Stan
