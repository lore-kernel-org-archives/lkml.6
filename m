Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C334C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A3C2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsTyAL6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A3C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJBOUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:20:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55108 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJBOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:20:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so1141836wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jmb0Kej9qZVSL2rqgit8rPCWIoY9/5vCJEvSJT42v6I=;
        b=UsTyAL6XoaR8yKLrnf/umJdfXP0wEbtleZAvBWFrOYbRhfT5ZGVET4n1ldfUZItiPV
         6NsSVqNCe8VNDHckl66VRdtNtW4Qn026OV3eNrXSQBSEE0H4PO+Z6GbSIj1aZSPLnoTU
         mbVz/ZU3kIUOut33gdBdaX+KQDe8Ncb52YO8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jmb0Kej9qZVSL2rqgit8rPCWIoY9/5vCJEvSJT42v6I=;
        b=gwi9uz+HkOUKPl0Rbr2awkrmajCNRiwmCWR/yrxw0JcwwmHXrmr+BotCbPjyVc94C5
         ULGL1CieSb1ny3tLzocEFDJqUrfuNafzsnBB/tracTplOATD2KLoJM0Q6K7Udkq/t8HR
         yMxZURbic1NU+Da3DmPsosazmz9YRC4ifuPqSbCqd2P4t8ShiU+rM9nE7nWOpMfp0rNE
         kqshBQ5V9iiDzfxQCVX/KS14DDgAyrDJXPa9jaocdecxnla3kJcs57BfKdPJUJdbgmU5
         HaWr5G/bSUPXnnMlv+LAQmVPHZTKYSLW8eZe16ANx5iZhhqIdebLMQJSSuTAp7b5biGy
         TJ2Q==
X-Gm-Message-State: ABuFfogeoDTP9OdYxEeDQfR93Wfsq6pxBYpBB8WWdSZjUQ8a9/RdA3jR
        iaAdPI18wm5oM9q5UjqByw72+2CNVr8=
X-Google-Smtp-Source: ACcGV63QX6xM7jIG5UnyrvxO8U2mqsfx64I7cPWLb1M//qu2858rrcMba1HWXf42wx6XsBwLVgs2zQ==
X-Received: by 2002:a1c:5d8c:: with SMTP id r134-v6mr612129wmb.147.1538465899778;
        Tue, 02 Oct 2018 00:38:19 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id z13sm14128213wrw.19.2018.10.02.00.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:38:19 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>, vgarodia@codeaurora.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
 <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org>
 <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
 <92f6f79a-02ae-d23e-1b97-fc41fd921c89@linaro.org>
 <33e8d8e3-138e-0031-5b75-4bef114ac75e@xs4all.nl>
 <36b42952-982c-9048-77fb-72ca45cc7476@linaro.org>
 <051af6fb-e0e8-4008-99c5-9685ac24e454@xs4all.nl>
 <CAPBb6MVupMsdhF6Rtk4fm8JeVurrK+ZsuxAQ-BwrTzdSP1xP0Q@mail.gmail.com>
 <6d65ac0d-80a0-88fe-ed19-4785f2675e36@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <18c14931-15b4-190e-eb03-5cae8f8db381@linaro.org>
Date:   Tue, 2 Oct 2018 10:38:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6d65ac0d-80a0-88fe-ed19-4785f2675e36@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/19/2018 06:02 PM, Stanimir Varbanov wrote:
> Hi Alex,
> 
> On 09/19/2018 01:32 PM, Alexandre Courbot wrote:
>> On Mon, Sep 17, 2018 at 11:33 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>
>>> On 09/17/2018 04:30 PM, Stanimir Varbanov wrote:
>>>> Hi Hans,
>>>>
>>>> On 09/17/2018 01:00 PM, Hans Verkuil wrote:
>>>>> On 07/18/2018 04:37 PM, Stanimir Varbanov wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 07/18/2018 04:26 PM, Nicolas Dufresne wrote:
>>>>>>> Le mercredi 18 juillet 2018 à 14:31 +0300, Stanimir Varbanov a écrit :
>>>>>>>> Hi Vikash,
>>>>>>>>
>>>>>>>> On 07/02/2018 10:44 AM, Vikash Garodia wrote:
>>>>>>>>> Exisiting code returns the max of the decoded
>>>>>>>>> size and buffer size. It turns out that buffer
>>>>>>>>> size is always greater due to hardware alignment
>>>>>>>>> requirement. As a result, payload size given to
>>>>>>>>> client is incorrect. This change ensures that
>>>>>>>>> the bytesused is assigned to actual payload size.
>>>>>>>>>
>>>>>>>>> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
>>>>>>>>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>>>>>>>>> ---
>>>>>>>>>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c
>>>>>>>>> b/drivers/media/platform/qcom/venus/vdec.c
>>>>>>>>> index d079aeb..ada1d2f 100644
>>>>>>>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>>>>>>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>>>>>>>> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst
>>>>>>>>> *inst, unsigned int buf_type,
>>>>>>>>>
>>>>>>>>>                  vb = &vbuf->vb2_buf;
>>>>>>>>>                  vb->planes[0].bytesused =
>>>>>>>>> -                        max_t(unsigned int, opb_sz, bytesused);
>>>>>>>>> +                        min_t(unsigned int, opb_sz, bytesused);
>>>>>>>>
>>>>>>>> Most probably my intension was to avoid bytesused == 0, but that is
>>>>>>>> allowed from v4l2 driver -> userspace direction
>>>>>>>
>>>>>>> It remains bad practice since it was used by decoders to indicate the
>>>>>>> last buffer. Some userspace (some GStreamer versions) will stop working
>>>>>>> if you start returning 0.
>>>>>>
>>>>>> I think it is legal v4l2 driver to return bytesused = 0 when userspace
>>>>>> issues streamoff on both queues before EOS, no? Simply because the
>>>>>> capture buffers are empty.
>>>>>>
>>>>>
>>>>> Going through some of the older pending patches I found this one:
>>>>>
>>>>> So is this patch right or wrong?
>>>>
>>>> I'm not sure either, let's not applying it for now (if Nicolas is right
>>>> this will break gstreamer plugin).
>>>>
>>>
>>> OK, I marked this as Rejected. If you change your mind it can be reposted :-)
>>
>> Mmm I'm not saying it has to be done in the current form, but at the
>> moment the returned bytesused seems to be wrong (at least Chrome is
>> not happy). We are returning the total size of the buffer instead of
>> the actually useful payload.
>>
>> If the intent is to avoid returning bytesused == 0 except for the
>> special case of the last buffer, how about the following?
>>
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -943,8 +943,7 @@ static void vdec_buf_done(struct venus_inst *inst,
>> unsigned int buf_type,
>>                unsigned int opb_sz = venus_helper_get_opb_size(inst);
>>
>>                vb = &vbuf->vb2_buf;
>> -               vb->planes[0].bytesused =
>> -                       max_t(unsigned int, opb_sz, bytesused);
>> +                vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
>>                vb->planes[0].data_offset = data_offset;
>>                vb->timestamp = timestamp_us * NSEC_PER_USEC;
>>                vbuf->sequence = inst->sequence_cap++;
>>
>> It works fine for me, and should not return 0 more often than it did
>> before (i.e. never). In practice I also never see the firmware
>> reporting a payload of zero on SDM845, but maybe older chips differ?
> 
> yes, it looks fine. Let me test it with older versions.
> 

OK, I played a bit with vb2_set_plane_payload(vb, 0, bytesused)

On v1 I see a buffer with LAST flag and bytesused == 0 (when
V4L2_DEC_CMD_STOP is used), after that after session_stop (first
streamoff) is called I see the rest of the capture buffers returned with
bytesused == 0.

So I think we can go ahead.

Vikash, can you resend with such a change?

-- 
regards,
Stan
